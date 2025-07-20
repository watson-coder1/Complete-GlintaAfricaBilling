<?php
/**
 * Test script to debug captive portal issues
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h1>Captive Portal Debug Test</h1>";

// Check if main includes exist
echo "<h2>1. File Existence Check</h2>";
$files_to_check = [
    'init.php',
    'system/controllers/captive_portal.php',
    'ui/ui/captive_portal.tpl',
    'ui/ui/captive_portal_success.tpl'
];

foreach ($files_to_check as $file) {
    echo "- $file: " . (file_exists($file) ? "✅ EXISTS" : "❌ MISSING") . "<br>";
}

// Check template directory
echo "<h2>2. Template Directory</h2>";
if (is_dir('ui/ui')) {
    $templates = glob('ui/ui/captive_portal*.tpl');
    echo "Found templates:<br>";
    foreach ($templates as $template) {
        echo "- " . basename($template) . "<br>";
    }
} else {
    echo "❌ Template directory not found";
}

// Test basic PHP
echo "<h2>3. PHP Test</h2>";
try {
    require_once 'init.php';
    echo "✅ init.php loaded successfully<br>";
    
    // Check database connection
    $db_test = ORM::for_table('tbl_appconfig')->limit(1)->find_one();
    if ($db_test) {
        echo "✅ Database connection working<br>";
    } else {
        echo "❌ Database connection failed<br>";
    }
    
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "<br>";
}

// Check if Smarty is working
echo "<h2>4. Smarty Template Engine</h2>";
try {
    global $ui;
    if (isset($ui)) {
        echo "✅ Smarty object exists<br>";
        echo "Template dir: " . $ui->getTemplateDir()[0] . "<br>";
        echo "Compile dir: " . $ui->getCompileDir() . "<br>";
    } else {
        echo "❌ Smarty object not found<br>";
    }
} catch (Exception $e) {
    echo "❌ Smarty error: " . $e->getMessage() . "<br>";
}

// Check M-Pesa configuration
echo "<h2>5. M-Pesa Configuration</h2>";
try {
    $mpesa_config = ORM::for_table('tbl_appconfig')
        ->where('setting', 'mpesa_consumer_key')
        ->find_one();
        
    if ($mpesa_config) {
        echo "✅ M-Pesa consumer key configured<br>";
    } else {
        echo "❌ M-Pesa consumer key missing<br>";
    }
    
    $daraja_config = ORM::for_table('tbl_pg')
        ->where('gateway', 'Daraja')
        ->find_one();
        
    if ($daraja_config) {
        echo "✅ Daraja gateway configured<br>";
        $pg_data = json_decode($daraja_config->pg_data, true);
        echo "Environment: " . ($pg_data['environment'] ?? 'not set') . "<br>";
    } else {
        echo "❌ Daraja gateway not configured<br>";
    }
    
} catch (Exception $e) {
    echo "❌ Config check error: " . $e->getMessage() . "<br>";
}

echo "<h2>6. Recent Payment Records</h2>";
try {
    $recent_payments = ORM::for_table('tbl_payment_gateway')
        ->order_by_desc('id')
        ->limit(5)
        ->find_many();
        
    if ($recent_payments) {
        echo "<table border='1'>";
        echo "<tr><th>ID</th><th>Username</th><th>Plan</th><th>Status</th><th>Created</th></tr>";
        foreach ($recent_payments as $payment) {
            echo "<tr>";
            echo "<td>" . $payment->id . "</td>";
            echo "<td>" . $payment->username . "</td>";
            echo "<td>" . $payment->plan_name . "</td>";
            echo "<td>" . $payment->status . "</td>";
            echo "<td>" . $payment->created_date . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "No payment records found<br>";
    }
} catch (Exception $e) {
    echo "❌ Payment check error: " . $e->getMessage() . "<br>";
}

?>