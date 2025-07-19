<?php
/**
 * Test script to verify Daraja payment gateway functions
 */

require_once 'system/boot.php';

echo "<h1>Daraja Function Test</h1>";

// Include the Daraja gateway file
$darajaFile = PAYMENTGATEWAY_PATH . DIRECTORY_SEPARATOR . 'Daraja.php';

if (file_exists($darajaFile)) {
    echo "<p>✓ Including Daraja.php file...</p>";
    include_once $darajaFile;
    
    // Test function existence
    $functions = ['Daraja_show_config', 'Daraja_save_config', 'Daraja_test_connection', 'Daraja_get_status', 'Daraja_payment_link', 'Daraja_process_payment'];
    
    echo "<h2>Function Availability Test</h2>";
    foreach ($functions as $func) {
        if (function_exists($func)) {
            echo "<p>✓ <code>$func</code> - Available</p>";
        } else {
            echo "<p>✗ <code>$func</code> - Not found</p>";
        }
    }
    
    // Test the show_config function
    echo "<h2>Show Config Function Test</h2>";
    if (function_exists('Daraja_show_config')) {
        echo "<p>Testing Daraja_show_config function...</p>";
        
        try {
            // Capture output
            ob_start();
            Daraja_show_config();
            $output = ob_get_clean();
            
            if (!empty($output)) {
                echo "<p>✓ Function executed and produced output</p>";
                echo "<details><summary>View Output</summary><pre>" . htmlspecialchars($output) . "</pre></details>";
            } else {
                echo "<p>⚠ Function executed but produced no output</p>";
            }
        } catch (Exception $e) {
            echo "<p>✗ Function execution failed: " . $e->getMessage() . "</p>";
        }
    }
    
    // Test database connection
    echo "<h2>Database Connection Test</h2>";
    try {
        $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
        if ($pg) {
            echo "<p>✓ Successfully connected to database and found Daraja record</p>";
        } else {
            echo "<p>⚠ Database connection OK but no Daraja record found</p>";
        }
    } catch (Exception $e) {
        echo "<p>✗ Database connection failed: " . $e->getMessage() . "</p>";
    }
    
} else {
    echo "<p>✗ Daraja.php file not found at: <code>$darajaFile</code></p>";
}

echo "<hr>";
echo "<p><a href='./'>← Back to Home</a> | <a href='paymentgateway/Daraja'>Test Daraja Config</a></p>";
?>