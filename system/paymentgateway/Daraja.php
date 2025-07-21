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
        'CallBackURL' => rtrim($pgData['callback_url'] ?? (U . 'captive_portal/callback'), '/'),
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