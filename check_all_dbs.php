<?php
// Database configuration
$host = 'glinta-mysql-prod';
$username = 'root';
$password = 'GlintaRoot2025!';

try {
    $pdo = new PDO("mysql:host=$host", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "🔍 Connected to MySQL server\n";
    
    // Show all databases
    $stmt = $pdo->query("SHOW DATABASES");
    $databases = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    echo "📋 Found " . count($databases) . " databases:\n";
    foreach ($databases as $db) {
        if (in_array($db, ['information_schema', 'mysql', 'performance_schema', 'sys'])) {
            continue; // Skip system databases
        }
        
        echo "\n🎯 Database: $db\n";
        
        try {
            $pdo->exec("USE $db");
            $table_stmt = $pdo->query("SHOW TABLES");
            $tables = $table_stmt->fetchAll(PDO::FETCH_COLUMN);
            
            echo "  Tables (" . count($tables) . "): ";
            if (count($tables) > 0) {
                echo "\n";
                foreach ($tables as $table) {
                    echo "    - $table\n";
                    if (strpos(strtolower($table), 'transaction') !== false) {
                        echo "      ⭐ This is a transaction table!\n";
                    }
                }
            } else {
                echo "None\n";
            }
        } catch (Exception $e) {
            echo "  Error accessing database: " . $e->getMessage() . "\n";
        }
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>