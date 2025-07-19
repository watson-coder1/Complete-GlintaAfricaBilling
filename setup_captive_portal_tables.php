<?php
/**
 * Setup captive portal database tables
 * Run this once to create the necessary tables
 */

require_once 'init.php';

echo "Setting up Captive Portal tables...\n";

try {
    // Create portal sessions table
    $sql = "CREATE TABLE IF NOT EXISTS `tbl_portal_sessions` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `session_id` varchar(50) NOT NULL,
        `mac_address` varchar(20) DEFAULT NULL,
        `ip_address` varchar(45) DEFAULT NULL,
        `user_agent` text,
        `plan_id` int(11) DEFAULT NULL,
        `phone_number` varchar(20) DEFAULT NULL,
        `amount` decimal(10,2) DEFAULT NULL,
        `payment_id` int(11) DEFAULT NULL,
        `checkout_request_id` varchar(100) DEFAULT NULL,
        `mikrotik_user` varchar(50) DEFAULT NULL,
        `status` varchar(20) DEFAULT 'pending',
        `expiry_warning_sent` tinyint(1) DEFAULT 0,
        `created_at` datetime NOT NULL,
        `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`id`),
        UNIQUE KEY `session_id` (`session_id`),
        KEY `mac_address` (`mac_address`),
        KEY `status` (`status`),
        KEY `created_at` (`created_at`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
    
    ORM::raw_execute($sql);
    echo "✓ Created tbl_portal_sessions table\n";
    
    // Add captive portal specific fields to payment gateway table if not exists
    $sql = "ALTER TABLE `tbl_payment_gateway` 
        ADD COLUMN IF NOT EXISTS `checkout_request_id` varchar(100) DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `pg_request` text,
        ADD COLUMN IF NOT EXISTS `gateway_trx_id` varchar(100) DEFAULT NULL,
        ADD INDEX IF NOT EXISTS `idx_checkout_request` (`checkout_request_id`);";
    
    ORM::raw_execute($sql);
    echo "✓ Updated tbl_payment_gateway table\n";
    
    // Add auto_renewal field to customers if not exists
    $sql = "ALTER TABLE `tbl_customers` 
        ADD COLUMN IF NOT EXISTS `auto_renewal` tinyint(1) DEFAULT 0;";
    
    ORM::raw_execute($sql);
    echo "✓ Updated tbl_customers table\n";
    
    // Create captive portal notification templates
    $notifications = [
        [
            'name' => 'Captive Portal Welcome',
            'subject' => 'Welcome to Glinta WiFi',
            'body' => "Dear Customer,\n\nThank you for purchasing {plan_name} WiFi access.\n\nYour access is valid until: {expiration}\nDevice: {mac_address}\n\nEnjoy your internet!"
        ],
        [
            'name' => 'Captive Portal Expiry Warning',
            'subject' => 'WiFi Access Expiring Soon',
            'body' => "Dear Customer,\n\nYour WiFi access will expire in {minutes_remaining} minutes.\n\nTo continue enjoying internet, please purchase a new package at the captive portal."
        ],
        [
            'name' => 'Captive Portal Expired',
            'subject' => 'WiFi Access Expired',
            'body' => "Dear Customer,\n\nYour WiFi access has expired.\n\nTo reconnect, please visit the captive portal and purchase a new package.\n\nThank you for using Glinta WiFi!"
        ]
    ];
    
    foreach ($notifications as $notif) {
        $existing = ORM::for_table('tbl_appconfig')
            ->where('setting', 'captive_' . str_replace(' ', '_', strtolower($notif['name'])))
            ->find_one();
            
        if (!$existing) {
            $config = ORM::for_table('tbl_appconfig')->create();
            $config->setting = 'captive_' . str_replace(' ', '_', strtolower($notif['name']));
            $config->value = json_encode($notif);
            $config->save();
            echo "✓ Created notification template: " . $notif['name'] . "\n";
        }
    }
    
    echo "\n✓ Captive Portal setup completed successfully!\n";
    
} catch (Exception $e) {
    echo "\n✗ Error: " . $e->getMessage() . "\n";
    exit(1);
}

// Display next steps
echo "\n=== Next Steps ===\n";
echo "1. Configure M-Pesa Daraja gateway in Admin Panel > Payment Gateway\n";
echo "2. Set up cron job for session monitor:\n";
echo "   * * * * * php " . __DIR__ . "/captive_portal_session_monitor.php\n";
echo "3. Configure MikroTik Hotspot to redirect to:\n";
echo "   " . U . "captive_portal?mac=\$(mac)&ip=\$(ip)\n";
echo "4. Test the captive portal flow\n";