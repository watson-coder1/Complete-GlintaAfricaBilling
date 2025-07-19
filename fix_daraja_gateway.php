<?php
/**
 * Fix Daraja M-Pesa Gateway Configuration Issues
 * This script will automatically fix common issues preventing Daraja from appearing in admin
 */

require_once 'init.php';

echo "<h2>🔧 Fixing Daraja M-Pesa Gateway Configuration</h2>";
echo "<hr>";

// Check if tbl_pg table exists
echo "<h3>1. Checking Database Table...</h3>";
try {
    $test = ORM::for_table('tbl_pg')->limit(1)->find_many();
    echo "✅ tbl_pg table exists<br>";
} catch (Exception $e) {
    echo "❌ tbl_pg table missing. Creating it...<br>";
    
    // Create tbl_pg table
    $sql = "
    CREATE TABLE IF NOT EXISTS `tbl_pg` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `gateway` varchar(50) NOT NULL,
        `pg_data` text,
        `status` tinyint(1) DEFAULT 0,
        `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`id`),
        UNIQUE KEY `gateway` (`gateway`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    
    try {
        $db = ORM::get_db();
        $db->exec($sql);
        echo "✅ tbl_pg table created successfully<br>";
    } catch (Exception $e) {
        echo "❌ Error creating table: " . $e->getMessage() . "<br>";
    }
}

// Check if Daraja configuration exists
echo "<h3>2. Checking Daraja Configuration...</h3>";
$daraja_config = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();

if (!$daraja_config) {
    echo "❌ Daraja configuration missing. Creating default configuration...<br>";
    
    // Create default Daraja configuration
    $daraja_config = ORM::for_table('tbl_pg')->create();
    $daraja_config->gateway = 'Daraja';
    $daraja_config->pg_data = json_encode([
        'consumer_key' => '',
        'consumer_secret' => '',
        'shortcode' => '',
        'passkey' => '',
        'environment' => 'sandbox',
        'callback_url' => U . 'callback/daraja',
        'timeout_url' => U . 'callback/daraja'
    ]);
    $daraja_config->status = 0;
    $daraja_config->save();
    
    echo "✅ Daraja configuration created<br>";
} else {
    echo "✅ Daraja configuration exists<br>";
}

// Check if Daraja is in active payment gateways
echo "<h3>3. Checking Active Payment Gateways...</h3>";
$active_gateways = $config['payment_gateway'] ?? '';
$gateway_list = explode(',', $active_gateways);

if (!in_array('Daraja', $gateway_list)) {
    echo "❌ Daraja not in active gateways list. Adding it...<br>";
    
    $gateway_list[] = 'Daraja';
    $new_gateway_list = implode(',', array_filter($gateway_list));
    
    // Update config
    $config_row = ORM::for_table('tbl_appconfig')->where('setting', 'payment_gateway')->find_one();
    if ($config_row) {
        $config_row->value = $new_gateway_list;
        $config_row->save();
        echo "✅ Daraja added to active gateways<br>";
    } else {
        // Create config if it doesn't exist
        $config_row = ORM::for_table('tbl_appconfig')->create();
        $config_row->setting = 'payment_gateway';
        $config_row->value = $new_gateway_list;
        $config_row->save();
        echo "✅ Payment gateway config created with Daraja<br>";
    }
} else {
    echo "✅ Daraja is already in active gateways<br>";
}

// Check file permissions and existence
echo "<h3>4. Checking Files...</h3>";

$files_to_check = [
    'system/paymentgateway/Daraja.php' => 'Daraja Gateway File',
    'ui/ui/paymentgateway/Daraja.tpl' => 'Daraja Template File'
];

foreach ($files_to_check as $file => $description) {
    if (file_exists($file)) {
        echo "✅ $description exists<br>";
        if (is_readable($file)) {
            echo "✅ $description is readable<br>";
        } else {
            echo "❌ $description is not readable<br>";
        }
    } else {
        echo "❌ $description missing<br>";
    }
}

// Test Daraja functions
echo "<h3>5. Testing Daraja Functions...</h3>";
if (file_exists('system/paymentgateway/Daraja.php')) {
    include_once 'system/paymentgateway/Daraja.php';
    
    if (function_exists('Daraja_show_config')) {
        echo "✅ Daraja_show_config function exists<br>";
    } else {
        echo "❌ Daraja_show_config function missing<br>";
    }
    
    if (function_exists('Daraja_save_config')) {
        echo "✅ Daraja_save_config function exists<br>";
    } else {
        echo "❌ Daraja_save_config function missing<br>";
    }
} else {
    echo "❌ Cannot test functions - Daraja.php file missing<br>";
}

echo "<h3>6. Final Status</h3>";
echo "<div style='background: #d4edda; padding: 15px; border-radius: 5px; border: 1px solid #c3e6cb;'>";
echo "🎉 <strong>Fix completed!</strong><br><br>";
echo "Now try accessing: <a href='" . U . "paymentgateway/Daraja' target='_blank'>" . U . "paymentgateway/Daraja</a><br><br>";
echo "You should now see the Daraja M-Pesa configuration page in your admin panel.";
echo "</div>";

echo "<hr>";
echo "<p><strong>Next Steps:</strong></p>";
echo "<ol>";
echo "<li>Visit <a href='" . U . "paymentgateway/Daraja' target='_blank'>Daraja Configuration</a></li>";
echo "<li>Enter your M-Pesa API credentials</li>";
echo "<li>Test the connection</li>";
echo "<li>Enable the gateway</li>";
echo "</ol>";

?>