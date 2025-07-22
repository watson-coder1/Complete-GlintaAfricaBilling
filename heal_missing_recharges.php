<?php
/**
 * Auto-Healing Script for Missing User Recharges
 * Scans for successful payments without user recharge records and fixes them
 */

require_once 'init.php';

echo "=== AUTO-HEALING MISSING USER RECHARGES ===\n";
echo "Started at: " . date('Y-m-d H:i:s') . "\n\n";

// Find successful payments without user recharges
$brokenPayments = ORM::raw_execute("
    SELECT p.*, s.mac_address, s.session_id 
    FROM tbl_payment_gateway p
    LEFT JOIN tbl_portal_sessions s ON s.payment_id = p.id
    LEFT JOIN tbl_user_recharges ur ON ur.username = s.mac_address AND ur.status = 'on'
    WHERE p.status = 2 
    AND s.mac_address IS NOT NULL
    AND ur.id IS NULL
    AND p.paid_date >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
    ORDER BY p.paid_date DESC
");

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
        
        // Update session status to completed
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('mac_address', $mac)
            ->where('payment_id', $paymentId)
            ->find_one();
        if ($session) {
            $session->status = 'completed';
            $session->save();
            echo "  ✅ Session status updated to completed\n";
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