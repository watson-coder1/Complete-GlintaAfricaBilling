<?php

/**
 * Apply M-Pesa Database Updates
 * Run this once to add M-Pesa fields to the database
 */

require_once 'init.php';

echo "Applying M-Pesa Database Updates...\n\n";

try {
    // Check if columns already exist
    $check_columns = ORM::get_db()->query("SHOW COLUMNS FROM tbl_payment_gateway LIKE 'mpesa_receipt_number'");
    if ($check_columns->rowCount() > 0) {
        echo "✅ M-Pesa columns already exist in tbl_payment_gateway\n";
    } else {
        echo "📝 Adding M-Pesa columns to tbl_payment_gateway...\n";
        
        ORM::get_db()->exec("
            ALTER TABLE tbl_payment_gateway 
            ADD COLUMN mpesa_receipt_number VARCHAR(20) DEFAULT '' COMMENT 'M-Pesa receipt number',
            ADD COLUMN mpesa_phone_number VARCHAR(15) DEFAULT '' COMMENT 'Customer phone number',
            ADD COLUMN mpesa_amount DECIMAL(10,2) DEFAULT 0.00 COMMENT 'Paid amount from M-Pesa',
            ADD COLUMN checkout_request_id VARCHAR(50) DEFAULT '' COMMENT 'STK Push checkout request ID'
        ");
        
        echo "✅ M-Pesa columns added successfully\n";
    }
    
    // Add indexes
    echo "📝 Adding database indexes...\n";
    try {
        ORM::get_db()->exec("ALTER TABLE tbl_payment_gateway ADD INDEX idx_checkout_request_id (checkout_request_id)");
        echo "✅ Checkout request ID index added\n";
    } catch (Exception $e) {
        echo "ℹ️  Checkout request ID index may already exist\n";
    }
    
    try {
        ORM::get_db()->exec("ALTER TABLE tbl_payment_gateway ADD INDEX idx_mpesa_receipt (mpesa_receipt_number)");
        echo "✅ M-Pesa receipt index added\n";
    } catch (Exception $e) {
        echo "ℹ️  M-Pesa receipt index may already exist\n";
    }
    
    // Add configuration settings
    echo "📝 Adding M-Pesa configuration settings...\n";
    
    $config_settings = [
        'daraja_consumer_key' => '',
        'daraja_consumer_secret' => '',
        'daraja_passkey' => '',
        'daraja_shortcode' => '',
        'daraja_environment' => 'sandbox',
        'daraja_callback_url' => '',
        'daraja_enabled' => '0'
    ];
    
    foreach ($config_settings as $setting => $default_value) {
        $existing = ORM::for_table('tbl_appconfig')->where('setting', $setting)->find_one();
        if (!$existing) {
            $config = ORM::for_table('tbl_appconfig')->create();
            $config->setting = $setting;
            $config->value = $default_value;
            $config->save();
            echo "✅ Added config: {$setting}\n";
        } else {
            echo "ℹ️  Config already exists: {$setting}\n";
        }
    }
    
    // Update payment gateway list
    echo "📝 Updating payment gateway list...\n";
    $pg_setting = ORM::for_table('tbl_appconfig')->where('setting', 'payment_gateway')->find_one();
    if ($pg_setting) {
        if (strpos($pg_setting->value, 'Daraja') === false) {
            $pg_setting->value = $pg_setting->value ? $pg_setting->value . ',Daraja' : 'Daraja';
            $pg_setting->save();
            echo "✅ Added Daraja to payment gateway list\n";
        } else {
            echo "ℹ️  Daraja already in payment gateway list\n";
        }
    } else {
        $pg_setting = ORM::for_table('tbl_appconfig')->create();
        $pg_setting->setting = 'payment_gateway';
        $pg_setting->value = 'Daraja';
        $pg_setting->save();
        echo "✅ Created payment gateway list with Daraja\n";
    }
    
    echo "\n🎉 M-Pesa database updates completed successfully!\n\n";
    echo "Next steps:\n";
    echo "1. Go to admin panel → Settings → Payment Gateway → Daraja\n";
    echo "2. Configure your M-Pesa Daraja credentials\n";
    echo "3. Set callback URL to: https://yourdomain.com/callback_mpesa.php\n";
    echo "4. Enable M-Pesa payments\n";
    echo "5. Test with mpesa_payment.php\n\n";
    
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
    echo "Please check your database connection and try again.\n";
}
?>