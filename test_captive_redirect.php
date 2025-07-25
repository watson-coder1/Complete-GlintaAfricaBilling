<?php
/**
 * Test script for captive portal redirect flow
 * Run this to verify the redirect to Google is working
 */

// Include system files
require_once 'init.php';

echo "=== Captive Portal Redirect Test ===\n\n";

// Test 1: Check if success page template exists
$templatePath = 'ui/ui/captive_portal_success.tpl';
if (file_exists($templatePath)) {
    echo "✅ Success template found at: $templatePath\n";
    
    // Check for redirect code in template
    $content = file_get_contents($templatePath);
    if (strpos($content, 'google.com') !== false) {
        echo "✅ Google redirect found in template\n";
    } else {
        echo "❌ Google redirect NOT found in template\n";
    }
    
    if (strpos($content, 'updateCountdown') !== false) {
        echo "✅ Countdown timer function found\n";
    } else {
        echo "❌ Countdown timer function NOT found\n";
    }
} else {
    echo "❌ Success template NOT found\n";
}

echo "\n";

// Test 2: Check recent successful payments
echo "Recent successful payments:\n";
$recentPayments = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2) // Successful
    ->where('payment_channel', 'Captive Portal')
    ->order_by_desc('paid_date')
    ->limit(5)
    ->find_many();

if ($recentPayments) {
    foreach ($recentPayments as $payment) {
        echo "- Payment ID: {$payment->id}, User: {$payment->username}, Date: {$payment->paid_date}\n";
    }
} else {
    echo "No recent successful payments found\n";
}

echo "\n";

// Test 3: Check active portal sessions
echo "Active portal sessions:\n";
$activeSessions = ORM::for_table('tbl_portal_sessions')
    ->where('status', 'completed')
    ->where_gt('created_at', date('Y-m-d H:i:s', strtotime('-24 hours')))
    ->order_by_desc('created_at')
    ->limit(5)
    ->find_many();

if ($activeSessions) {
    foreach ($activeSessions as $session) {
        echo "- Session: {$session->session_id}, MAC: {$session->mac_address}, Status: {$session->status}\n";
    }
} else {
    echo "No active completed sessions found\n";
}

echo "\n";

// Test 4: Simulate redirect URL generation
echo "Testing redirect URL generation:\n";
$baseUrl = 'http://billing.example.com/';
$sessionId = 'test_session_123';
$successUrl = $baseUrl . 'captive_portal/success/' . $sessionId;
echo "- Success URL would be: $successUrl\n";
echo "- Google redirect URL: https://www.google.com\n";

echo "\n✅ Test complete!\n";
echo "\nTo manually test the redirect:\n";
echo "1. Access the captive portal landing page\n";
echo "2. Complete a payment\n";
echo "3. Verify you are redirected to the success page\n";
echo "4. Wait 10 seconds (or check countdown)\n";
echo "5. Verify you are redirected to Google\n";