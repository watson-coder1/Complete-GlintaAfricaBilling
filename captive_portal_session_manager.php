<?php
/**
 * Captive Portal Session Manager
 * Handles automatic logout when user time expires
 * Should be run via cron job every minute
 */

require_once 'init.php';

class CaptivePortalSessionManager
{
    public static function processExpiredSessions()
    {
        $processed = 0;
        $errors = 0;
        $logFile = $UPLOAD_PATH . '/captive_portal_session_manager.log';
        
        try {
            // Find all expired user recharges that are still active
            $expiredSessions = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where_lt('expiration', date('Y-m-d H:i:s'))
                ->where('type', 'Hotspot')
                ->find_many();
                
            self::log("Found " . count($expiredSessions) . " expired sessions to process");
            
            foreach ($expiredSessions as $session) {
                try {
                    // Deactivate the session
                    $session->status = 'off';
                    $session->save();
                    
                    // Remove from RADIUS if using RADIUS
                    if ($_c['radius_enable']) {
                        self::removeFromRadius($session->username);
                    }
                    
                    // Disconnect from MikroTik router
                    self::disconnectFromMikroTik($session);
                    
                    // Update portal session status if exists
                    $portalSession = ORM::for_table('tbl_portal_sessions')
                        ->where('mac_address', $session->username)
                        ->where('status', 'completed')
                        ->find_one();
                        
                    if ($portalSession) {
                        $portalSession->status = 'expired';
                        $portalSession->save();
                    }
                    
                    // Log successful processing
                    self::log("Successfully expired session for user: " . $session->username . " (Plan: " . $session->namebp . ")");
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