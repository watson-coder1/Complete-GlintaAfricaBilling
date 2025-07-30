<?php
echo "Testing database connection...\n";

// Test with the exact same settings as in config.php
$db_host = "glinta-mysql-prod";
$db_user = "root";
$db_pass = "Glinta2025!";
$db_name = "glinta_billing";

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✅ Database connection successful!\n";
    
    // Test a simple query
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_transactions");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "✅ Query test successful! Found {$result['count']} transactions\n";
    
    // Check for M-Pesa transactions
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_transactions WHERE method = 'M-Pesa STK Push'");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "📱 Total M-Pesa transactions: {$result['count']}\n";
    
} catch (Exception $e) {
    echo "❌ Database connection failed: " . $e->getMessage() . "\n";
    
    // Try alternative password from environment
    echo "Trying with GlintaRoot2025!...\n";
    try {
        $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, "GlintaRoot2025!");
        echo "✅ Connected with GlintaRoot2025!\n";
    } catch (Exception $e2) {
        echo "❌ Also failed with GlintaRoot2025!: " . $e2->getMessage() . "\n";
    }
}
?>