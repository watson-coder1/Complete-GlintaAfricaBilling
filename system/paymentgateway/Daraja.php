<?php
/**
 * M-Pesa Daraja Payment Gateway
 * Function-based implementation for PHPNuxBill
 */

function Daraja_show_config()
{
    global $ui, $config;
    
    // Load existing configuration
    $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
    
    if ($pg) {
        $pgData = json_decode($pg['pg_data'], true);
        $ui->assign('daraja_consumer_key', $pgData['consumer_key'] ?? '');
        $ui->assign('daraja_consumer_secret', $pgData['consumer_secret'] ?? '');
        $ui->assign('daraja_business_shortcode', $pgData['shortcode'] ?? '');
        $ui->assign('daraja_passkey', $pgData['passkey'] ?? '');
        $ui->assign('daraja_environment', $pgData['environment'] ?? 'sandbox');
        $ui->assign('daraja_callback_url', $pgData['callback_url'] ?? U . 'callback/daraja');
        $ui->assign('daraja_timeout_url', $pgData['timeout_url'] ?? U . 'callback/daraja');
        $ui->assign('daraja_status', $pg['status'] ? 'Active' : 'Inactive');
        $ui->assign('daraja_sandbox_mode', $pgData['environment'] == 'sandbox');
    } else {
        // Default values
        $ui->assign('daraja_consumer_key', '');
        $ui->assign('daraja_consumer_secret', '');
        $ui->assign('daraja_business_shortcode', '');
        $ui->assign('daraja_passkey', '');
        $ui->assign('daraja_environment', 'sandbox');
        $ui->assign('daraja_callback_url', U . 'callback/daraja');
        $ui->assign('daraja_timeout_url', U . 'callback/daraja');
        $ui->assign('daraja_status', 'Inactive');
        $ui->assign('daraja_sandbox_mode', true);
    }
    
    $ui->assign('_title', 'M-Pesa Daraja Configuration');
    $ui->display('paymentgateway/Daraja.tpl');
}

function Daraja_save_config()
{
    global $config;
    
    $data = [
        'consumer_key' => _post('consumer_key'),
        'consumer_secret' => _post('consumer_secret'),
        'shortcode' => _post('shortcode'),
        'passkey' => _post('passkey'),
        'environment' => _post('environment'),
        'callback_url' => _post('callback_url'),
        'timeout_url' => _post('timeout_url')
    ];
    
    // Check if configuration exists
    $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
    
    if (!$pg) {
        $pg = ORM::for_table('tbl_pg')->create();
        $pg->gateway = 'Daraja';
    }
    
    $pg->pg_data = json_encode($data);
    $pg->status = _post('enabled') ? 1 : 0;
    $pg->save();
    
    if (_post('test_connection')) {
        // Test the connection
        $result = Daraja_test_connection($data);
        if ($result['success']) {
            r2(U . 'paymentgateway/Daraja', 's', 'Configuration saved and tested successfully!');
        } else {
            r2(U . 'paymentgateway/Daraja', 'e', 'Configuration saved but test failed: ' . $result['message']);
        }
    } else {
        r2(U . 'paymentgateway/Daraja', 's', 'Daraja configuration saved successfully');
    }
}

function Daraja_test_connection($config)
{
    $url = $config['environment'] == 'live'
        ? 'https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
        : 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
        
    $credentials = base64_encode($config['consumer_key'] . ':' . $config['consumer_secret']);
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Authorization: Basic ' . $credentials]);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode == 200) {
        $result = json_decode($response, true);
        if (isset($result['access_token'])) {
            return ['success' => true, 'message' => 'Connection successful'];
        }
    }
    
    return ['success' => false, 'message' => 'Failed to authenticate with M-Pesa API'];
}

function Daraja_get_status($user, $plan)
{
    return "M-Pesa Daraja Payment Gateway";
}

function Daraja_payment_link($trx)
{
    global $config;
    return U . 'order/view/' . $trx . '/daraja';
}

function Daraja_process_payment($user, $plan, $trx)
{
    $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
    
    if (!$pg || !$pg['status']) {
        return ['status' => 'error', 'message' => 'Payment gateway not configured or disabled'];
    }
    
    $pgData = json_decode($pg['pg_data'], true);
    
    // Create payment record
    $d = ORM::for_table('tbl_payment_gateway')->create();
    $d->username = $user['username'];
    $d->gateway = 'Daraja';
    $d->plan_id = $plan['id'];
    $d->plan_name = $plan['name_plan'];
    $d->routers_id = $plan['routers_id'] ?? 0;
    $d->routers = $plan['routers'] ?? '';
    $d->price = $plan['price'];
    $d->created_date = date('Y-m-d H:i:s');
    $d->status = 1; // unpaid
    $d->trx_invoice = $trx;
    $d->save();
    
    return [
        'status' => 'success',
        'redirect' => U . 'order/view/' . $d->id() . '/daraja'
    ];
}

/**
 * Initiate STK Push for M-Pesa payment
 */
function Daraja_stk_push($phoneNumber, $amount, $accountReference, $transactionDesc)
{
    global $config, $UPLOAD_PATH;
    
    // Get configuration
    $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
    
    if (!$pg || !$pg['status']) {
        return ['success' => false, 'message' => 'Payment gateway not configured or disabled'];
    }
    
    $pgData = json_decode($pg['pg_data'], true);
    
    // Get access token
    $token = Daraja_get_access_token($pgData);
    if (!$token) {
        return ['success' => false, 'message' => 'Failed to authenticate with M-Pesa'];
    }
    
    // Format phone number (remove leading 0 or +254)
    $phoneNumber = preg_replace('/[^0-9]/', '', $phoneNumber);
    if (substr($phoneNumber, 0, 1) == '0') {
        $phoneNumber = '254' . substr($phoneNumber, 1);
    } elseif (substr($phoneNumber, 0, 3) != '254') {
        $phoneNumber = '254' . $phoneNumber;
    }
    
    // Prepare STK Push request
    $timestamp = date('YmdHis');
    $password = base64_encode($pgData['shortcode'] . $pgData['passkey'] . $timestamp);
    
    $url = $pgData['environment'] == 'live'
        ? 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest'
        : 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
    
    $data = [
        'BusinessShortCode' => $pgData['shortcode'],
        'Password' => $password,
        'Timestamp' => $timestamp,
        'TransactionType' => 'CustomerPayBillOnline',
        'Amount' => intval($amount),
        'PartyA' => $phoneNumber,
        'PartyB' => $pgData['shortcode'],
        'PhoneNumber' => $phoneNumber,
        'CallBackURL' => U . 'callback/daraja',
        'AccountReference' => substr($accountReference, 0, 12), // Max 12 characters
        'TransactionDesc' => substr($transactionDesc, 0, 13)   // Max 13 characters
    ];
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $token,
        'Content-Type: application/json'
    ]);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    // Log the request and response
    if (isset($UPLOAD_PATH)) {
        file_put_contents($UPLOAD_PATH . '/daraja_stk_push.log', 
            date('Y-m-d H:i:s') . " Request: " . json_encode($data) . "\n" .
            "Response: " . $response . "\n\n", FILE_APPEND);
    }
    
    if ($httpCode == 200) {
        $result = json_decode($response, true);
        if (isset($result['ResponseCode']) && $result['ResponseCode'] == '0') {
            return [
                'success' => true,
                'checkout_request_id' => $result['CheckoutRequestID'],
                'merchant_request_id' => $result['MerchantRequestID'],
                'response_code' => $result['ResponseCode'],
                'response_description' => $result['ResponseDescription'],
                'customer_message' => $result['CustomerMessage']
            ];
        } else {
            return [
                'success' => false,
                'message' => $result['ResponseDescription'] ?? 'STK Push failed'
            ];
        }
    }
    
    return ['success' => false, 'message' => 'Failed to initiate payment. HTTP Code: ' . $httpCode];
}

/**
 * Get OAuth access token from M-Pesa
 */
function Daraja_get_access_token($config)
{
    $url = $config['environment'] == 'live'
        ? 'https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
        : 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
    
    $credentials = base64_encode($config['consumer_key'] . ':' . $config['consumer_secret']);
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Authorization: Basic ' . $credentials]);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode == 200) {
        $result = json_decode($response, true);
        if (isset($result['access_token'])) {
            return $result['access_token'];
        }
    }
    
    return false;
}

/**
 * Class-based wrapper for Daraja payment gateway
 * Used by captive portal and other components that need OOP interface
 */
class Daraja
{
    private $config;
    
    public function __construct()
    {
        $this->loadConfig();
    }
    
    private function loadConfig()
    {
        $pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
        
        if ($pg && $pg->status) {
            $this->config = json_decode($pg->pg_data, true);
        } else {
            $this->config = null;
        }
    }
    
    public function send_request($params)
    {
        if (!$this->config) {
            return ['success' => false, 'message' => 'Payment gateway not configured or disabled'];
        }
        
        $phoneNumber = $params['phone_number'] ?? '';
        $amount = $params['amount'] ?? 0;
        $accountReference = $params['invoice'] ?? '';
        $transactionDesc = $params['description'] ?? 'Payment';
        
        // Use the existing function
        return Daraja_stk_push($phoneNumber, $amount, $accountReference, $transactionDesc);
    }
    
    public function isEnabled()
    {
        return $this->config !== null;
    }
    
    public function getConfig()
    {
        return $this->config;
    }
}

/**
 * M-Pesa Payment Notification Handler
 * Called by callback.php when M-Pesa sends payment confirmation
 */
function Daraja_payment_notification()
{
    global $UPLOAD_PATH;
    
    try {
        $input = file_get_contents('php://input');
        
        // Log the callback for debugging
        file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
            date('Y-m-d H:i:s') . ' - Daraja callback received: ' . $input . PHP_EOL, FILE_APPEND);
        
        $data = json_decode($input, true);
        
        if (!$data || !isset($data['Body']['stkCallback'])) {
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                date('Y-m-d H:i:s') . ' - Invalid Daraja callback data structure' . PHP_EOL, FILE_APPEND);
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Invalid data']);
            return;
        }
        
        $callback = $data['Body']['stkCallback'];
        $checkoutRequestId = $callback['CheckoutRequestID'] ?? '';
        $resultCode = $callback['ResultCode'] ?? -1;
        
        if (empty($checkoutRequestId)) {
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                date('Y-m-d H:i:s') . ' - Missing CheckoutRequestID in Daraja callback' . PHP_EOL, FILE_APPEND);
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Missing checkout ID']);
            return;
        }
        
        // Find the payment record using checkout_request_id
        file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
            date('Y-m-d H:i:s') . " DARAJA CALLBACK: Processing callback for checkout_request_id=" . $checkoutRequestId . " result_code=" . $resultCode . "\n", FILE_APPEND);
        
        $payment = ORM::for_table('tbl_payment_gateway')
            ->where('checkout_request_id', $checkoutRequestId)
            ->find_one();
            
        if (!$payment) {
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                date('Y-m-d H:i:s') . ' - Payment record not found for Daraja checkout ID: ' . $checkoutRequestId . PHP_EOL, FILE_APPEND);
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Payment not found']);
            return;
        }
        
        file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
            date('Y-m-d H:i:s') . " DARAJA CALLBACK: Found payment record ID=" . $payment->id() . "\n", FILE_APPEND);
        
        if ($resultCode == 0) { // Success
            // Check if payment already processed
            if ($payment->status == 2) {
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " DARAJA CALLBACK: Payment already processed, skipping duplicate\n", FILE_APPEND);
                echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Already processed']);
                return;
            }
            
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
                date('Y-m-d H:i:s') . ' - Daraja payment marked as successful: ' . $mpesaReceiptNumber . PHP_EOL, FILE_APPEND);
            
            // Get session and plan
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('payment_id', $payment->id())
                ->find_one();
                
            if ($session) {
                $plan = ORM::for_table('tbl_plans')
                    ->where('id', $payment->plan_id)
                    ->find_one();
                
                if ($plan) {
                    // Check if user recharge already exists
                    $existingRecharge = ORM::for_table('tbl_user_recharges')
                        ->where('username', $session->mac_address)
                        ->where('status', 'on')
                        ->where_gt('expiration', date('Y-m-d H:i:s'))
                        ->find_one();
                    
                    if (!$existingRecharge) {
                        // Check if transaction already exists to prevent duplicates
                        $existingTransaction = ORM::for_table('tbl_transactions')
                            ->where('username', $session->mac_address)
                            ->where('method', 'M-Pesa STK Push')
                            ->where('plan_name', $plan->name_plan)
                            ->where('price', $payment->price)
                            ->where('recharged_on', date('Y-m-d'))
                            ->find_one();
                        
                        if (!$existingTransaction) {
                            // Create user recharge record
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
                            $userRecharge->method = 'M-Pesa STK Push';
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
                            $transaction->method = 'M-Pesa STK Push';
                            $transaction->routers = 'Main Router';
                            $transaction->type = 'Hotspot';
                            $transaction->save();
                            
                            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                                date('Y-m-d H:i:s') . ' - Daraja user recharge created for: ' . $session->mac_address . PHP_EOL, FILE_APPEND);
                        } else {
                            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                                date('Y-m-d H:i:s') . ' - Daraja transaction already exists, skipping duplicate creation for: ' . $session->mac_address . PHP_EOL, FILE_APPEND);
                        }
                    }
                    
                    // Create RADIUS user
                    require_once dirname(__DIR__) . '/autoload/RadiusManager.php';
                    $result = RadiusManager::createHotspotUser($session->mac_address, $session->mac_address, $plan, $userRecharge->expiration ?? date('Y-m-d H:i:s', strtotime('+2 hours')));
                    
                    if ($result['success']) {
                        file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                            date('Y-m-d H:i:s') . ' - Daraja RADIUS User Created: ' . $session->mac_address . PHP_EOL, FILE_APPEND);
                    }
                    
                    // Mark session as completed
                    $session->status = 'completed';
                    $session->save();
                }
            }
        } else {
            // Payment failed
            $payment->status = 3; // Failed
            $payment->pg_paid_response = $input;
            $payment->save();
            
            file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
                date('Y-m-d H:i:s') . ' - Daraja payment failed: Result Code ' . $resultCode . PHP_EOL, FILE_APPEND);
        }
        
        echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Success']);
        
    } catch (Exception $e) {
        file_put_contents($UPLOAD_PATH . '/captive_portal_callbacks.log', 
            date('Y-m-d H:i:s') . ' - Daraja callback error: ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
        echo json_encode(['ResultCode' => 1, 'ResultDesc' => 'Error: ' . $e->getMessage()]);
    }
}