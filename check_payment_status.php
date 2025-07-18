<?php

/**
 * Payment Status Checker
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * AJAX endpoint to check M-Pesa payment status
 */

header('Content-Type: application/json');

require_once 'init.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit();
}

$checkout_id = _post('checkout_id');

if (empty($checkout_id)) {
    echo json_encode(['success' => false, 'message' => 'Checkout ID is required']);
    exit();
}

try {
    // Find payment record
    $payment = ORM::for_table('tbl_payment_gateway')
        ->where('checkout_request_id', $checkout_id)
        ->find_one();
    
    if (!$payment) {
        echo json_encode(['success' => false, 'message' => 'Payment record not found']);
        exit();
    }
    
    $status = '';
    switch ($payment->status) {
        case 1:
            $status = 'pending';
            break;
        case 2:
            $status = 'paid';
            break;
        case 3:
            $status = 'failed';
            break;
        case 4:
            $status = 'cancelled';
            break;
        default:
            $status = 'unknown';
    }
    
    echo json_encode([
        'success' => true,
        'status' => $status,
        'payment_id' => $payment->id,
        'amount' => $payment->price,
        'plan_name' => $payment->plan_name,
        'created_date' => $payment->created_date,
        'paid_date' => $payment->paid_date,
        'mpesa_receipt' => $payment->mpesa_receipt_number
    ]);
    
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Database error']);
}
?>