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
    
    // Get current configuration
    $stmt = $pdo->prepare("SELECT pg_data FROM tbl_pg WHERE gateway = 'Daraja'");
    $stmt->execute();
    $result = $stmt->fetch();
    
    if ($result) {
        $pgData = json_decode($result['pg_data'], true);
        echo "Current environment: " . $pgData['environment'] . "\n";
        
        // Update environment to 'live'
        $pgData['environment'] = 'live';
        $newData = json_encode($pgData);
        
        $updateStmt = $pdo->prepare("UPDATE tbl_pg SET pg_data = ? WHERE gateway = 'Daraja'");
        $updateStmt->execute([$newData]);
        
        echo "Environment updated to: live\n";
        
        // Verify the change
        $verifyStmt = $pdo->prepare("SELECT pg_data FROM tbl_pg WHERE gateway = 'Daraja'");
        $verifyStmt->execute();
        $verifyResult = $verifyStmt->fetch();
        $verifyData = json_decode($verifyResult['pg_data'], true);
        echo "Verified environment is now: " . $verifyData['environment'] . "\n";
        
    } else {
        echo "Daraja configuration not found\n";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>