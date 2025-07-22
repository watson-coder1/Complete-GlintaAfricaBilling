<?php
/**
 * Fix Missing User Recharge
 * Creates missing user recharge for paid sessions
 */

require_once 'init.php';

$mac = 'd3:8a:b7:4c:51:a3'; // Your MacBook MAC

// Get session
$session = ORM::for_table('tbl_portal_sessions')
    ->where('mac_address', $mac)
    ->where('status', 'completed')
    ->order_by_desc('id')
    ->find_one();

if (!$session) {
    die("No completed session found for MAC: $mac");
}

// Get payment
$payment = ORM::for_table('tbl_payment_gateway')
    ->where('id', $session->payment_id)
    ->find_one();

if (!$payment || $payment->status != 2) {
    die("No successful payment found for session");
}

// Get plan
$plan = ORM::for_table('tbl_plans')
    ->where('id', $session->plan_id)
    ->find_one();

if (!$plan) {
    die("Plan not found");
}

// Check existing recharge
$existingRecharge = ORM::for_table('tbl_user_recharges')
    ->where('username', $mac)
    ->where('status', 'on')
    ->order_by_desc('id')
    ->find_one();

echo "=== FIX MISSING USER RECHARGE ===\n";
echo "MAC: $mac\n";
echo "Session ID: {$session->session_id}\n";
echo "Payment ID: {$payment->id}\n";
echo "Payment Status: {$payment->status}\n";
echo "Plan: {$plan->name_plan}\n";

if ($existingRecharge) {
    echo "Existing Recharge: YES (ID: {$existingRecharge->id()}, Status: {$existingRecharge->status}, Expires: {$existingRecharge->expiration})\n";
    
    // Check if it's expired
    if (strtotime($existingRecharge->expiration) > time()) {
        echo "✅ RECHARGE IS ACTIVE - No fix needed!\n";
        echo "The issue might be in the success page user recharge lookup logic.\n";
    } else {
        echo "❌ RECHARGE IS EXPIRED - Creating new one...\n";
        $createNew = true;
    }
} else {
    echo "Existing Recharge: NO\n";
    echo "Creating new user recharge...\n";
    $createNew = true;
}

if (isset($createNew) && $createNew) {
    // Create user recharge record
    $userRecharge = ORM::for_table('tbl_user_recharges')->create();
    $userRecharge->customer_id = 0; // Portal customer
    $userRecharge->username = $mac;
    $userRecharge->plan_id = $plan->id();
    $userRecharge->namebp = $plan->name_plan;
    $userRecharge->recharged_on = date('Y-m-d');
    $userRecharge->recharged_time = date('H:i:s');
    
    // Calculate expiration based on plan validity
    $expirationTime = strtotime('+' . $plan->validity . ' ' . $plan->validity_unit);
    $userRecharge->expiration = date('Y-m-d H:i:s', $expirationTime);
    $userRecharge->time = date('H:i:s', $expirationTime);
    
    $userRecharge->status = 'on';
    $userRecharge->type = 'Hotspot';
    $userRecharge->routers = 'Main Router';
    $userRecharge->method = 'M-Pesa STK Push';
    $userRecharge->admin_id = 1;
    $userRecharge->save();
    
    echo "✅ USER RECHARGE CREATED!\n";
    echo "ID: {$userRecharge->id()}\n";
    echo "Expires: {$userRecharge->expiration}\n";
    
    // Create transaction record
    $transaction = ORM::for_table('tbl_transactions')->create();
    $transaction->invoice = $userRecharge->id();
    $transaction->username = $mac;
    $transaction->plan_name = $plan->name_plan;
    $transaction->price = $payment->price;
    $transaction->recharged_on = date('Y-m-d');
    $transaction->recharged_time = date('H:i:s');
    $transaction->expiration = $userRecharge->expiration;
    $transaction->type = 'Hotspot';
    $transaction->method = 'M-Pesa STK Push';
    $transaction->save();
    
    echo "✅ TRANSACTION RECORD CREATED!\n";
    echo "Transaction ID: {$transaction->id()}\n";
}

echo "\n=== VERIFICATION ===\n";
echo "Now check: https://glintaafrica.com/debug_session.php?mac=$mac\n";
echo "User recharge should now show as FOUND!\n";
?>