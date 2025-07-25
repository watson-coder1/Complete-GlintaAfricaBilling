<?php
/**
 * Test RADIUS Integration Script
 * Tests the complete flow from payment completion to RADIUS user creation
 */

require_once('system/autoload.php');

echo "=== TESTING RADIUS INTEGRATION ===\n";
echo "Timestamp: " . date('Y-m-d H:i:s') . "\n\n";

// Test MAC address (the one from your logs)
$testMac = '9C:BC:F0:79:23:9A';

echo "🧪 Testing RADIUS integration for MAC: $testMac\n\n";

// 1. Check if user exists in payment system
echo "1. Checking payment system records...\n";
$userRecharge = ORM::for_table('tbl_user_recharges')
    ->where('username', $testMac)
    ->where('status', 'on')
    ->find_one();

if ($userRecharge) {
    echo "   ✅ User recharge found: Plan {$userRecharge->namebp}, Expires: {$userRecharge->expiration}\n";
} else {
    echo "   ❌ No active user recharge found\n";
    
    // Create a test recharge
    echo "   🔧 Creating test user recharge...\n";
    
    $plan = ORM::for_table('tbl_plans')->find_one(1);
    if (!$plan) {
        echo "   ❌ No plan found with ID 1\n";
        exit(1);
    }
    
    $userRecharge = ORM::for_table('tbl_user_recharges')->create();
    $userRecharge->customer_id = 0;
    $userRecharge->username = $testMac;
    $userRecharge->plan_id = $plan->id();
    $userRecharge->namebp = $plan->name_plan;
    $userRecharge->recharged_on = date('Y-m-d');
    $userRecharge->recharged_time = date('H:i:s');
    $userRecharge->expiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
    $userRecharge->time = date('H:i:s');
    $userRecharge->status = 'on';
    $userRecharge->type = 'Hotspot';
    $userRecharge->routers = 'Main Router';
    $userRecharge->method = 'Test Integration';
    $userRecharge->admin_id = 1;
    $userRecharge->save();
    
    echo "   ✅ Test user recharge created\n";
}

// 2. Test RADIUS user creation
echo "\n2. Testing RADIUS user creation...\n";
require_once __DIR__ . '/system/autoload/RadiusManager.php';

$plan = ORM::for_table('tbl_plans')->find_one($userRecharge->plan_id);
$result = RadiusManager::createHotspotUser(
    $testMac, 
    $testMac, 
    $plan, 
    $userRecharge->expiration
);

if ($result['success']) {
    echo "   ✅ RADIUS user creation successful: {$result['message']}\n";
} else {
    echo "   ❌ RADIUS user creation failed: {$result['message']}\n";
}

// 3. Check RADIUS database directly
echo "\n3. Checking RADIUS database entries...\n";

try {
    // Connect to radius database using the radius connection
    $radiusDb = ORM::get_db('radius');
    
    // Check radcheck entries
    $radcheckEntries = ORM::for_table('radcheck', 'radius')
        ->where('username', $testMac)
        ->find_many();
    
    if (count($radcheckEntries) > 0) {
        echo "   ✅ Found " . count($radcheckEntries) . " radcheck entries:\n";
        foreach ($radcheckEntries as $entry) {
            echo "      - {$entry->attribute} {$entry->op} {$entry->value}\n";
        }
    } else {
        echo "   ❌ No radcheck entries found\n";
    }
    
    // Check radreply entries
    $radreplyEntries = ORM::for_table('radreply', 'radius')
        ->where('username', $testMac)
        ->find_many();
    
    if (count($radreplyEntries) > 0) {
        echo "   ✅ Found " . count($radreplyEntries) . " radreply entries:\n";
        foreach ($radreplyEntries as $entry) {
            echo "      - {$entry->attribute} {$entry->op} {$entry->value}\n";
        }
    } else {
        echo "   ❌ No radreply entries found\n";
    }
    
} catch (Exception $e) {
    echo "   ❌ Database connection error: " . $e->getMessage() . "\n";
    echo "   💡 This might be a database configuration issue\n";
}

// 4. Test radtest command
echo "\n4. Testing radtest command...\n";
$radtestCommand = "timeout 10 radtest '$testMac' '$testMac' localhost 0 testing123 2>&1";
$output = shell_exec($radtestCommand);

if (strpos($output, 'Access-Accept') !== false) {
    echo "   ✅ radtest successful - User can authenticate\n";
    echo "   📋 Output: " . trim($output) . "\n";
} else {
    echo "   ❌ radtest failed\n";
    echo "   📋 Output: " . trim($output) . "\n";
}

// 5. Check RADIUS service status
echo "\n5. Checking RADIUS service status...\n";
$statusOutput = shell_exec('systemctl is-active freeradius 2>&1');
if (trim($statusOutput) === 'active') {
    echo "   ✅ FreeRADIUS service is active\n";
} else {
    echo "   ❌ FreeRADIUS service is not active: " . trim($statusOutput) . "\n";
}

// 6. Check database configuration
echo "\n6. Checking database configuration...\n";
$sqlConfig = '/etc/freeradius/3.0/mods-available/sql';
if (file_exists($sqlConfig)) {
    $configContent = file_get_contents($sqlConfig);
    
    if (strpos($configContent, 'server = "172.18.0.4"') !== false) {
        echo "   ✅ SQL server IP is correctly set to 172.18.0.4\n";
    } else {
        echo "   ⚠️ SQL server IP may not be correctly configured\n";
    }
    
    if (strpos($configContent, 'radius_db = "radius"') !== false) {
        echo "   ✅ Database name is correctly set to 'radius'\n";
    } elseif (strpos($configContent, 'radius_db = "glinta_billing"') !== false) {
        echo "   ❌ Database name is set to 'glinta_billing' instead of 'radius'\n";
        echo "   💡 Run the fix_radius_database_config.sh script to fix this\n";
    } else {
        echo "   ⚠️ Could not determine database configuration\n";
    }
} else {
    echo "   ❌ SQL configuration file not found at $sqlConfig\n";
}

echo "\n=== TEST SUMMARY ===\n";
echo "✅ If all tests passed, your RADIUS integration is working correctly\n";
echo "❌ If tests failed, run the fix_radius_database_config.sh script\n";
echo "🔧 After fixing, restart FreeRADIUS: sudo systemctl restart freeradius\n";
echo "📋 Monitor logs: sudo tail -f /var/log/freeradius/radius.log\n";
echo "\n=== END TEST ===\n";
?>