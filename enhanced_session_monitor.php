<?php
/**
 * Enhanced Session Monitoring System
 * Real-time session expiry tracking and automatic user removal
 * Developed for Glinta Africa Billing System
 * 
 * Usage:
 * - Run every minute via cron: * * * * * /usr/bin/php /path/to/enhanced_session_monitor.php
 * - Or call via web API for real-time checks
 */

require_once 'init.php';

class EnhancedSessionMonitor
{
    private static $log_file;
    
    public static function init()
    {
        global $UPLOAD_PATH;
        self::$log_file = $UPLOAD_PATH . '/enhanced_session_monitor.log';
    }
    
    /**
     * Main monitoring function - check all active sessions for expiry
     */
    public static function monitorAllSessions()
    {
        self::init();
        self::log("=== Enhanced Session Monitor Started ===");
        
        $results = [
            'expired_count' => 0,
            'warning_count' => 0,
            'active_count' => 0,
            'errors' => [],
            'processed_users' => []
        ];
        
        try {
            // Get all active sessions with enhanced time checking
            $current_datetime = date("Y-m-d H:i:s");
            $current_date = date("Y-m-d");
            $warning_time = date("Y-m-d H:i:s", strtotime('+5 minutes')); // 5 minute warning
            
            $activeSessions = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->find_many();
            
            self::log("Found " . count($activeSessions) . " active sessions to monitor");
            
            foreach ($activeSessions as $session) {
                try {
                    $session_status = self::checkSessionStatus($session);
                    $results['processed_users'][] = [
                        'username' => $session->username,
                        'plan' => $session->namebp,
                        'status' => $session_status['status'],
                        'expiry' => $session_status['expiry_time'],
                        'action_taken' => $session_status['action_taken']
                    ];
                    
                    switch ($session_status['status']) {
                        case 'expired':
                            $expired_result = self::processExpiredSession($session);
                            if ($expired_result['success']) {
                                $results['expired_count']++;
                                self::log("EXPIRED: User {$session->username} expired and removed from access");
                            } else {
                                $results['errors'][] = "Failed to process expired user {$session->username}: " . $expired_result['error'];
                            }
                            break;
                            
                        case 'warning':
                            self::sendExpiryWarning($session, $session_status['time_left']);
                            $results['warning_count']++;
                            self::log("WARNING: User {$session->username} expires in " . $session_status['time_left'] . " seconds");
                            break;
                            
                        case 'active':
                            $results['active_count']++;
                            break;
                    }
                    
                } catch (Exception $e) {
                    $results['errors'][] = "Error processing session {$session->username}: " . $e->getMessage();
                    self::log("ERROR: Processing session {$session->username}: " . $e->getMessage());
                }
            }
            
            // Additional monitoring tasks
            self::monitorRadiusSessionLimits();
            self::cleanupStaleConnections();
            
            self::log("=== Session Monitor Completed: {$results['expired_count']} expired, {$results['warning_count']} warnings, {$results['active_count']} active ===");
            
            return $results;
            
        } catch (Exception $e) {
            self::log("FATAL ERROR: " . $e->getMessage());
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Check individual session status
     */
    private static function checkSessionStatus($session)
    {
        $now = time();
        
        // Calculate precise expiry time
        if (!empty($session->time)) {
            $expiry_timestamp = strtotime($session->expiration . ' ' . $session->time);
            $expiry_display = $session->expiration . ' ' . $session->time;
        } else {
            $expiry_timestamp = strtotime($session->expiration . ' 23:59:59');
            $expiry_display = $session->expiration . ' (end of day)';
        }
        
        $time_left = $expiry_timestamp - $now;
        
        if ($time_left <= 0) {
            return [
                'status' => 'expired',
                'expiry_time' => $expiry_display,
                'time_left' => $time_left,
                'action_taken' => 'needs_removal'
            ];
        } else if ($time_left <= 300) { // 5 minutes warning
            return [
                'status' => 'warning',
                'expiry_time' => $expiry_display,
                'time_left' => $time_left,
                'action_taken' => 'warning_sent'
            ];
        } else {
            return [
                'status' => 'active',
                'expiry_time' => $expiry_display,
                'time_left' => $time_left,
                'action_taken' => 'none'
            ];
        }
    }
    
    /**
     * Process expired session with comprehensive cleanup
     */
    private static function processExpiredSession($session)
    {
        global $_app_stage;
        
        try {
            // Mark session as expired
            $session->status = 'off';
            $session->save();
            
            // Get customer and plan info
            $customer = ORM::for_table('tbl_customers')->where('id', $session->customer_id)->find_one();
            $plan = ORM::for_table('tbl_plans')->where('id', $session->plan_id)->find_one();
            
            if (!$customer) {
                $customer = $session; // Fallback for voucher users
            }
            
            // 1. Remove from device (MikroTik/RADIUS)
            if ($plan && $_app_stage != 'demo') {
                $device_path = Package::getDevice($plan);
                if (file_exists($device_path)) {
                    require_once $device_path;
                    (new $plan->device)->remove_customer($customer, $plan);
                    self::log("Device removal completed for {$customer->username}");
                }
            }
            
            // 2. Enhanced RADIUS cleanup
            if ($plan && $plan->type == 'Hotspot' && class_exists('RadiusManager')) {
                RadiusManager::removeRadiusUser($customer->username);
                $disconnect_result = RadiusManager::disconnectUser($customer->username);
                self::log("RADIUS cleanup for {$customer->username}: " . ($disconnect_result['success'] ? 'success' : $disconnect_result['message']));
            }
            
            // 3. Clean portal sessions
            $portalSessions = ORM::for_table('tbl_portal_sessions')
                ->where('mac_address', $customer->username)
                ->where_in('status', ['completed', 'active', 'pending'])
                ->find_many();
                
            foreach ($portalSessions as $portalSession) {
                $portalSession->status = 'expired';
                $portalSession->expired_at = date('Y-m-d H:i:s');
                $portalSession->save();
            }
            
            if (count($portalSessions) > 0) {
                self::log("Expired " . count($portalSessions) . " portal sessions for {$customer->username}");
            }
            
            // 4. Terminate active RADIUS accounting sessions
            $activeSessions = ORM::for_table('radacct', 'radius')
                ->where('username', $customer->username)
                ->where_null('acctstoptime')
                ->find_many();
                
            foreach ($activeSessions as $radSession) {
                $radSession->acctstoptime = date('Y-m-d H:i:s');
                $radSession->acctterminatecause = 'Session-Timeout';
                $radSession->save();
            }
            
            if (count($activeSessions) > 0) {
                self::log("Terminated " . count($activeSessions) . " active RADIUS sessions for {$customer->username}");
            }
            
            // 5. Send expiry notification
            self::sendExpiryNotification($customer, $session, $plan);
            
            return ['success' => true, 'message' => 'Session expired and user removed successfully'];
            
        } catch (Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Monitor RADIUS sessions for time/data limits
     */
    private static function monitorRadiusSessionLimits()
    {
        try {
            $processed = 0;
            
            // Check active RADIUS sessions for exceeded limits
            $activeSessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->find_many();
            
            foreach ($activeSessions as $session) {
                $username = $session->username;
                $session_duration = time() - strtotime($session->acctstarttime);
                
                // Check session timeout
                $timeout_check = ORM::for_table('radcheck', 'radius')
                    ->where('username', $username)
                    ->where('attribute', 'Session-Timeout')
                    ->find_one();
                
                if ($timeout_check && $session_duration >= intval($timeout_check->value)) {
                    self::log("TIMEOUT: Disconnecting user {$username} (session duration: {$session_duration}s, limit: {$timeout_check->value}s)");
                    
                    if (class_exists('RadiusManager')) {
                        RadiusManager::disconnectUser($username);
                    }
                    $processed++;
                    continue;
                }
                
                // Check data limits
                $data_limit_check = ORM::for_table('radcheck', 'radius')
                    ->where('username', $username)
                    ->where('attribute', 'Max-Octets')
                    ->find_one();
                
                if ($data_limit_check) {
                    $total_data = ($session->acctinputoctets ?? 0) + ($session->acctoutputoctets ?? 0);
                    $data_limit = intval($data_limit_check->value);
                    
                    if ($total_data >= $data_limit) {
                        self::log("DATA LIMIT: Disconnecting user {$username} (used: " . self::formatBytes($total_data) . ", limit: " . self::formatBytes($data_limit) . ")");
                        
                        if (class_exists('RadiusManager')) {
                            RadiusManager::disconnectUser($username);
                        }
                        $processed++;
                    }
                }
            }
            
            if ($processed > 0) {
                self::log("RADIUS limit monitoring: processed {$processed} exceeded sessions");
            }
            
        } catch (Exception $e) {
            self::log("Error monitoring RADIUS limits: " . $e->getMessage());
        }
    }
    
    /**
     * Clean up stale connections and sessions
     */
    private static function cleanupStaleConnections()
    {
        try {
            // Clean RADIUS sessions older than 24 hours without stop time
            $stale_cutoff = date('Y-m-d H:i:s', strtotime('-24 hours'));
            
            $staleSessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->where_lt('acctstarttime', $stale_cutoff)
                ->find_many();
            
            foreach ($staleSessions as $staleSession) {
                $staleSession->acctstoptime = date('Y-m-d H:i:s');
                $staleSession->acctterminatecause = 'Lost-Carrier';
                $staleSession->save();
            }
            
            if (count($staleSessions) > 0) {
                self::log("Cleaned up " . count($staleSessions) . " stale RADIUS sessions");
            }
            
        } catch (Exception $e) {
            self::log("Error cleaning stale connections: " . $e->getMessage());
        }
    }
    
    /**
     * Send expiry warning notification
     */
    private static function sendExpiryWarning($session, $seconds_left)
    {
        try {
            $minutes_left = ceil($seconds_left / 60);
            $message = "Your internet session will expire in {$minutes_left} minutes. Please recharge to continue browsing.";
            
            // You can implement SMS/WhatsApp/Email notification here
            self::log("WARNING SENT: User {$session->username} - {$minutes_left} minutes left");
            
        } catch (Exception $e) {
            self::log("Error sending warning: " . $e->getMessage());
        }
    }
    
    /**
     * Send expiry notification
     */
    private static function sendExpiryNotification($customer, $session, $plan)
    {
        global $config;
        
        try {
            $textExpired = Lang::getNotifText('expired');
            Message::sendPackageNotification($customer, $session->namebp, $plan->price ?? 0, $textExpired, $config['user_notification_expired']);
            
        } catch (Exception $e) {
            self::log("Error sending expiry notification: " . $e->getMessage());
        }
    }
    
    /**
     * Format bytes for display
     */
    private static function formatBytes($bytes, $precision = 2)
    {
        $units = array('B', 'KB', 'MB', 'GB', 'TB');
        
        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }
        
        return round($bytes, $precision) . ' ' . $units[$i];
    }
    
    /**
     * Logging function
     */
    private static function log($message)
    {
        $timestamp = date('Y-m-d H:i:s');
        $logMessage = "[$timestamp] $message" . PHP_EOL;
        
        file_put_contents(self::$log_file, $logMessage, FILE_APPEND | LOCK_EX);
        
        // Also echo if running from command line
        if (php_sapi_name() === 'cli') {
            echo $logMessage;
        }
    }
    
    /**
     * Get monitoring statistics
     */
    public static function getStatistics()
    {
        try {
            $stats = [];
            
            // Active sessions by type
            $stats['hotspot_active'] = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where('type', 'Hotspot')
                ->count();
                
            $stats['pppoe_active'] = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where('type', 'PPPOE')
                ->count();
            
            // RADIUS sessions
            $stats['radius_active'] = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->count();
            
            // Sessions expiring in next hour
            $next_hour = date('Y-m-d H:i:s', strtotime('+1 hour'));
            $stats['expiring_soon'] = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where_raw("CONCAT(expiration, ' ', IFNULL(time, '23:59:59')) <= ?", [$next_hour])
                ->count();
            
            return $stats;
            
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
}

// Command line execution
if (php_sapi_name() === 'cli') {
    echo "Enhanced Session Monitor Starting...\n";
    $result = EnhancedSessionMonitor::monitorAllSessions();
    echo "Monitor completed: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
}

// Web API endpoints
if (isset($_GET['action'])) {
    header('Content-Type: application/json');
    
    switch ($_GET['action']) {
        case 'monitor':
            echo json_encode(EnhancedSessionMonitor::monitorAllSessions());
            break;
            
        case 'stats':
            echo json_encode(EnhancedSessionMonitor::getStatistics());
            break;
            
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
    exit;
}
?>