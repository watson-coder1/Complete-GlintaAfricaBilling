<?php
echo "🔍 Verifying M-Pesa dashboard display with correct database password...\n\n";

// Test with the corrected database password
$db_host = "glinta-mysql-prod";
$db_user = "root";
$db_pass = "GlintaRoot2025!";
$db_name = "glinta_billing";

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✅ Database connection successful!\n\n";
    
    $current_date = date('Y-m-d');
    echo "📅 Checking for today ($current_date):\n\n";
    
    // Check today's income (what the dashboard should show)
    $stmt = $pdo->prepare("
        SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total 
        FROM tbl_transactions 
        WHERE recharged_on = ? 
        AND method != 'Customer - Balance' 
        AND method != 'Recharge Balance - Administrator'
    ");
    $stmt->execute([$current_date]);
    $today_income = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "💰 Dashboard 'Today's Income': {$today_income['count']} transactions, Ksh. " . number_format($today_income['total'], 2) . "\n";
    
    // Check M-Pesa specific transactions
    $stmt = $pdo->prepare("
        SELECT COUNT(*) as count, COALESCE(SUM(price), 0) as total 
        FROM tbl_transactions 
        WHERE recharged_on = ? AND method = 'M-Pesa STK Push'
    ");
    $stmt->execute([$current_date]);
    $mpesa_today = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo "📱 M-Pesa transactions today: {$mpesa_today['count']} transactions, Ksh. " . number_format($mpesa_today['total'], 2) . "\n\n";
    
    // Show recent M-Pesa transactions
    $stmt = $pdo->prepare("
        SELECT username, plan_name, price, recharged_on, recharged_time, invoice 
        FROM tbl_transactions 
        WHERE method = 'M-Pesa STK Push' 
        ORDER BY recharged_on DESC, recharged_time DESC 
        LIMIT 5
    ");
    $stmt->execute();
    $recent_mpesa = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "📋 Recent M-Pesa transactions:\n";
    if (empty($recent_mpesa)) {
        echo "   ❌ No M-Pesa transactions found\n";
    } else {
        foreach ($recent_mpesa as $transaction) {
            echo "   📝 {$transaction['recharged_on']} {$transaction['recharged_time']}: {$transaction['username']} - {$transaction['plan_name']} - Ksh. {$transaction['price']} (Invoice: {$transaction['invoice']})\n";
        }
    }
    
    echo "\n✅ M-Pesa dashboard verification complete!\n";
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>