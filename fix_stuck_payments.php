<?php
/**
 * Stuck Payment Healing Script
 * Fixes captive portal payments that are stuck in processing state
 * Run this script when users report being stuck on processing page
 */

require_once('system/autoload.php');

// Define logging function
function logMessage($message) {
    $logFile = __DIR__ . '/system/uploads/payment_healing.log';
    file_put_contents($logFile, date('Y-m-d H:i:s') . " - " . $message . PHP_EOL, FILE_APPEND);
    echo date('Y-m-d H:i:s') . " - " . $message . "\n";
}

logMessage("=== PAYMENT HEALING SCRIPT STARTED ===");

// 1. Find payments that are successful but sessions are not marked completed
$stuckPayments = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2) // Paid
    ->where('gateway', 'Daraja')
    ->where_gte('created_date', date('Y-m-d H:i:s', strtotime('-24 hours')))
    ->find_many();

logMessage("Found " . count($stuckPayments) . " successful payments in the last 24 hours");

$healedCount = 0;

foreach ($stuckPayments as $payment) {
    // Find corresponding session
    $session = ORM::for_table('tbl_portal_sessions')
        ->where('payment_id', $payment->id())
        ->find_one();
    
    if ($session && $session->status !== 'completed') {
        logMessage("HEALING: Found stuck session " . $session->session_id . " with payment ID " . $payment->id());
        
        // Get plan details
        $plan = ORM::for_table('tbl_plans')
            ->where('id', $payment->plan_id)
            ->find_one();
        
        if ($plan) {
            // Check if user recharge exists
            $userRecharge = ORM::for_table('tbl_user_recharges')
                ->where('username', $session->mac_address)
                ->where('status', 'on')
                ->where_gt('expiration', date('Y-m-d H:i:s'))
                ->find_one();
            
            if (!$userRecharge) {
                // Create missing user recharge
                $userRecharge = ORM::for_table('tbl_user_recharges')->create();
                $userRecharge->customer_id = 0;
                $userRecharge->username = $session->mac_address;
                $userRecharge->plan_id = $plan->id();
                $userRecharge->namebp = $plan->name_plan;
                $userRecharge->recharged_on = date('Y-m-d');
                $userRecharge->recharged_time = date('H:i:s');
                $userRecharge->expiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
                $userRecharge->time = date('H:i:s');
                $userRecharge->status = 'on';
                $userRecharge->type = 'Hotspot';
                $userRecharge->routers = 'Main Router';
                $userRecharge->method = 'M-Pesa STK Push (Healed)';
                $userRecharge->admin_id = 1;
                $userRecharge->save();
                
                logMessage("HEALING: Created missing user recharge for " . $session->mac_address);
                
                // Create transaction record
                $transaction = ORM::for_table('tbl_transactions')->create();
                $transaction->invoice = $userRecharge->id();
                $transaction->username = $session->mac_address;
                $transaction->plan_name = $plan->name_plan;
                $transaction->price = $payment->price;
                $transaction->recharged_on = date('Y-m-d');
                $transaction->recharged_time = date('H:i:s');
                $transaction->expiration = $userRecharge->expiration;
                $transaction->time = $userRecharge->time;
                $transaction->method = 'M-Pesa STK Push (Healed)';
                $transaction->routers = 'Main Router';
                $transaction->type = 'Hotspot';
                $transaction->save();
                
                logMessage("HEALING: Created transaction record for " . $session->mac_address);
            }
            
            // Create RADIUS user
            require_once __DIR__ . '/system/autoload/RadiusManager.php';
            $result = RadiusManager::createHotspotUser(
                $session->mac_address, 
                $session->mac_address, 
                $plan, 
                $userRecharge->expiration
            );
            
            if ($result['success']) {
                logMessage("HEALING: RADIUS user created/updated for " . $session->mac_address);
            } else {
                logMessage("HEALING: RADIUS user creation failed for " . $session->mac_address . " - " . $result['message']);
            }
            
            // Mark session as completed
            $session->status = 'completed';
            $session->save();
            
            logMessage("HEALING: Marked session " . $session->session_id . " as completed");
            $healedCount++;
        }
    }
}

// 2. Check for payments stuck in processing state for more than 10 minutes
$oldProcessingSessions = ORM::for_table('tbl_portal_sessions')
    ->where('status', 'processing')
    ->where_lt('created_at', date('Y-m-d H:i:s', strtotime('-10 minutes')))
    ->find_many();

logMessage("Found " . count($oldProcessingSessions) . " sessions stuck in processing for more than 10 minutes");

foreach ($oldProcessingSessions as $session) {
    if ($session->payment_id) {
        $payment = ORM::for_table('tbl_payment_gateway')
            ->where('id', $session->payment_id)
            ->find_one();
        
        if ($payment && $payment->status == 2) { // Payment successful but session not updated
            logMessage("HEALING: Found successful payment with stuck session - Session ID: " . $session->session_id);
            
            // Get plan and heal as above
            $plan = ORM::for_table('tbl_plans')
                ->where('id', $payment->plan_id)
                ->find_one();
            
            if ($plan) {
                // Similar healing process as above
                $userRecharge = ORM::for_table('tbl_user_recharges')
                    ->where('username', $session->mac_address)
                    ->where('status', 'on')
                    ->where_gt('expiration', date('Y-m-d H:i:s'))
                    ->find_one();
                
                if (!$userRecharge) {
                    // Create user recharge (same as above)
                    $userRecharge = ORM::for_table('tbl_user_recharges')->create();
                    $userRecharge->customer_id = 0;
                    $userRecharge->username = $session->mac_address;
                    $userRecharge->plan_id = $plan->id();
                    $userRecharge->namebp = $plan->name_plan;
                    $userRecharge->recharged_on = date('Y-m-d');
                    $userRecharge->recharged_time = date('H:i:s');
                    $userRecharge->expiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
                    $userRecharge->time = date('H:i:s');
                    $userRecharge->status = 'on';
                    $userRecharge->type = 'Hotspot';
                    $userRecharge->routers = 'Main Router';
                    $userRecharge->method = 'M-Pesa STK Push (Healed)';
                    $userRecharge->admin_id = 1;
                    $userRecharge->save();
                    
                    // Create transaction record
                    $transaction = ORM::for_table('tbl_transactions')->create();
                    $transaction->invoice = $userRecharge->id();
                    $transaction->username = $session->mac_address;
                    $transaction->plan_name = $plan->name_plan;
                    $transaction->price = $payment->price;
                    $transaction->recharged_on = date('Y-m-d');
                    $transaction->recharged_time = date('H:i:s');
                    $transaction->expiration = $userRecharge->expiration;
                    $transaction->time = $userRecharge->time;
                    $transaction->method = 'M-Pesa STK Push (Healed)';
                    $transaction->routers = 'Main Router';
                    $transaction->type = 'Hotspot';
                    $transaction->save();
                }
                
                // Create RADIUS user
                require_once __DIR__ . '/system/autoload/RadiusManager.php';
                $result = RadiusManager::createHotspotUser(
                    $session->mac_address, 
                    $session->mac_address, 
                    $plan, 
                    $userRecharge->expiration
                );
                
                // Mark session as completed
                $session->status = 'completed';
                $session->save();
                
                logMessage("HEALING: Healed stuck processing session " . $session->session_id);
                $healedCount++;
            }
        } else if ($payment && $payment->status == 3) { // Payment failed
            $session->status = 'failed';
            $session->save();
            logMessage("HEALING: Marked failed payment session as failed - Session ID: " . $session->session_id);
        }
    }
}

logMessage("=== HEALING COMPLETE: " . $healedCount . " sessions healed ===");

// 3. Display summary
echo "\n=== PAYMENT HEALING SUMMARY ===\n";
echo "Total sessions healed: " . $healedCount . "\n";
echo "Check system/uploads/payment_healing.log for detailed logs\n";
echo "\nTo automatically run this script every 10 minutes, add this cron job:\n";
echo "*/10 * * * * /usr/bin/php " . __FILE__ . " >> /var/log/payment_healing_cron.log 2>&1\n";
?>