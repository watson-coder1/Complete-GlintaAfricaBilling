<?php
/**
 * Simple standalone script to remove duplicate transaction records
 */

// Database configuration
$host = 'glinta-mysql-prod';
$dbname = 'glinta_billing';
$username = 'root';
$password = 'GlintaRoot2025!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "🔧 Starting Transaction Duplicate Cleanup - " . date('Y-m-d H:i:s') . "\n";
    
    // Find duplicates - same username, method, plan, price, and date with multiple records
    $sql = "
        SELECT username, method, plan_name, price, recharged_on, COUNT(*) as duplicate_count, 
               GROUP_CONCAT(id ORDER BY recharged_time DESC) as transaction_ids
        FROM tbl_transactions 
        WHERE recharged_on >= '2025-07-25'
        AND method = 'M-Pesa STK Push'
        GROUP BY username, method, plan_name, price, recharged_on 
        HAVING COUNT(*) > 1
        ORDER BY duplicate_count DESC
    ";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $duplicateGroups = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "Found " . count($duplicateGroups) . " groups of duplicate transactions\n";
    
    $totalRemoved = 0;
    $totalKept = 0;
    
    foreach ($duplicateGroups as $group) {
        $username = $group['username'];
        $plan_name = $group['plan_name'];
        $price = $group['price'];
        $transaction_ids = explode(',', $group['transaction_ids']);
        $duplicate_count = $group['duplicate_count'];
        
        echo "\n📋 Processing user: {$username} - {$plan_name} (Ksh. {$price}) - ({$duplicate_count} duplicates)\n";
        
        // Keep the first ID (most recent due to ORDER BY recharged_time DESC)
        $keep_id = array_shift($transaction_ids);
        echo "   ✅ Keeping transaction ID: {$keep_id}\n";
        $totalKept++;
        
        // Remove the rest
        foreach ($transaction_ids as $remove_id) {
            try {
                $delete_sql = "DELETE FROM tbl_transactions WHERE id = ?";
                $delete_stmt = $pdo->prepare($delete_sql);
                $delete_stmt->execute([$remove_id]);
                
                echo "   ❌ Removed duplicate transaction ID: {$remove_id}\n";
                $totalRemoved++;
            } catch (Exception $e) {
                echo "   ⚠️  Error removing transaction ID {$remove_id}: " . $e->getMessage() . "\n";
            }
        }
    }
    
    echo "\n✅ Transaction duplicate cleanup completed - " . date('Y-m-d H:i:s') . "\n";
    echo "📊 Summary:\n";
    echo "   - Groups processed: " . count($duplicateGroups) . "\n";
    echo "   - Records kept: {$totalKept}\n";
    echo "   - Duplicates removed: {$totalRemoved}\n";
    
    // Calculate total income impact
    $totalSaved = 0;
    foreach ($duplicateGroups as $group) {
        $price = floatval($group['price']);
        $duplicate_count = intval($group['duplicate_count']);
        $duplicates_removed = $duplicate_count - 1; // Keep 1, remove the rest
        $totalSaved += ($price * $duplicates_removed);
    }
    
    echo "\n💰 Financial Impact:\n";
    echo "   - Total amount removed from inflated income: Ksh. " . number_format($totalSaved, 2) . "\n";
    
    echo "\n🎉 Transaction cleanup completed successfully!\n";
    
} catch (Exception $e) {
    echo "❌ Database connection failed: " . $e->getMessage() . "\n";
    exit(1);
}
?>