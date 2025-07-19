<?php
/**
 * Captive Portal Session Monitor
 * Monitors active sessions and automatically disconnects expired users
 * Run this script every minute via cron: * * * * * php /path/to/captive_portal_session_monitor.php
 */

// Include initialization
if (file_exists("init.php")) {
    include "init.php";
} else if (file_exists("/var/www/html/init.php")) {
    include "/var/www/html/init.php";
} else {
    echo "Init file not found!\n";
    exit(1);
}

// Lock file to prevent multiple instances
$lockFile = $CACHE_PATH . '/captive_portal_monitor.lock';
$lock = fopen($lockFile, 'c');
if (!flock($lock, LOCK_EX | LOCK_NB)) {
    echo "Monitor already running\n";
    exit;
}

echo "=== Captive Portal Session Monitor " . date('Y-m-d H:i:s') . " ===\n";

// Check all active portal sessions
$activeSessions = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_like('username', '%:%:%:%:%:%') // MAC address format
    ->find_many();

echo "Found " . count($activeSessions) . " active MAC-based sessions\n";

foreach ($activeSessions as $session) {
    $currentTime = time();
    $expirationTime = strtotime($session->expiration . ' ' . $session->time);
    
    echo "Checking " . $session->username . " - Expires: " . $session->expiration . " " . $session->time;
    
    if ($currentTime >= $expirationTime) {
        echo " - EXPIRED - Disconnecting...\n";
        
        try {
            // Get plan details
            $plan = ORM::for_table('tbl_plans')->find_one($session->plan_id);
            
            if ($plan) {
                // Load device handler
                $dvc = Package::getDevice($plan);
                if (file_exists($dvc)) {
                    require_once $dvc;
                    
                    // Create customer object for device handler
                    $customer = [
                        'username' => $session->username,
                        'id' => 0,
                        'fullname' => 'Portal User'
                    ];
                    
                    // Disconnect user from MikroTik/RADIUS
                    (new $plan['device'])->remove_customer($customer, $plan);
                    
                    echo "  - Disconnected from " . $plan['device'] . "\n";
                }
            }
            
            // Update session status
            $session->status = 'off';
            $session->save();
            
            // Update portal session if exists
            $portalSession = ORM::for_table('tbl_portal_sessions')
                ->where('mac_address', $session->username)
                ->where('status', 'completed')
                ->find_one();
                
            if ($portalSession) {
                $portalSession->status = 'expired';
                $portalSession->save();
            }
            
            // Log the disconnection
            file_put_contents($UPLOAD_PATH . '/captive_portal_disconnections.log',
                date('Y-m-d H:i:s') . " - Disconnected expired user: " . $session->username . "\n",
                FILE_APPEND);
                
        } catch (Exception $e) {
            echo "  - ERROR: " . $e->getMessage() . "\n";
            file_put_contents($UPLOAD_PATH . '/captive_portal_errors.log',
                date('Y-m-d H:i:s') . " - Error disconnecting " . $session->username . ": " . $e->getMessage() . "\n",
                FILE_APPEND);
        }
    } else {
        $remainingMinutes = round(($expirationTime - $currentTime) / 60);
        echo " - Active (" . $remainingMinutes . " minutes remaining)\n";
        
        // Send warning notification if less than 5 minutes remaining
        if ($remainingMinutes <= 5 && $remainingMinutes > 0) {
            $portalSession = ORM::for_table('tbl_portal_sessions')
                ->where('mac_address', $session->username)
                ->find_one();
                
            if ($portalSession && !$portalSession->expiry_warning_sent) {
                // Mark warning as sent
                $portalSession->expiry_warning_sent = 1;
                $portalSession->save();
                
                echo "  - Sending expiry warning\n";
                
                // Log warning
                file_put_contents($UPLOAD_PATH . '/captive_portal_warnings.log',
                    date('Y-m-d H:i:s') . " - Warning sent to " . $session->username . " - " . $remainingMinutes . " minutes remaining\n",
                    FILE_APPEND);
            }
        }
    }
}

// Clean up old portal sessions (older than 24 hours)
$oldSessions = ORM::for_table('tbl_portal_sessions')
    ->where_lt('created_at', date('Y-m-d H:i:s', strtotime('-24 hours')))
    ->where_not_equal('status', 'completed')
    ->delete_many();
    
echo "\nCleaned up $oldSessions old portal sessions\n";

// Release lock
flock($lock, LOCK_UN);
fclose($lock);

echo "=== Monitor completed ===\n";