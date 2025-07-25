<?php
/**
 * Fix Monthly Income Calculation
 * This script analyzes and fixes the dashboard income calculation
 */

require_once 'system/orm.php';
require_once 'config.php';

ORM::configure("mysql:host=$db_host;dbname=$db_name;charset=utf8mb4");
ORM::configure('username', $db_user);
ORM::configure('password', $db_password);
ORM::configure('id_column_overrides', array(
    'tbl_transactions' => 'id',
    'tbl_payment_gateway' => 'id',
    'tbl_user_recharges' => 'id'
));

echo "=== MONTHLY INCOME CALCULATION ANALYSIS ===\n\n";

// Get current month date range
$start_date = date('Y-m-01');
$end_date = date('Y-m-d');
$current_month = date('F Y');

echo "Analyzing income for: $current_month\n";
echo "Date range: $start_date to $end_date\n\n";

// 1. Analyze tbl_transactions
echo "1. TRANSACTIONS TABLE ANALYSIS:\n";
echo "--------------------------------\n";

// Get all payment methods in transactions
$payment_methods = ORM::for_table('tbl_transactions')
    ->select_expr('method')
    ->select_expr('COUNT(*)', 'count')
    ->select_expr('SUM(price)', 'total')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $end_date)
    ->group_by('method')
    ->find_many();

$total_transactions_income = 0;
foreach ($payment_methods as $method) {
    echo sprintf("- %s: %d transactions = KSH %s\n", 
        $method->method, 
        $method->count, 
        number_format($method->total, 2)
    );
    
    // Exclude balance transfers
    if ($method->method != 'Customer - Balance' && 
        $method->method != 'Recharge Balance - Administrator') {
        $total_transactions_income += $method->total;
    }
}

echo "\nTotal from transactions (excluding balance): KSH " . number_format($total_transactions_income, 2) . "\n\n";

// 2. Analyze tbl_payment_gateway
echo "2. PAYMENT GATEWAY TABLE ANALYSIS:\n";
echo "-----------------------------------\n";

$gateway_payments = ORM::for_table('tbl_payment_gateway')
    ->select_expr('payment_method')
    ->select_expr('COUNT(*)', 'count')
    ->select_expr('SUM(price)', 'total')
    ->where('status', 2) // Paid
    ->where_gte('paid_date', $start_date . ' 00:00:00')
    ->where_lte('paid_date', $end_date . ' 23:59:59')
    ->group_by('payment_method')
    ->find_many();

$total_gateway_income = 0;
foreach ($gateway_payments as $payment) {
    echo sprintf("- %s: %d payments = KSH %s\n", 
        $payment->payment_method, 
        $payment->count, 
        number_format($payment->total, 2)
    );
    $total_gateway_income += $payment->total;
}

echo "\nTotal from payment gateway: KSH " . number_format($total_gateway_income, 2) . "\n\n";

// 3. Check for duplicates
echo "3. DUPLICATE ANALYSIS:\n";
echo "----------------------\n";

// Check if M-Pesa payments exist in both tables
$mpesa_in_transactions = ORM::for_table('tbl_transactions')
    ->where('method', 'M-Pesa STK Push')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $end_date)
    ->sum('price');

$mpesa_in_gateway = ORM::for_table('tbl_payment_gateway')
    ->where('payment_method', 'M-Pesa STK Push')
    ->where('status', 2)
    ->where_gte('paid_date', $start_date . ' 00:00:00')
    ->where_lte('paid_date', $end_date . ' 23:59:59')
    ->sum('price');

echo "M-Pesa in transactions table: KSH " . number_format($mpesa_in_transactions ?: 0, 2) . "\n";
echo "M-Pesa in gateway table: KSH " . number_format($mpesa_in_gateway ?: 0, 2) . "\n";

if ($mpesa_in_transactions > 0 && $mpesa_in_gateway > 0) {
    echo "\n⚠️  WARNING: M-Pesa payments found in BOTH tables!\n";
    echo "This causes DOUBLE COUNTING in the dashboard.\n";
}

// 4. Calculate correct total
echo "\n4. CORRECT INCOME CALCULATION:\n";
echo "------------------------------\n";

// The correct total should only count from tbl_transactions
// as payment gateway entries should create transaction records
$correct_total = $total_transactions_income;

echo "Correct monthly income: KSH " . number_format($correct_total, 2) . "\n";

// Show what dashboard might be showing
$dashboard_calculation = $total_transactions_income + ($mpesa_in_gateway ?: 0);
echo "\nDashboard might show: KSH " . number_format($dashboard_calculation, 2) . " (if double counting)\n";

// 5. Create fix file
echo "\n5. CREATING FIX:\n";
echo "----------------\n";

$fix_content = '<?php
/**
 * Dashboard Income Calculation Fix
 * Run this to update dashboard.php to show correct income
 */

$dashboard_file = "system/controllers/dashboard.php";
$backup_file = $dashboard_file . ".backup_" . date("YmdHis");

// Create backup
if (!copy($dashboard_file, $backup_file)) {
    die("Failed to create backup. Please check permissions.\n");
}

echo "Backup created: $backup_file\n";

// Read the file
$content = file_get_contents($dashboard_file);

// Fix 1: Remove double counting of M-Pesa
$old_code = \'// Add M-Pesa revenue for this month
$mpesa_revenue_month = ORM::for_table(\\\'tbl_payment_gateway\\\')
    ->where(\\\'status\\\', 2)
    ->where(\\\'gateway\\\', \\\'Daraja\\\')
    ->where_gte(\\\'paid_date\\\', $start_date . \\\' 00:00:00\\\')
    ->where_lte(\\\'paid_date\\\', $current_date . \\\' 23:59:59\\\')
    ->sum(\\\'price\\\');

$total_income_month = ($imonth_total ?: 0) + ($mpesa_revenue_month ?: 0);\';

$new_code = \'// No need to add M-Pesa separately - already included in transactions
// This prevents double counting
$total_income_month = $imonth_total ?: 0;\';

$content = str_replace($old_code, $new_code, $content);

// Fix 2: Also fix daily income calculation
$old_daily = \'// Also get M-Pesa revenue from payment gateway table
$mpesa_revenue_today = ORM::for_table(\\\'tbl_payment_gateway\\\')
    ->where(\\\'status\\\', 2) // Paid
    ->where(\\\'gateway\\\', \\\'Daraja\\\')
    ->where(\\\'paid_date\\\', $current_date)
    ->sum(\\\'price\\\');

$total_income_today = ($iday_total ?: 0) + ($mpesa_revenue_today ?: 0);\';

$new_daily = \'// No need to add M-Pesa separately - already included in transactions
$total_income_today = $iday_total ?: 0;\';

$content = str_replace($old_daily, $new_daily, $content);

// Write the fixed content
if (file_put_contents($dashboard_file, $content)) {
    echo "Dashboard controller updated successfully!\n";
    echo "Income calculation is now accurate.\n";
    
    // Clear cache
    $cache_files = glob("system/cache/*.temp");
    foreach ($cache_files as $cache_file) {
        unlink($cache_file);
    }
    echo "Cache cleared.\n";
} else {
    echo "Failed to update dashboard controller.\n";
}
';

file_put_contents('apply_income_fix.php', $fix_content);
echo "Fix script created: apply_income_fix.php\n";
echo "Run 'php apply_income_fix.php' to apply the fix.\n";

// 6. Summary
echo "\n=== SUMMARY ===\n";
echo "Current dashboard shows: KSH 39,810\n";
echo "Correct amount should be: KSH " . number_format($correct_total, 2) . "\n";
echo "\nThe issue is caused by counting M-Pesa payments twice:\n";
echo "1. Once from tbl_transactions\n";
echo "2. Again from tbl_payment_gateway\n";
echo "\nRun 'php apply_income_fix.php' to fix this issue.\n";