<?php
require_once 'init.php';

echo "🔍 Checking M-Pesa transactions for dashboard display...\n\n";

// Check today's M-Pesa transactions
$current_date = date('Y-m-d');

echo "📅 Current date: $current_date\n\n";

// From tbl_transactions (what the dashboard should show)
$mpesa_transactions_today = ORM::for_table('tbl_transactions')
    ->where('recharged_on', $current_date)
    ->where('method', 'M-Pesa STK Push')
    ->find_many();

echo "📋 M-Pesa transactions in tbl_transactions today: " . count($mpesa_transactions_today) . "\n";

$total_amount = 0;
foreach ($mpesa_transactions_today as $transaction) {
    echo "   - {$transaction->username}: {$transaction->plan_name} - Ksh. {$transaction->price} at {$transaction->recharged_time}\n";
    $total_amount += $transaction->price;
}

echo "💰 Total M-Pesa amount today from transactions: Ksh. " . number_format($total_amount, 2) . "\n\n";

// Check what the dashboard income calculation shows
$iday_total = ORM::for_table('tbl_transactions')
    ->where('recharged_on', $current_date)
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->sum('price');

if ($iday_total == '') {
    $iday_total = '0.00';
}

echo "📊 Dashboard 'Today's Income' calculation: Ksh. " . number_format($iday_total, 2) . "\n";

// Check payment gateway records
$mpesa_gateway_today = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2) // Paid
    ->where('gateway', 'Daraja')
    ->where_gte('paid_date', $current_date . ' 00:00:00')
    ->where_lte('paid_date', $current_date . ' 23:59:59')
    ->find_many();

echo "📋 M-Pesa payments in tbl_payment_gateway today: " . count($mpesa_gateway_today) . "\n";

$gateway_total = 0;
foreach ($mpesa_gateway_today as $payment) {
    echo "   - {$payment->username}: {$payment->plan_name} - Ksh. {$payment->price} (Receipt: {$payment->mpesa_receipt_number})\n";
    $gateway_total += $payment->price;
}

echo "💰 Total M-Pesa amount today from gateway: Ksh. " . number_format($gateway_total, 2) . "\n\n";

// Check recent transactions to see if M-Pesa is being recorded properly
echo "📋 Recent transactions (all methods):\n";
$recent_transactions = ORM::for_table('tbl_transactions')
    ->order_by_desc('recharged_on')
    ->order_by_desc('recharged_time')
    ->limit(10)
    ->find_many();

foreach ($recent_transactions as $transaction) {
    echo "   - {$transaction->recharged_on} {$transaction->recharged_time}: {$transaction->username} - {$transaction->method} - Ksh. {$transaction->price}\n";
}

echo "\n✅ Analysis complete!\n";
?>