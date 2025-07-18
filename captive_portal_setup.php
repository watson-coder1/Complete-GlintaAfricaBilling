<?php
require_once 'init.php';

echo "Setting up Captive Portal...\n";

// Create portal sessions table
$createPortalSessions = "
CREATE TABLE IF NOT EXISTS `tbl_portal_sessions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `session_id` VARCHAR(255) NOT NULL UNIQUE,
    `mac_address` VARCHAR(17) NOT NULL,
    `ip_address` VARCHAR(45) DEFAULT NULL,
    `user_agent` TEXT DEFAULT NULL,
    `plan_id` INT(11) DEFAULT NULL,
    `phone_number` VARCHAR(20) DEFAULT NULL,
    `amount` DECIMAL(10,2) DEFAULT NULL,
    `payment_id` INT(11) DEFAULT NULL,
    `checkout_request_id` VARCHAR(255) DEFAULT NULL,
    `mikrotik_user` VARCHAR(255) DEFAULT NULL,
    `status` ENUM('pending', 'processing', 'completed', 'failed', 'expired') DEFAULT 'pending',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `expires_at` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_session_id` (`session_id`),
    INDEX `idx_mac_address` (`mac_address`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
";

try {
    $db->exec($createPortalSessions);
    echo "✅ Portal sessions table created\n";
} catch (Exception $e) {
    echo "Error creating table: " . $e->getMessage() . "\n";
}

// Create sample plans
$samplePlans = [
    [
        'name_plan' => 'Quick Browse - 30 Minutes',
        'price' => 20,
        'validity' => 30,
        'validity_unit' => 'Min',
        'type' => 'Hotspot'
    ],
    [
        'name_plan' => '1 Hour WiFi Access',
        'price' => 50,
        'validity' => 1,
        'validity_unit' => 'Hrs',
        'type' => 'Hotspot'
    ],
    [
        'name_plan' => '3 Hours Premium',
        'price' => 100,
        'validity' => 3,
        'validity_unit' => 'Hrs',
        'type' => 'Hotspot'
    ]
];

foreach ($samplePlans as $planData) {
    $existing = ORM::for_table('tbl_plans')
        ->where('name_plan', $planData['name_plan'])
        ->find_one();
        
    if (!$existing) {
        $plan = ORM::for_table('tbl_plans')->create();
        $plan->name_plan = $planData['name_plan'];
        $plan->price = $planData['price'];
        $plan->validity = $planData['validity'];
        $plan->validity_unit = $planData['validity_unit'];
        $plan->type = $planData['type'];
        $plan->enabled = 1;
        $plan->routers = '1';
        $plan->save();
        echo "✅ Created plan: " . $planData['name_plan'] . "\n";
    } else {
        echo "ℹ️ Plan exists: " . $planData['name_plan'] . "\n";
    }
}

echo "\n✅ Captive Portal Setup Complete!\n";
echo "Portal URL: https://glintaafrica.com/?_route=captive_portal\n";
?>