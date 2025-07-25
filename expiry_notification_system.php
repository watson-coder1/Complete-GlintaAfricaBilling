<?php
/**
 * Expiry Notification System
 * Sends automatic notifications to users approaching expiry
 * Developed for Glinta Africa Billing System
 * 
 * Usage:
 * - Run every 10 minutes via cron: */10 * * * * /usr/bin/php /path/to/expiry_notification_system.php
 */

require_once 'init.php';

class ExpiryNotificationSystem
{
    private static $log_file;
    private static $notification_intervals = [
        300,    // 5 minutes
        600,    // 10 minutes
        1800,   // 30 minutes
        3600,   // 1 hour
        7200,   // 2 hours
        21600,  // 6 hours
        86400   // 24 hours
    ];
    
    public static function init()
    {
        global $UPLOAD_PATH;
        self::$log_file = $UPLOAD_PATH . '/expiry_notifications.log';
    }
    
    /**
     * Process expiry notifications
     */
    public static function processNotifications()
    {
        self::init();
        self::log("=== Expiry Notification System Started ===");
        
        $results = [
            'notifications_sent' => 0,
            'errors' => 0,
            'processed_users' => []
        ];
        
        try {
            $current_time = time();
            
            // Get all active sessions
            $activeSessions = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->find_many();
            
            self::log("Checking " . count($activeSessions) . " active sessions for expiry notifications");
            
            foreach ($activeSessions as $session) {
                try {
                    // Calculate expiry time
                    if (!empty($session->time)) {
                        $expiry_time = strtotime($session->expiration . ' ' . $session->time);
                    } else {
                        $expiry_time = strtotime($session->expiration . ' 23:59:59');
                    }
                    
                    $time_until_expiry = $expiry_time - $current_time;
                    
                    // Skip already expired sessions
                    if ($time_until_expiry <= 0) {
                        continue;
                    }
                    
                    // Check if notification should be sent
                    $should_notify = self::shouldSendNotification($session, $time_until_expiry);
                    
                    if ($should_notify) {
                        $notification_result = self::sendExpiryNotification($session, $time_until_expiry);
                        
                        if ($notification_result['success']) {
                            $results['notifications_sent']++;
                            self::recordNotification($session, $time_until_expiry);
                            
                            $results['processed_users'][] = [
                                'username' => $session->username,
                                'plan' => $session->namebp,
                                'time_left' => self::formatTimeLeft($time_until_expiry),
                                'notification_sent' => true
                            ];
                            
                            self::log("NOTIFICATION SENT: User {$session->username} - " . self::formatTimeLeft($time_until_expiry) . " remaining");
                        } else {
                            $results['errors']++;
                            self::log("NOTIFICATION FAILED: User {$session->username} - " . $notification_result['error']);
                        }
                    }
                    
                } catch (Exception $e) {
                    $results['errors']++;
                    self::log("ERROR: Processing user {$session->username}: " . $e->getMessage());
                }
            }
            
            self::log("=== Notification System Completed: {$results['notifications_sent']} sent, {$results['errors']} errors ===");
            
            return $results;
            
        } catch (Exception $e) {
            self::log("FATAL ERROR: " . $e->getMessage());
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Check if notification should be sent based on time intervals
     */
    private static function shouldSendNotification($session, $time_until_expiry)
    {
        // Find the appropriate notification interval
        $notification_interval = null;
        foreach (self::$notification_intervals as $interval) {
            if ($time_until_expiry <= $interval) {
                $notification_interval = $interval;
                break;
            }
        }
        
        if (!$notification_interval) {
            return false; // Too early to notify
        }
        
        // Check if we've already sent a notification for this interval
        $last_notification = self::getLastNotification($session->username);
        
        if ($last_notification && 
            $last_notification['interval'] == $notification_interval &&
            (time() - strtotime($last_notification['sent_at'])) < 300) { // Don't spam within 5 minutes
            return false;
        }
        
        return true;
    }
    
    /**
     * Send expiry notification to user
     */
    private static function sendExpiryNotification($session, $time_until_expiry)
    {
        global $config;
        
        try {
            // Get customer info
            $customer = ORM::for_table('tbl_customers')->where('id', $session->customer_id)->find_one();
            if (!$customer) {
                $customer = (object)[
                    'username' => $session->username,
                    'fullname' => $session->username,
                    'phonenumber' => '',
                    'email' => ''
                ];
            }
            
            // Format time left
            $time_left_str = self::formatTimeLeft($time_until_expiry);
            
            // Create notification message
            $message = self::createNotificationMessage($session, $time_left_str, $config);
            
            $success = false;
            $method = $config['user_notification_expired'] ?? 'none';
            
            switch ($method) {
                case 'sms':
                    if (!empty($customer->phonenumber)) {
                        $success = Message::sendSMS($customer->phonenumber, $message);
                        self::log("SMS notification sent to {$customer->phonenumber} for user {$session->username}");
                    }
                    break;
                    
                case 'wa':
                    if (!empty($customer->phonenumber)) {
                        $success = Message::sendWhatsapp($customer->phonenumber, $message);
                        self::log("WhatsApp notification sent to {$customer->phonenumber} for user {$session->username}");
                    }
                    break;
                    
                case 'email':
                    if (!empty($customer->email)) {
                        $success = Message::sendEmail($customer->email, 'Internet Package Expiry Warning', $message);
                        self::log("Email notification sent to {$customer->email} for user {$session->username}");
                    }
                    break;
                    
                default:
                    // Log only notification (no actual sending)
                    $success = true;
                    self::log("LOG-ONLY notification for user {$session->username}: {$message}");
            }
            
            return ['success' => $success, 'method' => $method, 'message' => $message];
            
        } catch (Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
    
    /**
     * Create notification message
     */
    private static function createNotificationMessage($session, $time_left_str, $config)
    {
        $company_name = $config['CompanyName'] ?? 'Internet Service Provider';
        
        if (strpos($time_left_str, 'hour') !== false || strpos($time_left_str, 'day') !== false) {
            // For longer time periods
            $message = "Hi {$session->username}!\n\n";
            $message .= "Your internet package '{$session->namebp}' will expire in {$time_left_str}.\n\n";
            $message .= "To avoid service interruption, please recharge your account before expiry.\n\n";
            $message .= "Thank you,\n{$company_name}";
        } else {
            // For urgent notifications (minutes)
            $message = "URGENT: Hi {$session->username}!\n\n";
            $message .= "Your internet package '{$session->namebp}' will expire in {$time_left_str}.\n\n";
            $message .= "Please recharge IMMEDIATELY to avoid disconnection.\n\n";
            $message .= "{$company_name}";
        }
        
        return $message;
    }
    
    /**
     * Record notification in database
     */
    private static function recordNotification($session, $time_until_expiry)
    {
        try {
            // Create notification record
            $notification = ORM::for_table('tbl_notifications')->create();
            $notification->username = $session->username;
            $notification->customer_id = $session->customer_id;
            $notification->type = 'expiry_warning';
            $notification->message = "Package expires in " . self::formatTimeLeft($time_until_expiry);
            $notification->time_until_expiry = $time_until_expiry;
            $notification->notification_interval = self::getIntervalForTime($time_until_expiry);
            $notification->sent_at = date('Y-m-d H:i:s');
            $notification->save();
            
        } catch (Exception $e) {
            // If notifications table doesn't exist, create it
            self::createNotificationsTable();
            
            // Try again
            try {
                $notification = ORM::for_table('tbl_notifications')->create();
                $notification->username = $session->username;
                $notification->customer_id = $session->customer_id;
                $notification->type = 'expiry_warning';
                $notification->message = "Package expires in " . self::formatTimeLeft($time_until_expiry);
                $notification->time_until_expiry = $time_until_expiry;
                $notification->notification_interval = self::getIntervalForTime($time_until_expiry);
                $notification->sent_at = date('Y-m-d H:i:s');
                $notification->save();
            } catch (Exception $e2) {
                self::log("Failed to record notification: " . $e2->getMessage());
            }
        }
    }
    
    /**
     * Get last notification for user
     */
    private static function getLastNotification($username)
    {
        try {
            $notification = ORM::for_table('tbl_notifications')
                ->where('username', $username)
                ->where('type', 'expiry_warning')
                ->order_by_desc('sent_at')
                ->find_one();
            
            if ($notification) {
                return [
                    'interval' => $notification->notification_interval,
                    'sent_at' => $notification->sent_at,
                    'time_until_expiry' => $notification->time_until_expiry
                ];
            }
            
            return null;
            
        } catch (Exception $e) {
            return null;
        }
    }
    
    /**
     * Get interval for given time
     */
    private static function getIntervalForTime($time_until_expiry)
    {
        foreach (self::$notification_intervals as $interval) {
            if ($time_until_expiry <= $interval) {
                return $interval;
            }
        }
        return 0;
    }
    
    /**
     * Format time left in human readable format
     */
    private static function formatTimeLeft($seconds)
    {
        if ($seconds < 60) {
            return $seconds . ' seconds';
        } elseif ($seconds < 3600) {
            $minutes = floor($seconds / 60);
            return $minutes . ' minute' . ($minutes != 1 ? 's' : '');
        } elseif ($seconds < 86400) {
            $hours = floor($seconds / 3600);
            $minutes = floor(($seconds % 3600) / 60);
            $result = $hours . ' hour' . ($hours != 1 ? 's' : '');
            if ($minutes > 0) {
                $result .= ' and ' . $minutes . ' minute' . ($minutes != 1 ? 's' : '');
            }
            return $result;
        } else {
            $days = floor($seconds / 86400);
            $hours = floor(($seconds % 86400) / 3600);
            $result = $days . ' day' . ($days != 1 ? 's' : '');
            if ($hours > 0) {
                $result .= ' and ' . $hours . ' hour' . ($hours != 1 ? 's' : '');
            }
            return $result;
        }
    }
    
    /**
     * Create notifications table if it doesn't exist
     */
    private static function createNotificationsTable()
    {
        try {
            $sql = "CREATE TABLE IF NOT EXISTS tbl_notifications (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(255) NOT NULL,
                customer_id INT,
                type VARCHAR(100) NOT NULL,
                message TEXT NOT NULL,
                time_until_expiry INT,
                notification_interval INT,
                sent_at DATETIME NOT NULL,
                INDEX idx_username_type (username, type),
                INDEX idx_sent_at (sent_at)
            )";
            
            ORM::raw_execute($sql);
            self::log("Created tbl_notifications table");
            
        } catch (Exception $e) {
            self::log("Failed to create notifications table: " . $e->getMessage());
        }
    }
    
    /**
     * Clean old notifications (older than 30 days)
     */
    public static function cleanOldNotifications()
    {
        try {
            $cutoff_date = date('Y-m-d H:i:s', strtotime('-30 days'));
            
            $deleted = ORM::for_table('tbl_notifications')
                ->where_lt('sent_at', $cutoff_date)
                ->delete_many();
            
            if ($deleted > 0) {
                self::log("Cleaned up {$deleted} old notifications");
            }
            
            return $deleted;
            
        } catch (Exception $e) {
            self::log("Error cleaning old notifications: " . $e->getMessage());
            return 0;
        }
    }
    
    /**
     * Get notification statistics
     */
    public static function getStatistics()
    {
        try {
            $stats = [];
            
            // Notifications sent today
            $today = date('Y-m-d');
            $stats['sent_today'] = ORM::for_table('tbl_notifications')
                ->where('type', 'expiry_warning')
                ->where_gte('sent_at', $today . ' 00:00:00')
                ->count();
            
            // Notifications sent this week
            $week_start = date('Y-m-d', strtotime('monday this week'));
            $stats['sent_this_week'] = ORM::for_table('tbl_notifications')
                ->where('type', 'expiry_warning')
                ->where_gte('sent_at', $week_start . ' 00:00:00')
                ->count();
            
            // Average notifications per day (last 7 days)
            $stats['avg_per_day'] = round($stats['sent_this_week'] / 7, 1);
            
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
        $logMessage = "[$timestamp] $message" . PHP_EOL;
        
        file_put_contents(self::$log_file, $logMessage, FILE_APPEND | LOCK_EX);
        
        // Also echo if running from command line
        if (php_sapi_name() === 'cli') {
            echo $logMessage;
        }
    }
}

// Command line execution
if (php_sapi_name() === 'cli') {
    echo "Expiry Notification System Starting...\n";
    $result = ExpiryNotificationSystem::processNotifications();
    echo "Notifications completed: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
    
    // Clean old notifications once daily
    $hour = date('H');
    if ($hour == '01') { // Run at 1 AM
        echo "Cleaning old notifications...\n";
        $cleaned = ExpiryNotificationSystem::cleanOldNotifications();
        echo "Cleaned {$cleaned} old notifications\n";
    }
}

// Web API endpoints
if (isset($_GET['action'])) {
    header('Content-Type: application/json');
    
    switch ($_GET['action']) {
        case 'process':
            echo json_encode(ExpiryNotificationSystem::processNotifications());
            break;
            
        case 'stats':
            echo json_encode(ExpiryNotificationSystem::getStatistics());
            break;
            
        case 'clean':
            $cleaned = ExpiryNotificationSystem::cleanOldNotifications();
            echo json_encode(['cleaned' => $cleaned]);
            break;
            
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
    exit;
}
?>