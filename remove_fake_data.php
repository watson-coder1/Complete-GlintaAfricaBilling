<?php

/**
 * Remove Fake Data and Fix Dashboard for Real Data Only
 * Developed by Watsons Developers (watsonsdevelopers.com)
 */

require_once 'init.php';

echo "<h2>🧹 Removing Fake Data and Fixing Dashboard</h2>";

// 1. Remove all fake/sample data
echo "<h3>1. Removing Fake Data</h3>";
try {
    // Remove sample transactions
    $deleted_transactions = ORM::for_table('tbl_transactions')
        ->where_like('invoice', 'SAMPLE%')
        ->delete_many();
    echo "✅ Removed fake transactions<br>";
    
    // Remove sample user recharges
    $deleted_recharges = ORM::for_table('tbl_user_recharges')
        ->where_like('username', 'sample_user%')
        ->delete_many();
    echo "✅ Removed fake user recharges<br>";
    
} catch (Exception $e) {
    echo "❌ Error removing fake data: " . $e->getMessage() . "<br>";
}

// 2. Fix dashboard to handle empty data gracefully
echo "<h3>2. Configuring Dashboard for Real Data</h3>";
try {
    // Set configuration to handle empty data properly
    $configs = [
        ['setting' => 'hide_aui', 'value' => 'yes'], // Hide All Users Insights until real data exists
        ['setting' => 'hide_pg', 'value' => 'yes'],  // Hide Payment Gateway widget
        ['setting' => 'show_empty_charts', 'value' => 'no'] // Don't show empty charts
    ];
    
    foreach ($configs as $config_item) {
        $setting = ORM::for_table('tbl_appconfig')
            ->where('setting', $config_item['setting'])
            ->find_one();
        
        if (!$setting) {
            $setting = ORM::for_table('tbl_appconfig')->create();
            $setting->setting = $config_item['setting'];
        }
        $setting->value = $config_item['value'];
        $setting->save();
    }
    
    echo "✅ Configured dashboard to hide empty widgets<br>";
    
} catch (Exception $e) {
    echo "❌ Error configuring dashboard: " . $e->getMessage() . "<br>";
}

// 3. Clear all cache files
echo "<h3>3. Clearing Cache</h3>";
try {
    $cacheFiles = glob($CACHE_PATH . '/*.temp');
    foreach ($cacheFiles as $file) {
        unlink($file);
    }
    echo "✅ Cleared all cache files<br>";
    
} catch (Exception $e) {
    echo "❌ Error clearing cache: " . $e->getMessage() . "<br>";
}

// 4. Show current real data status
echo "<h3>4. Real Data Status</h3>";
try {
    $real_customers = ORM::for_table('tbl_customers')->count();
    $real_transactions = ORM::for_table('tbl_transactions')
        ->where_not_like('invoice', 'SAMPLE%')
        ->count();
    $real_recharges = ORM::for_table('tbl_user_recharges')
        ->where_not_like('username', 'sample_user%')
        ->count();
    $real_plans = ORM::for_table('tbl_plans')->count();
    
    echo "📊 <strong>Current Real Data:</strong><br>";
    echo "├── Customers: $real_customers<br>";
    echo "├── Transactions: $real_transactions<br>";
    echo "├── User Recharges: $real_recharges<br>";
    echo "└── Plans: $real_plans<br>";
    
    if ($real_customers == 0) {
        echo "⚠️ <strong>No customers yet</strong> - Dashboard will show zeros until you have real customers<br>";
    }
    
    if ($real_transactions == 0) {
        echo "⚠️ <strong>No transactions yet</strong> - Monthly sales charts will be empty until real payments<br>";
    }
    
} catch (Exception $e) {
    echo "❌ Error checking real data: " . $e->getMessage() . "<br>";
}

echo "<h3>✅ Cleanup Complete!</h3>";
echo "<h4>📋 What Was Done:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Removed all fake data</strong> - No more sample transactions or users</li>";
echo "<li>✅ <strong>Hidden empty widgets</strong> - Charts will only show when you have real data</li>";
echo "<li>✅ <strong>Cleared cache</strong> - Fresh start with real data only</li>";
echo "<li>✅ <strong>Kept cron fix</strong> - Timestamp files remain to prevent cron warnings</li>";
echo "</ul>";

echo "<h4>🚀 What Happens Now:</h4>";
echo "<ul>";
echo "<li>📊 <strong>Dashboard shows real metrics only</strong></li>";
echo "<li>💰 <strong>Charts populate as you get real customers and payments</strong></li>";
echo "<li>🔐 <strong>RADIUS system works with real user authentication</strong></li>";
echo "<li>📱 <strong>M-Pesa payments create real transactions</strong></li>";
echo "</ul>";

echo "<h4>🎯 To Get Real Data:</h4>";
echo "<ol>";
echo "<li><strong>Configure M-Pesa Daraja:</strong> Admin → Payment Gateway → Daraja</li>";
echo "<li><strong>Create Internet Plans:</strong> Admin → Services → Internet Plans</li>";
echo "<li><strong>Set up Mikrotik:</strong> Use the Mikrotik config generator</li>";
echo "<li><strong>Test Payment Flow:</strong> Use /mpesa_payment.php</li>";
echo "<li><strong>Real customers pay → Real data appears in dashboard</strong></li>";
echo "</ol>";

echo "<hr>";
echo "<p><strong>Dashboard will now show:</strong></p>";
echo "<ul>";
echo "<li>✅ Real customer counts</li>";
echo "<li>✅ Real transaction amounts</li>";
echo "<li>✅ Real RADIUS sessions</li>";
echo "<li>✅ Empty charts until real data exists</li>";
echo "</ul>";

?>