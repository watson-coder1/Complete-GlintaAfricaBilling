<?php

/**
 * Clear all existing RADIUS users and reset access control
 * This script will remove all current RADIUS users so only paying customers get access
 */

require_once('init.php');

try {
    echo "Starting RADIUS user cleanup...\n";
    
    // Clear all RADIUS user tables
    $tables_to_clear = [
        'radcheck',
        'radreply', 
        'radgroupcheck',
        'radgroupreply',
        'radusergroup'
    ];
    
    foreach ($tables_to_clear as $table) {
        $deleted = ORM::for_table($table, 'radius')->delete_many();
        echo "Cleared $deleted records from $table\n";
    }
    
    // Clear active accounting sessions
    $active_sessions = ORM::for_table('radacct', 'radius')
        ->where_null('acctstoptime')
        ->find_many();
        
    foreach ($active_sessions as $session) {
        $session->acctstoptime = date('Y-m-d H:i:s');
        $session->acctterminatecause = 'Admin-Reset';
        $session->save();
    }
    
    echo "Terminated " . count($active_sessions) . " active sessions\n";
    
    // Set all user recharges to expired
    $active_recharges = ORM::for_table('tbl_user_recharges')
        ->where('status', 'on')
        ->find_many();
        
    foreach ($active_recharges as $recharge) {
        $recharge->status = 'off';
        $recharge->save();
    }
    
    echo "Expired " . count($active_recharges) . " active user recharges\n";
    
    echo "\n=== RADIUS CLEANUP COMPLETE ===\n";
    echo "✅ All existing RADIUS users have been removed\n";
    echo "✅ All active sessions have been terminated\n";
    echo "✅ All user recharges have been expired\n";
    echo "✅ System is now ready for payment-only access\n";
    echo "\nOnly users who make new payments will get internet access.\n";
    
} catch (Exception $e) {
    echo "Error during cleanup: " . $e->getMessage() . "\n";
}

?>