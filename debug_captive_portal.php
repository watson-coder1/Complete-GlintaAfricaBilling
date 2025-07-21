<?php

/**
 * Debug script for captive portal issues
 * This script will help identify the exact error causing the internal error message
 */

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

echo "<h1>Captive Portal Debug Script</h1>";
echo "<hr>";

try {
    echo "<h2>1. Loading Configuration...</h2>";
    
    // Include the config file
    if (file_exists('config.php')) {
        require_once 'config.php';
        echo "✅ Config file loaded successfully<br>";
        echo "Database Host: " . $db_host . "<br>";
        echo "Database Name: " . $db_name . "<br>";
    } else {
        echo "❌ Config file not found<br>";
        exit;
    }
    
    echo "<h2>2. Loading System Files...</h2>";
    
    // Include system files
    if (file_exists('system/orm.php')) {
        require_once 'system/orm.php';
        echo "✅ ORM loaded<br>";
    } else {
        echo "❌ ORM file not found<br>";
        exit;
    }
    
    if (file_exists('system/boot.php')) {
        require_once 'system/boot.php';
        echo "✅ Boot file loaded<br>";
    } else {
        echo "❌ Boot file not found<br>";
        exit;
    }
    
    echo "<h2>3. Testing Database Connection...</h2>";
    
    // Test database connection
    try {
        $testDb = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
        $testDb->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "✅ Database connection successful<br>";
    } catch (PDOException $e) {
        echo "❌ Database connection failed: " . $e->getMessage() . "<br>";
        exit;
    }
    
    echo "<h2>4. Checking Required Tables...</h2>";
    
    // Check if required tables exist
    $requiredTables = [
        'tbl_plans',
        'tbl_portal_sessions',
        'tbl_user_recharges',
        'tbl_payment_gateway',
        'tbl_voucher',
        'tbl_transactions'
    ];
    
    foreach ($requiredTables as $table) {
        try {
            $stmt = $testDb->query("SHOW TABLES LIKE '$table'");
            if ($stmt->rowCount() > 0) {
                echo "✅ Table '$table' exists<br>";
            } else {
                echo "❌ Table '$table' missing<br>";
            }
        } catch (PDOException $e) {
            echo "❌ Error checking table '$table': " . $e->getMessage() . "<br>";
        }
    }
    
    echo "<h2>5. Testing Smarty Template Engine...</h2>";
    
    // Test if Smarty is working
    global $ui;
    if (isset($ui) && is_object($ui)) {
        echo "✅ Smarty template engine is available<br>";
        
        // Test template directory
        $templateDir = 'ui/ui/';
        if (is_dir($templateDir)) {
            echo "✅ Template directory exists<br>";
            
            // Check for captive portal template
            if (file_exists($templateDir . 'captive_portal_landing.tpl')) {
                echo "✅ Captive portal template exists<br>";
            } else {
                echo "❌ Captive portal template missing<br>";
            }
        } else {
            echo "❌ Template directory missing<br>";
        }
    } else {
        echo "❌ Smarty template engine not available<br>";
    }
    
    echo "<h2>6. Testing Plan Retrieval...</h2>";
    
    // Test plan retrieval (the likely cause of the error)
    try {
        $packages = ORM::for_table('tbl_plans')
            ->where('enabled', 1)
            ->where('type', 'Hotspot')
            ->order_by_asc('price')
            ->find_many();
            
        if (count($packages) > 0) {
            echo "✅ Found " . count($packages) . " enabled Hotspot plans<br>";
            foreach ($packages as $package) {
                echo "- Plan: " . $package->name_plan . " (KES " . $package->price . ")<br>";
            }
        } else {
            echo "⚠️ No enabled Hotspot plans found<br>";
            echo "This might be causing the error. Let's create a default plan...<br>";
            
            // Create a default plan
            $defaultPlan = ORM::for_table('tbl_plans')->create();
            $defaultPlan->name_plan = '1 Hour WiFi Access';
            $defaultPlan->price = 50;
            $defaultPlan->validity = 1;
            $defaultPlan->validity_unit = 'Hrs';
            $defaultPlan->type = 'Hotspot';
            $defaultPlan->enabled = 1;
            $defaultPlan->routers = '1';
            $defaultPlan->save();
            
            echo "✅ Default plan created<br>";
        }
    } catch (Exception $e) {
        echo "❌ Error retrieving plans: " . $e->getMessage() . "<br>";
        echo "Stack trace: <pre>" . $e->getTraceAsString() . "</pre>";
    }
    
    echo "<h2>7. Testing Session Creation...</h2>";
    
    // Test session creation
    try {
        $sessionId = uniqid('debug_', true);
        $session = ORM::for_table('tbl_portal_sessions')->create();
        $session->session_id = $sessionId;
        $session->mac_address = 'debug-mac';
        $session->ip_address = '127.0.0.1';
        $session->user_agent = 'Debug Script';
        $session->created_at = date('Y-m-d H:i:s');
        $session->expires_at = date('Y-m-d H:i:s', strtotime('+2 hours'));
        $session->status = 'pending';
        $session->save();
        
        echo "✅ Session creation successful (ID: $sessionId)<br>";
        
        // Clean up test session
        $session->delete();
        echo "✅ Test session cleaned up<br>";
        
    } catch (Exception $e) {
        echo "❌ Error creating session: " . $e->getMessage() . "<br>";
        echo "Stack trace: <pre>" . $e->getTraceAsString() . "</pre>";
    }
    
    echo "<h2>8. Summary</h2>";
    echo "If all checks above passed, the captive portal should work correctly.<br>";
    echo "If any checks failed, those are the issues that need to be fixed.<br>";
    echo "<br><strong>Next step:</strong> Try accessing the captive portal at: <a href='" . APP_URL . "/captive_portal'>" . APP_URL . "/captive_portal</a>";
    
} catch (Exception $e) {
    echo "<h2>Critical Error</h2>";
    echo "❌ " . $e->getMessage() . "<br>";
    echo "Stack trace: <pre>" . $e->getTraceAsString() . "</pre>";
}

?>