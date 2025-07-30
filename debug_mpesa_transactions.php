<?php
// Debug M-Pesa transactions in dashboard
$host = 'glinta-mysql-prod';
$dbname = 'glinta_billing';
$username = 'root';
$password = 'Glinta2025!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "🔍 Checking M-Pesa transactions in the database...\n\n";
    
    // Check tbl_transactions for M-Pesa records
    echo "📋 Checking tbl_transactions for M-Pesa STK Push records:\n";
    $stmt = $pdo->query("
        SELECT COUNT(*) as count, 
               SUM(price) as total_amount,
               DATE(recharged_on) as date
        FROM tbl_transactions 
        WHERE method = 'M-Pesa STK Push'
        GROUP BY DATE(recharged_on)
        ORDER BY date DESC
        LIMIT 10
    ");
    $transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($transactions)) {
        echo "   ❌ No M-Pesa STK Push records found in tbl_transactions\n";
    } else {
        foreach ($transactions as $row) {
            echo "   📅 {$row['date']}: {$row['count']} transactions, Total: Ksh. " . number_format($row['total_amount'], 2) . "\n";
        }
    }
    
    // Check tbl_payment_gateway for successful payments
    echo "\n📋 Checking tbl_payment_gateway for successful M-Pesa payments:\n";
    $stmt = $pdo->query("
        SELECT COUNT(*) as count, 
               SUM(price) as total_amount,
               DATE(paid_date) as date
        FROM tbl_payment_gateway 
        WHERE status = 2 AND gateway = 'Daraja'
        GROUP BY DATE(paid_date)
        ORDER BY date DESC
        LIMIT 10
    ");
    $payments = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($payments)) {
        echo "   ❌ No successful M-Pesa payments found in tbl_payment_gateway\n";
    } else {
        foreach ($payments as $row) {
            echo "   📅 {$row['date']}: {$row['count']} payments, Total: Ksh. " . number_format($row['total_amount'], 2) . "\n";
        }
    }
    
    // Check today's income specifically
    $today = date('Y-m-d');
    echo "\n📊 Today's income analysis ($today):\n";
    
    // From transactions table
    $stmt = $pdo->prepare("
        SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total
        FROM tbl_transactions 
        WHERE recharged_on = ? 
        AND method != 'Customer - Balance' 
        AND method != 'Recharge Balance - Administrator'
    ");
    $stmt->execute([$today]);
    $today_transactions = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "   📈 Total transactions today: {$today_transactions['count']}, Amount: Ksh. " . number_format($today_transactions['total'], 2) . "\n";
    
    // M-Pesa specific from transactions
    $stmt = $pdo->prepare("
        SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total
        FROM tbl_transactions 
        WHERE recharged_on = ? AND method = 'M-Pesa STK Push'
    ");
    $stmt->execute([$today]);
    $today_mpesa_transactions = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "   💳 M-Pesa transactions today: {$today_mpesa_transactions['count']}, Amount: Ksh. " . number_format($today_mpesa_transactions['total'], 2) . "\n";
    
    // From payment gateway
    $stmt = $pdo->prepare("
        SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total
        FROM tbl_payment_gateway 
        WHERE DATE(paid_date) = ? AND status = 2 AND gateway = 'Daraja'
    ");
    $stmt->execute([$today]);
    $today_mpesa_payments = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "   🏦 M-Pesa payment gateway today: {$today_mpesa_payments['count']}, Amount: Ksh. " . number_format($today_mpesa_payments['total'], 2) . "\n";
    
    // Check for recent M-Pesa records
    echo "\n📋 Recent M-Pesa transaction records (last 5):\n";
    $stmt = $pdo->query("
        SELECT username, plan_name, price, recharged_on, recharged_time, method, invoice
        FROM tbl_transactions 
        WHERE method = 'M-Pesa STK Push'
        ORDER BY recharged_on DESC, recharged_time DESC
        LIMIT 5
    ");
    $recent = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($recent)) {
        echo "   ❌ No recent M-Pesa transactions found\n";
    } else {
        foreach ($recent as $row) {
            echo "   📝 {$row['username']} - {$row['plan_name']} - Ksh. {$row['price']} on {$row['recharged_on']} {$row['recharged_time']} (Invoice: {$row['invoice']})\n";
        }
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>