<?php
echo "🔍 Checking what tables exist in the database...\n\n";

$db_host = "glinta-mysql-prod";
$db_user = "root";
$db_pass = "GlintaRoot2025!";
$db_name = "glinta_billing";

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✅ Connected to database: $db_name\n\n";
    
    // Show all tables
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    echo "📋 Found " . count($tables) . " tables:\n";
    foreach ($tables as $table) {
        echo "   - $table\n";
    }
    
    // Look for transaction-related tables
    $transaction_tables = array_filter($tables, function($table) {
        return strpos(strtolower($table), 'transaction') !== false;
    });
    
    if (!empty($transaction_tables)) {
        echo "\n🎯 Transaction-related tables:\n";
        foreach ($transaction_tables as $table) {
            echo "   - $table\n";
            
            // Check record count
            $count_stmt = $pdo->query("SELECT COUNT(*) FROM $table");
            $count = $count_stmt->fetchColumn();
            echo "     Records: $count\n";
            
            if ($count > 0) {
                // Show sample records
                $sample_stmt = $pdo->query("SELECT * FROM $table LIMIT 2");
                $samples = $sample_stmt->fetchAll(PDO::FETCH_ASSOC);
                echo "     Sample columns: " . implode(', ', array_keys($samples[0])) . "\n";
            }
        }
    } else {
        echo "\n❌ No transaction tables found\n";
    }
    
    // Check for payment gateway table
    $payment_tables = array_filter($tables, function($table) {
        return strpos(strtolower($table), 'payment') !== false;
    });
    
    if (!empty($payment_tables)) {
        echo "\n💳 Payment-related tables:\n";
        foreach ($payment_tables as $table) {
            echo "   - $table\n";
            
            $count_stmt = $pdo->query("SELECT COUNT(*) FROM $table");
            $count = $count_stmt->fetchColumn();
            echo "     Records: $count\n";
        }
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>