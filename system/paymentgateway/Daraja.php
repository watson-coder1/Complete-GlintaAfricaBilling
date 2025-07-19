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