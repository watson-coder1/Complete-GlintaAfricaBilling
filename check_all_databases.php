<?php
echo "🔍 Checking all databases on MySQL server...\n\n";

$db_host = "glinta-mysql-prod";
$db_user = "root";
$db_pass = "GlintaRoot2025!";

try {
    $pdo = new PDO("mysql:host=$db_host", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✅ Connected to MySQL server\n\n";
    
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
            
            echo "   Tables (" . count($tables) . "): ";
            if (count($tables) > 0) {
                echo "\n";
                foreach ($tables as $table) {
                    echo "     - $table\n";
                    if (strpos(strtolower($table), 'transaction') !== false) {
                        echo "       ⭐ This is a transaction table!\n";
                        
                        // Check record count
                        $count_stmt = $pdo->query("SELECT COUNT(*) FROM $table");
                        $count = $count_stmt->fetchColumn();
                        echo "       📊 Records: $count\n";
                        
                        if ($count > 0) {
                            // Check for M-Pesa records
                            try {
                                $mpesa_stmt = $pdo->query("SELECT COUNT(*) FROM $table WHERE method = 'M-Pesa STK Push'");
                                $mpesa_count = $mpesa_stmt->fetchColumn();
                                echo "       💳 M-Pesa records: $mpesa_count\n";
                            } catch (Exception $e) {
                                echo "       ❌ Could not check M-Pesa records: " . $e->getMessage() . "\n";
                            }
                        }
                    }
                }
            } else {
                echo "None\n";
            }
        } catch (Exception $e) {
            echo "   Error accessing database: " . $e->getMessage() . "\n";
        }
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>