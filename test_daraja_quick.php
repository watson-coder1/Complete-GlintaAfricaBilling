<?php
/**
 * Quick test to verify Daraja functions are accessible
 */

require_once 'init.php';

echo "<h1>Quick Daraja Test</h1>";

// Check if Daraja file exists
$darajaFile = 'system/paymentgateway/Daraja.php';
if (file_exists($darajaFile)) {
    echo "<p>✅ Daraja.php file exists</p>";
    
    // Include the file
    include_once $darajaFile;
    
    // Test function existence
    if (function_exists('Daraja_show_config')) {
        echo "<p>✅ Daraja_show_config function exists</p>";
    } else {
        echo "<p>❌ Daraja_show_config function missing</p>";
    }
    
    if (function_exists('Daraja_save_config')) {
        echo "<p>✅ Daraja_save_config function exists</p>";
    } else {
        echo "<p>❌ Daraja_save_config function missing</p>";
    }
    
    // Check database
    try {
        $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
        if ($pg) {
            echo "<p>✅ Daraja configuration found in database</p>";
        } else {
            echo "<p>❌ Daraja configuration not found in database</p>";
        }
    } catch (Exception $e) {
        echo "<p>❌ Database error: " . $e->getMessage() . "</p>";
    }
    
} else {
    echo "<p>❌ Daraja.php file not found</p>";
}

echo "<hr>";
echo "<p><strong>Status:</strong> Daraja gateway should now be accessible at: <a href='" . U . "paymentgateway/Daraja' target='_blank'>" . U . "paymentgateway/Daraja</a></p>";
echo "<p><em>Note: You need to be logged in as admin to access the configuration page.</em></p>";
?>