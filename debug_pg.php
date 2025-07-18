<?php
// Debug script to check payment gateway system
require_once 'system/boot.php';

echo "<h2>Payment Gateway Debug</h2>";

// Check if PAYMENTGATEWAY_PATH is defined
echo "<h3>Path Constants:</h3>";
echo "PAYMENTGATEWAY_PATH: " . (defined('PAYMENTGATEWAY_PATH') ? PAYMENTGATEWAY_PATH : 'NOT DEFINED') . "<br>";
echo "Actual path: " . __DIR__ . '/system/paymentgateway/<br>';

// Check directory contents
echo "<h3>Directory Contents:</h3>";
$path = __DIR__ . '/system/paymentgateway/';
if (is_dir($path)) {
    $files = scandir($path);
    echo "<ul>";
    foreach ($files as $file) {
        if ($file != '.' && $file != '..') {
            echo "<li>$file";
            if (pathinfo($file, PATHINFO_EXTENSION) == 'php') {
                echo " (PHP file)";
            }
            echo "</li>";
        }
    }
    echo "</ul>";
} else {
    echo "Directory not found!<br>";
}

// Check database
echo "<h3>Database Tables:</h3>";
try {
    $tables = $db->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
    echo "<ul>";
    foreach ($tables as $table) {
        echo "<li>$table</li>";
    }
    echo "</ul>";
    
    // Check if tbl_pg exists
    if (in_array('tbl_pg', $tables)) {
        echo "<p style='color:green'>✓ Payment gateway table (tbl_pg) exists</p>";
        
        // Check contents
        $pgs = ORM::for_table('tbl_pg')->find_many();
        if (count($pgs) > 0) {
            echo "<h4>Configured Gateways:</h4>";
            echo "<ul>";
            foreach ($pgs as $pg) {
                echo "<li>{$pg->gateway} - Status: " . ($pg->status ? 'Active' : 'Inactive') . "</li>";
            }
            echo "</ul>";
        } else {
            echo "<p>No payment gateways configured yet.</p>";
        }
    } else {
        echo "<p style='color:red'>✗ Payment gateway table (tbl_pg) missing!</p>";
    }
    
} catch (Exception $e) {
    echo "<p style='color:red'>Database error: " . $e->getMessage() . "</p>";
}

echo "<hr>";
echo "<p><a href='./'>Back to Home</a> | <a href='paymentgateway'>Go to Payment Gateway</a></p>";