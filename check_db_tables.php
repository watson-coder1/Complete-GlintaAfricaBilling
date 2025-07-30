<?php
// Database configuration
$host = 'glinta-mysql-prod';
$dbname = 'glinta_billing';
$username = 'root';
$password = 'GlintaRoot2025!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "🔍 Connected to database: $dbname\n";
    
    // Show all tables
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    echo "📋 Found " . count($tables) . " tables:\n";
    foreach ($tables as $table) {
        echo "  - $table\n";
    }
    
    // Look for transaction table specifically
    $transaction_tables = array_filter($tables, function($table) {
        return strpos(strtolower($table), 'transaction') !== false;
    });
    
    if (!empty($transaction_tables)) {
        echo "\n🎯 Transaction tables found:\n";
        foreach ($transaction_tables as $table) {
            echo "  - $table\n";
            
            // Check a few records
            $count_stmt = $pdo->query("SELECT COUNT(*) FROM $table");
            $count = $count_stmt->fetchColumn();
            echo "    Record count: $count\n";
        }
    } else {
        echo "\n❌ No transaction tables found\n";
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>