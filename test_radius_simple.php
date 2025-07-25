<?php
/**
 * Simple RADIUS Integration Test (Host System Compatible)
 * Tests RADIUS integration without requiring Docker container files
 */

echo "=== SIMPLE RADIUS INTEGRATION TEST ===\n";
echo "Timestamp: " . date('Y-m-d H:i:s') . "\n\n";

// Test MAC address from your logs
$testMac = '9C:BC:F0:79:23:9A';

echo "🧪 Testing RADIUS integration for MAC: $testMac\n\n";

// 1. Test MySQL connection directly
echo "1. Testing MySQL connection...\n";
try {
    $host = '172.18.0.4';  // MySQL container IP
    $user = 'root';
    $pass = 'Glinta2025!';
    
    // Test glinta_billing database
    $pdo1 = new PDO("mysql:host=$host;dbname=glinta_billing", $user, $pass);
    echo "   ✅ Connected to glinta_billing database\n";
    
    // Test radius database
    $pdo2 = new PDO("mysql:host=$host;dbname=radius", $user, $pass);
    echo "   ✅ Connected to radius database\n";
    
} catch (Exception $e) {
    echo "   ❌ Database connection failed: " . $e->getMessage() . "\n";
    exit(1);
}

// 2. Check recent payments
echo "\n2. Checking recent payments...\n";
try {
    $stmt = $pdo1->query("SELECT * FROM tbl_payment_gateway WHERE status = 2 AND gateway = 'Daraja' ORDER BY created_date DESC LIMIT 3");
    $payments = $stmt->fetchAll();
    
    if (count($payments) > 0) {
        echo "   ✅ Found " . count($payments) . " successful payments:\n";
        foreach ($payments as $payment) {
            echo "      - Payment ID: {$payment['id']}, User: {$payment['username']}, Amount: KES {$payment['price']}\n";
        }
    } else {
        echo "   ❌ No successful payments found\n";
    }
} catch (Exception $e) {
    echo "   ❌ Error checking payments: " . $e->getMessage() . "\n";
}

// 3. Check portal sessions
echo "\n3. Checking portal sessions...\n";
try {
    $stmt = $pdo1->query("SELECT * FROM tbl_portal_sessions WHERE status = 'completed' ORDER BY created_at DESC LIMIT 3");
    $sessions = $stmt->fetchAll();
    
    if (count($sessions) > 0) {
        echo "   ✅ Found " . count($sessions) . " completed sessions:\n";
        foreach ($sessions as $session) {
            echo "      - Session: {$session['session_id']}, MAC: {$session['mac_address']}, Status: {$session['status']}\n";
        }
    } else {
        echo "   ❌ No completed sessions found\n";
    }
} catch (Exception $e) {
    echo "   ❌ Error checking sessions: " . $e->getMessage() . "\n";
}

// 4. Check user recharges
echo "\n4. Checking user recharges...\n";
try {
    $stmt = $pdo1->query("SELECT * FROM tbl_user_recharges WHERE status = 'on' ORDER BY recharged_on DESC LIMIT 3");
    $recharges = $stmt->fetchAll();
    
    if (count($recharges) > 0) {
        echo "   ✅ Found " . count($recharges) . " active recharges:\n";
        foreach ($recharges as $recharge) {
            echo "      - User: {$recharge['username']}, Plan: {$recharge['namebp']}, Expires: {$recharge['expiration']}\n";
        }
    } else {
        echo "   ❌ No active recharges found\n";
    }
} catch (Exception $e) {
    echo "   ❌ Error checking recharges: " . $e->getMessage() . "\n";
}

// 5. Check RADIUS database entries
echo "\n5. Checking RADIUS database entries...\n";
try {
    // Check radcheck entries
    $stmt = $pdo2->query("SELECT * FROM radcheck LIMIT 5");
    $radcheckEntries = $stmt->fetchAll();
    
    if (count($radcheckEntries) > 0) {
        echo "   ✅ Found " . count($radcheckEntries) . " radcheck entries:\n";
        foreach ($radcheckEntries as $entry) {
            echo "      - User: {$entry['username']}, Attribute: {$entry['attribute']}, Value: {$entry['value']}\n";
        }
    } else {
        echo "   ❌ No radcheck entries found\n";
    }
    
    // Check for specific test user
    $stmt = $pdo2->prepare("SELECT * FROM radcheck WHERE username = ?");
    $stmt->execute([$testMac]);
    $testUserEntries = $stmt->fetchAll();
    
    if (count($testUserEntries) > 0) {
        echo "   ✅ Test user $testMac found in RADIUS:\n";
        foreach ($testUserEntries as $entry) {
            echo "      - {$entry['attribute']} {$entry['op']} {$entry['value']}\n";
        }
    } else {
        echo "   ❌ Test user $testMac NOT found in RADIUS database\n";
    }
    
} catch (Exception $e) {
    echo "   ❌ Error checking RADIUS database: " . $e->getMessage() . "\n";
}

// 6. Add test user to RADIUS if missing
echo "\n6. Adding test user to RADIUS database...\n";
try {
    // Insert test user
    $stmt = $pdo2->prepare("INSERT INTO radcheck (username, attribute, op, value) VALUES (?, 'Cleartext-Password', ':=', ?) ON DUPLICATE KEY UPDATE value = ?");
    $stmt->execute([$testMac, $testMac, $testMac]);
    
    $stmt = $pdo2->prepare("INSERT INTO radcheck (username, attribute, op, value) VALUES (?, 'Auth-Type', ':=', 'Accept') ON DUPLICATE KEY UPDATE value = 'Accept'");
    $stmt->execute([$testMac]);
    
    echo "   ✅ Test user added/updated in RADIUS database\n";
    
} catch (Exception $e) {
    echo "   ❌ Error adding test user: " . $e->getMessage() . "\n";
}

// 7. Test RADIUS authentication
echo "\n7. Testing RADIUS authentication...\n";
$radtestCommand = "timeout 10 radtest '$testMac' '$testMac' localhost 0 testing123 2>&1";
$output = shell_exec($radtestCommand);

if (strpos($output, 'Access-Accept') !== false) {
    echo "   ✅ RADIUS authentication successful!\n";
    echo "   📋 Output: " . trim($output) . "\n";
} else {
    echo "   ❌ RADIUS authentication failed\n";
    echo "   📋 Output: " . trim($output) . "\n";
}

// 8. Check FreeRADIUS service status
echo "\n8. Checking FreeRADIUS service status...\n";
$statusOutput = shell_exec('systemctl is-active freeradius 2>&1');
if (trim($statusOutput) === 'active') {
    echo "   ✅ FreeRADIUS service is active\n";
} else {
    echo "   ❌ FreeRADIUS service status: " . trim($statusOutput) . "\n";
}

echo "\n=== KEY FINDINGS ===\n";
echo "🔍 If payments exist but no RADIUS users are created automatically,\n";
echo "   the issue is in the M-Pesa callback not calling RadiusManager::createHotspotUser()\n";
echo "\n🔍 If RADIUS authentication fails even with manual user creation,\n";
echo "   the issue is in FreeRADIUS configuration or database connectivity\n";
echo "\n🔍 If authentication works but users still get ERR_CONNECTION_CLOSED,\n";
echo "   the issue is in MikroTik configuration or the redirect mechanism\n";

echo "\n=== NEXT STEPS ===\n";
echo "1. Check the M-Pesa callback code to ensure it calls RadiusManager::createHotspotUser()\n";
echo "2. Verify MikroTik is configured to use RADIUS authentication\n";
echo "3. Test the complete flow: Payment → RADIUS user creation → MikroTik auth → Internet access\n";

echo "\n=== END TEST ===\n";
?>