<?php
/**
 * Fix Callback Routing and Internet Access Assignment
 * 
 * This script ensures that M-Pesa callbacks are properly routed and 
 * that users get internet access immediately after successful payment.
 */

require_once 'init.php';

echo "=== FIXING CALLBACK ROUTING AND INTERNET ACCESS ===\n";
echo "Started at: " . date('Y-m-d H:i:s') . "\n\n";

// Step 1: Check current Daraja configuration
echo "1. Checking current Daraja gateway configuration...\n";

$darajaGateway = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
if ($darajaGateway) {
    $pgData = json_decode($darajaGateway->pg_data, true);
    $currentCallbackUrl = $pgData['callback_url'] ?? 'Not set';
    echo "   Current callback URL: {$currentCallbackUrl}\n";
    
    // Check if it's using the system callback or direct callback
    if (strpos($currentCallbackUrl, 'callback/daraja') !== false) {
        echo "   ✅ Using system callback routing (callback/daraja)\n";
        $usingSystemCallback = true;
    } elseif (strpos($currentCallbackUrl, 'callback_mpesa.php') !== false) {
        echo "   ⚠️  Using direct callback file (callback_mpesa.php)\n";
        $usingSystemCallback = false;
    } else {
        echo "   ❌ Unknown callback URL format\n";
        $usingSystemCallback = false;
    }
} else {
    echo "   ❌ Daraja gateway not configured\n";
    exit(1);
}

// Step 2: Ensure proper database configuration for RADIUS
echo "\n2. Checking RADIUS database configuration...\n";

// Test RADIUS database connection
try {
    $testRadius = ORM::for_table('radcheck', 'radius')->limit(1)->find_one();
    echo "   ✅ RADIUS database connection working\n";
} catch (Exception $e) {
    echo "   ❌ RADIUS database connection failed: " . $e->getMessage() . "\n";
    echo "   📝 You may need to configure the RADIUS database connection in config.php\n";
    
    // Show what needs to be added to config.php
    echo "\n   Add this to your config.php:\n";
    echo "   // RADIUS Database Configuration\n";
    echo "   \$db_radius = 'mysql:host=' . \$db_host . ';dbname=radius';\n";
    echo "   ORM::configure('connection_string', \$db_radius, 'radius');\n";
    echo "   ORM::configure('username', \$db_user, 'radius');\n";
    echo "   ORM::configure('password', \$db_password, 'radius');\n";
    echo "   ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'), 'radius');\n\n";
}

// Step 3: Find and fix recent successful payments without internet access
echo "\n3. Finding successful payments without internet access...\n";

// Look for recent successful payments
$recentPayments = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2) // Paid status
    ->where('gateway', 'Daraja')
    ->where_gte('paid_date', date('Y-m-d H:i:s', strtotime('-24 hours')))
    ->order_by_desc('id')
    ->find_many();

$needsFixing = [];

foreach ($recentPayments as $payment) {
    // Check if user has active recharge
    $userRecharge = ORM::for_table('tbl_user_recharges')
        ->where('username', $payment->username)
        ->where('status', 'on')
        ->where_gt('expiration', date('Y-m-d H:i:s'))
        ->find_one();
    
    // Check if RADIUS user exists
    $radiusUser = null;
    try {
        $radiusUser = ORM::for_table('radcheck', 'radius')
            ->where('username', $payment->username)
            ->where('attribute', 'Cleartext-Password')
            ->find_one();
    } catch (Exception $e) {
        // RADIUS DB not accessible
    }
    
    $issues = [];
    if (!$userRecharge) {
        $issues[] = 'No user recharge';
    }
    if (!$radiusUser) {
        $issues[] = 'No RADIUS user';
    }
    
    if (!empty($issues)) {
        $needsFixing[] = [
            'payment' => $payment,
            'issues' => $issues,
            'has_recharge' => $userRecharge ? true : false,
            'has_radius' => $radiusUser ? true : false
        ];
        
        echo "   ❌ Payment ID {$payment->id()}: {$payment->username} - " . implode(', ', $issues) . "\n";
    }
}

if (empty($needsFixing)) {
    echo "   ✅ All recent successful payments have proper internet access\n";
} else {
    echo "   📊 Found " . count($needsFixing) . " payments that need fixing\n";
}

// Step 4: Fix the issues
if (!empty($needsFixing)) {
    echo "\n4. Fixing internet access issues...\n";
    
    $fixed = 0;
    
    foreach ($needsFixing as $item) {
        $payment = $item['payment'];
        $issues = $item['issues'];
        
        echo "   🔧 Fixing Payment ID {$payment->id()}: {$payment->username}\n";
        
        try {
            // Get plan details
            $plan = ORM::for_table('tbl_plans')->find_one($payment->plan_id);
            if (!$plan) {
                echo "      ❌ Plan not found, skipping\n";
                continue;
            }
            
            // Create user recharge if missing
            if (!$item['has_recharge']) {
                $userRecharge = ORM::for_table('tbl_user_recharges')->create();
                $userRecharge->customer_id = 0;
                $userRecharge->username = $payment->username;
                $userRecharge->plan_id = $payment->plan_id;
                $userRecharge->namebp = $payment->plan_name;
                $userRecharge->recharged_on = date('Y-m-d', strtotime($payment->paid_date));
                $userRecharge->recharged_time = date('H:i:s', strtotime($payment->paid_date));
                
                // Calculate expiration based on plan
                if ($plan->typebp == 'Limited' && $plan->limit_type == 'Time_Limit') {
                    $time_unit = $plan->time_unit;
                    $time_limit = $plan->time_limit;
                    
                    if ($time_unit == 'Hrs') {
                        $expiration = date('Y-m-d H:i:s', strtotime($payment->paid_date . ' +' . $time_limit . ' hours'));
                    } else {
                        $expiration = date('Y-m-d H:i:s', strtotime($payment->paid_date . ' +' . $time_limit . ' minutes'));
                    }
                } elseif (isset($plan->validity) && isset($plan->validity_unit)) {
                    $expiration = date('Y-m-d H:i:s', strtotime($payment->paid_date . ' +' . $plan->validity . ' ' . $plan->validity_unit));
                } else {
                    // Default 24 hours
                    $expiration = date('Y-m-d H:i:s', strtotime($payment->paid_date . ' +24 hours'));
                }
                
                $userRecharge->expiration = date('Y-m-d', strtotime($expiration));
                $userRecharge->time = date('H:i:s', strtotime($expiration));
                $userRecharge->status = 'on';
                $userRecharge->method = 'M-Pesa STK Push';
                $userRecharge->routers = $payment->routers ?: 'Main Router';
                $userRecharge->type = $plan->type ?: 'Hotspot';
                $userRecharge->admin_id = 1;
                $userRecharge->save();
                
                echo "      ✅ Created user recharge (expires: {$expiration})\n";
            } else {
                // Get existing recharge for RADIUS creation
                $userRecharge = ORM::for_table('tbl_user_recharges')
                    ->where('username', $payment->username)
                    ->where('status', 'on')
                    ->where_gt('expiration', date('Y-m-d H:i:s'))
                    ->find_one();
                
                $expiration = $userRecharge->expiration . ' ' . $userRecharge->time;
            }
            
            // Create RADIUS user if missing and plan is Hotspot
            if (!$item['has_radius'] && $plan->type == 'Hotspot') {
                require_once 'system/autoload/RadiusManager.php';
                $radiusResult = RadiusManager::createHotspotUser(
                    $payment->username, 
                    $payment->username, 
                    $plan, 
                    $expiration
                );
                
                if ($radiusResult['success']) {
                    echo "      ✅ Created RADIUS user\n";
                } else {
                    echo "      ❌ RADIUS user creation failed: {$radiusResult['message']}\n";
                }
            }
            
            // Create transaction record if missing
            $existingTransaction = ORM::for_table('tbl_transactions')
                ->where('username', $payment->username)
                ->where('method', 'M-Pesa STK Push')
                ->where('plan_name', $payment->plan_name)
                ->where('price', $payment->price)
                ->where('recharged_on', date('Y-m-d', strtotime($payment->paid_date)))
                ->find_one();
            
            if (!$existingTransaction) {
                $transaction = ORM::for_table('tbl_transactions')->create();
                $transaction->invoice = 'MPESA' . $payment->id();
                $transaction->username = $payment->username;
                $transaction->plan_name = $payment->plan_name;
                $transaction->price = $payment->price;
                $transaction->recharged_on = date('Y-m-d', strtotime($payment->paid_date));
                $transaction->recharged_time = date('H:i:s', strtotime($payment->paid_date));
                $transaction->method = 'M-Pesa STK Push';
                $transaction->routers = $payment->routers ?: 'Main Router';
                $transaction->type = $plan->type ?: 'Hotspot';
                $transaction->save();
                
                echo "      ✅ Created transaction record\n";
            }
            
            // Update portal session status if exists
            $portalSession = ORM::for_table('tbl_portal_sessions')
                ->where('payment_id', $payment->id())
                ->find_one();
            
            if ($portalSession && $portalSession->status !== 'completed') {
                $portalSession->status = 'completed';
                $portalSession->save();
                echo "      ✅ Updated portal session status\n";
            }
            
            $fixed++;
            echo "      ✅ Fixed payment ID {$payment->id()}\n\n";
            
        } catch (Exception $e) {
            echo "      ❌ Error fixing payment {$payment->id()}: {$e->getMessage()}\n\n";
        }
    }
    
    echo "   📊 Successfully fixed {$fixed} out of " . count($needsFixing) . " payments\n";
}

// Step 5: Recommendations
echo "\n=== SUMMARY AND RECOMMENDATIONS ===\n";

if ($usingSystemCallback) {
    echo "✅ Using system callback routing - this is recommended\n";
} else {
    echo "⚠️  Consider switching to system callback routing:\n";
    echo "   Update callback URL to: " . U . "callback/daraja\n";
}

echo "\n📋 MONITORING RECOMMENDATIONS:\n";
echo "1. Set up a cron job to run this healing script every 10 minutes:\n";
echo "   */10 * * * * /usr/bin/php " . __FILE__ . " >> /var/log/callback_healing.log 2>&1\n\n";

echo "2. Monitor callback logs:\n";
if ($usingSystemCallback) {
    echo "   tail -f system/logs/system.log | grep M-Pesa\n";
} else {
    echo "   tail -f system/logs/system.log | grep M-Pesa\n";
    echo "   Check direct callback logs in your web server access logs\n";
}

echo "\n3. Test the complete payment flow:\n";
echo "   - Make a test payment through captive portal\n";
echo "   - Check that tbl_payment_gateway status becomes 2 (paid)\n";
echo "   - Check that tbl_user_recharges record is created\n";
echo "   - Check that RADIUS user is created in radcheck table\n";
echo "   - Verify user can authenticate and access internet\n";

echo "\n📊 CURRENT STATUS:\n";
echo "- Recent payments checked: " . count($recentPayments) . "\n";
echo "- Payments needing fixes: " . count($needsFixing) . "\n";
echo "- Payments fixed: " . ($fixed ?? 0) . "\n";

echo "\nCompleted at: " . date('Y-m-d H:i:s') . "\n";
?>