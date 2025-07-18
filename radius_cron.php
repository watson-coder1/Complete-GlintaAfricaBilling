<?php

/**
 * RADIUS Automatic Session Management Cron Job
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * 
 * Run this every 5 minutes via cron:
 * */5 * * * * /usr/bin/php /path/to/radius_cron.php >> /var/log/radius_cron.log 2>&1
 */

// Prevent web access
if (php_sapi_name() !== 'cli') {
    die('This script can only be run from command line');
}

// Set working directory
chdir(__DIR__);

require_once 'init.php';

echo "[" . date('Y-m-d H:i:s') . "] RADIUS Cron Job Started\n";

try {
    // Load RadiusManager
    if (!class_exists('RadiusManager')) {
        require_once 'system/autoload/RadiusManager.php';
    }
    
    // 1. Process expired users
    echo "Processing expired users...\n";
    $expired_result = RadiusManager::processExpiredUsers();
    
    if ($expired_result['success']) {
        echo "✅ Processed {$expired_result['processed']} expired users\n";
    } else {
        echo "❌ Error processing expired users: " . $expired_result['message'] . "\n";
    }
    
    // 2. Check for users with exceeded session time
    echo "Checking session time limits...\n";
    $session_checks = 0;
    
    try {
        // Get users with active sessions and time limits
        $active_sessions = ORM::for_table('radacct', 'radius')
            ->where_null('acctstoptime')
            ->find_many();
        
        foreach ($active_sessions as $session) {
            // Check if user has session timeout
            $timeout_check = ORM::for_table('radcheck', 'radius')
                ->where('username', $session->username)
                ->where('attribute', 'Session-Timeout')
                ->find_one();
            
            if ($timeout_check) {
                $session_duration = time() - strtotime($session->acctstarttime);
                $timeout_limit = intval($timeout_check->value);
                
                if ($session_duration >= $timeout_limit) {
                    // Session exceeded time limit, disconnect
                    echo "⏰ Disconnecting user {$session->username} (session timeout exceeded)\n";
                    RadiusManager::disconnectUser($session->username);
                    $session_checks++;
                }
            }
        }
        
        echo "✅ Checked {$session_checks} sessions for timeout\n";
        
    } catch (Exception $e) {
        echo "❌ Error checking session timeouts: " . $e->getMessage() . "\n";
    }
    
    // 3. Check for users with exceeded data limits
    echo "Checking data limits...\n";
    $data_checks = 0;
    
    try {
        $active_sessions = ORM::for_table('radacct', 'radius')
            ->where_null('acctstoptime')
            ->find_many();
        
        foreach ($active_sessions as $session) {
            // Check if user has data limit
            $data_limit_check = ORM::for_table('radcheck', 'radius')
                ->where('username', $session->username)
                ->where('attribute', 'Max-Octets')
                ->find_one();
            
            if ($data_limit_check) {
                $total_data = ($session->acctinputoctets ?? 0) + ($session->acctoutputoctets ?? 0);
                $data_limit = intval($data_limit_check->value);
                
                if ($total_data >= $data_limit) {
                    // Data limit exceeded, disconnect
                    echo "📊 Disconnecting user {$session->username} (data limit exceeded)\n";
                    RadiusManager::disconnectUser($session->username);
                    $data_checks++;
                }
            }
        }
        
        echo "✅ Checked {$data_checks} sessions for data limits\n";
        
    } catch (Exception $e) {
        echo "❌ Error checking data limits: " . $e->getMessage() . "\n";
    }
    
    // 4. Clean old accounting records (run once daily)
    $hour = date('H');
    if ($hour == '02') { // Run at 2 AM
        echo "Cleaning old accounting records...\n";
        $clean_result = RadiusManager::cleanOldRecords(90); // Keep 90 days
        
        if ($clean_result['success']) {
            echo "✅ Cleaned {$clean_result['deleted']} old records\n";
        } else {
            echo "❌ Error cleaning records: " . $clean_result['message'] . "\n";
        }
    }
    
    // 5. Update active user counts in cache
    echo "Updating active user statistics...\n";
    try {
        $hotspot_online = ORM::for_table('radacct', 'radius')
            ->where_null('acctstoptime')
            ->count();
        
        $pppoe_active = ORM::for_table('tbl_customers')
            ->where('service_type', 'PPPoE')
            ->where('status', 'Active')
            ->count();
        
        // Update cache file for dashboard
        $cache_data = [
            'hotspot_online' => $hotspot_online,
            'pppoe_active' => $pppoe_active,
            'last_updated' => time()
        ];
        
        $cache_file = $CACHE_PATH . '/realtime_users.json';
        file_put_contents($cache_file, json_encode($cache_data));
        
        echo "✅ Updated user statistics: {$hotspot_online} hotspot, {$pppoe_active} PPPoE\n";
        
    } catch (Exception $e) {
        echo "❌ Error updating statistics: " . $e->getMessage() . "\n";
    }
    
    // 6. Log completion
    $timestamp_file = $UPLOAD_PATH . '/radius_cron_last_run.txt';
    file_put_contents($timestamp_file, time());
    
    echo "✅ RADIUS Cron Job Completed Successfully\n";
    
} catch (Exception $e) {
    echo "❌ Fatal Error: " . $e->getMessage() . "\n";
    _log('RADIUS Cron Fatal Error: ' . $e->getMessage(), 'RADIUS', 0);
}

echo "[" . date('Y-m-d H:i:s') . "] RADIUS Cron Job Finished\n\n";
?>