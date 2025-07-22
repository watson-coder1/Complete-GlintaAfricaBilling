<?php
/**
 * Test Callback Endpoint - Manual test to verify M-Pesa callback URL
 * This will simulate what Safaricom sends and test if our handler works
 */

require_once 'init.php';

// Test callback URL construction
echo "=== M-PESA CALLBACK URL TEST ===\n";
echo "Testing callback endpoint accessibility\n\n";

// Get app URL
$app_url = rtrim(APP_URL, '/');
$callback_url = $app_url . '/?_route=captive_portal/callback';

echo "1. CALLBACK URL ANALYSIS:\n";
echo "   App URL: " . APP_URL . "\n";
echo "   Full callback URL: " . $callback_url . "\n";
echo "   Expected by M-Pesa: This URL should be publicly accessible\n\n";

// Test URL accessibility (simulate external call)
echo "2. TESTING URL ACCESSIBILITY:\n";
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $callback_url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 10);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode([
    'Body' => [
        'stkCallback' => [
            'MerchantRequestID' => 'test-merchant-123',
            'CheckoutRequestID' => 'test-checkout-456',
            'ResultCode' => 0,
            'ResultDesc' => 'The service request is processed successfully.',
            'CallbackMetadata' => [
                'Item' => [
                    ['Name' => 'Amount', 'Value' => 100],
                    ['Name' => 'MpesaReceiptNumber', 'Value' => 'TEST123'],
                    ['Name' => 'PhoneNumber', 'Value' => 254712345678],
                    ['Name' => 'TransactionDate' => '20250722140000']
                ]
            ]
        ]
    ]
]));
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    'User-Agent: M-Pesa-Test/1.0'
]);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

if ($error) {
    echo "   ❌ CURL Error: " . $error . "\n";
} else {
    echo "   ✅ HTTP Response Code: " . $http_code . "\n";
    echo "   Response: " . substr($response, 0, 200) . "...\n";
}

echo "\n3. CHECKING CURRENT CONFIGURATION:\n";

// Check Daraja configuration
$pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
if ($pg) {
    $pgData = json_decode($pg['pg_data'], true);
    echo "   Daraja Status: " . ($pg['status'] ? 'Enabled' : 'Disabled') . "\n";
    echo "   Environment: " . ($pgData['environment'] ?? 'Not Set') . "\n";
    echo "   Shortcode: " . (!empty($pgData['shortcode']) ? 'Set' : 'Not Set') . "\n";
    echo "   Consumer Key: " . (!empty($pgData['consumer_key']) ? 'Set' : 'Not Set') . "\n";
    echo "   Callback URL in config: " . ($pgData['callback_url'] ?? 'Default (captive_portal/callback)') . "\n";
} else {
    echo "   ❌ Daraja configuration not found!\n";
}

echo "\n4. RECENT PAYMENT RECORDS:\n";
$recentPayments = ORM::for_table('tbl_payment_gateway')
    ->where('gateway', 'Daraja')
    ->order_by_desc('id')
    ->limit(3)
    ->find_many();

if ($recentPayments) {
    foreach ($recentPayments as $payment) {
        echo "   Payment ID: " . $payment->id() . "\n";
        echo "     Status: " . $payment->status . " (1=pending, 2=paid)\n";
        echo "     Checkout Request ID: " . ($payment->checkout_request_id ?? 'None') . "\n";
        echo "     Created: " . $payment->created_date . "\n";
        echo "     Username/MAC: " . $payment->username . "\n\n";
    }
} else {
    echo "   No recent M-Pesa payments found\n";
}

echo "5. LOG FILE CHECK:\n";
$logPath = $UPLOAD_PATH . '/captive_portal_callbacks.log';
if (file_exists($logPath)) {
    $logSize = filesize($logPath);
    echo "   Callback log exists: " . $logPath . " (" . $logSize . " bytes)\n";
    if ($logSize > 0) {
        echo "   Recent entries:\n";
        $lines = file($logPath);
        $recentLines = array_slice($lines, -5);
        foreach ($recentLines as $line) {
            echo "     " . trim($line) . "\n";
        }
    } else {
        echo "   ❌ Log file is empty - callbacks are not being received\n";
    }
} else {
    echo "   ❌ Callback log file doesn't exist\n";
}

echo "\n=== DIAGNOSIS ===\n";
echo "If callback logs are empty, the issue is likely:\n";
echo "1. M-Pesa cannot reach your callback URL (firewall, DNS, SSL issues)\n";
echo "2. Different callback URL is configured in your M-Pesa app\n";
echo "3. STK push is using wrong callback URL parameter\n\n";

echo "✅ NEXT STEPS:\n";
echo "1. Verify this URL works in browser: " . $callback_url . "\n";
echo "2. Check if your server can receive POST requests from external sources\n";
echo "3. Verify your M-Pesa app configuration matches this callback URL\n";
echo "4. Make a test STK push and monitor the callback log file\n";
?>