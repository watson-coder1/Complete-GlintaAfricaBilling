<?php

/**
 * Enhanced Dynamic Captive Portal Controller
 * Complete captive portal system for Glinta Africa Billing System
 * 
 * Features:
 * - MAC address-based device fingerprinting
 * - M-Pesa STK Push payment integration
 * - RADIUS user creation and management
 * - Voucher-based authentication
 * - Session management with auto-logout
 * - Template rendering with required variables
 * 
 * @author Glinta Africa Development Team
 * @version 2.0
 */

// Ensure required globals are available
global $config, $ui, $UPLOAD_PATH;

// Initialize required variables
if (!isset($UPLOAD_PATH)) {
    $UPLOAD_PATH = dirname(__DIR__, 2) . '/logs';
    if (!is_dir($UPLOAD_PATH)) {
        mkdir($UPLOAD_PATH, 0755, true);
    }
}

// Debug logging for all portal requests (with safe path handling)
try {
    $debugPath = $UPLOAD_PATH;
    $debugInfo = "=== Captive Portal Request " . date('Y-m-d H:i:s') . " ===\n";
    $debugInfo .= "Route: " . ($routes['1'] ?? 'landing') . "\n";
    $debugInfo .= "Method: " . $_SERVER['REQUEST_METHOD'] . "\n";
    $debugInfo .= "GET: " . json_encode($_GET) . "\n";
    $debugInfo .= "POST: " . json_encode($_POST) . "\n";
    $debugInfo .= "User Agent: " . ($_SERVER['HTTP_USER_AGENT'] ?? 'Unknown') . "\n";
    $debugInfo .= "IP Address: " . ($_SERVER['REMOTE_ADDR'] ?? 'Unknown') . "\n";
    file_put_contents($debugPath . '/captive_portal_debug.log', $debugInfo . "\n", FILE_APPEND);
} catch (Exception $e) {
    // Silent fail for debug logging
}

// Set required template variables
$ui->assign('_url', U);
$ui->assign('_title', 'Glinta Africa WiFi Portal');

switch ($routes['1']) {
    case 'landing':
    case '':
    default:
        try {
            // Main captive portal landing page
            $mac = $_GET['mac'] ?? '';
            $ip = $_GET['ip'] ?? '';
            $sessionId = uniqid('portal_', true);
            
            // Detect real IP if not provided by MikroTik
            if (empty($ip)) {
                $forwardedFor = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '';
                $realIp = $_SERVER['HTTP_X_REAL_IP'] ?? '';
                $remoteAddr = $_SERVER['REMOTE_ADDR'] ?? '';
                
                $ip = $forwardedFor ?: $realIp ?: $remoteAddr ?: '127.0.0.1';
                
                // Handle comma-separated IPs (proxy chains)
                if (strpos($ip, ',') !== false) {
                    $ip = trim(explode(',', $ip)[0]);
                }
            }
            
            // Generate MAC if not provided (device fingerprinting)
            if (empty($mac)) {
                $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
                $acceptLang = $_SERVER['HTTP_ACCEPT_LANGUAGE'] ?? '';
                
                if (!empty($userAgent)) {
                    $deviceHash = substr(md5($userAgent . $ip . $acceptLang . date('Y-m-d')), 0, 12);
                    $mac = implode(':', str_split($deviceHash, 2));
                } else {
                    $mac = 'device-' . substr(md5($ip . time()), 0, 12);
                }
            }
            
            // Validate and clean MAC address
            $mac = strtolower(preg_replace('/[^a-f0-9:]/', '', $mac));
            if (strlen($mac) < 12) {
                $mac = 'auto-' . substr(md5($ip . $userAgent), 0, 12);
            }
            
            // Create new portal session FIRST (always create it)
            $portalSessionCreated = false;
            try {
                $session = ORM::for_table('tbl_portal_sessions')->create();
                $session->session_id = $sessionId;
                $session->mac_address = $mac;
                $session->ip_address = $ip;
                $session->user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';
                $session->created_at = date('Y-m-d H:i:s');
                $session->expires_at = date('Y-m-d H:i:s', strtotime('+2 hours'));
                $session->status = 'pending';
                $session->save();
                $portalSessionCreated = true;
                
                // Debug: Log successful session creation
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " Session created successfully: $sessionId (MAC: $mac, IP: $ip)\n", FILE_APPEND);
                    
            } catch (Exception $e) {
                // If session creation fails, continue without saving (graceful degradation)
                error_log("Portal session creation failed: " . $e->getMessage());
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " Session creation FAILED: " . $e->getMessage() . "\n", FILE_APPEND);
            }
            
            // Check if MAC already has active session (AFTER creating portal session)
            $activeSession = ORM::for_table('tbl_user_recharges')
                ->where('username', $mac)
                ->where('status', 'on')
                ->where_gt('expiration', date('Y-m-d H:i:s'))
                ->find_one();
                
            if ($activeSession && $portalSessionCreated) {
                // User already has active session but we created portal session for form consistency
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " User has active session, redirecting to success (MAC: $mac)\n", FILE_APPEND);
                r2(U . 'captive_portal/success/' . $mac, 's', 'You already have an active internet session');
                return;
            }
            
            // Get available packages from existing plans (Hotspot only)
            $packages = ORM::for_table('tbl_plans')
                ->where('enabled', 1)
                ->where('type', 'Hotspot')
                ->order_by_asc('price')
                ->find_many();
                
            if (empty($packages)) {
                // Create default package if none exist
                $defaultPlan = ORM::for_table('tbl_plans')->create();
                $defaultPlan->name_plan = '1 Hour WiFi Access';
                $defaultPlan->price = 50;
                $defaultPlan->validity = 1;
                $defaultPlan->validity_unit = 'Hrs';
                $defaultPlan->type = 'Hotspot';
                $defaultPlan->enabled = 1;
                $defaultPlan->routers = '1';
                $defaultPlan->save();
                
                $packages = [$defaultPlan];
            }
            
            // Set all required template variables
            $ui->assign('packages', $packages);
            $ui->assign('session_id', $sessionId);
            $ui->assign('mac', $mac);
            $ui->assign('ip', $ip);
            $ui->assign('_url', U);
            $ui->assign('_title', 'Glinta Africa WiFi Portal');
            $ui->assign('_system_name', $config['CompanyName'] ?? 'Glinta Africa');
            
            $ui->display('captive_portal_landing.tpl');
            
        } catch (Exception $e) {
            error_log("Captive Portal Landing Error: " . $e->getMessage());
            $ui->assign('_url', U);
            $ui->assign('_title', 'WiFi Portal - Error');
            $ui->assign('error_message', 'Service temporarily unavailable. Please try again.');
            $ui->display('error.tpl');
        }
        break;
        
    case 'select':
        // Package selection and M-Pesa payment initiation
        try {
            // Debug: Log all incoming data
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " === SELECT CASE START ===\n", FILE_APPEND);
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " POST Data: " . json_encode($_POST) . "\n", FILE_APPEND);
                
            // Validate request method
            if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " ERROR: Invalid request method\n", FILE_APPEND);
                r2(U . 'captive_portal', 'e', 'Invalid request method');
                return;
            }
            
            $sessionId = $_POST['session_id'] ?? '';
            $planId = $_POST['plan_id'] ?? '';
            $phoneNumber = $_POST['phone_number'] ?? '';
            
            // Comprehensive input validation
            if (empty($sessionId) || empty($planId) || empty($phoneNumber)) {
                r2(U . 'captive_portal', 'e', 'Missing required information. Please fill all fields.');
                return;
            }
            
            // Validate and format phone number
            $phoneNumber = preg_replace('/[^0-9]/', '', $phoneNumber);
            if (strlen($phoneNumber) < 9 || strlen($phoneNumber) > 12) {
                r2(U . 'captive_portal', 'e', 'Please enter a valid phone number (9-12 digits)');
                return;
            }
            
            // Format to international format (254...)
            if (substr($phoneNumber, 0, 1) === '0') {
                $phoneNumber = '254' . substr($phoneNumber, 1);
            } elseif (substr($phoneNumber, 0, 3) !== '254') {
                $phoneNumber = '254' . $phoneNumber;
            }
            
            // Validate Kenyan mobile number
            if (!preg_match('/^254(7[0-9]{8}|1[0-9]{8})$/', $phoneNumber)) {
                r2(U . 'captive_portal', 'e', 'Please enter a valid Kenyan mobile number');
                return;
            }
            
            // Get and validate session
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $sessionId)
                ->where('status', 'pending')
                ->find_one();
                
            if (!$session) {
                r2(U . 'captive_portal', 'e', 'Invalid or expired session. Please start again.');
                return;
            }
            
            // Check session expiration
            if ($session->expires_at === null) {
                // Handle sessions with missing expiration - set default 2 hour expiration from creation time
                $session->expires_at = date('Y-m-d H:i:s', strtotime($session->created_at . ' +2 hours'));
                $session->save();
            }
            
            if (strtotime($session->expires_at) < time()) {
                r2(U . 'captive_portal', 'e', 'Session has expired. Please start again.');
                return;
            }
            
            // Get and validate plan
            $plan = ORM::for_table('tbl_plans')
                ->where('id', $planId)
                ->where('enabled', 1)
                ->where('type', 'Hotspot')
                ->find_one();
                
            if (!$plan) {
                r2(U . 'captive_portal', 'e', 'Invalid or unavailable plan selected');
                return;
            }
            
            // Check if user already has active session for this MAC
            $existingSession = ORM::for_table('tbl_user_recharges')
                ->where('username', $session->mac_address)
                ->where('status', 'on')
                ->where_gt('expiration', date('Y-m-d H:i:s'))
                ->find_one();
                
            if ($existingSession) {
                r2(U . 'captive_portal/success/' . $session->mac_address, 's', 'You already have an active internet session');
                return;
            }
            
            // Update session with plan and phone
            $session->plan_id = $planId;
            $session->phone_number = $phoneNumber;
            $session->amount = $plan->price;
            $session->status = 'processing';
            $session->save();
            
            // Check if M-Pesa gateway is configured
            $mpesaEnabled = false;
            try {
                require_once dirname(__DIR__) . '/paymentgateway/Daraja.php';
                $daraja = new Daraja();
                $mpesaEnabled = $daraja->isEnabled();
                
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " M-Pesa Gateway Status: " . ($mpesaEnabled ? 'Enabled' : 'Disabled') . "\n", FILE_APPEND);
                    
            } catch (Exception $e) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " Daraja check error: " . $e->getMessage() . "\n", FILE_APPEND);
                error_log("Daraja check failed: " . $e->getMessage());
            }
            
            if (!$mpesaEnabled) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " Payment system not configured - redirecting to error\n", FILE_APPEND);
                r2(U . 'captive_portal', 'e', 'Payment system not configured. Please contact administrator.');
                return;
            }
            
            // Initiate M-Pesa STK Push
            $accountReference = 'PORTAL-' . substr($sessionId, -8);
            $transactionDesc = 'Glinta WiFi - ' . substr($plan->name_plan, 0, 13);
            
            // Log STK push request details
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " Initiating STK Push - Phone: $phoneNumber, Amount: {$plan->price}, Ref: $accountReference\n", FILE_APPEND);
            
            $stkResult = $daraja->send_request([
                'phone_number' => $phoneNumber,
                'amount' => $plan->price,
                'invoice' => $accountReference,
                'description' => $transactionDesc
            ]);
            
            // Log the STK push result
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " STK Push Result: " . json_encode($stkResult) . "\n", FILE_APPEND);
            
            if ($stkResult['success']) {
                // Create payment gateway record with required fields only
                try {
                    $payment = ORM::for_table('tbl_payment_gateway')->create();
                    $payment->username = $session->mac_address;
                    $payment->gateway = 'Daraja';
                    $payment->gateway_trx_id = $stkResult['merchant_request_id'] ?? '';
                    $payment->plan_id = $planId;
                    $payment->plan_name = $plan->name_plan;
                    $payment->routers_id = $plan->routers_id ?? 1;
                    $payment->routers = $plan->routers ?? 'default';
                    $payment->price = $plan->price;
                    $payment->pg_url_payment = '';
                    $payment->payment_method = 'M-Pesa STK Push';
                    $payment->payment_channel = 'Captive Portal';
                    $payment->pg_request = json_encode([
                        'phone_number' => $phoneNumber,
                        'amount' => $plan->price,
                        'account_reference' => $accountReference,
                        'session_id' => $sessionId,
                        'stk_request' => $stkResult
                    ]);
                    $payment->expired_date = date('Y-m-d H:i:s', strtotime('+1 hour'));
                    $payment->created_date = date('Y-m-d H:i:s');
                    $payment->trx_invoice = $accountReference;
                    $payment->status = 1; // Pending
                    $payment->checkout_request_id = $stkResult['checkout_request_id'] ?? '';
                    $payment->save();
                    
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Payment record created with ID: " . $payment->id() . "\n", FILE_APPEND);
                        
                } catch (Exception $paymentError) {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Payment creation error: " . $paymentError->getMessage() . "\n", FILE_APPEND);
                    throw $paymentError;
                }
                
                // Update session with payment ID
                $session->payment_id = $payment->id();
                $session->checkout_request_id = $stkResult['checkout_request_id'] ?? '';
                $session->save();
                
                // Debug the redirect URL before redirecting
                $redirectUrl = U . 'captive_portal/payment/' . $sessionId;
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " REDIRECT URL: " . $redirectUrl . "\n", FILE_APPEND);
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " SESSION ID: " . $sessionId . "\n", FILE_APPEND);
                    
                // Redirect to payment status page
                r2($redirectUrl, 's', 'Payment request sent to your phone. Please check and enter your M-Pesa PIN.');
                
            } else {
                $errorMessage = $stkResult['message'] ?? 'Unknown error occurred';
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " STK Push Failed: " . $errorMessage . "\n", FILE_APPEND);
                
                // Update session status to failed
                $session->status = 'failed';
                $session->save();
                
                r2(U . 'captive_portal', 'e', 'Failed to initiate M-Pesa payment: ' . $errorMessage . '. Please try again or contact support.');
            }
            
        } catch (Exception $e) {
            error_log("Captive Portal Select Error: " . $e->getMessage());
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " Payment Error: " . $e->getMessage() . "\n", FILE_APPEND);
            r2(U . 'captive_portal', 'e', 'Payment system error. Please try again later.');
        }
        break;
        
    case 'payment':
        // Payment status and monitoring page
        try {
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " === PAYMENT CASE START ===\n", FILE_APPEND);
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " Route: " . json_encode($routes) . "\n", FILE_APPEND);
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " URL: " . $_SERVER['REQUEST_URI'] . "\n", FILE_APPEND);
            
            $sessionId = $routes['2'] ?? '';
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " Payment page session ID: " . ($sessionId ?: 'EMPTY') . "\n", FILE_APPEND);
            
            if (empty($sessionId)) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " ERROR: Session ID required - redirecting\n", FILE_APPEND);
                r2(U . 'captive_portal', 'e', 'Session ID required');
                return;
            }
            
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $sessionId)
                ->find_one();
                
            if (!$session) {
                r2(U . 'captive_portal', 'e', 'Invalid or expired session');
                return;
            }
            
            $plan = null;
            if ($session->plan_id) {
                $plan = ORM::for_table('tbl_plans')
                    ->where('id', $session->plan_id)
                    ->find_one();
            }
                
            $payment = null;
            if ($session->payment_id) {
                $payment = ORM::for_table('tbl_payment_gateway')
                    ->where('id', $session->payment_id)
                    ->find_one();
            }
            
            // Set all required template variables
            $ui->assign('session', $session);
            $ui->assign('plan', $plan);
            $ui->assign('payment', $payment);
            $ui->assign('session_id', $sessionId);
            $ui->assign('_url', U);
            $ui->assign('_title', 'Processing Payment - Glinta Africa');
            $ui->assign('_system_name', $config['CompanyName'] ?? 'Glinta Africa');
            
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " About to display payment template for session: $sessionId\n", FILE_APPEND);
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " Template variables assigned - session_id: '$sessionId', _url: '" . U . "'\n", FILE_APPEND);
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " Session object ID: " . ($session ? $session->session_id : 'NULL') . "\n", FILE_APPEND);
            
            $ui->display('captive_portal_payment.tpl');
            
        } catch (Exception $e) {
            error_log("Captive Portal Payment Error: " . $e->getMessage());
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " PAYMENT CASE ERROR: " . $e->getMessage() . "\n", FILE_APPEND);
            r2(U . 'captive_portal', 'e', 'Unable to load payment page. Please try again.');
        }
        break;
        
    case 'status':
        // Check payment and session status (support both GET and POST, including MAC-based)
        try {
            $sessionId = $routes['2'] ?? $_POST['session_id'] ?? $_GET['session_id'] ?? '';
            $mac = $_POST['mac'] ?? $_GET['mac'] ?? '';
            
            // Allow MAC-based status checking for better reliability
            if (empty($sessionId) && empty($mac)) {
                if ($_SERVER['REQUEST_METHOD'] === 'POST' || isset($_GET['ajax'])) {
                    header('Content-Type: application/json');
                    echo json_encode(['status' => 'error', 'message' => 'Session ID or MAC address required']);
                    exit;
                } else {
                    r2(U . 'captive_portal', 'e', 'Session ID required');
                    return;
                }
            }
            
            // Handle AJAX status check
            if ($_SERVER['REQUEST_METHOD'] === 'POST' || isset($_GET['ajax'])) {
                header('Content-Type: application/json');
                header('Cache-Control: no-cache, no-store, must-revalidate');
                header('Pragma: no-cache');
                header('Expires: 0');
                
                // Log status check for debugging
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " Status check for session: $sessionId" . ($mac ? " / MAC: $mac" : "") . "\n", FILE_APPEND);
                
                $session = null;
                
                // Find session by ID or MAC address
                if (!empty($sessionId)) {
                    $session = ORM::for_table('tbl_portal_sessions')
                        ->where('session_id', $sessionId)
                        ->find_one();
                } elseif (!empty($mac)) {
                    // Find most recent session for this MAC
                    $session = ORM::for_table('tbl_portal_sessions')
                        ->where('mac_address', $mac)
                        ->order_by_desc('created_at')
                        ->find_one();
                        
                    if ($session) {
                        $sessionId = $session->session_id;
                    }
                }
                    
                if (!$session) {
                    // Try direct MAC-based payment lookup for better reliability
                    if (!empty($mac)) {
                        $payment = ORM::for_table('tbl_payment_gateway')
                            ->where('username', $mac)
                            ->where('status', 2)
                            ->where_gte('created_date', date('Y-m-d H:i:s', strtotime('-2 hours')))
                            ->order_by_desc('id')
                            ->find_one();

                        if ($payment) {
                            echo json_encode([
                                'status' => 'completed',
                                'message' => 'Payment successful! Internet access activated.',
                                'redirect' => U . 'captive_portal/success/' . ($sessionId ?: 'success') . '?mac=' . urlencode($mac)
                            ]);
                            exit;
                        }
                    }
                    
                    echo json_encode(['status' => 'error', 'message' => 'Session not found']);
                    exit;
                }
                
                // Check if payment exists and is completed
                $payment = null;
                if ($session->payment_id) {
                    $payment = ORM::for_table('tbl_payment_gateway')
                        ->where('id', $session->payment_id)
                        ->find_one();
                }
                
                // Only check for payments specifically linked to this session
                // Don't use MAC address backup check as it picks up old successful payments
                
                // Check for active user recharge (in case callback was processed)
                $activeRecharge = ORM::for_table('tbl_user_recharges')
                    ->where('username', $session->mac_address)
                    ->where('status', 'on')
                    ->where_gt('expiration', date('Y-m-d H:i:s'))
                    ->find_one();
                
                // Log current status for debugging with more detail
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " Status check results - Session status: " . ($session->status ?? 'null') . 
                    ", Session payment_id: " . ($session->payment_id ?? 'null') .
                    ", Payment found: " . ($payment ? 'yes' : 'no') .
                    ", Payment ID: " . ($payment ? $payment->id() : 'none') .
                    ", Payment status: " . ($payment ? $payment->status : 'none') . 
                    ", IDs match: " . ($payment && $payment->id() == $session->payment_id ? 'yes' : 'no') .
                    ", Active recharge: " . ($activeRecharge ? 'yes' : 'no') . "\n", FILE_APPEND);
                
                // If payment is successful but session not marked completed, update it
                if ($payment && $payment->status == 2 && $payment->id == $session->payment_id && $session->status !== 'completed') {
                    $session->status = 'completed';
                    $session->save();
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Session status updated to completed based on payment status\n", FILE_APPEND);
                }
                
                // Only consider completed if:
                // 1. There's an active recharge, OR
                // 2. The payment linked to THIS session is successful (status 2), OR  
                // 3. The session itself is marked as completed
                if ($activeRecharge || ($payment && $payment->status == 2 && $payment->id == $session->payment_id) || $session->status === 'completed') {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Payment completed - sending success response\n", FILE_APPEND);
                    $redirectUrl = U . 'captive_portal/success/' . $sessionId;
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Sending success response with redirect: " . $redirectUrl . "\n", FILE_APPEND);
                    echo json_encode([
                        'status' => 'completed',
                        'message' => 'Payment successful! Internet access activated.',
                        'redirect' => $redirectUrl
                    ]);
                } elseif ($payment && $payment->status == 0) {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Payment failed - sending error response\n", FILE_APPEND);
                    echo json_encode([
                        'status' => 'failed',
                        'message' => 'Payment failed. Please try again.',
                        'redirect' => U . 'captive_portal'
                    ]);
                } else {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . " Payment still pending\n", FILE_APPEND);
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
                r2(U . 'captive_portal', 'e', 'Invalid or expired session');
                return;
            }
            
            $plan = null;
            if ($session->plan_id) {
                $plan = ORM::for_table('tbl_plans')
                    ->where('id', $session->plan_id)
                    ->find_one();
            }
                
            $payment = null;
            if ($session->payment_id) {
                $payment = ORM::for_table('tbl_payment_gateway')
                    ->where('id', $session->payment_id)
                    ->find_one();
            }
            
            // Check if already paid and active - redirect to success
            if ($payment && $payment->status == 2) {
                r2(U . 'captive_portal/success/' . $sessionId);
                return;
            }
            
            // Check for active recharge
            $activeRecharge = ORM::for_table('tbl_user_recharges')
                ->where('username', $session->mac_address)
                ->where('status', 'on')
                ->where_gt('expiration', date('Y-m-d H:i:s'))
                ->find_one();
                
            if ($activeRecharge) {
                r2(U . 'captive_portal/success/' . $sessionId);
                return;
            }
            
            // Set all required template variables
            $ui->assign('session', $session);
            $ui->assign('plan', $plan);
            $ui->assign('payment', $payment);
            $ui->assign('session_id', $sessionId);
            $ui->assign('_url', U);
            $ui->assign('_title', 'Payment Status - Glinta Africa');
            $ui->assign('_system_name', $config['CompanyName'] ?? 'Glinta Africa');
            
            $ui->display('captive_portal_status.tpl');
            
        } catch (Exception $e) {
            error_log("Captive Portal Status Error: " . $e->getMessage());
            
            if ($_SERVER['REQUEST_METHOD'] === 'POST' || isset($_GET['ajax'])) {
                header('Content-Type: application/json');
                echo json_encode(['status' => 'error', 'message' => 'System error occurred']);
                exit;
            } else {
                r2(U . 'captive_portal', 'e', 'Unable to check status. Please try again.');
            }
        }
        break;
        
    case 'success':
        // Success page after payment completion
        try {
            $sessionId = $routes['2'] ?? '';
            
            // Allow MAC address as identifier for existing sessions
            if (empty($sessionId)) {
                $mac = $_GET['mac'] ?? '';
                if (!empty($mac)) {
                    // Find session by MAC address
                    $session = ORM::for_table('tbl_portal_sessions')
                        ->where('mac_address', $mac)
                        ->where('status', 'completed')
                        ->order_by_desc('created_at')
                        ->find_one();
                    if ($session) {
                        $sessionId = $session->session_id;
                    }
                }
            }
            
            if (empty($sessionId)) {
                r2(U . 'captive_portal', 'e', 'Session not found');
                return;
            }
            
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $sessionId)
                ->find_one();
                
            if (!$session) {
                r2(U . 'captive_portal', 'e', 'Invalid or expired session');
                return;
            }
            
            $plan = null;
            if ($session->plan_id) {
                $plan = ORM::for_table('tbl_plans')
                    ->where('id', $session->plan_id)
                    ->find_one();
            }
                
            $payment = null;
            if ($session->payment_id) {
                $payment = ORM::for_table('tbl_payment_gateway')
                    ->where('id', $session->payment_id)
                    ->find_one();
            }
            
            // Check if user recharge exists (should be created by callback)
            $userRecharge = ORM::for_table('tbl_user_recharges')
                ->where('username', $session->mac_address)
                ->where('status', 'on')
                ->where_gt('expiration', date('Y-m-d H:i:s'))
                ->order_by_desc('recharged_on')
                ->find_one();
            
            // If no active recharge found, check if we should create one (for voucher users)
            if (!$userRecharge && $session->status === 'completed') {
                // This might be a voucher activation - still show success
            }
            
            // Set all required template variables
            $ui->assign('session', $session);
            $ui->assign('plan', $plan);
            $ui->assign('payment', $payment);
            $ui->assign('user_recharge', $userRecharge);
            $ui->assign('session_id', $sessionId);
            $ui->assign('mac_address', $session->mac_address);
            $ui->assign('_url', U);
            $ui->assign('_title', 'Welcome to Glinta WiFi');
            $ui->assign('_system_name', $config['CompanyName'] ?? 'Glinta Africa');
            
            // Add connection info for display
            $connectionInfo = [
                'mac' => $session->mac_address,
                'ip' => $session->ip_address,
                'connected_at' => $userRecharge ? $userRecharge->recharged_on . ' ' . $userRecharge->recharged_time : $session->created_at,
                'expires_at' => $userRecharge ? $userRecharge->expiration : null
            ];
            $ui->assign('connection_info', $connectionInfo);
            
            $ui->display('captive_portal_success.tpl');
            
        } catch (Exception $e) {
            error_log("Captive Portal Success Error: " . $e->getMessage());
            r2(U . 'captive_portal', 'e', 'Unable to load success page. Please contact support.');
        }
        break;
        
    case 'debug_log':
        // Simple debug endpoint for JavaScript logging
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $input = file_get_contents('php://input');
            $data = json_decode($input, true);
            
            if ($data && isset($data['message'])) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " JS DEBUG: " . $data['message'] . "\n", FILE_APPEND);
            }
            
            header('Content-Type: application/json');
            echo json_encode(['status' => 'logged']);
            exit;
        }
        break;
        
    case 'callback':
        // M-Pesa callback handler for captive portal payments
        header('Content-Type: application/json');
        
        try {
            $input = file_get_contents('php://input');
            
            // Log the callback for debugging
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                date('Y-m-d H:i:s') . ' - Callback received: ' . $input . PHP_EOL, FILE_APPEND);
            
            $data = json_decode($input, true);
            
            if (!$data || !isset($data['Body']['stkCallback'])) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                    date('Y-m-d H:i:s') . ' - Invalid callback data structure' . PHP_EOL, FILE_APPEND);
                echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Invalid data']);
                exit;
            }
            
            $callback = $data['Body']['stkCallback'];
            $checkoutRequestId = $callback['CheckoutRequestID'] ?? '';
            $resultCode = $callback['ResultCode'] ?? -1;
            
            if (empty($checkoutRequestId)) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                    date('Y-m-d H:i:s') . ' - Missing CheckoutRequestID' . PHP_EOL, FILE_APPEND);
                echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Missing checkout ID']);
                exit;
            }
            
            // Find the payment record using checkout_request_id
            $payment = ORM::for_table('tbl_payment_gateway')
                ->where('checkout_request_id', $checkoutRequestId)
                ->find_one();
                
            if (!$payment) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                    date('Y-m-d H:i:s') . ' - Payment record not found for checkout ID: ' . $checkoutRequestId . PHP_EOL, FILE_APPEND);
                echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Payment not found']);
                exit;
            }
            
            if ($resultCode == 0) { // Success
                // Extract payment details from callback
                $mpesaReceiptNumber = '';
                $phoneNumber = '';
                $amount = 0;
                $transactionDate = '';
                
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
                                $amount = floatval($item['Value']);
                                break;
                            case 'TransactionDate':
                                $transactionDate = $item['Value'];
                                break;
                        }
                    }
                }
                
                // Update payment record
                $payment->status = 2; // Paid
                $payment->paid_date = date('Y-m-d H:i:s');
                $payment->pg_paid_response = $input;
                $payment->gateway_trx_id = $mpesaReceiptNumber;
                $payment->save();
                
                file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                    date('Y-m-d H:i:s') . ' - Payment marked as successful: ' . $mpesaReceiptNumber . PHP_EOL, FILE_APPEND);
                
                // Get session and plan
                $session = ORM::for_table('tbl_portal_sessions')
                    ->where('payment_id', $payment->id())
                    ->find_one();
                    
                if (!$session) {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                        date('Y-m-d H:i:s') . ' - Session not found for payment ID: ' . $payment->id() . PHP_EOL, FILE_APPEND);
                    echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Session not found']);
                    exit;
                }
                
                $plan = ORM::for_table('tbl_plans')
                    ->where('id', $payment->plan_id)
                    ->find_one();
                
                if (!$plan) {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                        date('Y-m-d H:i:s') . ' - Plan not found for ID: ' . $payment->plan_id . PHP_EOL, FILE_APPEND);
                    echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Plan not found']);
                    exit;
                }
                
                // Check if user recharge already exists (prevent duplicates)
                $existingRecharge = ORM::for_table('tbl_user_recharges')
                    ->where('username', $session->mac_address)
                    ->where('status', 'on')
                    ->where_gt('expiration', date('Y-m-d H:i:s'))
                    ->find_one();
                
                if (!$existingRecharge) {
                    // Create user recharge record
                    $userRecharge = ORM::for_table('tbl_user_recharges')->create();
                    $userRecharge->customer_id = 0; // Portal customer
                    $userRecharge->username = $session->mac_address;
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
                    $userRecharge->routers = $plan->routers ?? '1';
                    $userRecharge->method = 'M-Pesa STK Push';
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
                    $transaction->method = 'M-Pesa STK Push';
                    $transaction->routers = $plan->routers ?? '1';
                    $transaction->save();
                    
                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                        date('Y-m-d H:i:s') . ' - User recharge created for: ' . $session->mac_address . PHP_EOL, FILE_APPEND);
                }
                
                // Create RADIUS user using RadiusManager
                try {
                    require_once dirname(__DIR__) . '/autoload/RadiusManager.php';
                    
                    $username = $session->mac_address;
                    $password = $session->mac_address; // Use MAC as password for auto-login
                    
                    // Calculate expiration for RADIUS
                    $radiusExpiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
                    
                    $result = RadiusManager::createHotspotUser($username, $password, $plan, $radiusExpiration);
                    
                    if ($result['success']) {
                        file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                            date('Y-m-d H:i:s') . ' - RADIUS User Created: ' . $username . PHP_EOL, FILE_APPEND);
                        $session->mikrotik_user = $username;
                    } else {
                        file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                            date('Y-m-d H:i:s') . ' - RADIUS User Creation Failed: ' . $result['message'] . PHP_EOL, FILE_APPEND);
                    }
                    
                    // Always update session status to completed when payment is successful
                    // regardless of RADIUS creation status
                    $session->status = 'completed';
                    $session->save();
                    
                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                        date('Y-m-d H:i:s') . ' - Session status updated to completed' . PHP_EOL, FILE_APPEND);
                } catch (Exception $radiusError) {
                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                        date('Y-m-d H:i:s') . ' - RADIUS Error: ' . $radiusError->getMessage() . PHP_EOL, FILE_APPEND);
                    
                    // Still update session status to completed even if RADIUS fails
                    $session->status = 'completed';
                    $session->save();
                    
                    file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                        date('Y-m-d H:i:s') . ' - Session status updated to completed (despite RADIUS error)' . PHP_EOL, FILE_APPEND);
                }
                
            } else {
                // Payment failed or cancelled
                $resultDesc = $callback['ResultDesc'] ?? 'Payment failed';
                
                $payment->status = 0; // Failed
                $payment->pg_paid_response = $input;
                $payment->save();
                
                file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                    date('Y-m-d H:i:s') . ' - Payment failed: ' . $resultDesc . PHP_EOL, FILE_APPEND);
            }
            
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Success']);
            
        } catch (Exception $e) {
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                date('Y-m-d H:i:s') . ' - Callback Error: ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Acknowledged']);
        }
        exit;
        break;
        
    case 'voucher':
        // Voucher code authentication (alternative to payment)
        try {
            // Validate request method
            if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
                r2(U . 'captive_portal', 'e', 'Invalid request method');
                return;
            }
            
            $sessionId = $_POST['session_id'] ?? '';
            $voucherCode = strtoupper(trim($_POST['voucher_code'] ?? ''));
            
            if (empty($sessionId) || empty($voucherCode)) {
                r2(U . 'captive_portal', 'e', 'Please enter a voucher code');
                return;
            }
            
            // Validate voucher code format
            if (strlen($voucherCode) < 6) {
                r2(U . 'captive_portal', 'e', 'Invalid voucher code format');
                return;
            }
            
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $sessionId)
                ->find_one();
                
            if (!$session) {
                r2(U . 'captive_portal', 'e', 'Invalid or expired session');
                return;
            }
            
            // Check if user already has active session
            $existingSession = ORM::for_table('tbl_user_recharges')
                ->where('username', $session->mac_address)
                ->where('status', 'on')
                ->where_gt('expiration', date('Y-m-d H:i:s'))
                ->find_one();
                
            if ($existingSession) {
                r2(U . 'captive_portal/success/' . $sessionId, 's', 'You already have an active internet session');
                return;
            }
            
            // Check voucher validity
            $voucher = ORM::for_table('tbl_voucher')
                ->where('code', $voucherCode)
                ->where('status', 0) // Unused
                ->find_one();
                
            if (!$voucher) {
                r2(U . 'captive_portal', 'e', 'Invalid or already used voucher code');
                return;
            }
            
            $plan = ORM::for_table('tbl_plans')
                ->where('id', $voucher->id_plan)
                ->where('enabled', 1)
                ->find_one();
                
            if (!$plan) {
                r2(U . 'captive_portal', 'e', 'Voucher plan not found or disabled');
                return;
            }
            
            // Activate voucher
            $voucher->status = 1; // Used
            $voucher->used_date = date('Y-m-d H:i:s');
            $voucher->save();
            
            // Create user recharge
            $userRecharge = ORM::for_table('tbl_user_recharges')->create();
            $userRecharge->customer_id = 0;
            $userRecharge->username = $session->mac_address;
            $userRecharge->plan_id = $plan->id();
            $userRecharge->namebp = $plan->name_plan;
            $userRecharge->recharged_on = date('Y-m-d');
            $userRecharge->recharged_time = date('H:i:s');
            
            // Calculate expiration
            $expirationTime = strtotime('+' . $plan->validity . ' ' . $plan->validity_unit);
            $userRecharge->expiration = date('Y-m-d H:i:s', $expirationTime);
            $userRecharge->time = date('H:i:s', $expirationTime);
            
            $userRecharge->status = 'on';
            $userRecharge->type = 'Hotspot';
            $userRecharge->routers = $plan->routers ?? '1';
            $userRecharge->method = 'Voucher';
            $userRecharge->save();
            
            // Create transaction record
            $transaction = ORM::for_table('tbl_transactions')->create();
            $transaction->invoice = $userRecharge->id();
            $transaction->username = $session->mac_address;
            $transaction->plan_name = $plan->name_plan;
            $transaction->price = 0; // Voucher has no cost
            $transaction->recharged_on = date('Y-m-d');
            $transaction->recharged_time = date('H:i:s');
            $transaction->expiration = $userRecharge->expiration;
            $transaction->time = $userRecharge->time;
            $transaction->method = 'Voucher';
            $transaction->routers = $plan->routers ?? '1';
            $transaction->save();
            
            // Create RADIUS user
            try {
                require_once dirname(__DIR__) . '/autoload/RadiusManager.php';
                
                $username = $session->mac_address;
                $password = $session->mac_address; // Use MAC as password for auto-login
                $radiusExpiration = $userRecharge->expiration;
                
                $result = RadiusManager::createHotspotUser($username, $password, $plan, $radiusExpiration);
                
                if ($result['success']) {
                    $session->status = 'completed';
                    $session->mikrotik_user = $username;
                    $session->plan_id = $plan->id();
                    $session->save();
                    
                    file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                        date('Y-m-d H:i:s') . ' - Voucher activated: ' . $voucherCode . ' for MAC: ' . $username . PHP_EOL, FILE_APPEND);
                    
                    r2(U . 'captive_portal/success/' . $sessionId, 's', 'Voucher activated successfully! You now have internet access.');
                } else {
                    // Rollback voucher if RADIUS creation fails
                    $voucher->status = 0;
                    $voucher->used_date = null;
                    $voucher->save();
                    
                    $userRecharge->delete();
                    $transaction->delete();
                    
                    r2(U . 'captive_portal', 'e', 'Failed to activate internet access: ' . $result['message']);
                }
            } catch (Exception $radiusError) {
                // Rollback voucher if RADIUS creation fails
                $voucher->status = 0;
                $voucher->used_date = null;
                $voucher->save();
                
                $userRecharge->delete();
                $transaction->delete();
                
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . ' - RADIUS Error for voucher: ' . $radiusError->getMessage() . PHP_EOL, FILE_APPEND);
                
                r2(U . 'captive_portal', 'e', 'System error. Please contact support.');
            }
            
        } catch (Exception $e) {
            error_log("Captive Portal Voucher Error: " . $e->getMessage());
            r2(U . 'captive_portal', 'e', 'System error occurred. Please try again.');
        }
        break;
}

// End of captive portal controller
?>