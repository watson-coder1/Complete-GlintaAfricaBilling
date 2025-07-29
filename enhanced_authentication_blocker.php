<?php
/**
 * Enhanced Authentication Blocker System
 * Prevents users from re-logging in without making a new payment after their package expires
 * 
 * Features:
 * - MAC address-based blocking for expired users
 * - Session validation and expiry checks
 * - Payment status verification
 * - Comprehensive authentication prevention
 * 
 * @author Glinta Africa Development Team
 * @version 1.0
 */

require_once 'init.php';

class EnhancedAuthenticationBlocker 
{
    private static $log_file;
    
    public static function init()
    {
        global $UPLOAD_PATH;
        self::$log_file = $UPLOAD_PATH . '/auth_blocker.log';
        self::createBlockedMacTable();
    }
    
    /**
     * Create blocked MAC addresses tracking table
     */
    private static function createBlockedMacTable()
    {
        try {
            $sql = "CREATE TABLE IF NOT EXISTS `tbl_blocked_mac_addresses` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `mac_address` varchar(20) NOT NULL,
                `username` varchar(100) DEFAULT NULL,
                `reason` varchar(255) DEFAULT 'expired_session',
                `blocked_at` datetime NOT NULL,
                `expires_at` datetime DEFAULT NULL,
                `last_attempt` datetime DEFAULT NULL,
                `attempt_count` int(11) DEFAULT 0,
                `status` enum('active','lifted','expired') DEFAULT 'active',
                `created_by` varchar(50) DEFAULT 'system',
                `notes` text,
                PRIMARY KEY (`id`),
                UNIQUE KEY `unique_mac_active` (`mac_address`, `status`),
                KEY `mac_address` (`mac_address`),
                KEY `blocked_at` (`blocked_at`),
                KEY `status` (`status`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tracks blocked MAC addresses to prevent re-authentication';";
            
            ORM::raw_execute($sql);
            
            // Create session attempts tracking table
            $sql2 = "CREATE TABLE IF NOT EXISTS `tbl_auth_attempts` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `mac_address` varchar(20) NOT NULL,
                `ip_address` varchar(45) DEFAULT NULL,
                `attempt_type` enum('captive_portal','radius','voucher') NOT NULL,
                `attempt_time` datetime NOT NULL,
                `user_agent` text,
                `session_id` varchar(50) DEFAULT NULL,
                `blocked` tinyint(1) DEFAULT 0,
                `reason` varchar(255) DEFAULT NULL,
                PRIMARY KEY (`id`),
                KEY `mac_address` (`mac_address`),
                KEY `attempt_time` (`attempt_time`),
                KEY `blocked` (`blocked`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tracks authentication attempts from potentially blocked users';";
            
            ORM::raw_execute($sql2);
            
        } catch (Exception $e) {
            self::log("Error creating blocked MAC table: " . $e->getMessage());
            throw $e;
        }
    }
    
    /**
     * Check if MAC address should be blocked from authentication
     * This is the main authentication gate
     */
    public static function isAuthenticationBlocked($mac_address, $attempt_type = 'captive_portal', $session_id = null)
    {
        self::init();
        
        if (empty($mac_address)) {
            return ['blocked' => false, 'reason' => 'No MAC address provided'];
        }
        
        // Clean and normalize MAC address
        $mac_address = self::normalizeMacAddress($mac_address);
        
        // Record this authentication attempt
        self::recordAuthAttempt($mac_address, $attempt_type, $session_id);
        
        try {
            // 1. Check for active blocking entry
            $activeBlock = self::getActiveBlock($mac_address);
            if ($activeBlock) {
                self::log("AUTH BLOCKED: {$mac_address} - Active block found (ID: {$activeBlock->id}, Reason: {$activeBlock->reason})");
                return [
                    'blocked' => true,
                    'reason' => $activeBlock->reason,
                    'blocked_since' => $activeBlock->blocked_at,
                    'block_id' => $activeBlock->id
                ];
            }
            
            // 2. Check if user has expired recharge without new payment
            $expiredRecharge = self::hasExpiredRechargeWithoutPayment($mac_address);
            if ($expiredRecharge['has_expired']) {
                // Create new block for expired user trying to authenticate
                $blockResult = self::blockMacAddress(
                    $mac_address, 
                    $mac_address, // username same as MAC for hotspot
                    'expired_session_retry',
                    "User attempted to re-authenticate after session expired on {$expiredRecharge['expired_at']}"
                );
                
                self::log("AUTH BLOCKED: {$mac_address} - Expired session retry blocked (Expired: {$expiredRecharge['expired_at']})");
                
                return [
                    'blocked' => true,
                    'reason' => 'expired_session_retry',
                    'expired_at' => $expiredRecharge['expired_at'],
                    'message' => 'Your previous session has expired. Please make a new payment to access the internet.',
                    'block_id' => $blockResult['block_id'] ?? null
                ];
            }
            
            // 3. Check for suspicious rapid authentication attempts
            $suspiciousActivity = self::detectSuspiciousActivity($mac_address);
            if ($suspiciousActivity['is_suspicious']) {
                $blockResult = self::blockMacAddress(
                    $mac_address,
                    $mac_address,
                    'suspicious_activity',
                    "Multiple rapid authentication attempts detected: {$suspiciousActivity['attempts']} attempts in {$suspiciousActivity['timeframe']} minutes"
                );
                
                self::log("AUTH BLOCKED: {$mac_address} - Suspicious activity detected ({$suspiciousActivity['attempts']} attempts)");
                
                return [
                    'blocked' => true,
                    'reason' => 'suspicious_activity',
                    'message' => 'Too many authentication attempts. Please wait before trying again.',
                    'attempts' => $suspiciousActivity['attempts'],
                    'block_id' => $blockResult['block_id'] ?? null
                ];
            }
            
            // 4. Check if MAC has active session already (prevent duplicate sessions)
            $activeSession = self::hasActiveSession($mac_address);
            if ($activeSession['has_active']) {
                self::log("AUTH INFO: {$mac_address} - Already has active session (Plan: {$activeSession['plan']}, Expires: {$activeSession['expires']})");
                return [
                    'blocked' => false,
                    'has_active_session' => true,
                    'active_session' => $activeSession,
                    'message' => 'You already have an active internet session.'
                ];
            }
            
            // Authentication allowed
            self::log("AUTH ALLOWED: {$mac_address} - No blocking conditions found");
            return ['blocked' => false, 'reason' => 'Authentication permitted'];
            
        } catch (Exception $e) {
            self::log("Error checking authentication block for {$mac_address}: " . $e->getMessage());
            // On error, allow authentication but log the issue
            return ['blocked' => false, 'reason' => 'Error during check - allowing authentication', 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Block a MAC address from authentication
     */
    public static function blockMacAddress($mac_address, $username = null, $reason = 'expired_session', $notes = null, $duration_hours = null)
    {
        self::init();
        
        try {
            $mac_address = self::normalizeMacAddress($mac_address);
            
            // Check if already blocked
            $existingBlock = self::getActiveBlock($mac_address);
            if ($existingBlock) {
                // Update existing block
                $existingBlock->reason = $reason;
                $existingBlock->notes = $notes;
                $existingBlock->blocked_at = date('Y-m-d H:i:s'); // Reset block time
                if ($duration_hours) {
                    $existingBlock->expires_at = date('Y-m-d H:i:s', strtotime("+{$duration_hours} hours"));
                }
                $existingBlock->save();
                
                self::log("BLOCK UPDATED: {$mac_address} - Updated existing block (ID: {$existingBlock->id})");
                return ['success' => true, 'action' => 'updated', 'block_id' => $existingBlock->id()];
            }
            
            // Create new block
            $block = ORM::for_table('tbl_blocked_mac_addresses')->create();
            $block->mac_address = $mac_address;
            $block->username = $username ?: $mac_address;
            $block->reason = $reason;
            $block->blocked_at = date('Y-m-d H:i:s');
            $block->notes = $notes;
            $block->status = 'active';
            $block->created_by = 'system';
            
            if ($duration_hours) {
                $block->expires_at = date('Y-m-d H:i:s', strtotime("+{$duration_hours} hours"));
            }
            
            $block->save();
            
            self::log("BLOCK CREATED: {$mac_address} - New block created (ID: {$block->id()}, Reason: {$reason})");
            
            return ['success' => true, 'action' => 'created', 'block_id' => $block->id()];
            
        } catch (Exception $e) {
            self::log("Error blocking MAC {$mac_address}: " . $e->getMessage());
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Unblock a MAC address (allow authentication again)
     */
    public static function unblockMacAddress($mac_address, $reason = 'manual_unblock')
    {
        self::init();
        
        try {
            $mac_address = self::normalizeMacAddress($mac_address);
            
            $blocks = ORM::for_table('tbl_blocked_mac_addresses')
                ->where('mac_address', $mac_address)
                ->where('status', 'active')
                ->find_many();
            
            $unblocked = 0;
            foreach ($blocks as $block) {
                $block->status = 'lifted';
                $block->notes = ($block->notes ? $block->notes . "\n" : '') . "Unblocked: {$reason} at " . date('Y-m-d H:i:s');
                $block->save();
                $unblocked++;
            }
            
            self::log("UNBLOCK: {$mac_address} - {$unblocked} blocks removed (Reason: {$reason})");
            
            return ['success' => true, 'unblocked_count' => $unblocked];
            
        } catch (Exception $e) {
            self::log("Error unblocking MAC {$mac_address}: " . $e->getMessage());
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Check if user has expired recharge without new payment
     */
    private static function hasExpiredRechargeWithoutPayment($mac_address)
    {
        try {
            // Find the most recent recharge for this MAC
            $recentRecharge = ORM::for_table('tbl_user_recharges')
                ->where('username', $mac_address)
                ->order_by_desc('recharged_on')
                ->order_by_desc('recharged_time')
                ->find_one();
            
            if (!$recentRecharge) {
                return ['has_expired' => false, 'reason' => 'no_previous_recharge'];
            }
            
            // Check if the most recent recharge is expired and marked as 'off'
            if ($recentRecharge->status === 'off') {
                // Calculate precise expiry time
                $expiry_time = !empty($recentRecharge->time) 
                    ? strtotime($recentRecharge->expiration . ' ' . $recentRecharge->time)
                    : strtotime($recentRecharge->expiration . ' 23:59:59');
                
                $now = time();
                
                // If expiry time has passed and status is 'off', check for new payment
                if ($expiry_time < $now) {
                    // Check if there's been a successful payment since expiry
                    $expiry_datetime = date('Y-m-d H:i:s', $expiry_time);
                    
                    $newPaymentSinceExpiry = ORM::for_table('tbl_payment_gateway')
                        ->where('username', $mac_address)
                        ->where('status', 2) // Successful payment
                        ->where_gt('paid_date', $expiry_datetime)
                        ->find_one();
                    
                    if (!$newPaymentSinceExpiry) {
                        return [
                            'has_expired' => true,
                            'expired_at' => $expiry_datetime,
                            'plan_name' => $recentRecharge->namebp,
                            'no_new_payment' => true
                        ];
                    }
                }
            }
            
            return ['has_expired' => false, 'reason' => 'active_or_new_payment_found'];
            
        } catch (Exception $e) {
            self::log("Error checking expired recharge for {$mac_address}: " . $e->getMessage());
            return ['has_expired' => false, 'reason' => 'error_during_check'];
        }
    }
    
    /**
     * Check if MAC has active session
     */
    private static function hasActiveSession($mac_address)
    {
        try {
            // Current datetime for comparison
            $currentDateTime = date('Y-m-d H:i:s');
            $currentDate = date('Y-m-d');
            $currentTime = date('H:i:s');
            
            $activeSession = ORM::for_table('tbl_user_recharges')
                ->where('username', $mac_address)
                ->where('status', 'on')
                ->find_one();
            
            if ($activeSession) {
                // Build the full expiration datetime
                $expirationDateTime = $activeSession->expiration . ' ' . ($activeSession->time ?: '23:59:59');
                
                // Check if the session hasn't expired yet
                if (strtotime($expirationDateTime) > strtotime($currentDateTime)) {
                    self::log("ACTIVE SESSION FOUND: {$mac_address} - Plan: {$activeSession->namebp}, Expires: {$expirationDateTime}");
                    
                    return [
                        'has_active' => true,
                        'plan' => $activeSession->namebp,
                        'expires' => $expirationDateTime,
                        'expiration_date' => $activeSession->expiration,
                        'expiration_time' => $activeSession->time,
                        'recharge_id' => $activeSession->id()
                    ];
                } else {
                    self::log("EXPIRED SESSION: {$mac_address} - Plan: {$activeSession->namebp}, Expired: {$expirationDateTime}");
                }
            }
            
            return ['has_active' => false];
            
        } catch (Exception $e) {
            return ['has_active' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Detect suspicious authentication activity
     */
    private static function detectSuspiciousActivity($mac_address)
    {
        try {
            $timeframe_minutes = 5; // Check last 5 minutes
            $max_attempts = 10; // Max 10 attempts in timeframe
            
            $since_time = date('Y-m-d H:i:s', strtotime("-{$timeframe_minutes} minutes"));
            
            $recentAttempts = ORM::for_table('tbl_auth_attempts')
                ->where('mac_address', $mac_address)
                ->where_gte('attempt_time', $since_time)
                ->count();
            
            if ($recentAttempts >= $max_attempts) {
                return [
                    'is_suspicious' => true,
                    'attempts' => $recentAttempts,
                    'timeframe' => $timeframe_minutes,
                    'threshold' => $max_attempts
                ];
            }
            
            return ['is_suspicious' => false, 'attempts' => $recentAttempts];
            
        } catch (Exception $e) {
            return ['is_suspicious' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Get active block for MAC address
     */
    private static function getActiveBlock($mac_address)
    {
        try {
            return ORM::for_table('tbl_blocked_mac_addresses')
                ->where('mac_address', $mac_address)
                ->where('status', 'active')
                ->where_raw('(expires_at IS NULL OR expires_at > NOW())')
                ->find_one();
        } catch (Exception $e) {
            return null;
        }
    }
    
    /**
     * Record authentication attempt
     */
    private static function recordAuthAttempt($mac_address, $attempt_type, $session_id = null)
    {
        try {
            $attempt = ORM::for_table('tbl_auth_attempts')->create();
            $attempt->mac_address = $mac_address;
            $attempt->ip_address = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
            $attempt->attempt_type = $attempt_type;
            $attempt->attempt_time = date('Y-m-d H:i:s');
            $attempt->user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';
            $attempt->session_id = $session_id;
            $attempt->save();
            
        } catch (Exception $e) {
            // Silent fail for attempt recording
            self::log("Failed to record auth attempt: " . $e->getMessage());
        }
    }
    
    /**
     * Normalize MAC address format
     */
    private static function normalizeMacAddress($mac)
    {
        if (empty($mac)) return '';
        
        // Remove all non-alphanumeric characters and convert to lowercase
        $clean = strtolower(preg_replace('/[^a-f0-9]/', '', $mac));
        
        // If it's a device fingerprint or auto-generated MAC, return as-is
        if (strpos($mac, 'device-') === 0 || strpos($mac, 'auto-') === 0) {
            return $mac;
        }
        
        // Ensure it's at least 12 characters for a MAC
        if (strlen($clean) >= 12) {
            return substr($clean, 0, 12);
        }
        
        return $mac; // Return original if can't normalize
    }
    
    /**
     * Process expired users and block them from re-authentication
     */
    public static function processExpiredUsersForBlocking()
    {
        self::init();
        
        try {
            $processed = 0;
            $errors = 0;
            
            // Find all users who just expired (status changed to 'off' recently)
            $expiredUsers = ORM::for_table('tbl_user_recharges')
                ->where('status', 'off')
                ->where_gte('expiration', date('Y-m-d H:i:s', strtotime('-1 hour'))) // Recently expired
                ->find_many();
            
            foreach ($expiredUsers as $expiredUser) {
                try {
                    // Check if this MAC is already blocked
                    $existingBlock = self::getActiveBlock($expiredUser->username);
                    if ($existingBlock) {
                        continue; // Already blocked
                    }
                    
                    // Block the MAC address to prevent re-authentication
                    $blockResult = self::blockMacAddress(
                        $expiredUser->username,
                        $expiredUser->username,
                        'session_expired',
                        "Session expired on {$expiredUser->expiration}. Plan: {$expiredUser->namebp}"
                    );
                    
                    if ($blockResult['success']) {
                        $processed++;
                        self::log("EXPIRED USER BLOCKED: {$expiredUser->username} - Plan: {$expiredUser->namebp}");
                    } else {
                        $errors++;
                        self::log("ERROR blocking expired user {$expiredUser->username}: " . ($blockResult['error'] ?? 'Unknown error'));
                    }
                    
                } catch (Exception $e) {
                    $errors++;
                    self::log("Exception processing expired user {$expiredUser->username}: " . $e->getMessage());
                }
            }
            
            self::log("Expired user blocking completed: {$processed} blocked, {$errors} errors");
            
            return [
                'success' => true,
                'processed' => $processed,
                'errors' => $errors,
                'message' => "Processed {$processed} expired users for blocking"
            ];
            
        } catch (Exception $e) {
            self::log("Error in processExpiredUsersForBlocking: " . $e->getMessage());
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Clean up expired blocks and old attempt records
     */
    public static function cleanupOldRecords()
    {
        self::init();
        
        try {
            // Mark expired blocks as 'expired'
            $expiredBlocks = ORM::for_table('tbl_blocked_mac_addresses')
                ->where('status', 'active')
                ->where_not_null('expires_at')
                ->where_lt('expires_at', date('Y-m-d H:i:s'))
                ->find_many();
            
            foreach ($expiredBlocks as $block) {
                $block->status = 'expired';
                $block->save();
            }
            
            self::log("Marked " . count($expiredBlocks) . " blocks as expired");
            
            // Clean old auth attempts (older than 7 days)
            $cutoff = date('Y-m-d H:i:s', strtotime('-7 days'));
            $deletedAttempts = ORM::for_table('tbl_auth_attempts')
                ->where_lt('attempt_time', $cutoff)
                ->delete_many();
            
            self::log("Deleted {$deletedAttempts} old auth attempt records");
            
            return [
                'success' => true,
                'expired_blocks' => count($expiredBlocks),
                'deleted_attempts' => $deletedAttempts
            ];
            
        } catch (Exception $e) {
            self::log("Error in cleanup: " . $e->getMessage());
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Get statistics about blocked MACs and auth attempts
     */
    public static function getBlockingStatistics()
    {
        self::init();
        
        try {
            $stats = [];
            
            // Active blocks
            $stats['active_blocks'] = ORM::for_table('tbl_blocked_mac_addresses')
                ->where('status', 'active')
                ->count();
            
            // Blocks by reason
            $blockReasons = ORM::for_table('tbl_blocked_mac_addresses')
                ->where('status', 'active')
                ->select('reason')
                ->select_expr('COUNT(*)', 'count')
                ->group_by('reason')
                ->find_array();
            
            $stats['blocks_by_reason'] = [];
            foreach ($blockReasons as $reason) {
                $stats['blocks_by_reason'][$reason['reason']] = $reason['count'];
            }
            
            // Auth attempts in last 24 hours
            $stats['recent_attempts'] = ORM::for_table('tbl_auth_attempts')
                ->where_gte('attempt_time', date('Y-m-d H:i:s', strtotime('-24 hours')))
                ->count();
            
            // Blocked attempts in last 24 hours
            $stats['recent_blocked_attempts'] = ORM::for_table('tbl_auth_attempts')
                ->where_gte('attempt_time', date('Y-m-d H:i:s', strtotime('-24 hours')))
                ->where('blocked', 1)
                ->count();
            
            return $stats;
            
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    
    /**
     * Logging function
     */
    private static function log($message)
    {
        $timestamp = date('Y-m-d H:i:s');
        $logMessage = "[{$timestamp}] {$message}" . PHP_EOL;
        
        try {
            file_put_contents(self::$log_file, $logMessage, FILE_APPEND | LOCK_EX);
        } catch (Exception $e) {
            // Silent fail for logging
        }
        
        // Also echo if running from command line
        if (php_sapi_name() === 'cli') {
            echo $logMessage;
        }
    }
}

// Command line interface
if (php_sapi_name() === 'cli') {
    if (isset($argv[1])) {
        switch ($argv[1]) {
            case 'process-expired':
                echo "Processing expired users for blocking...\n";
                $result = EnhancedAuthenticationBlocker::processExpiredUsersForBlocking();
                echo "Result: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
                break;
                
            case 'cleanup':
                echo "Cleaning up old records...\n";
                $result = EnhancedAuthenticationBlocker::cleanupOldRecords();
                echo "Result: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
                break;
                
            case 'stats':
                echo "Blocking statistics:\n";
                $stats = EnhancedAuthenticationBlocker::getBlockingStatistics();
                echo json_encode($stats, JSON_PRETTY_PRINT) . "\n";
                break;
                
            case 'block':
                if (isset($argv[2])) {
                    $mac = $argv[2];
                    $reason = $argv[3] ?? 'manual_block';
                    echo "Blocking MAC: {$mac}\n";
                    $result = EnhancedAuthenticationBlocker::blockMacAddress($mac, $mac, $reason);
                    echo "Result: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
                } else {
                    echo "Usage: php enhanced_authentication_blocker.php block <mac_address> [reason]\n";
                }
                break;
                
            case 'unblock':
                if (isset($argv[2])) {
                    $mac = $argv[2];
                    echo "Unblocking MAC: {$mac}\n";
                    $result = EnhancedAuthenticationBlocker::unblockMacAddress($mac);
                    echo "Result: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
                } else {
                    echo "Usage: php enhanced_authentication_blocker.php unblock <mac_address>\n";
                }
                break;
                
            default:
                echo "Usage: php enhanced_authentication_blocker.php [process-expired|cleanup|stats|block|unblock]\n";
        }
    } else {
        echo "Enhanced Authentication Blocker\n";
        echo "Usage: php enhanced_authentication_blocker.php [process-expired|cleanup|stats|block|unblock]\n";
    }
}

// Web API endpoints
if (isset($_GET['action'])) {
    header('Content-Type: application/json');
    
    switch ($_GET['action']) {
        case 'check':
            $mac = $_GET['mac'] ?? '';
            $type = $_GET['type'] ?? 'captive_portal';
            echo json_encode(EnhancedAuthenticationBlocker::isAuthenticationBlocked($mac, $type));
            break;
            
        case 'process_expired':
            echo json_encode(EnhancedAuthenticationBlocker::processExpiredUsersForBlocking());
            break;
            
        case 'cleanup':
            echo json_encode(EnhancedAuthenticationBlocker::cleanupOldRecords());
            break;
            
        case 'stats':
            echo json_encode(EnhancedAuthenticationBlocker::getBlockingStatistics());
            break;
            
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
    exit;
}
?>