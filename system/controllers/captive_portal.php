<?php

/**
 * Enhanced Dynamic Captive Portal Controller
 * True captive portal flow - no login required, just payment for access
 * Integrated with existing system (tbl_plans, RadiusManager, M-Pesa)
 */

// Debug logging for all portal requests
$debugInfo = "=== Captive Portal Request " . date('Y-m-d H:i:s') . " ===\n";
$debugInfo .= "Route: " . ($routes['1'] ?? 'landing') . "\n";
$debugInfo .= "Method: " . $_SERVER['REQUEST_METHOD'] . "\n";
$debugInfo .= "GET: " . json_encode($_GET) . "\n";
$debugInfo .= "POST: " . json_encode($_POST) . "\n";
$debugInfo .= "User Agent: " . ($_SERVER['HTTP_USER_AGENT'] ?? 'Unknown') . "\n";
file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', $debugInfo . "\n", FILE_APPEND);

switch ($routes['1']) {
    case 'landing':
    default:
        // Main captive portal landing page
        $mac = $_GET['mac'] ?? '';
        $ip = $_GET['ip'] ?? '';
        $sessionId = uniqid('portal_', true);
        
        // Detect real IP if not provided by MikroTik
        if (empty($ip)) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? $_SERVER['HTTP_X_REAL_IP'] ?? $_SERVER['REMOTE_ADDR'] ?? 'Unknown';
            if (strpos($ip, ',') !== false) {
                $ip = trim(explode(',', $ip)[0]);
            }
        }
        
        // Generate MAC if not provided (device fingerprinting)
        if (empty($mac)) {
            $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
            if (!empty($userAgent)) {
                $deviceHash = substr(md5($userAgent . $ip . $_SERVER['HTTP_ACCEPT_LANGUAGE']), 0, 12);
                $mac = implode(':', str_split($deviceHash, 2));
            } else {
                $mac = 'device-' . substr(md5($ip . time()), 0, 12);
            }
        }
        
        // Check if MAC already has active session
        $activeSession = ORM::for_table('tbl_user_recharges')
            ->where('username', $mac)
            ->where('status', 'on')
            ->where_gt('expiration', date('Y-m-d H:i:s'))
            ->find_one();
            
        if ($activeSession) {
            // User already has active session - redirect to status
            r2(U . 'captive_portal/status/' . $mac);
        }
        
        // Create new portal session
        $session = ORM::for_table('tbl_portal_sessions')->create();
        $session->session_id = $sessionId;
        $session->mac_address = $mac;
        $session->ip_address = $ip;
        $session->user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';
        $session->created_at = date('Y-m-d H:i:s');
        $session->status = 'pending';
        $session->save();
        
        // Get available packages from existing plans (Hotspot only)
        $packages = ORM::for_table('tbl_plans')
            ->where('enabled', 1)
            ->where('type', 'Hotspot')
            ->order_by_asc('price')
            ->find_many();
            
        $ui->assign('packages', $packages);
        $ui->assign('session_id', $sessionId);
        $ui->assign('mac', $mac);
        $ui->assign('ip', $ip);
        $ui->assign('_title', 'Glinta Africa WiFi Portal');
        $ui->display('captive_portal_landing.tpl');
        break;
        
    case 'select':
        // Package selection and M-Pesa payment initiation
        $sessionId = $_POST['session_id'] ?? '';
        $planId = $_POST['plan_id'] ?? '';
        $phoneNumber = $_POST['phone_number'] ?? '';
        
        if (!$sessionId || !$planId || !$phoneNumber) {
            r2(U . 'captive_portal', 'e', 'Missing required information');
        }
        
        // Validate phone number
        $phoneNumber = preg_replace('/[^0-9]/', '', $phoneNumber);
        if (strlen($phoneNumber) < 10) {
            r2(U . 'captive_portal', 'e', 'Please enter a valid phone number');
        }
        
        // Format to 254 format
        if (substr($phoneNumber, 0, 1) === '0') {
            $phoneNumber = '254' . substr($phoneNumber, 1);
        } elseif (substr($phoneNumber, 0, 3) !== '254') {
            $phoneNumber = '254' . $phoneNumber;
        }
        
        // Get session and plan
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'captive_portal', 'e', 'Invalid session');
        }
        
        $plan = ORM::for_table('tbl_plans')
            ->where('id', $planId)
            ->where('enabled', 1)
            ->find_one();
            
        if (!$plan) {
            r2(U . 'captive_portal', 'e', 'Invalid plan selected');
        }
        
        // Update session with plan and phone
        $session->plan_id = $planId;
        $session->phone_number = $phoneNumber;
        $session->amount = $plan->price;
        $session->save();
        
        // Check if M-Pesa gateway is configured
        $mpesaConfig = ORM::for_table('tbl_appconfig')
            ->where('setting', 'mpesa_consumer_key')
            ->find_one();
            
        if (!$mpesaConfig || empty($mpesaConfig->value)) {
            r2(U . 'captive_portal', 'e', 'Payment system not configured. Please contact administrator.');
        }
        
        // Initiate M-Pesa STK Push using existing gateway
        try {
            // Use existing Daraja integration
            require_once 'system/paymentgateway/Daraja.php';
            
            $accountReference = 'PORTAL-' . substr($sessionId, -8);
            $transactionDesc = 'Glinta WiFi - ' . $plan->name_plan;
            
            $stkResult = Daraja_stk_push($phoneNumber, $plan->price, $accountReference, $transactionDesc);
            
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                "STK Push Result: " . json_encode($stkResult) . "\n", FILE_APPEND);
            
            if ($stkResult['success']) {
                // Create payment gateway record
                $payment = ORM::for_table('tbl_payment_gateway')->create();
                $payment->username = $session->mac_address;
                $payment->gateway = 'Daraja';
                $payment->plan_id = $planId;
                $payment->plan_name = $plan->name_plan;
                $payment->price = $plan->price;
                $payment->pg_url_payment = $stkResult['checkout_request_id'];
                $payment->payment_method = 'M-Pesa STK Push';
                $payment->payment_channel = 'Captive Portal';
                $payment->created_date = date('Y-m-d H:i:s');
                $payment->pg_paid_response = json_encode($stkResult);
                $payment->status = 1; // Pending
                $payment->save();
                
                // Update session with payment ID
                $session->payment_id = $payment->id;
                $session->checkout_request_id = $stkResult['checkout_request_id'];
                $session->save();
                
                // Redirect to payment status page
                r2(U . 'captive_portal/payment/' . $sessionId, 's', 'Payment request sent to your phone. Please check and enter your M-Pesa PIN.');
            } else {
                r2(U . 'captive_portal', 'e', 'Failed to initiate payment: ' . ($stkResult['message'] ?? 'Unknown error'));
            }
        } catch (Exception $e) {
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                "Payment Error: " . $e->getMessage() . "\n", FILE_APPEND);
            r2(U . 'captive_portal', 'e', 'Payment system error. Please try again.');
        }
        break;
        
    case 'payment':
        // Payment status and monitoring page
        $sessionId = $routes['2'] ?? '';
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'captive_portal', 'e', 'Invalid session');
        }
        
        $plan = ORM::for_table('tbl_plans')
            ->where('id', $session->plan_id)
            ->find_one();
            
        $payment = ORM::for_table('tbl_payment_gateway')
            ->where('id', $session->payment_id)
            ->find_one();
            
        $ui->assign('session', $session);
        $ui->assign('plan', $plan);
        $ui->assign('payment', $payment);
        $ui->assign('_title', 'Processing Payment - Glinta Africa');
        $ui->display('captive_portal_payment.tpl');
        break;
        
    case 'status':
        // Check payment and session status
        $sessionId = $routes['2'] ?? '';
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // AJAX status check
            header('Content-Type: application/json');
            
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $sessionId)
                ->find_one();
                
            if (!$session) {
                echo json_encode(['status' => 'error', 'message' => 'Session not found']);
                exit;
            }
            
            // Check if payment is completed
            $payment = ORM::for_table('tbl_payment_gateway')
                ->where('id', $session->payment_id)
                ->find_one();
                
            if ($payment && $payment->status == 2) { // Paid
                echo json_encode([
                    'status' => 'completed',
                    'message' => 'Payment successful! Internet access activated.',
                    'redirect' => U . 'captive_portal/success/' . $sessionId
                ]);
            } else {
                echo json_encode([
                    'status' => 'pending',
                    'message' => 'Waiting for payment confirmation...'
                ]);
            }
            exit;
        }
        
        // Regular status page
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'captive_portal', 'e', 'Invalid session');
        }
        
        $plan = ORM::for_table('tbl_plans')
            ->where('id', $session->plan_id)
            ->find_one();
            
        $payment = ORM::for_table('tbl_payment_gateway')
            ->where('id', $session->payment_id)
            ->find_one();
            
        // Check if already paid and active
        if ($payment && $payment->status == 2) {
            r2(U . 'captive_portal/success/' . $sessionId);
        }
        
        $ui->assign('session', $session);
        $ui->assign('plan', $plan);
        $ui->assign('payment', $payment);
        $ui->display('captive_portal_status.tpl');
        break;
        
    case 'success':
        // Success page after payment completion
        $sessionId = $routes['2'] ?? '';
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'captive_portal', 'e', 'Invalid session');
        }
        
        $plan = ORM::for_table('tbl_plans')
            ->where('id', $session->plan_id)
            ->find_one();
            
        $payment = ORM::for_table('tbl_payment_gateway')
            ->where('id', $session->payment_id)
            ->find_one();
            
        // Check if user recharge exists (should be created by callback)
        $userRecharge = ORM::for_table('tbl_user_recharges')
            ->where('username', $session->mac_address)
            ->where('status', 'on')
            ->find_one();
            
        $ui->assign('session', $session);
        $ui->assign('plan', $plan);
        $ui->assign('payment', $payment);
        $ui->assign('user_recharge', $userRecharge);
        $ui->assign('_title', 'Welcome to Glinta WiFi');
        $ui->display('captive_portal_success.tpl');
        break;
        
    case 'callback':
        // M-Pesa callback handler for captive portal payments
        header('Content-Type: application/json');
        
        $input = file_get_contents('php://input');
        file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
            date('Y-m-d H:i:s') . ' - ' . $input . PHP_EOL, FILE_APPEND);
        
        try {
            $data = json_decode($input, true);
            
            if ($data && isset($data['Body']['stkCallback'])) {
                $callback = $data['Body']['stkCallback'];
                $checkoutRequestId = $callback['CheckoutRequestID'];
                $resultCode = $callback['ResultCode'];
                
                // Find the payment record
                $payment = ORM::for_table('tbl_payment_gateway')
                    ->where('pg_url_payment', $checkoutRequestId)
                    ->find_one();
                    
                if ($payment) {
                    if ($resultCode == 0) { // Success
                        // Process successful payment
                        $mpesaReceiptNumber = '';
                        $phoneNumber = '';
                        $amount = 0;
                        
                        if (isset($callback['CallbackMetadata']['Item'])) {
                            foreach ($callback['CallbackMetadata']['Item'] as $item) {
                                switch ($item['Name']) {
                                    case 'MpesaReceiptNumber':
                                        $mpesaReceiptNumber = $item['Value'];
                                        break;
                                    case 'PhoneNumber':
                                        $phoneNumber = $item['Value'];
                                        break;
                                    case 'Amount':
                                        $amount = $item['Value'];
                                        break;
                                }
                            }
                        }
                        
                        // Update payment record
                        $payment->status = 2; // Paid
                        $payment->paid_date = date('Y-m-d H:i:s');
                        $payment->pg_paid_response = $input;
                        $payment->save();
                        
                        // Get session and plan
                        $session = ORM::for_table('tbl_portal_sessions')
                            ->where('payment_id', $payment->id)
                            ->find_one();
                            
                        $plan = ORM::for_table('tbl_plans')
                            ->where('id', $payment->plan_id)
                            ->find_one();
                        
                        if ($session && $plan) {
                            // Create user recharge record
                            $userRecharge = ORM::for_table('tbl_user_recharges')->create();
                            $userRecharge->customer_id = 0; // Portal customer
                            $userRecharge->username = $session->mac_address;
                            $userRecharge->plan_id = $plan->id;
                            $userRecharge->namebp = $plan->name_plan;
                            $userRecharge->recharged_on = date('Y-m-d');
                            $userRecharge->recharged_time = date('H:i:s');
                            $userRecharge->expiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
                            $userRecharge->time = date('H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
                            $userRecharge->status = 'on';
                            $userRecharge->type = 'Hotspot';
                            $userRecharge->routers = $plan->routers;
                            $userRecharge->method = 'M-Pesa STK Push';
                            $userRecharge->save();
                            
                            // Create transaction record
                            $transaction = ORM::for_table('tbl_transactions')->create();
                            $transaction->invoice = $userRecharge->id;
                            $transaction->username = $session->mac_address;
                            $transaction->plan_name = $plan->name_plan;
                            $transaction->price = $payment->price;
                            $transaction->recharged_on = date('Y-m-d');
                            $transaction->recharged_time = date('H:i:s');
                            $transaction->expiration = $userRecharge->expiration;
                            $transaction->time = $userRecharge->time;
                            $transaction->method = 'M-Pesa STK Push';
                            $transaction->routers = $plan->routers;
                            $transaction->save();
                            
                            // Create MikroTik user using RadiusManager
                            try {
                                require_once 'system/autoload/RadiusManager.php';
                                
                                $username = $session->mac_address;
                                $password = $session->mac_address; // Use MAC as password for auto-login
                                
                                $result = RadiusManager::createHotspotUser($username, $password, $plan);
                                
                                if ($result['success']) {
                                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                                        "RADIUS User Created: $username\n", FILE_APPEND);
                                        
                                    // Update session status
                                    $session->status = 'completed';
                                    $session->mikrotik_user = $username;
                                    $session->save();
                                } else {
                                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                                        "RADIUS User Creation Failed: " . $result['message'] . "\n", FILE_APPEND);
                                }
                            } catch (Exception $radiusError) {
                                file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                                    "RADIUS Error: " . $radiusError->getMessage() . "\n", FILE_APPEND);
                            }
                        }
                    } else {
                        // Payment failed
                        $payment->status = 0; // Failed
                        $payment->pg_paid_response = $input;
                        $payment->save();
                    }
                }
            }
            
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Success']);
            
        } catch (Exception $e) {
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                "Callback Error: " . $e->getMessage() . "\n", FILE_APPEND);
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Acknowledged']);
        }
        break;
        
    case 'voucher':
        // Voucher code authentication (alternative to payment)
        $sessionId = $_POST['session_id'] ?? '';
        $voucherCode = strtoupper(trim($_POST['voucher_code'] ?? ''));
        
        if (!$sessionId || !$voucherCode) {
            r2(U . 'captive_portal', 'e', 'Please enter a voucher code');
        }
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'captive_portal', 'e', 'Invalid session');
        }
        
        // Check voucher validity
        $voucher = ORM::for_table('tbl_voucher')
            ->where('code', $voucherCode)
            ->where('status', 0) // Unused
            ->find_one();
            
        if (!$voucher) {
            r2(U . 'captive_portal', 'e', 'Invalid or already used voucher code');
        }
        
        $plan = ORM::for_table('tbl_plans')
            ->where('id', $voucher->id_plan)
            ->find_one();
            
        if (!$plan) {
            r2(U . 'captive_portal', 'e', 'Voucher plan not found');
        }
        
        // Activate voucher
        $voucher->status = 1; // Used
        $voucher->used_date = date('Y-m-d H:i:s');
        $voucher->save();
        
        // Create user recharge
        $userRecharge = ORM::for_table('tbl_user_recharges')->create();
        $userRecharge->customer_id = 0;
        $userRecharge->username = $session->mac_address;
        $userRecharge->plan_id = $plan->id;
        $userRecharge->namebp = $plan->name_plan;
        $userRecharge->recharged_on = date('Y-m-d');
        $userRecharge->recharged_time = date('H:i:s');
        $userRecharge->expiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
        $userRecharge->time = date('H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
        $userRecharge->status = 'on';
        $userRecharge->type = 'Hotspot';
        $userRecharge->routers = $plan->routers;
        $userRecharge->method = 'Voucher';
        $userRecharge->save();
        
        // Create RADIUS user
        try {
            require_once 'system/autoload/RadiusManager.php';
            $result = RadiusManager::createHotspotUser($session->mac_address, $session->mac_address, $plan);
            
            if ($result['success']) {
                $session->status = 'completed';
                $session->mikrotik_user = $session->mac_address;
                $session->save();
                
                r2(U . 'captive_portal/success/' . $sessionId, 's', 'Voucher activated successfully! You now have internet access.');
            } else {
                r2(U . 'captive_portal', 'e', 'Failed to activate internet access: ' . $result['message']);
            }
        } catch (Exception $e) {
            r2(U . 'captive_portal', 'e', 'System error. Please contact support.');
        }
        break;
}

?>