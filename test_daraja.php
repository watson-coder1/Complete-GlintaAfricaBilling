<?php
/**
 * Test Daraja Gateway Configuration
 * Run this to check if M-Pesa is properly configured
 */

require_once 'init.php';

echo "=== Daraja Gateway Configuration Test ===\n";

// Check if Daraja gateway exists in database
$pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();

if (!$pg) {
    echo "❌ ERROR: Daraja gateway not found in database\n";
    echo "Please configure M-Pesa Daraja in Admin Panel > Payment Gateway\n";
    exit(1);
}

echo "✅ Daraja gateway found in database\n";
echo "Status: " . ($pg->status ? 'Active' : 'Inactive') . "\n";

if (!$pg->status) {
    echo "❌ ERROR: Daraja gateway is disabled\n";
    echo "Please enable it in Admin Panel > Payment Gateway\n";
    exit(1);
}

$pgData = json_decode($pg->pg_data, true);

if (!$pgData) {
    echo "❌ ERROR: Invalid gateway configuration data\n";
    exit(1);
}

echo "Configuration:\n";
echo "- Environment: " . ($pgData['environment'] ?? 'NOT SET') . "\n";
echo "- Consumer Key: " . (isset($pgData['consumer_key']) && !empty($pgData['consumer_key']) ? 'SET' : 'NOT SET') . "\n";
echo "- Consumer Secret: " . (isset($pgData['consumer_secret']) && !empty($pgData['consumer_secret']) ? 'SET' : 'NOT SET') . "\n";
echo "- Business Shortcode: " . ($pgData['shortcode'] ?? 'NOT SET') . "\n";
echo "- Passkey: " . (isset($pgData['passkey']) && !empty($pgData['passkey']) ? 'SET' : 'NOT SET') . "\n";
echo "- Callback URL: " . ($pgData['callback_url'] ?? 'NOT SET') . "\n";

// Check required fields
$required = ['consumer_key', 'consumer_secret', 'shortcode', 'passkey'];
$missing = [];

foreach ($required as $field) {
    if (!isset($pgData[$field]) || empty($pgData[$field])) {
        $missing[] = $field;
    }
}

if (!empty($missing)) {
    echo "❌ ERROR: Missing required configuration: " . implode(', ', $missing) . "\n";
    echo "Please configure these fields in Admin Panel > Payment Gateway > Daraja\n";
    exit(1);
}

echo "✅ All required fields are configured\n";

// Test authentication
echo "\nTesting M-Pesa authentication...\n";

require_once 'system/paymentgateway/Daraja.php';

$token = Daraja_get_access_token($pgData);
if ($token) {
    echo "✅ M-Pesa authentication successful\n";
    echo "Access token: " . substr($token, 0, 20) . "...\n";
} else {
    echo "❌ ERROR: M-Pesa authentication failed\n";
    echo "Check your consumer key and secret\n";
    exit(1);
}

echo "\nTesting Daraja class...\n";
try {
    $daraja = new Daraja();
    if ($daraja->isEnabled()) {
        echo "✅ Daraja class working correctly\n";
    } else {
        echo "❌ ERROR: Daraja class reports gateway is disabled\n";
    }
} catch (Exception $e) {
    echo "❌ ERROR: Daraja class error: " . $e->getMessage() . "\n";
}

echo "\n=== Test Complete ===\n";
echo "If all tests passed, the gateway should work for STK Push\n";