<?php

/**
 * M-Pesa Daraja Callback Handler
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * Handles STK Push payment confirmations
 */

// Set JSON response header
header('Content-Type: application/json');

// Allow CORS for Safaricom
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    // Include system initialization
    require_once 'init.php';
    
    // Log incoming request
    $raw_input = file_get_contents('php://input');
    _log('M-Pesa Callback Raw Input: ' . $raw_input, 'M-Pesa', 0);
    
    // Validate request method
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        exit();
    }
    
    // Parse JSON input
    $callback_data = json_decode($raw_input, true);
    
    if (!$callback_data) {
        _log('M-Pesa Callback: Invalid JSON received', 'M-Pesa', 0);
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid JSON']);
        exit();
    }
    
    // Validate callback structure
    if (!isset($callback_data['Body']['stkCallback'])) {
        _log('M-Pesa Callback: Invalid callback structure', 'M-Pesa', 0);
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid callback structure']);
        exit();
    }
    
    $stk_callback = $callback_data['Body']['stkCallback'];
    $checkout_request_id = $stk_callback['CheckoutRequestID'] ?? '';
    $result_code = $stk_callback['ResultCode'] ?? '';
    $result_desc = $stk_callback['ResultDesc'] ?? '';
    
    _log("M-Pesa Callback - CheckoutID: {$checkout_request_id}, ResultCode: {$result_code}, ResultDesc: {$result_desc}", 'M-Pesa', 0);
    
    if (empty($checkout_request_id)) {
        _log('M-Pesa Callback: Missing CheckoutRequestID', 'M-Pesa', 0);
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Missing CheckoutRequestID']);
        exit();
    }
    
    // Find payment record
    $payment = ORM::for_table('tbl_payment_gateway')
        ->where('checkout_request_id', $checkout_request_id)
        ->find_one();
    
    if (!$payment) {
        _log("M-Pesa Callback: Payment record not found for CheckoutID: {$checkout_request_id}", 'M-Pesa', 0);
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Payment record not found']);
        exit();
    }
    
    // Update payment record with callback data
    $payment->pg_paid_response = $raw_input;
    
    if ($result_code == '0') {
        // Payment successful
        _log("M-Pesa Payment SUCCESS for CheckoutID: {$checkout_request_id}", 'M-Pesa', 0);
        
        $callback_metadata = $stk_callback['CallbackMetadata']['Item'] ?? [];
        $mpesa_receipt = '';
        $phone_number = '';
        $amount = 0;
        $transaction_date = '';
        
        // Extract callback metadata
        foreach ($callback_metadata as $item) {
            switch ($item['Name']) {
                case 'MpesaReceiptNumber':
                    $mpesa_receipt = $item['Value'];
                    break;
                case 'PhoneNumber':
                    $phone_number = $item['Value'];
                    break;
                case 'Amount':
                    $amount = $item['Value'];
                    break;
                case 'TransactionDate':
                    $transaction_date = $item['Value'];
                    break;
            }
        }
        
        // Update payment record
        $payment->status = 2; // Paid
        $payment->paid_date = date('Y-m-d H:i:s');
        $payment->mpesa_receipt_number = $mpesa_receipt;
        $payment->mpesa_phone_number = $phone_number;
        $payment->mpesa_amount = $amount;
        $payment->save();
        
        _log("M-Pesa Payment Details - Receipt: {$mpesa_receipt}, Phone: {$phone_number}, Amount: {$amount}", 'M-Pesa', 0);
        
        // Activate service
        $activation_result = activate_service_after_payment($payment);
        
        if ($activation_result) {
            _log("Service activated successfully for user: {$payment->username}", 'M-Pesa', 0);
        } else {
            _log("Service activation failed for user: {$payment->username}", 'M-Pesa', 0);
        }
        
    } else {
        // Payment failed or cancelled
        _log("M-Pesa Payment FAILED for CheckoutID: {$checkout_request_id}, ResultCode: {$result_code}, ResultDesc: {$result_desc}", 'M-Pesa', 0);
        
        $payment->status = 3; // Failed
        $payment->save();
    }
    
    // Respond to Safaricom
    http_response_code(200);
    echo json_encode([
        'ResultCode' => 0,
        'ResultDesc' => 'Success'
    ]);
    
} catch (Exception $e) {
    _log('M-Pesa Callback Exception: ' . $e->getMessage(), 'M-Pesa', 0);
    
    http_response_code(500);
    echo json_encode([
        'ResultCode' => 1,
        'ResultDesc' => 'Internal server error'
    ]);
}

/**
 * Activate service after successful payment
 */
function activate_service_after_payment($payment)
{
    try {
        // Get plan details
        $plan = ORM::for_table('tbl_plans')->find_one($payment->plan_id);
        if (!$plan) {
            _log("Plan not found: {$payment->plan_id}", 'M-Pesa', 0);
            return false;
        }
        
        // Get customer
        $customer = ORM::for_table('tbl_customers')->where('username', $payment->username)->find_one();
        if (!$customer) {
            _log("Customer not found: {$payment->username}", 'M-Pesa', 0);
            return false;
        }
        
        // Create transaction record
        $transaction = ORM::for_table('tbl_transactions')->create();
        $transaction->invoice = 'MPESA' . $payment->id;
        $transaction->username = $payment->username;
        $transaction->plan_name = $payment->plan_name;
        $transaction->price = $payment->price;
        $transaction->recharged_on = date('Y-m-d');
        $transaction->recharged_time = date('H:i:s');
        $transaction->method = 'M-Pesa STK Push';
        $transaction->routers = $payment->routers;
        $transaction->type = $plan->type;
        $transaction->save();
        
        // Create user recharge record
        $recharge = ORM::for_table('tbl_user_recharges')->create();
        $recharge->customer_id = $customer->id;
        $recharge->username = $payment->username;
        $recharge->plan_id = $payment->plan_id;
        $recharge->namebp = $payment->plan_name;
        $recharge->recharged_on = date('Y-m-d');
        $recharge->recharged_time = date('H:i:s');
        
        // Calculate expiration based on plan
        if ($plan->typebp == 'Limited' && $plan->limit_type == 'Time_Limit') {
            $time_unit = $plan->time_unit;
            $time_limit = $plan->time_limit;
            
            if ($time_unit == 'Hrs') {
                $expiration = date('Y-m-d H:i:s', strtotime('+' . $time_limit . ' hours'));
            } else {
                $expiration = date('Y-m-d H:i:s', strtotime('+' . $time_limit . ' minutes'));
            }
            
            $recharge->expiration = date('Y-m-d', strtotime($expiration));
            $recharge->time = date('H:i:s', strtotime($expiration));
        } else {
            // Default 30 days for unlimited plans
            $recharge->expiration = date('Y-m-d', strtotime('+30 days'));
            $recharge->time = '23:59:59';
        }
        
        $recharge->status = 'on';
        $recharge->method = 'M-Pesa STK Push';
        $recharge->routers = $payment->routers;
        $recharge->type = $plan->type;
        $recharge->save();
        
        // Activate based on service type
        if ($plan->type == 'Hotspot') {
            return activate_hotspot_service($customer, $plan, $recharge);
        } elseif ($plan->type == 'PPPOE') {
            return activate_pppoe_service($customer, $plan, $recharge);
        }
        
        return true;
        
    } catch (Exception $e) {
        _log('Service activation error: ' . $e->getMessage(), 'M-Pesa', 0);
        return false;
    }
}

/**
 * Activate Hotspot service (RADIUS) - Enhanced with RadiusManager
 */
function activate_hotspot_service($customer, $plan, $recharge)
{
    global $config;
    
    if (!$config['radius_enable']) {
        _log('RADIUS not enabled, skipping hotspot activation', 'M-Pesa', $customer->id);
        return false;
    }
    
    try {
        // Load RadiusManager if not already loaded
        if (!class_exists('RadiusManager')) {
            require_once 'system/autoload/RadiusManager.php';
        }
        
        // Generate secure password
        $password = RadiusManager::generatePassword(8);
        
        // Calculate expiration time
        $expiration_time = $recharge->expiration . ' ' . $recharge->time;
        
        // Create RADIUS user with full configuration
        $result = RadiusManager::createHotspotUser(
            $customer->username,
            $password,
            $plan,
            $expiration_time
        );
        
        if ($result['success']) {
            _log("Hotspot service activated for user: {$customer->username}, Password: {$password}", 'M-Pesa', $customer->id);
            
            // Store credentials for customer access
            $customer->password = $password; // Store for customer to see
            $customer->save();
            
            return true;
        } else {
            _log('RADIUS activation failed: ' . $result['message'], 'M-Pesa', $customer->id);
            return false;
        }
        
    } catch (Exception $e) {
        _log('RADIUS activation failed: ' . $e->getMessage(), 'M-Pesa', $customer->id);
        return false;
    }
}

/**
 * Activate PPPoE service
 */
function activate_pppoe_service($customer, $plan, $recharge)
{
    try {
        // Update customer status for PPPoE
        $customer->status = 'Active';
        $customer->service_type = 'PPPoE';
        
        // Generate PPPoE credentials if not exist
        if (empty($customer->pppoe_username)) {
            $customer->pppoe_username = $customer->username . '_pppoe';
        }
        if (empty($customer->pppoe_password)) {
            $customer->pppoe_password = substr(md5(time() . $customer->username), 0, 10);
        }
        
        $customer->save();
        
        _log("PPPoE service activated for user: {$customer->username}, PPPoE User: {$customer->pppoe_username}", 'M-Pesa', $customer->id);
        
        return true;
        
    } catch (Exception $e) {
        _log('PPPoE activation failed: ' . $e->getMessage(), 'M-Pesa', $customer->id);
        return false;
    }
}