<?php
/**
 * Diagnostic script to identify why Daraja configuration is not appearing
 */

// Include the bootstrap file to initialize the system
require_once 'system/boot.php';

echo "<h1>Daraja Payment Gateway Diagnostic</h1>";

// Check 1: Verify PAYMENTGATEWAY_PATH constant
echo "<h2>1. Path Verification</h2>";
if (defined('PAYMENTGATEWAY_PATH')) {
    echo "<p>✓ PAYMENTGATEWAY_PATH defined: <code>" . PAYMENTGATEWAY_PATH . "</code></p>";
    
    // Check if the path exists
    if (is_dir(PAYMENTGATEWAY_PATH)) {
        echo "<p>✓ Payment gateway directory exists</p>";
        
        // List files in the directory
        $files = scandir(PAYMENTGATEWAY_PATH);
        echo "<p>Files in payment gateway directory:</p><ul>";
        foreach ($files as $file) {
            if ($file !== '.' && $file !== '..') {
                echo "<li>$file";
                if (pathinfo($file, PATHINFO_EXTENSION) === 'php') {
                    echo " <span style='color: green;'>(PHP Gateway)</span>";
                }
                echo "</li>";
            }
        }
        echo "</ul>";
    } else {
        echo "<p>✗ Payment gateway directory does not exist!</p>";
    }
} else {
    echo "<p>✗ PAYMENTGATEWAY_PATH not defined!</p>";
}

// Check 2: Verify Daraja.php file
echo "<h2>2. Daraja.php File Check</h2>";
$darajaFile = PAYMENTGATEWAY_PATH . DIRECTORY_SEPARATOR . 'Daraja.php';
if (file_exists($darajaFile)) {
    echo "<p>✓ Daraja.php file exists at: <code>$darajaFile</code></p>";
    
    // Check if file is readable
    if (is_readable($darajaFile)) {
        echo "<p>✓ Daraja.php file is readable</p>";
        
        // Include the file and check functions
        include_once $darajaFile;
        
        if (function_exists('Daraja_show_config')) {
            echo "<p>✓ Daraja_show_config function exists</p>";
        } else {
            echo "<p>✗ Daraja_show_config function not found!</p>";
        }
        
        if (function_exists('Daraja_save_config')) {
            echo "<p>✓ Daraja_save_config function exists</p>";
        } else {
            echo "<p>✗ Daraja_save_config function not found!</p>";
        }
    } else {
        echo "<p>✗ Daraja.php file is not readable!</p>";
    }
} else {
    echo "<p>✗ Daraja.php file does not exist at: <code>$darajaFile</code></p>";
}

// Check 3: Database table verification
echo "<h2>3. Database Table Check</h2>";
try {
    // Check if tbl_pg table exists
    $query = $db->query("SHOW TABLES LIKE 'tbl_pg'");
    $tableExists = $query->fetch();
    
    if ($tableExists) {
        echo "<p>✓ tbl_pg table exists</p>";
        
        // Check for Daraja record
        $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
        if ($pg) {
            echo "<p>✓ Daraja configuration record exists in database</p>";
            echo "<p>Status: " . ($pg['status'] ? 'Active' : 'Inactive') . "</p>";
            $pgData = json_decode($pg['pg_data'], true);
            if ($pgData) {
                echo "<p>Configuration data:</p><pre>" . print_r($pgData, true) . "</pre>";
            }
        } else {
            echo "<p>✗ Daraja configuration record not found in tbl_pg table</p>";
        }
    } else {
        echo "<p>✗ tbl_pg table does not exist!</p>";
        echo "<p>This is likely the main issue. The Daraja gateway requires the tbl_pg table.</p>";
    }
    
    // Check tbl_payment_gateway table
    $query = $db->query("SHOW TABLES LIKE 'tbl_payment_gateway'");
    $tableExists = $query->fetch();
    if ($tableExists) {
        echo "<p>✓ tbl_payment_gateway table exists</p>";
    } else {
        echo "<p>✗ tbl_payment_gateway table does not exist!</p>";
    }
    
} catch (Exception $e) {
    echo "<p>✗ Database error: " . $e->getMessage() . "</p>";
}

// Check 4: Active payment gateways configuration
echo "<h2>4. Active Payment Gateways Check</h2>";
try {
    $pgConfig = ORM::for_table('tbl_appconfig')->where('setting', 'payment_gateway')->find_one();
    if ($pgConfig) {
        echo "<p>✓ payment_gateway configuration exists</p>";
        echo "<p>Active gateways: <code>" . $pgConfig['value'] . "</code></p>";
        
        $activeGateways = explode(',', $pgConfig['value']);
        if (in_array('Daraja', $activeGateways)) {
            echo "<p>✓ Daraja is in the active gateways list</p>";
        } else {
            echo "<p>✗ Daraja is not in the active gateways list</p>";
        }
    } else {
        echo "<p>✗ payment_gateway configuration not found in tbl_appconfig</p>";
    }
} catch (Exception $e) {
    echo "<p>✗ Error checking payment gateway configuration: " . $e->getMessage() . "</p>";
}

// Check 5: Template file verification
echo "<h2>5. Template File Check</h2>";
$templatePath = $ui->template_dir[0] . 'paymentgateway/Daraja.tpl';
if (file_exists($templatePath)) {
    echo "<p>✓ Daraja.tpl template exists at: <code>$templatePath</code></p>";
} else {
    echo "<p>✗ Daraja.tpl template not found at: <code>$templatePath</code></p>";
    
    // Check alternative paths
    foreach ($ui->template_dir as $index => $dir) {
        $altPath = $dir . 'paymentgateway/Daraja.tpl';
        if (file_exists($altPath)) {
            echo "<p>✓ Found template at alternative path [$index]: <code>$altPath</code></p>";
        }
    }
}

// Check 6: URL routing simulation
echo "<h2>6. URL Routing Test</h2>";
$testAction = 'Daraja';
$testFile = PAYMENTGATEWAY_PATH . DIRECTORY_SEPARATOR . $testAction . '.php';

echo "<p>Testing route: <code>/paymentgateway/Daraja</code></p>";
echo "<p>Expected file path: <code>$testFile</code></p>";

if (file_exists($testFile)) {
    echo "<p>✓ File exists for routing</p>";
    
    // Simulate the controller logic
    echo "<p>Testing function calls:</p>";
    
    if (function_exists($testAction . '_show_config')) {
        echo "<p>✓ Show config function callable: <code>{$testAction}_show_config</code></p>";
    } else {
        echo "<p>✗ Show config function not callable: <code>{$testAction}_show_config</code></p>";
    }
    
    if (function_exists($testAction . '_save_config')) {
        echo "<p>✓ Save config function callable: <code>{$testAction}_save_config</code></p>";
    } else {
        echo "<p>✗ Save config function not callable: <code>{$testAction}_save_config</code></p>";
    }
} else {
    echo "<p>✗ File does not exist for routing</p>";
}

echo "<h2>Recommended Actions</h2>";
echo "<ol>";
if (!$tableExists) {
    echo "<li><strong>CRITICAL:</strong> Run the SQL script to create the tbl_pg table: <code>create_tbl_pg.sql</code></li>";
}
echo "<li>Ensure the Daraja.php file has correct permissions</li>";
echo "<li>Verify that the web server can read the payment gateway directory</li>";
echo "<li>Check that all required functions exist in Daraja.php</li>";
echo "<li>Test by visiting: <a href='paymentgateway/Daraja'>paymentgateway/Daraja</a></li>";
echo "</ol>";

echo "<hr>";
echo "<p><a href='./'>← Back to Home</a> | <a href='paymentgateway'>Payment Gateways</a></p>";
?>