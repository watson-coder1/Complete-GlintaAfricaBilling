<?php
/**
 * Captive Portal Session Manager
 * Handles automatic logout when user time expires
 * Should be run via cron job every minute
 */

require_once 'init.php';
require_once 'enhanced_authentication_blocker.php';

class CaptivePortalSessionManager
{
    public static function processExpiredSessions()
    {
        $processed = 0;
        $errors = 0;
        $logFile = $UPLOAD_PATH . '/captive_portal_session_manager.log';
        
        try {
            // Find all expired user recharges that are still active (enhanced time check)
            $current_datetime = date("Y-m-d H:i:s");
            $current_date = date("Y-m-d");
            
            $expiredSessions = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where('type', 'Hotspot')
                ->where_raw("(
                    (expiration < ? AND time IS NULL) OR 
                    (expiration = ? AND time IS NOT NULL AND CONCAT(expiration, ' ', time) <= ?) OR
                    (expiration < ?)
                )", [$current_date, $current_date, $current_datetime, $current_date])
                ->find_many();
                
            self::log("Found " . count($expiredSessions) . " expired sessions to process");
            
            foreach ($expiredSessions as $session) {
                try {
                    // Double-check if session is truly expired (enhanced time logic)
                    $now = time();
                    if (!empty($session->time)) {
                        $expiry_time = strtotime($session->expiration . ' ' . $session->time);
                    } else {
                        $expiry_time = strtotime($session->expiration . ' 23:59:59');
                    }
                    
                    if ($now < $expiry_time) {
                        self::log("Session not yet expired for user: " . $session->username . " (expires: " . date('Y-m-d H:i:s', $expiry_time) . ")");
                        continue;
                    }
                    
                    // Deactivate the session
                    $session->status = 'off';
                    $session->save();
                    
                    // Enhanced RADIUS cleanup using RadiusManager
                    if (class_exists('RadiusManager')) {
                        RadiusManager::removeRadiusUser($session->username);
                        $disconnect_result = RadiusManager::disconnectUser($session->username);
                        self::log("RADIUS cleanup for " . $session->username . ": " . ($disconnect_result['success'] ? 'success' : $disconnect_result['message']));
                    } else {
                        // Fallback to manual cleanup
                        self::removeFromRadius($session->username);
                    }
                    
                    // Disconnect from MikroTik router
                    self::disconnectFromMikroTik($session);
                    
                    // Update portal session status if exists
                    $portalSession = ORM::for_table('tbl_portal_sessions')
                        ->where('mac_address', $session->username)
                        ->where_in('status', ['completed', 'active'])
                        ->find_one();
                        
                    if ($portalSession) {
                        $portalSession->status = 'expired';
                        $portalSession->expired_at = date('Y-m-d H:i:s');
                        $portalSession->save();
                    }
                    
                    // ENHANCED AUTHENTICATION BLOCKING - Block expired user from re-authentication
                    try {
                        $blockResult = EnhancedAuthenticationBlocker::blockMacAddress(
                            $session->username,
                            $session->username,
                            'session_expired',
                            "Session expired on {$session->expiration}. Plan: {$session->namebp}. Blocked to prevent re-authentication without payment."
                        );
                        
                        if ($blockResult['success']) {
                            self::log("BLOCKED EXPIRED USER: {$session->username} blocked from re-authentication (Block ID: {$blockResult['block_id']})");
                        } else {
                            self::log("ERROR blocking expired user {$session->username}: " . ($blockResult['error'] ?? 'Unknown error'));
                        }
                    } catch (Exception $blockError) {
                        self::log("Exception blocking expired user {$session->username}: " . $blockError->getMessage());
                    }
                    
                    // Log successful processing with detailed info
                    $expiry_str = !empty($session->time) ? $session->expiration . ' ' . $session->time : $session->expiration . ' (end of day)';
                    self::log("Successfully expired session for user: " . $session->username . " (Plan: " . $session->namebp . ", Expired: " . $expiry_str . ")");
                    $processed++;
                    
                } catch (Exception $e) {
                    self::log("Error processing session " . $session->username . ": " . $e->getMessage());
                    $errors++;
                }
            }
            
            // Clean up old portal sessions (older than 24 hours)
            self::cleanupOldPortalSessions();
            
            self::log("Session cleanup completed. Processed: $processed, Errors: $errors");
            
            return [
                'success' => true,
                'processed' => $processed,
                'errors' => $errors,
                'message' => "Processed $processed expired sessions with $errors errors"
            ];
            
        } catch (Exception $e) {
            self::log("Fatal error in session manager: " . $e->getMessage());
            return [
                'success' => false,
                'message' => $e->getMessage()
            ];
        }
    }
    
    private static function removeFromRadius($username)
    {
        try {
            // Remove all RADIUS entries for this user
            ORM::for_table('radcheck', 'radius')
                ->where('username', $username)
                ->delete_many();
                
            ORM::for_table('radreply', 'radius')
                ->where('username', $username)
                ->delete_many();
                
            ORM::for_table('radusergroup', 'radius')
                ->where('username', $username)
                ->delete_many();
                
            // Kill active sessions
            ORM::for_table('radacct', 'radius')
                ->where('username', $username)
                ->where_null('acctstoptime')
                ->update_many(['acctstoptime' => date('Y-m-d H:i:s')]);
                
            self::log("Removed RADIUS entries for user: $username");
            
        } catch (Exception $e) {
            self::log("Error removing RADIUS entries for $username: " . $e->getMessage());
            throw $e;
        }
    }
    
    private static function disconnectFromMikroTik($session)
    {
        try {
            // Get router information
            $router = ORM::for_table('tbl_routers')
                ->where('name', $session->routers)
                ->find_one();
                
            if (!$router) {
                self::log("Router not found: " . $session->routers);
                return;
            }
            
            // Use MikroTik API to disconnect user
            require_once 'system/devices/MikrotikHotspot.php';
            
            $mikrotik = new MikrotikHotspot();
            $client = $mikrotik->getClient($router->ip_address, $router->username, $router->password);
            
            if ($client) {
                // Remove hotspot user
                $mikrotik->removeHotspotUser($client, $session->username);
                
                // Remove active sessions
                $mikrotik->removeHotspotActiveUser($client, $session->username);
                
                self::log("Disconnected user from MikroTik: " . $session->username);
            }
            
        } catch (Exception $e) {
            self::log("Error disconnecting from MikroTik for user " . $session->username . ": " . $e->getMessage());
            // Don't throw - this is not critical for session expiry
        }
    }
    
    private static function cleanupOldPortalSessions()
    {
        try {
            $cutoffTime = date('Y-m-d H:i:s', strtotime('-24 hours'));
            
            $deleted = ORM::for_table('tbl_portal_sessions')
                ->where_lt('created_at', $cutoffTime)
                ->where_in('status', ['pending', 'processing', 'failed'])
                ->delete_many();
                
            self::log("Cleaned up $deleted old portal sessions");
            
        } catch (Exception $e) {
            self::log("Error cleaning up old portal sessions: " . $e->getMessage());
        }
    }
    
    private static function log($message)
    {
        global $UPLOAD_PATH;
        $logFile = $UPLOAD_PATH . '/captive_portal_session_manager.log';
        $timestamp = date('Y-m-d H:i:s');
        $logMessage = "[$timestamp] $message" . PHP_EOL;
        
        file_put_contents($logFile, $logMessage, FILE_APPEND | LOCK_EX);
        
        // Also echo if running from command line
        if (php_sapi_name() === 'cli') {
            echo $logMessage;
        }
    }
    
    /**
     * Get session status for a user
     */
    public static function getUserSessionStatus($username)
    {
        $session = ORM::for_table('tbl_user_recharges')
            ->where('username', $username)
            ->where('status', 'on')
            ->order_by_desc('recharged_on')
            ->find_one();
            
        if (!$session) {
            return [
                'active' => false,
                'message' => 'No active session found'
            ];
        }
        
        $now = new DateTime();
        $expiry = new DateTime($session->expiration);
        
        if ($now > $expiry) {
            return [
                'active' => false,
                'expired' => true,
                'message' => 'Session expired',
                'expired_at' => $session->expiration
            ];
        }
        
        $timeLeft = $expiry->diff($now);
        
        return [
            'active' => true,
            'plan_name' => $session->namebp,
            'expires_at' => $session->expiration,
            'time_left' => $timeLeft->format('%h hours %i minutes'),
            'time_left_seconds' => $expiry->getTimestamp() - $now->getTimestamp()
        ];
    }
    
    /**
     * Force logout a specific user
     */
    public static function forceLogoutUser($username)
    {
        try {
            // Find active session
            $session = ORM::for_table('tbl_user_recharges')
                ->where('username', $username)
                ->where('status', 'on')
                ->find_one();
                
            if (!$session) {
                return ['success' => false, 'message' => 'No active session found'];
            }
            
            // Deactivate session
            $session->status = 'off';
            $session->save();
            
            // Remove from RADIUS
            if ($_c['radius_enable']) {
                self::removeFromRadius($username);
            }
            
            // Disconnect from MikroTik
            self::disconnectFromMikroTik($session);
            
            // Update portal session
            $portalSession = ORM::for_table('tbl_portal_sessions')
                ->where('mac_address', $username)
                ->where('status', 'completed')
                ->find_one();
                
            if ($portalSession) {
                $portalSession->status = 'logged_out';
                $portalSession->save();
            }
            
            self::log("Force logout completed for user: $username");
            
            return ['success' => true, 'message' => 'User logged out successfully'];
            
        } catch (Exception $e) {
            self::log("Error in force logout for $username: " . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
}

// If running from command line, execute the session cleanup
if (php_sapi_name() === 'cli') {
    echo "Starting Captive Portal Session Manager...\n";
    $result = CaptivePortalSessionManager::processExpiredSessions();
    echo "Result: " . json_encode($result) . "\n";
}

// If called via web (for testing), return JSON response
if (isset($_GET['action'])) {
    header('Content-Type: application/json');
    
    switch ($_GET['action']) {
        case 'process_expired':
            echo json_encode(CaptivePortalSessionManager::processExpiredSessions());
            break;
            
        case 'user_status':
            $username = $_GET['username'] ?? '';
            if ($username) {
                echo json_encode(CaptivePortalSessionManager::getUserSessionStatus($username));
            } else {
                echo json_encode(['error' => 'Username required']);
            }
            break;
            
        case 'force_logout':
            $username = $_GET['username'] ?? '';
            if ($username) {
                echo json_encode(CaptivePortalSessionManager::forceLogoutUser($username));
            } else {
                echo json_encode(['error' => 'Username required']);
            }
            break;
            
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
    exit;
}

?>