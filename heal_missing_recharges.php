<?php
/**
 * Auto-Healing Script for Missing User Recharges
 * Scans for successful payments without user recharge records and fixes them
 */

require_once 'init.php';

echo "=== AUTO-HEALING MISSING USER RECHARGES ===\n";
echo "Started at: " . date('Y-m-d H:i:s') . "\n\n";

// Find successful payments from recent sessions first (avoid collation issues)
$recentSessions = ORM::for_table('tbl_portal_sessions')
    ->where('status', 'completed')
    ->where_not_null('payment_id')
    ->where_gte('created_at', date('Y-m-d H:i:s', strtotime('-24 hours')))
    ->order_by_desc('id')
    ->find_many();

$brokenPayments = [];
foreach ($recentSessions as $session) {
    // Check if payment is successful
    $payment = ORM::for_table('tbl_payment_gateway')
        ->where('id', $session->payment_id)
        ->where('status', 2)
        ->find_one();
    
    if ($payment) {
        // Check if user recharge exists
        $userRecharge = ORM::for_table('tbl_user_recharges')
            ->where('username', $session->mac_address)
            ->where('status', 'on')
            ->where_gt('expiration', date('Y-m-d H:i:s'))
            ->find_one();
        
        if (!$userRecharge) {
            $brokenPayments[] = [
                'id' => $payment->id(),
                'mac_address' => $session->mac_address,
                'session_id' => $session->session_id,
                'plan_id' => $payment->plan_id,
                'price' => $payment->price,
                'paid_date' => $payment->paid_date,
                'payment' => $payment,
                'session' => $session
            ];
        }
    }
}

if (!$brokenPayments || count($brokenPayments) == 0) {
    echo "✅ No broken payments found - all payments have user recharges!\n";
    exit;
}

echo "❌ Found " . count($brokenPayments) . " payments without user recharges:\n\n";

$fixed = 0;
foreach ($brokenPayments as $row) {
    $paymentId = $row['id'];
    $mac = $row['mac_address'];
    $sessionId = $row['session_id'];
    $planId = $row['plan_id'];
    $amount = $row['price'];
    $paidDate = $row['paid_date'];
    $payment = $row['payment'];
    $session = $row['session'];
    
    echo "Processing Payment ID: $paymentId, MAC: $mac\n";
    
    // Get plan details
    $plan = ORM::for_table('tbl_plans')->find_one($planId);
    if (!$plan) {
        echo "  ❌ Plan not found for ID: $planId\n";
        continue;
    }
    
    try {
        // Create user recharge record
        $userRecharge = ORM::for_table('tbl_user_recharges')->create();
        $userRecharge->customer_id = 0;
        $userRecharge->username = $mac;
        $userRecharge->plan_id = $plan->id();
        $userRecharge->namebp = $plan->name_plan;
        $userRecharge->recharged_on = date('Y-m-d', strtotime($paidDate));
        $userRecharge->recharged_time = date('H:i:s', strtotime($paidDate));
        
        // Calculate expiration from payment date
        $expirationTime = strtotime($paidDate . ' +' . $plan->validity . ' ' . $plan->validity_unit);
        $userRecharge->expiration = date('Y-m-d H:i:s', $expirationTime);
        $userRecharge->time = date('H:i:s', $expirationTime);
        
        $userRecharge->status = 'on';
        $userRecharge->type = 'Hotspot';
        $userRecharge->routers = 'Main Router';
        $userRecharge->method = 'M-Pesa STK Push';
        $userRecharge->admin_id = 1;
        $userRecharge->save();
        
        // Create transaction record
        $transaction = ORM::for_table('tbl_transactions')->create();
        $transaction->invoice = $userRecharge->id();
        $transaction->username = $mac;
        $transaction->plan_name = $plan->name_plan;
        $transaction->price = $amount;
        $transaction->recharged_on = date('Y-m-d', strtotime($paidDate));
        $transaction->recharged_time = date('H:i:s', strtotime($paidDate));
        $transaction->expiration = $userRecharge->expiration;
        $transaction->time = $userRecharge->time;
        $transaction->method = 'M-Pesa STK Push';
        $transaction->routers = 'Main Router';
        $transaction->type = 'Hotspot';
        $transaction->save();
        
        // Ensure RADIUS user exists
        require_once 'system/autoload/RadiusManager.php';
        $result = RadiusManager::createHotspotUser($mac, $mac, $plan, $userRecharge->expiration);
        
        echo "  ✅ Fixed! Recharge ID: {$userRecharge->id()}, Transaction ID: {$transaction->id()}, RADIUS: " . ($result['success'] ? 'OK' : 'FAILED') . "\n";
        $fixed++;
        
        // Session should already be completed, but double-check
        if ($session->status !== 'completed') {
            $session->status = 'completed';
            $session->save();
            echo "  ✅ Session status updated to completed\n";
        } else {
            echo "  ✅ Session already marked as completed\n";
        }
        
    } catch (Exception $e) {
        echo "  ❌ Error fixing payment $paymentId: " . $e->getMessage() . "\n";
    }
    
    echo "\n";
}

echo "=== HEALING COMPLETE ===\n";
echo "Fixed: $fixed payments\n";
echo "Finished at: " . date('Y-m-d H:i:s') . "\n\n";

if ($fixed > 0) {
    echo "✅ Run the debug tool again to verify fixes:\n";
    echo "https://glintaafrica.com/debug_session.php?mac=d3:8a:b7:4c:51:a3\n\n";
    
    echo "💡 Consider setting up a cron job to run this script regularly:\n";
    echo "*/5 * * * * /usr/bin/php /var/www/glintaafrica/heal_missing_recharges.php >> /var/log/heal_recharges.log 2>&1\n";
}
?>