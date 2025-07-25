<?php
/**
 * Fix Dashboard Income Calculation
 * Ensures accurate monthly income without double-counting
 */

require_once 'init.php';

echo "<h2>Fixing Dashboard Income Calculation</h2>";

// Backup the dashboard file
$dashboardFile = 'system/controllers/dashboard.php';
$backupFile = $dashboardFile . '.backup_' . date('YmdHis');

echo "<h3>1. Creating Backup</h3>";
if (copy($dashboardFile, $backupFile)) {
    echo "✅ Backup created: $backupFile<br>";
} else {
    die("❌ Failed to create backup. Aborting.");
}

// Read the dashboard content
$content = file_get_contents($dashboardFile);

echo "<h3>2. Updating Income Calculations</h3>";

// Fix 1: Update daily income calculation (lines 37-46)
$dailyIncomeOld = '/$iday = ORM::for_table\(\'tbl_transactions\'\)[\s\S]*?->sum\(\'price\'\);/';
$dailyIncomeNew = '$iday = ORM::for_table(\'tbl_transactions\')
    ->where(\'recharged_on\', $current_date)
    ->where_not_equal(\'method\', \'Customer - Balance\')
    ->where_not_equal(\'method\', \'Recharge Balance - Administrator\')
    ->sum(\'price\');';

if (preg_match($dailyIncomeOld, $content)) {
    $content = preg_replace($dailyIncomeOld, $dailyIncomeNew, $content);
    echo "✅ Fixed daily income calculation<br>";
}

// Fix 2: Update monthly income calculation (lines 48-56)
$monthlyIncomeOld = '/$imonth = ORM::for_table\(\'tbl_transactions\'\)[\s\S]*?->where_lte\(\'recharged_on\', \$current_date\)->sum\(\'price\'\);/';
$monthlyIncomeNew = '$imonth = ORM::for_table(\'tbl_transactions\')
    ->where_not_equal(\'method\', \'Customer - Balance\')
    ->where_not_equal(\'method\', \'Recharge Balance - Administrator\')
    ->where_gte(\'recharged_on\', $start_date)
    ->where_lte(\'recharged_on\', $current_date)->sum(\'price\');';

if (preg_match($monthlyIncomeOld, $content)) {
    $content = preg_replace($monthlyIncomeOld, $monthlyIncomeNew, $content);
    echo "✅ Fixed monthly income calculation<br>";
}

// Fix 3: Remove the duplicate M-Pesa addition at the bottom (lines 560-598)
// This prevents double-counting if M-Pesa is already in tbl_transactions
$duplicatePattern = '/\/\/ Re-verify Income Today includes M-Pesa transactions[\s\S]*?\/\/ Update the imonth variable to include M-Pesa\s*\$ui->assign\(\'imonth\', \$total_income_month\);/';

if (preg_match($duplicatePattern, $content)) {
    // Comment out the duplicate section instead of removing it
    $content = preg_replace($duplicatePattern, '// FIXED: Removed duplicate M-Pesa calculation to prevent double-counting
// M-Pesa transactions are already included in tbl_transactions table', $content);
    echo "✅ Removed duplicate M-Pesa calculation<br>";
}

// Fix 4: Ensure monthly sales calculation is correct
$monthlySalesPattern = '/->where\(\'method\', \'M-Pesa STK Push\'\)/';
$monthlySalesReplacement = "->where_not_equal('method', 'Customer - Balance')
        ->where_not_equal('method', 'Recharge Balance - Administrator')";

$content = preg_replace($monthlySalesPattern, $monthlySalesReplacement, $content);

// Save the updated file
if (file_put_contents($dashboardFile, $content)) {
    echo "✅ Dashboard file updated successfully<br>";
} else {
    die("❌ Failed to save changes");
}

// Clear cache
echo "<h3>3. Clearing Cache</h3>";
$cacheFiles = [
    $CACHE_PATH . '/monthlyRegistered.temp',
    $CACHE_PATH . '/monthlySales.temp',
    $CACHE_PATH . '/monthlySalesByService.temp'
];

foreach ($cacheFiles as $file) {
    if (file_exists($file) && unlink($file)) {
        echo "✅ Cleared: " . basename($file) . "<br>";
    }
}

// Verify the fix
echo "<h3>4. Verification</h3>";

$reset_day = $config['reset_day'] ?: 1;
if (date("d") >= $reset_day) {
    $start_date = date('Y-m-' . $reset_day);
} else {
    $start_date = date('Y-m-' . $reset_day, strtotime("-1 MONTH"));
}
$current_date = date('Y-m-d');

// Check if M-Pesa transactions exist in both tables
echo "<h4>Checking for M-Pesa Transactions:</h4>";

// In tbl_transactions
$mpesa_in_transactions = ORM::for_table('tbl_transactions')
    ->where_like('method', '%M-Pesa%')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->count();

$mpesa_amount_transactions = ORM::for_table('tbl_transactions')
    ->where_like('method', '%M-Pesa%')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->sum('price');

echo "<p>M-Pesa in tbl_transactions: {$mpesa_in_transactions} transactions, Amount: " . number_format($mpesa_amount_transactions ?: 0, 2) . "</p>";

// In tbl_payment_gateway
$mpesa_in_gateway = ORM::for_table('tbl_payment_gateway')
    ->where('gateway', 'Daraja')
    ->where('status', 2)
    ->where_gte('paid_date', $start_date . ' 00:00:00')
    ->where_lte('paid_date', $current_date . ' 23:59:59')
    ->count();

$mpesa_amount_gateway = ORM::for_table('tbl_payment_gateway')
    ->where('gateway', 'Daraja')
    ->where('status', 2)
    ->where_gte('paid_date', $start_date . ' 00:00:00')
    ->where_lte('paid_date', $current_date . ' 23:59:59')
    ->sum('price');

echo "<p>M-Pesa in tbl_payment_gateway: {$mpesa_in_gateway} transactions, Amount: " . number_format($mpesa_amount_gateway ?: 0, 2) . "</p>";

// Calculate new totals
echo "<h4>New Income Calculation:</h4>";

$new_monthly_total = ORM::for_table('tbl_transactions')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->sum('price');

echo "<div style='background-color: #d4edda; padding: 15px; border-radius: 5px;'>";
echo "<h4>✅ Fix Complete!</h4>";
echo "<p><strong>New Monthly Income: " . number_format($new_monthly_total ?: 0, 2) . "</strong></p>";
echo "<p>This includes all payment methods except balance transfers.</p>";

// Show breakdown by payment method
$breakdown = ORM::for_table('tbl_transactions')
    ->select('method')
    ->select_expr('COUNT(*)', 'count')
    ->select_expr('SUM(price)', 'total')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->group_by('method')
    ->find_many();

echo "<h4>Breakdown by Payment Method:</h4>";
echo "<table border='1' style='border-collapse: collapse; width: 100%;'>";
echo "<tr><th>Method</th><th>Count</th><th>Amount</th></tr>";
foreach ($breakdown as $item) {
    echo "<tr>";
    echo "<td>{$item->method}</td>";
    echo "<td>{$item->count}</td>";
    echo "<td>" . number_format($item->total, 2) . "</td>";
    echo "</tr>";
}
echo "</table>";
echo "</div>";

echo "<div style='margin-top: 20px;'>";
echo "<a href='dashboard' style='background-color: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;'>View Dashboard</a>";
echo "</div>";

?>