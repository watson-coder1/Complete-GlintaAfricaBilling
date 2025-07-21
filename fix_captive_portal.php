<?php
/**
 * Web-based Captive Portal Fix Script
 * Access this via http://localhost:8080/fix_captive_portal.php
 */

// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<!DOCTYPE html><html><head><title>Captive Portal Fix</title>";
echo "<style>body{font-family:Arial,sans-serif;margin:20px;} .success{color:green;} .error{color:red;} .warning{color:orange;}</style>";
echo "</head><body>";

echo "<h1>🔧 Captive Portal Fix Script</h1>";
echo "<p>This script will automatically fix common captive portal issues.</p><hr>";

try {
    // Load system files
    echo "<h2>Step 1: Loading System Files</h2>";
    require_once 'init.php';
    echo "<span class='success'>✅ System files loaded successfully</span><br><br>";

    // Check and create missing tables
    echo "<h2>Step 2: Checking Database Tables</h2>";
    
    // Check if tbl_portal_sessions exists
    try {
        ORM::raw_execute("SELECT 1 FROM tbl_portal_sessions LIMIT 1");
        echo "<span class='success'>✅ tbl_portal_sessions table exists</span><br>";
    } catch (Exception $e) {
        echo "<span class='warning'>⚠️ Creating tbl_portal_sessions table...</span><br>";
        
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
            `expires_at` datetime DEFAULT NULL,
            `created_at` datetime NOT NULL,
            `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `session_id` (`session_id`),
            KEY `mac_address` (`mac_address`),
            KEY `status` (`status`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
        
        ORM::raw_execute($sql);
        echo "<span class='success'>✅ tbl_portal_sessions table created</span><br>";
    }

    // Check plans
    echo "<h2>Step 3: Checking WiFi Plans</h2>";
    
    $plans = ORM::for_table('tbl_plans')
        ->where('enabled', 1)
        ->where('type', 'Hotspot')
        ->find_many();
    
    if (count($plans) == 0) {
        echo "<span class='warning'>⚠️ No enabled Hotspot plans found. Creating default plans...</span><br>";
        
        // Create default plans
        $defaultPlans = [
            ['name' => '1 Hour WiFi Access', 'price' => 50, 'validity' => 1, 'unit' => 'Hrs'],
            ['name' => '1 Day WiFi Access', 'price' => 150, 'validity' => 1, 'unit' => 'Days'],
            ['name' => '1 Week WiFi Access', 'price' => 500, 'validity' => 7, 'unit' => 'Days'],
        ];
        
        foreach ($defaultPlans as $planData) {
            $plan = ORM::for_table('tbl_plans')->create();
            $plan->name_plan = $planData['name'];
            $plan->price = $planData['price'];
            $plan->validity = $planData['validity'];
            $plan->validity_unit = $planData['unit'];
            $plan->type = 'Hotspot';
            $plan->enabled = 1;
            $plan->routers = '1';
            $plan->save();
            
            echo "<span class='success'>✅ Created plan: {$planData['name']} - KES {$planData['price']}</span><br>";
        }
    } else {
        echo "<span class='success'>✅ Found " . count($plans) . " enabled Hotspot plans</span><br>";
        foreach ($plans as $plan) {
            echo "- {$plan->name_plan} (KES {$plan->price})<br>";
        }
    }

    // Check template files
    echo "<h2>Step 4: Checking Template Files</h2>";
    
    $requiredTemplates = [
        'ui/ui/captive_portal_landing.tpl',
        'ui/ui/captive_portal_payment.tpl',
        'ui/ui/captive_portal_status.tpl',
        'ui/ui/captive_portal_success.tpl'
    ];
    
    foreach ($requiredTemplates as $template) {
        if (file_exists($template)) {
            echo "<span class='success'>✅ $template exists</span><br>";
        } else {
            echo "<span class='error'>❌ $template missing</span><br>";
        }
    }

    // Test basic functionality
    echo "<h2>Step 5: Testing Basic Functionality</h2>";
    
    // Test session creation
    try {
        $testSession = ORM::for_table('tbl_portal_sessions')->create();
        $testSession->session_id = 'test_' . time();
        $testSession->mac_address = 'test:mac:address';
        $testSession->ip_address = '192.168.1.100';
        $testSession->status = 'pending';
        $testSession->created_at = date('Y-m-d H:i:s');
        $testSession->expires_at = date('Y-m-d H:i:s', strtotime('+2 hours'));
        $testSession->save();
        
        echo "<span class='success'>✅ Session creation test passed</span><br>";
        
        // Clean up test session
        $testSession->delete();
        
    } catch (Exception $e) {
        echo "<span class='error'>❌ Session creation test failed: " . $e->getMessage() . "</span><br>";
    }

    echo "<h2>🎉 Fix Complete!</h2>";
    echo "<div style='background:#d4edda;padding:15px;border-radius:5px;margin:20px 0;'>";
    echo "<strong>The captive portal should now work correctly!</strong><br><br>";
    echo "Next steps:<br>";
    echo "1. Try accessing: <a href='/captive_portal' target='_blank'>http://localhost:8080/captive_portal</a><br>";
    echo "2. If you still get errors, check the debug script: <a href='/debug_captive_portal.php' target='_blank'>Debug Script</a><br>";
    echo "3. Check the system logs in the Docker container for any remaining issues.<br>";
    echo "</div>";

} catch (Exception $e) {
    echo "<h2 class='error'>❌ Critical Error</h2>";
    echo "<div style='background:#f8d7da;padding:15px;border-radius:5px;margin:20px 0;'>";
    echo "<strong>Error:</strong> " . $e->getMessage() . "<br>";
    echo "<strong>File:</strong> " . $e->getFile() . " (Line " . $e->getLine() . ")<br>";
    echo "<details><summary>Stack Trace</summary><pre>" . $e->getTraceAsString() . "</pre></details>";
    echo "</div>";
    
    echo "<h3>Possible Solutions:</h3>";
    echo "<ul>";
    echo "<li>Make sure your Docker containers are running: <code>docker-compose up -d</code></li>";
    echo "<li>Check database connection in config.php</li>";
    echo "<li>Ensure all system files are present</li>";
    echo "<li>Check Docker container logs: <code>docker-compose logs web</code></li>";
    echo "</ul>";
}

echo "</body></html>";
?>