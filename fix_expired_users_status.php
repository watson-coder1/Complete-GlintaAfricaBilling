<?php

/**
 * Fix Expired Users Status - Automated Maintenance
 * Updates user recharge statuses for expired users
 * Should be run regularly via cron job
 */

require_once 'init.php';

$current_date = date('Y-m-d');
$current_datetime = date('Y-m-d H:i:s');

echo "🔧 Starting Expired Users Status Fix - " . date('Y-m-d H:i:s') . "\n";

// Find users marked as 'on' but actually expired
$expired_users = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_lt('expiration', $current_date)
    ->find_many();

$count = 0;
$details = [];

foreach ($expired_users as $user) {
    $details[] = [
        'username' => $user->username,
        'plan' => $user->namebp,
        'expired_on' => $user->expiration,
        'days_expired' => (strtotime($current_date) - strtotime($user->expiration)) / 86400
    ];
    
    $user->status = 'off';
    $user->save();
    $count++;
}

echo "✅ Updated $count expired users from 'on' to 'off' status\n";

if ($count > 0) {
    echo "\n📋 Details of updated users:\n";
    foreach ($details as $detail) {
        echo sprintf("- %s (%s) - Expired: %s (%d days ago)\n",
            $detail['username'],
            $detail['plan'],
            $detail['expired_on'],
            round($detail['days_expired'])
        );
    }
}

// Also update RADIUS if enabled
if ($config['radius_enable'] == 'yes') {
    try {
        // Remove expired users from RADIUS tables
        $radius_updated = 0;
        foreach ($expired_users as $user) {
            // Remove from radcheck
            $deleted_check = ORM::for_table('radcheck', 'radius')
                ->where('username', $user->username)
                ->delete_many();
            
            // Remove from radreply
            $deleted_reply = ORM::for_table('radreply', 'radius')
                ->where('username', $user->username)
                ->delete_many();
                
            if ($deleted_check > 0 || $deleted_reply > 0) {
                $radius_updated++;
            }
        }
        
        if ($radius_updated > 0) {
            echo "✅ Updated $radius_updated users in RADIUS tables\n";
        }
    } catch (Exception $e) {
        echo "⚠️ RADIUS update failed: " . $e->getMessage() . "\n";
    }
}

// Clear relevant cache files
$cache_files = [
    'activeUsersByService.temp',
    'monthlyRegistered.temp',
    'monthlyRegisteredByService.temp'
];

$cache_cleared = 0;
foreach ($cache_files as $cache_file) {
    $file_path = $CACHE_PATH . DIRECTORY_SEPARATOR . $cache_file;
    if (file_exists($file_path)) {
        unlink($file_path);
        $cache_cleared++;
    }
}

if ($cache_cleared > 0) {
    echo "✅ Cleared $cache_cleared cache files\n";
}

echo "✅ Maintenance complete - " . date('Y-m-d H:i:s') . "\n\n";

// Log the maintenance action
$log = ORM::for_table('tbl_logs')->create();
$log->user = 'System';
$log->name = 'Expired Users Maintenance';
$log->description = "Updated $count expired users status from 'on' to 'off'";
$log->date = $current_datetime;
$log->save();

?>