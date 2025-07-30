<?php
echo "🔍 Checking tbl_user_recharges table structure...\n\n";

$db_host = "glinta-mysql-prod";
$db_user = "root";
$db_pass = "GlintaRoot2025!";
$db_name = "glinta_billing";

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✅ Connected to database\n\n";
    
    // Check tbl_user_recharges structure
    $stmt = $pdo->query("DESCRIBE tbl_user_recharges");
    $columns = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "📋 tbl_user_recharges table structure:\n";
    foreach ($columns as $column) {
        $null = $column['Null'] == 'YES' ? 'NULL' : 'NOT NULL';
        $default = $column['Default'] ? "DEFAULT '{$column['Default']}'" : ($column['Null'] == 'YES' ? 'DEFAULT NULL' : 'NO DEFAULT');
        echo "   - {$column['Field']}: {$column['Type']} $null $default\n";
        
        if ($column['Field'] == 'expiration' && $column['Null'] == 'NO' && !$column['Default']) {
            echo "     ⚠️  PROBLEM: expiration field is NOT NULL with no default value!\n";
        }
    }
    
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}
?>