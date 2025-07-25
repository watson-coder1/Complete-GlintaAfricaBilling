<?php
/**
 * Check Monthly Income Calculation Issue
 * This script diagnoses why 39,810 doesn't reflect the total amount received
 */

require_once 'init.php';

echo "<h2>Monthly Income Calculation Analysis</h2>";

// Get reset day configuration
$reset_day = $config['reset_day'];
if (empty($reset_day)) {
    $reset_day = 1;
}

// Calculate date range
if (date("d") >= $reset_day) {
    $start_date = date('Y-m-' . $reset_day);
} else {
    $start_date = date('Y-m-' . $reset_day, strtotime("-1 MONTH"));
}
$current_date = date('Y-m-d');

echo "<h3>Date Range: $start_date to $current_date</h3>";

// 1. Check all payment methods and their totals
echo "<h3>1. All Payment Methods This Month</h3>";
$all_methods = ORM::for_table('tbl_transactions')
    ->select('method')
    ->select_expr('COUNT(*)', 'count')
    ->select_expr('SUM(price)', 'total')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->group_by('method')
    ->find_many();

echo "<table border='1' style='border-collapse: collapse; width: 100%;'>";
echo "<tr><th>Payment Method</th><th>Count</th><th>Total Amount</th></tr>";

$grand_total = 0;
foreach ($all_methods as $method) {
    echo "<tr>";
    echo "<td>{$method->method}</td>";
    echo "<td>{$method->count}</td>";
    echo "<td>" . number_format($method->total, 2) . "</td>";
    echo "</tr>";
    $grand_total += $method->total;
}
echo "<tr style='background-color: #f0f0f0; font-weight: bold;'>";
echo "<td>GRAND TOTAL</td>";
echo "<td colspan='2'>" . number_format($grand_total, 2) . "</td>";
echo "</tr>";
echo "</table>";

// 2. Check what dashboard currently shows (excluding balance methods)
echo "<h3>2. Dashboard Calculation (Current Logic)</h3>";
$dashboard_total = ORM::for_table('tbl_transactions')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->sum('price');

echo "<p><strong>Dashboard shows: " . number_format($dashboard_total, 2) . "</strong></p>";
echo "<p>This excludes: 'Customer - Balance' and 'Recharge Balance - Administrator'</p>";

// 3. Check if it's configured for M-Pesa only
echo "<h3>3. M-Pesa Only Check</h3>";
$mpesa_only = ORM::for_table('tbl_transactions')
    ->where('method', 'M-Pesa STK Push')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->sum('price');

echo "<p>M-Pesa STK Push only: " . number_format($mpesa_only ?: 0, 2) . "</p>";

// Check if dashboard is showing M-Pesa only value
if (abs($dashboard_total - ($mpesa_only ?: 0)) < 1) {
    echo "<p style='color: red; font-weight: bold;'>⚠️ Dashboard is configured to show M-Pesa payments only!</p>";
}

// 4. Check payment gateway table
echo "<h3>4. Payment Gateway Table (M-Pesa Daraja)</h3>";
$gateway_total = ORM::for_table('tbl_payment_gateway')
    ->where('status', 2) // Paid
    ->where('gateway', 'Daraja')
    ->where_gte('paid_date', $start_date . ' 00:00:00')
    ->where_lte('paid_date', $current_date . ' 23:59:59')
    ->sum('price');

echo "<p>Payment Gateway total: " . number_format($gateway_total ?: 0, 2) . "</p>";

// 5. Check all payment types that should be included
echo "<h3>5. Recommended Income Calculation</h3>";
$recommended_methods = [
    'M-Pesa STK Push',
    'Cash',
    'Voucher',
    'Bank Transfer',
    'Check',
    'Credit Card',
    'PayPal',
    'Other'
];

$recommended_total = 0;
echo "<table border='1' style='border-collapse: collapse; width: 100%;'>";
echo "<tr><th>Payment Method</th><th>Amount</th><th>Should Include?</th></tr>";

foreach ($all_methods as $method) {
    $should_include = !in_array($method->method, ['Customer - Balance', 'Recharge Balance - Administrator']);
    $row_color = $should_include ? 'background-color: #d4edda;' : 'background-color: #f8d7da;';
    
    echo "<tr style='$row_color'>";
    echo "<td>{$method->method}</td>";
    echo "<td>" . number_format($method->total, 2) . "</td>";
    echo "<td>" . ($should_include ? '✅ YES' : '❌ NO') . "</td>";
    echo "</tr>";
    
    if ($should_include) {
        $recommended_total += $method->total;
    }
}
echo "<tr style='background-color: #f0f0f0; font-weight: bold;'>";
echo "<td>RECOMMENDED TOTAL</td>";
echo "<td colspan='2'>" . number_format($recommended_total, 2) . "</td>";
echo "</tr>";
echo "</table>";

// 6. Combined total (transactions + payment gateway)
echo "<h3>6. Combined Total (Including Payment Gateway)</h3>";
$combined_total = $recommended_total + ($gateway_total ?: 0);
echo "<p>Transactions: " . number_format($recommended_total, 2) . "</p>";
echo "<p>Payment Gateway: " . number_format($gateway_total ?: 0, 2) . "</p>";
echo "<p><strong>Combined Total: " . number_format($combined_total, 2) . "</strong></p>";

// 7. Check dashboard code
echo "<h3>7. Dashboard Code Analysis</h3>";
$dashboard_file = 'system/controllers/dashboard.php';
$dashboard_content = file_get_contents($dashboard_file);

// Check if it's filtering for M-Pesa only
if (strpos($dashboard_content, "->where('method', 'M-Pesa STK Push')") !== false) {
    echo "<p style='color: red; font-weight: bold;'>⚠️ Dashboard is configured to count ONLY M-Pesa payments!</p>";
    echo "<p>This is why you see 39,810 instead of the total amount.</p>";
} else {
    echo "<p>✅ Dashboard is using standard calculation (excluding balance methods).</p>";
}

// 8. Recommendation
echo "<h3>8. Recommendation</h3>";
echo "<div style='background-color: #e7f3ff; padding: 15px; border-radius: 5px;'>";
echo "<p><strong>The issue:</strong> The dashboard is currently configured to show only M-Pesa STK Push payments (39,810) instead of all payment methods.</p>";
echo "<p><strong>Solution:</strong> We need to revert the dashboard to count all payment methods except balance transfers.</p>";
echo "<p><strong>Action:</strong> Run the fix script below to restore proper income calculation.</p>";
echo "</div>";

?>

<h3>Fix Script</h3>
<form method="post" action="fix_income_calculation.php">
    <button type="submit" style="background-color: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">
        Fix Income Calculation
    </button>
</form>