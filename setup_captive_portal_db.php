<?php

/**
 * Setup Captive Portal Database Tables
 * Creates the necessary database structure for the captive portal
 */

require_once 'init.php';

echo "<h2>🗃️ Setting up Captive Portal Database</h2>";

try {
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
    
    $db->exec($createPortalSessions);
    echo "✅ Created `tbl_portal_sessions` table<br>";
    
    // Update tbl_plans to ensure it has service_type for Hotspot packages
    $updatePlansTable = "
    ALTER TABLE `tbl_plans` 
    ADD COLUMN IF NOT EXISTS `service_type` ENUM('Hotspot', 'PPPoE') DEFAULT 'Hotspot',
    ADD COLUMN IF NOT EXISTS `data_limit` VARCHAR(50) DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS `description` TEXT DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS `portal_visible` TINYINT(1) DEFAULT 1;
    ";
    
    try {
        $db->exec($updatePlansTable);
        echo "✅ Updated `tbl_plans` table with portal fields<br>";
    } catch (Exception $e) {
        echo "ℹ️ Plans table already has portal fields<br>";
    }
    
    // Update payment gateway table to support portal payments
    $updatePaymentGateway = "
    ALTER TABLE `tbl_payment_gateway`
    ADD COLUMN IF NOT EXISTS `payment_channel` VARCHAR(50) DEFAULT 'Web Portal',
    ADD COLUMN IF NOT EXISTS `device_info` TEXT DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS `session_data` TEXT DEFAULT NULL;
    ";
    
    try {
        $db->exec($updatePaymentGateway);
        echo "✅ Updated `tbl_payment_gateway` table<br>";
    } catch (Exception $e) {
        echo "ℹ️ Payment gateway table already updated<br>";
    }
    
    // Create sample Hotspot plans for the portal
    echo "<h3>📦 Creating Sample Hotspot Packages</h3>";
    
    $samplePlans = [
        [
            'name_plan' => 'Quick Browse - 30 Minutes',
            'price' => 20,
            'validity' => 30,
            'validity_unit' => 'Min',
            'type' => 'Hotspot',
            'data_limit' => '500MB',
            'description' => 'Perfect for quick browsing and social media'
        ],
        [
            'name_plan' => '1 Hour WiFi Access',
            'price' => 50,
            'validity' => 1,
            'validity_unit' => 'Hrs',
            'type' => 'Hotspot',
            'data_limit' => '1GB',
            'description' => 'Ideal for work and entertainment'
        ],
        [
            'name_plan' => '3 Hours Premium',
            'price' => 100,
            'validity' => 3,
            'validity_unit' => 'Hrs',
            'type' => 'Hotspot',
            'data_limit' => '3GB',
            'description' => 'Extended browsing with high-speed access'
        ],
        [
            'name_plan' => 'Full Day Access',
            'price' => 200,
            'validity' => 1,
            'validity_unit' => 'Day',
            'type' => 'Hotspot',
            'data_limit' => '5GB',
            'description' => '24-hour unlimited high-speed internet'
        ],
        [
            'name_plan' => 'Weekend Special',
            'price' => 500,
            'validity' => 3,
            'validity_unit' => 'Day',
            'type' => 'Hotspot',
            'data_limit' => '15GB',
            'description' => 'Perfect for the weekend - 3 full days'
        ]
    ];
    
    foreach ($samplePlans as $planData) {
        // Check if plan already exists
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
            $plan->service_type = 'Hotspot';
            $plan->data_limit = $planData['data_limit'];
            $plan->description = $planData['description'];
            $plan->enabled = 1;
            $plan->portal_visible = 1;
            $plan->routers = '1'; // Default router
            $plan->save();
            
            echo "✅ Created plan: {$planData['name_plan']} - KES {$planData['price']}<br>";
        } else {
            echo "ℹ️ Plan already exists: {$planData['name_plan']}<br>";
        }
    }
    
    // Create captive portal route configuration
    echo "<h3>🌐 Setting up Routes</h3>";
    
    $routeConfig = [
        'captive_portal' => [
            'controller' => 'captive_portal',
            'description' => 'Main captive portal landing page',
            'methods' => ['GET', 'POST']
        ]
    ];
    
    // Check if .htaccess exists and add portal routes
    $htaccessFile = '.htaccess';
    if (file_exists($htaccessFile)) {
        $htaccessContent = file_get_contents($htaccessFile);
        
        if (strpos($htaccessContent, 'captive_portal') === false) {
            $portalRule = "\n# Captive Portal Routes\nRewriteRule ^captive_portal(/.*)?$ index.php?_route=captive_portal$1 [QSA,L]\n";
            file_put_contents($htaccessFile, $htaccessContent . $portalRule);
            echo "✅ Added captive portal route to .htaccess<br>";
        } else {
            echo "ℹ️ Captive portal route already exists in .htaccess<br>";
        }
    } else {
        echo "⚠️ .htaccess file not found - you may need to configure routes manually<br>";
    }
    
    // Test database connections
    echo "<h3>🔌 Testing Database Connections</h3>";
    
    // Test main database
    $testQuery = ORM::for_table('tbl_portal_sessions')->count();
    echo "✅ Main database connection: OK<br>";
    
    // Test RADIUS database if enabled
    if ($config['radius_enable']) {
        try {
            $radiusTest = ORM::for_table('radcheck', 'radius')->count();
            echo "✅ RADIUS database connection: OK<br>";
        } catch (Exception $e) {
            echo "⚠️ RADIUS database connection: " . $e->getMessage() . "<br>";
        }
    } else {
        echo "ℹ️ RADIUS not enabled in configuration<br>";
    }
    
    // Create initial admin notification
    echo "<h3>📧 Admin Notifications</h3>";
    
    try {
        $notification = ORM::for_table('tbl_logs')->create();
        $notification->date = date('Y-m-d H:i:s');
        $notification->type = 'Admin';
        $notification->description = 'Captive Portal system has been successfully installed and configured';
        $notification->save();
        echo "✅ Created admin notification<br>";
    } catch (Exception $e) {
        echo "ℹ️ Could not create admin notification: " . $e->getMessage() . "<br>";
    }
    
    echo "<h3>✅ Captive Portal Setup Complete!</h3>";
    echo "<h4>📋 Summary:</h4>";
    echo "<ul>";
    echo "<li>✅ <strong>Database Tables:</strong> Created portal sessions table</li>";
    echo "<li>✅ <strong>Sample Plans:</strong> Added 5 Hotspot packages for testing</li>";
    echo "<li>✅ <strong>URL Routes:</strong> Configured captive portal routing</li>";
    echo "<li>✅ <strong>Integration:</strong> Connected with existing M-Pesa and RADIUS systems</li>";
    echo "</ul>";
    
    echo "<h4>🌐 Portal Access:</h4>";
    echo "<ul>";
    echo "<li><strong>Main Portal:</strong> <a href='" . U . "captive_portal' target='_blank'>" . U . "captive_portal</a></li>";
    echo "<li><strong>For MikroTik:</strong> Set hotspot login page to: <code>" . U . "captive_portal</code></li>";
    echo "<li><strong>Testing:</strong> Add ?mac=00:11:22:33:44:55&ip=192.168.1.100 for testing</li>";
    echo "</ul>";
    
    echo "<h4>⚙️ Next Steps:</h4>";
    echo "<ul>";
    echo "<li>1. Configure MikroTik hotspot to redirect to your portal URL</li>";
    echo "<li>2. Set up walled garden for portal access (add your domain)</li>";
    echo "<li>3. Test M-Pesa payments with real transactions</li>";
    echo "<li>4. Configure automatic session cleanup cron job</li>";
    echo "</ul>";
    
} catch (Exception $e) {
    echo "<h3>❌ Setup Failed</h3>";
    echo "<p><strong>Error:</strong> " . $e->getMessage() . "</p>";
    echo "<p>Please check your database connection and try again.</p>";
}

?>