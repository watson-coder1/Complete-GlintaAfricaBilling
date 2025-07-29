<?php
try {
    // Direct database connection
    $pdo = new PDO(
        'mysql:host=glinta-mysql-prod;dbname=glinta_billing;charset=utf8mb4',
        'glinta_user',
        'Glinta2025!',
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]
    );
    
    // Show all tables
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll();
    
    echo "Available tables:\n";
    foreach ($tables as $table) {
        echo "- " . current($table) . "\n";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>