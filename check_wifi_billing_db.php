<?php
// Database configuration for wifi-billing-mysql
$host = 'wifi-billing-mysql';
$dbname = 'billing';
$username = 'root';
$password = 'rootpassword123';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "🔍 Connected to database: $dbname on $host\n";
    
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
            
            if ($count > 0) {
                echo "    Sample records:\n";
                $sample_stmt = $pdo->query("SELECT * FROM $table LIMIT 3");
                $samples = $sample_stmt->fetchAll(PDO::FETCH_ASSOC);
                foreach ($samples as $sample) {
                    echo "      ID: " . ($sample['id'] ?? 'N/A') . ", Username: " . ($sample['username'] ?? 'N/A') . "\n";
                }
            }
        }
    } else {
        echo "\n❌ No transaction tables found\n";
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>