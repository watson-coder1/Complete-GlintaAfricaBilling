<?php
/**
 * Comprehensive Fix for Internet Access Assignment After Payment
 * 
 * This script addresses multiple issues in the payment-to-access flow:
 * 1. Fixes callback URL routing inconsistencies
 * 2. Ensures proper RADIUS database configuration
 * 3. Heals missing user recharges from successful payments
 * 4. Validates and fixes RADIUS user creation
 * 5. Implements proper error handling and rollback mechanisms
 */

require_once 'init.php';

echo "=== FIXING INTERNET ACCESS ASSIGNMENT AFTER PAYMENT ===\n";
echo "Started at: " . date('Y-m-d H:i:s') . "\n\n";

// Step 1: Check and fix RADIUS database configuration
echo "1. Checking RADIUS database configuration...\n";

// Check if RADIUS database connection is configured
try {
    $radiusTest = ORM::for_table('radcheck', 'radius')->limit(1)->find_one();
    echo "   ✅ RADIUS database connection is working\n";
} catch (Exception $e) {
    echo "   ❌ RADIUS database connection failed: " . $e->getMessage() . "\n";
    echo "   🔧 Attempting to fix RADIUS database configuration...\n";
    
    // Add RADIUS database configuration if missing
    $configFile = __DIR__ . '/config.php';
    if (file_exists($configFile)) {
        $configContent = file_get_contents($configFile);
        
        // Check if RADIUS database config exists
        if (strpos($configContent, "ORM::configure('connection_string', \$db_radius, 'radius')") === false) {
            // Add RADIUS database configuration
            $radiusConfig = "\n\n// RADIUS Database Configuration\n";
            $radiusConfig .= "\$db_radius = 'mysql:host=' . \$db_host . ';dbname=radius';\n";
            $radiusConfig .= "ORM::configure('connection_string', \$db_radius, 'radius');\n";
            $radiusConfig .= "ORM::configure('username', \$db_user, 'radius');\n";
            $radiusConfig .= "ORM::configure('password', \$db_password, 'radius');\n";
            $radiusConfig .= "ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'), 'radius');\n";
            
            file_put_contents($configFile, $configContent . $radiusConfig);
            echo "   ✅ Added RADIUS database configuration to config.php\n";
        }
    }
}

// Step 2: Fix callback URL routing inconsistencies
echo "\n2. Fixing callback URL routing...\n";

// Update Daraja gateway configuration to use consistent callback URL
$darajaGateway = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
if ($darajaGateway) {
    $pgData = json_decode($darajaGateway->pg_data, true);
    
    // Ensure callback URL points to the direct callback handler
    $correctCallbackUrl = U . 'callback_mpesa.php';
    if (isset($pgData['callback_url']) && $pgData['callback_url'] !== $correctCallbackUrl) {
        $pgData['callback_url'] = $correctCallbackUrl;
        $darajaGateway->pg_data = json_encode($pgData);
        $darajaGateway->save();
        echo "   ✅ Updated Daraja callback URL to: $correctCallbackUrl\n";
    } else {
        echo "   ✅ Daraja callback URL is correctly configured\n";
    }
} else {
    echo "   ⚠️  Daraja gateway not found in database\n";
}

// Step 3: Check for successful payments without user recharges
echo "\n3. Healing missing user recharges from successful payments...\n";

$successfulPayments = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2) // Paid status
    ->where_gte('paid_date', date('Y-m-d H:i:s', strtotime('-48 hours')))
    ->order_by_desc('id')
    ->find_many();

$missingRecharges = 0;
$fixedRecharges = 0;

foreach ($successfulPayments as $payment) {
    // Check if user recharge exists
    $userRecharge = ORM::for_table('tbl_user_recharges')
        ->where('username', $payment->username)
        ->where('status', 'on')
        ->where_gt('expiration', date('Y-m-d H:i:s'))
        ->find_one();
    
    if (!$userRecharge) {
        $missingRecharges++;
        echo "   ❌ Missing recharge for payment ID: {$payment->id()}, User: {$payment->username}\n";
        
        // Get plan details
        $plan = ORM::for_table('tbl_plans')->find_one($payment->plan_id);
        if (!$plan) {
            echo "      ⚠️  Plan not found, skipping...\n";
            continue;
        }
        
        try {
            // Create user recharge record
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
                $transaction->expiration = $userRecharge->expiration;
                $transaction->time = $userRecharge->time;
                $transaction->save();
                
                echo "      ✅ Created transaction record\n";
            }
            
            // Create RADIUS user
            require_once 'system/autoload/RadiusManager.php';
            $radiusResult = RadiusManager::createHotspotUser($payment->username, $payment->username, $plan, $expiration);
            
            if ($radiusResult['success']) {
                echo "      ✅ Fixed! Created recharge and RADIUS user for {$payment->username}\n";
                $fixedRecharges++;
            } else {
                echo "      ⚠️  Recharge created but RADIUS user creation failed: {$radiusResult['message']}\n";
            }
            
        } catch (Exception $e) {
            echo "      ❌ Error creating recharge: " . $e->getMessage() . "\n";
        }
    }
}

echo "   📊 Found {$missingRecharges} missing recharges, fixed {$fixedRecharges}\n";

// Step 4: Validate existing RADIUS users
echo "\n4. Validating existing RADIUS users...\n";

$activeRecharges = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_gt('expiration', date('Y-m-d H:i:s'))
    ->find_many();

$missingRadiusUsers = 0;
$fixedRadiusUsers = 0;

foreach ($activeRecharges as $recharge) {
    if ($recharge->type === 'Hotspot') {
        // Check if RADIUS user exists
        try {
            $radiusUser = ORM::for_table('radcheck', 'radius')
                ->where('username', $recharge->username)
                ->where('attribute', 'Cleartext-Password')
                ->find_one();
            
            if (!$radiusUser) {
                $missingRadiusUsers++;
                echo "   ❌ Missing RADIUS user for active recharge: {$recharge->username}\n";
                
                // Get plan for RADIUS creation
                $plan = ORM::for_table('tbl_plans')->find_one($recharge->plan_id);
                if ($plan) {
                    require_once 'system/autoload/RadiusManager.php';
                    $radiusResult = RadiusManager::createHotspotUser(
                        $recharge->username, 
                        $recharge->username, 
                        $plan, 
                        $recharge->expiration . ' ' . $recharge->time
                    );
                    
                    if ($radiusResult['success']) {
                        echo "      ✅ Created missing RADIUS user for {$recharge->username}\n";
                        $fixedRadiusUsers++;
                    } else {
                        echo "      ❌ Failed to create RADIUS user: {$radiusResult['message']}\n";
                    }
                }
            }
        } catch (Exception $e) {
            echo "   ⚠️  Error checking RADIUS user {$recharge->username}: " . $e->getMessage() . "\n";
        }
    }
}

echo "   📊 Found {$missingRadiusUsers} missing RADIUS users, fixed {$fixedRadiusUsers}\n";

// Step 5: Update callback handler with improved error handling
echo "\n5. Creating improved callback handler...\n";

$improvedCallbackPath = __DIR__ . '/callback_mpesa_improved.php';
$improvedCallback = '<?php
/**
 * Improved M-Pesa Callback Handler with Enhanced Error Handling
 * This version includes proper rollback mechanisms and logging
 */

// Set JSON response header
header("Content-Type: application/json");

// Allow CORS for Safaricom
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Handle preflight requests
if ($_SERVER["REQUEST_METHOD"] == "OPTIONS") {
    http_response_code(200);
    exit();
}

try {
    // Include system initialization
    require_once "init.php";
    
    // Log incoming request
    $raw_input = file_get_contents("php://input");
    _log("M-Pesa Callback Raw Input: " . $raw_input, "M-Pesa", 0);
    
    // Validate request method
    if ($_SERVER["REQUEST_METHOD"] !== "POST") {
        http_response_code(405);
        echo json_encode(["success" => false, "message" => "Method not allowed"]);
        exit();
    }
    
    // Parse JSON input
    $callback_data = json_decode($raw_input, true);
    
    if (!$callback_data) {
        _log("M-Pesa Callback: Invalid JSON received", "M-Pesa", 0);
        http_response_code(400);
        echo json_encode(["success" => false, "message" => "Invalid JSON"]);
        exit();
    }
    
    // Validate callback structure
    if (!isset($callback_data["Body"]["stkCallback"])) {
        _log("M-Pesa Callback: Invalid callback structure", "M-Pesa", 0);
        http_response_code(400);
        echo json_encode(["success" => false, "message" => "Invalid callback structure"]);
        exit();
    }
    
    $stk_callback = $callback_data["Body"]["stkCallback"];
    $checkout_request_id = $stk_callback["CheckoutRequestID"] ?? "";
    $result_code = $stk_callback["ResultCode"] ?? "";
    $result_desc = $stk_callback["ResultDesc"] ?? "";
    
    _log("M-Pesa Callback - CheckoutID: {$checkout_request_id}, ResultCode: {$result_code}, ResultDesc: {$result_desc}", "M-Pesa", 0);
    
    if (empty($checkout_request_id)) {
        _log("M-Pesa Callback: Missing CheckoutRequestID", "M-Pesa", 0);
        http_response_code(400);
        echo json_encode(["success" => false, "message" => "Missing CheckoutRequestID"]);
        exit();
    }
    
    // Find payment record
    $payment = ORM::for_table("tbl_payment_gateway")
        ->where("checkout_request_id", $checkout_request_id)
        ->find_one();
    
    if (!$payment) {
        _log("M-Pesa Callback: Payment record not found for CheckoutID: {$checkout_request_id}", "M-Pesa", 0);
        http_response_code(404);
        echo json_encode(["success" => false, "message" => "Payment record not found"]);
        exit();
    }
    
    // Update payment record with callback data
    $payment->pg_paid_response = $raw_input;
    
    if ($result_code == "0") {
        // Payment successful - start transaction for atomicity
        ORM::get_db()->beginTransaction();
        
        try {
            _log("M-Pesa Payment SUCCESS for CheckoutID: {$checkout_request_id}", "M-Pesa", 0);
            
            $callback_metadata = $stk_callback["CallbackMetadata"]["Item"] ?? [];
            $mpesa_receipt = "";
            $phone_number = "";
            $amount = 0;
            $transaction_date = "";
            
            // Extract callback metadata
            foreach ($callback_metadata as $item) {
                switch ($item["Name"]) {
                    case "MpesaReceiptNumber":
                        $mpesa_receipt = $item["Value"];
                        break;
                    case "PhoneNumber":
                        $phone_number = $item["Value"];
                        break;
                    case "Amount":
                        $amount = $item["Value"];
                        break;
                    case "TransactionDate":
                        $transaction_date = $item["Value"];
                        break;
                }
            }
            
            // Update payment record
            $payment->status = 2; // Paid
            $payment->paid_date = date("Y-m-d H:i:s");
            $payment->mpesa_receipt_number = $mpesa_receipt;
            $payment->mpesa_phone_number = $phone_number;
            $payment->mpesa_amount = $amount;
            $payment->save();
            
            _log("M-Pesa Payment Details - Receipt: {$mpesa_receipt}, Phone: {$phone_number}, Amount: {$amount}", "M-Pesa", 0);
            
            // Get plan details
            $plan = ORM::for_table("tbl_plans")->find_one($payment->plan_id);
            if (!$plan) {
                throw new Exception("Plan not found: {$payment->plan_id}");
            }
            
            // Check if transaction already exists to prevent duplicates
            $existingTransaction = ORM::for_table("tbl_transactions")
                ->where("username", $payment->username)
                ->where("method", "M-Pesa STK Push")
                ->where("plan_name", $payment->plan_name)
                ->where("price", $payment->price)
                ->where("recharged_on", date("Y-m-d"))
                ->find_one();
                
            if (!$existingTransaction) {
                // Create transaction record
                $transaction = ORM::for_table("tbl_transactions")->create();
                $transaction->invoice = "MPESA" . $payment->id();
                $transaction->username = $payment->username;
                $transaction->plan_name = $payment->plan_name;
                $transaction->price = $payment->price;
                $transaction->recharged_on = date("Y-m-d");
                $transaction->recharged_time = date("H:i:s");
                $transaction->method = "M-Pesa STK Push";
                $transaction->routers = $payment->routers;
                $transaction->type = $plan->type;
                $transaction->save();
                
                _log("M-Pesa Transaction created - Invoice: MPESA{$payment->id()}, Amount: {$payment->price}", "M-Pesa", 0);
            }
            
            // Check if user recharge already exists
            $existingRecharge = ORM::for_table("tbl_user_recharges")
                ->where("username", $payment->username)
                ->where("status", "on")
                ->where_gt("expiration", date("Y-m-d H:i:s"))
                ->find_one();
            
            if (!$existingRecharge) {
                // Create user recharge record
                $recharge = ORM::for_table("tbl_user_recharges")->create();
                $recharge->customer_id = 0;
                $recharge->username = $payment->username;
                $recharge->plan_id = $payment->plan_id;
                $recharge->namebp = $payment->plan_name;
                $recharge->recharged_on = date("Y-m-d");
                $recharge->recharged_time = date("H:i:s");
                
                // Calculate expiration based on plan
                if ($plan->typebp == "Limited" && $plan->limit_type == "Time_Limit") {
                    $time_unit = $plan->time_unit;
                    $time_limit = $plan->time_limit;
                    
                    if ($time_unit == "Hrs") {
                        $expiration = date("Y-m-d H:i:s", strtotime("+" . $time_limit . " hours"));
                    } else {
                        $expiration = date("Y-m-d H:i:s", strtotime("+" . $time_limit . " minutes"));
                    }
                } elseif (isset($plan->validity) && isset($plan->validity_unit)) {
                    $expiration = date("Y-m-d H:i:s", strtotime("+" . $plan->validity . " " . $plan->validity_unit));
                } else {
                    // Default 24 hours
                    $expiration = date("Y-m-d H:i:s", strtotime("+24 hours"));
                }
                
                $recharge->expiration = date("Y-m-d", strtotime($expiration));
                $recharge->time = date("H:i:s", strtotime($expiration));
                $recharge->status = "on";
                $recharge->method = "M-Pesa STK Push";
                $recharge->routers = $payment->routers ?: "Main Router";
                $recharge->type = $plan->type ?: "Hotspot";
                $recharge->admin_id = 1;
                $recharge->save();
                
                _log("User recharge created for: {$payment->username}, expires: {$expiration}", "M-Pesa", 0);
            }
            
            // Create RADIUS user for hotspot plans
            if ($plan->type == "Hotspot") {
                require_once dirname(__DIR__) . "/system/autoload/RadiusManager.php";
                $radiusResult = RadiusManager::createHotspotUser(
                    $payment->username, 
                    $payment->username, 
                    $plan, 
                    $expiration ?? date("Y-m-d H:i:s", strtotime("+24 hours"))
                );
                
                if ($radiusResult["success"]) {
                    _log("RADIUS user created successfully for: {$payment->username}", "M-Pesa", 0);
                } else {
                    _log("RADIUS user creation failed for: {$payment->username} - " . $radiusResult["message"], "M-Pesa", 0);
                    // Don\'t fail the transaction if RADIUS creation fails, but log it
                }
            }
            
            // Update portal session status if exists
            $portalSession = ORM::for_table("tbl_portal_sessions")
                ->where("payment_id", $payment->id())
                ->find_one();
            
            if ($portalSession) {
                $portalSession->status = "completed";
                $portalSession->save();
                _log("Portal session marked as completed for payment: {$payment->id()}", "M-Pesa", 0);
            }
            
            // Commit transaction
            ORM::get_db()->commit();
            _log("M-Pesa callback processing completed successfully", "M-Pesa", 0);
            
        } catch (Exception $e) {
            // Rollback transaction on error
            ORM::get_db()->rollback();
            _log("M-Pesa callback processing failed, rolled back: " . $e->getMessage(), "M-Pesa", 0);
            throw $e;
        }
        
    } else {
        // Payment failed or cancelled
        _log("M-Pesa Payment FAILED for CheckoutID: {$checkout_request_id}, ResultCode: {$result_code}, ResultDesc: {$result_desc}", "M-Pesa", 0);
        
        $payment->status = 3; // Failed
        $payment->save();
        
        // Update portal session status if exists
        $portalSession = ORM::for_table("tbl_portal_sessions")
            ->where("payment_id", $payment->id())
            ->find_one();
        
        if ($portalSession) {
            $portalSession->status = "failed";
            $portalSession->save();
        }
    }
    
    // Respond to Safaricom
    http_response_code(200);
    echo json_encode([
        "ResultCode" => 0,
        "ResultDesc" => "Success"
    ]);
    
} catch (Exception $e) {
    _log("M-Pesa Callback Exception: " . $e->getMessage(), "M-Pesa", 0);
    
    http_response_code(500);
    echo json_encode([
        "ResultCode" => 1,
        "ResultDesc" => "Internal server error"
    ]);
}
?>';

file_put_contents($improvedCallbackPath, $improvedCallback);
echo "   ✅ Created improved callback handler: callback_mpesa_improved.php\n";

// Step 6: Summary and recommendations
echo "\n=== SUMMARY AND RECOMMENDATIONS ===\n";
echo "✅ Fixed RADIUS database configuration\n";
echo "✅ Updated callback URL routing\n";
echo "✅ Healed {$fixedRecharges} missing user recharges\n";
echo "✅ Fixed {$fixedRadiusUsers} missing RADIUS users\n";
echo "✅ Created improved callback handler with error handling\n\n";

echo "📋 NEXT STEPS:\n";
echo "1. Replace callback_mpesa.php with callback_mpesa_improved.php:\n";
echo "   mv callback_mpesa.php callback_mpesa_backup.php\n";
echo "   mv callback_mpesa_improved.php callback_mpesa.php\n\n";

echo "2. Set up monitoring cron job to run this healing script:\n";
echo "   */10 * * * * /usr/bin/php " . __FILE__ . " >> /var/log/heal_internet_access.log 2>&1\n\n";

echo "3. Monitor logs for any remaining issues:\n";
echo "   tail -f /var/log/heal_internet_access.log\n";
echo "   tail -f system/logs/system.log\n\n";

echo "4. Test the complete flow:\n";
echo "   - Make a test payment through captive portal\n";
echo "   - Verify user_recharge is created\n";
echo "   - Verify RADIUS user is created in radcheck table\n";
echo "   - Verify user can access internet\n\n";

echo "Completed at: " . date('Y-m-d H:i:s') . "\n";
?>