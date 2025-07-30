<?php
// Simple M-Pesa check
echo "Starting M-Pesa check...\n";

try {
    // Database connection
    $host = 'glinta-mysql-prod';
    $dbname = 'glinta_billing';
    $username = 'root';
    $password = 'Glinta2025!';

    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "Connected to database\n";
    
    // Check for M-Pesa transactions today
    $today = date('Y-m-d');
    $stmt = $pdo->prepare("SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total FROM tbl_transactions WHERE recharged_on = ? AND method = 'M-Pesa STK Push'");
    $stmt->execute([$today]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "M-Pesa transactions today: {$result['count']} transactions, Total: Ksh. " . number_format($result['total'], 2) . "\n";
    
    // Check all transactions today
    $stmt = $pdo->prepare("SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total FROM tbl_transactions WHERE recharged_on = ? AND method != 'Customer - Balance' AND method != 'Recharge Balance - Administrator'");
    $stmt->execute([$today]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "All transactions today: {$result['count']} transactions, Total: Ksh. " . number_format($result['total'], 2) . "\n";
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>