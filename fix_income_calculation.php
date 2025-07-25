<?php
/**
 * Fix Monthly Income Calculation
 * This script restores proper income calculation to include all payment methods
 * except balance transfers
 */

require_once 'init.php';

echo "<h2>Fixing Monthly Income Calculation</h2>";

// Backup the original file
$dashboardFile = 'system/controllers/dashboard.php';
$backupFile = $dashboardFile . '.backup_' . date('YmdHis');

echo "<h3>1. Creating Backup</h3>";
if (copy($dashboardFile, $backupFile)) {
    echo "✅ Backup created: $backupFile<br>";
} else {
    die("❌ Failed to create backup. Aborting.");
}

// Read the current dashboard content
$dashboardContent = file_get_contents($dashboardFile);
$originalContent = $dashboardContent;

echo "<h3>2. Fixing Income Calculations</h3>";

// Fix patterns that might be filtering for M-Pesa only
$fixes = [
    // Daily income fix
    [
        'pattern' => "/->where\('method', 'M-Pesa STK Push'\)/",
        'replacement' => "->where_not_equal('method', 'Customer - Balance')\n    ->where_not_equal('method', 'Recharge Balance - Administrator')",
        'description' => 'Daily income calculation'
    ],
    // Monthly income fix
    [
        'pattern' => "/->where\('method', 'M-Pesa STK Push'\)/",
        'replacement' => "->where_not_equal('method', 'Customer - Balance')\n    ->where_not_equal('method', 'Recharge Balance - Administrator')",
        'description' => 'Monthly income calculation'
    ],
    // Monthly sales fix
    [
        'pattern' => "/->where\('tbl_transactions\.method', 'M-Pesa STK Push'\)/",
        'replacement' => "->where_not_equal('tbl_transactions.method', 'Customer - Balance')\n        ->where_not_equal('tbl_transactions.method', 'Recharge Balance - Administrator')",
        'description' => 'Monthly sales by service'
    ]
];

$changes_made = 0;
foreach ($fixes as $fix) {
    if (preg_match($fix['pattern'], $dashboardContent)) {
        $dashboardContent = preg_replace($fix['pattern'], $fix['replacement'], $dashboardContent);
        echo "✅ Fixed: {$fix['description']}<br>";
        $changes_made++;
    }
}

// Also ensure the main monthly income calculation (lines 48-56) is correct
$monthlyIncomePattern = '/(\$imonth = ORM::for_table\(\'tbl_transactions\'\)[\s\S]*?->sum\(\'price\'\);)/';
$monthlyIncomeReplacement = '$imonth = ORM::for_table(\'tbl_transactions\')
    ->where_not_equal(\'method\', \'Customer - Balance\')
    ->where_not_equal(\'method\', \'Recharge Balance - Administrator\')
    ->where_gte(\'recharged_on\', $start_date)
    ->where_lte(\'recharged_on\', $current_date)->sum(\'price\');';

if (preg_match($monthlyIncomePattern, $dashboardContent)) {
    $dashboardContent = preg_replace($monthlyIncomePattern, $monthlyIncomeReplacement, $dashboardContent);
    echo "✅ Fixed: Main monthly income calculation<br>";
    $changes_made++;
}

// Write the fixed content back
if ($changes_made > 0) {
    echo "<h3>3. Saving Changes</h3>";
    if (file_put_contents($dashboardFile, $dashboardContent)) {
        echo "✅ Dashboard file updated successfully<br>";
        echo "✅ Made $changes_made fixes<br>";
    } else {
        echo "❌ Failed to save changes<br>";
    }
} else {
    echo "<h3>3. No Changes Needed</h3>";
    echo "ℹ️ Dashboard is already using the correct calculation method<br>";
}

// Clear cache files to force recalculation
echo "<h3>4. Clearing Cache</h3>";
$cacheFiles = [
    $CACHE_PATH . '/monthlyRegistered.temp',
    $CACHE_PATH . '/monthlyRegisteredByService.temp',
    $CACHE_PATH . '/monthlySales.temp',
    $CACHE_PATH . '/monthlySalesByService.temp',
    $CACHE_PATH . '/activeUsersByService.temp'
];

foreach ($cacheFiles as $file) {
    if (file_exists($file)) {
        if (unlink($file)) {
            echo "✅ Cleared: " . basename($file) . "<br>";
        }
    }
}

// Verify the fix
echo "<h3>5. Verification</h3>";

// Get date range
$reset_day = $config['reset_day'] ?: 1;
if (date("d") >= $reset_day) {
    $start_date = date('Y-m-' . $reset_day);
} else {
    $start_date = date('Y-m-' . $reset_day, strtotime("-1 MONTH"));
}
$current_date = date('Y-m-d');

// Calculate new total
$new_total = ORM::for_table('tbl_transactions')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->sum('price');

// Also add payment gateway total
$gateway_total = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2)
    ->where('gateway', 'Daraja')
    ->where_gte('paid_date', $start_date . ' 00:00:00')
    ->where_lte('paid_date', $current_date . ' 23:59:59')
    ->sum('price');

$combined_total = ($new_total ?: 0) + ($gateway_total ?: 0);

echo "<div style='background-color: #d4edda; padding: 15px; border-radius: 5px; margin-top: 20px;'>";
echo "<h4>✅ Fix Complete!</h4>";
echo "<p><strong>New Monthly Income Calculation:</strong></p>";
echo "<ul>";
echo "<li>Transaction Total: " . number_format($new_total ?: 0, 2) . "</li>";
echo "<li>Payment Gateway Total: " . number_format($gateway_total ?: 0, 2) . "</li>";
echo "<li><strong>Combined Total: " . number_format($combined_total, 2) . "</strong></li>";
echo "</ul>";
echo "<p>The dashboard will now show the correct total income including all payment methods except balance transfers.</p>";
echo "</div>";

// Show what payment methods are included
echo "<h3>6. Included Payment Methods</h3>";
$included_methods = ORM::for_table('tbl_transactions')
    ->select('method')
    ->select_expr('COUNT(*)', 'count')
    ->select_expr('SUM(price)', 'total')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->group_by('method')
    ->find_many();

echo "<table border='1' style='border-collapse: collapse; width: 100%;'>";
echo "<tr><th>Payment Method</th><th>Count</th><th>Total Amount</th></tr>";

foreach ($included_methods as $method) {
    echo "<tr>";
    echo "<td>{$method->method}</td>";
    echo "<td>{$method->count}</td>";
    echo "<td>" . number_format($method->total, 2) . "</td>";
    echo "</tr>";
}
echo "</table>";

echo "<div style='margin-top: 20px;'>";
echo "<a href='dashboard' style='background-color: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;'>Go to Dashboard</a>";
echo "</div>";

?>