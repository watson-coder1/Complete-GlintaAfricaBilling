<?php
// Simple test captive portal to bypass routing issues
include "init.php";

// Get packages from database
try {
    $packages = ORM::for_table('tbl_plans')
        ->where('enabled', 1)
        ->where('type', 'Hotspot')
        ->order_by_asc('price')
        ->find_many();
    
    $mac = $_GET['mac'] ?? 'test-device';
    $ip = $_GET['ip'] ?? $_SERVER['REMOTE_ADDR'];
    $session_id = uniqid('portal_');
    
    // Assign template variables
    $ui->assign('packages', $packages);
    $ui->assign('mac', $mac);
    $ui->assign('ip', $ip); 
    $ui->assign('session_id', $session_id);
    $ui->assign('_url', APP_URL . '/');
    
    // Display template
    $ui->display('captive_portal_landing.tpl');
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "<br>";
    echo "Database connection issue. Please check configuration.";
}
?>