<?php

/**
 * Check Dashboard Data Connections
 * Verify all metrics are pulling real data
 */

require_once 'init.php';

echo "<h2>🔍 Checking Dashboard Data Connections</h2>";

// 1. Check Today's Income
echo "<h3>💰 Income Data Check</h3>";

$current_date = date('Y-m-d');
$month_start = date('Y-m-01');

// Today's income - ONLY M-Pesa
$todayIncome = ORM::for_table('tbl_transactions')
    ->where('recharged_on', $current_date)
    ->where('method', 'M-Pesa STK Push')
    ->sum('price');
echo "Today's Income (M-Pesa only): KES " . ($todayIncome ?: 0) . "<br>";

// Month's income - ONLY M-Pesa
$monthIncome = ORM::for_table('tbl_transactions')
    ->where_gte('recharged_on', $month_start)
    ->where_lte('recharged_on', $current_date)
    ->where('method', 'M-Pesa STK Push')
    ->sum('price');
echo "This Month's Income (M-Pesa only): KES " . ($monthIncome ?: 0) . "<br>";

// 2. Check Active/Expired Users
echo "<h3>👥 User Status Check</h3>";

$activeUsers = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->count();
echo "Active Users: " . $activeUsers . "<br>";

$expiredUsers = ORM::for_table('tbl_user_recharges')
    ->where('status', 'off')
    ->count();
echo "Expired Users: " . $expiredUsers . "<br>";

// 3. Check Service-Specific Income Today
echo "<h3>📊 Service-Specific Income (Today)</h3>";

// Hotspot income today
$hotspotIncomeToday = ORM::for_table('tbl_transactions')
    ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'Hotspot')
    ->where('tbl_transactions.recharged_on', $current_date)
    ->where('tbl_transactions.method', 'M-Pesa STK Push')
    ->sum('tbl_transactions.price');
echo "Hotspot Income Today: KES " . ($hotspotIncomeToday ?: 0) . "<br>";

// PPPoE income today
$pppoeIncomeToday = ORM::for_table('tbl_transactions')
    ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'PPPOE')
    ->where('tbl_transactions.recharged_on', $current_date)
    ->where('tbl_transactions.method', 'M-Pesa STK Push')
    ->sum('tbl_transactions.price');
echo "PPPoE Income Today: KES " . ($pppoeIncomeToday ?: 0) . "<br>";

// 4. Check Active Users by Service Type
echo "<h3>🌐 Active Users by Service Type</h3>";

// Check RADIUS connection
if ($config['radius_enable']) {
    try {
        // Hotspot online from RADIUS
        $hotspotOnline = ORM::for_table('radacct', 'radius')
            ->where_null('acctstoptime')
            ->count();
        echo "Hotspot Users Online (RADIUS): " . $hotspotOnline . "<br>";
    } catch (Exception $e) {
        echo "RADIUS Connection Error: " . $e->getMessage() . "<br>";
        echo "Hotspot Users Online: 0 (RADIUS not accessible)<br>";
    }
} else {
    echo "RADIUS is disabled in config<br>";
}

// PPPoE active from customer table
$pppoeActive = ORM::for_table('tbl_customers')
    ->join('tbl_user_recharges', ['tbl_customers.id', '=', 'tbl_user_recharges.customer_id'])
    ->where('tbl_customers.service_type', 'PPPoE')
    ->where('tbl_user_recharges.status', 'on')
    ->count();
echo "PPPoE Active Users: " . $pppoeActive . "<br>";

// 5. Check for data conflicts
echo "<h3>⚠️ Checking for Data Conflicts</h3>";

// Check if total customers equals sum of service types
$totalCustomers = ORM::for_table('tbl_customers')->count();
$hotspotCustomers = ORM::for_table('tbl_customers')->where('service_type', 'Hotspot')->count();
$pppoeCustomers = ORM::for_table('tbl_customers')->where('service_type', 'PPPoE')->count();
$unknownCustomers = ORM::for_table('tbl_customers')->where_null('service_type')->count();

echo "Total Customers: " . $totalCustomers . "<br>";
echo "Hotspot Customers: " . $hotspotCustomers . "<br>";
echo "PPPoE Customers: " . $pppoeCustomers . "<br>";
echo "Unknown Service Type: " . $unknownCustomers . "<br>";

if ($unknownCustomers > 0) {
    echo "⚠️ WARNING: " . $unknownCustomers . " customers have no service type set!<br>";
}

// 6. Check transaction data
echo "<h3>💳 Transaction Data Check</h3>";
$totalTransactions = ORM::for_table('tbl_transactions')->count();
$mpesaTransactions = ORM::for_table('tbl_transactions')
    ->where('method', 'M-Pesa STK Push')
    ->count();
$otherTransactions = ORM::for_table('tbl_transactions')
    ->where_not_equal('method', 'M-Pesa STK Push')
    ->count();

echo "Total Transactions: " . $totalTransactions . "<br>";
echo "M-Pesa Transactions: " . $mpesaTransactions . "<br>";
echo "Other Payment Methods: " . $otherTransactions . "<br>";

// 7. Sample data check
echo "<h3>📝 Recent Transactions (Last 5)</h3>";
$recentTransactions = ORM::for_table('tbl_transactions')
    ->order_by_desc('id')
    ->limit(5)
    ->find_many();

foreach ($recentTransactions as $trans) {
    echo "- " . $trans->username . " | " . $trans->method . " | KES " . $trans->price . " | " . $trans->recharged_on . "<br>";
}

// 8. Fix recommendations
echo "<h3>🔧 Recommendations</h3>";
if ($unknownCustomers > 0) {
    echo "1. Update customers without service_type:<br>";
    echo "<code>UPDATE tbl_customers SET service_type = 'Hotspot' WHERE service_type IS NULL;</code><br>";
}

if ($mpesaTransactions == 0) {
    echo "2. No M-Pesa transactions found. Test the payment gateway to generate real data.<br>";
}

if (!$config['radius_enable']) {
    echo "3. Enable RADIUS in config to track Hotspot online users.<br>";
}

echo "<h3>✅ Data Connection Summary</h3>";
echo "<ul>";
echo "<li><strong>Income Today/Month:</strong> Connected to tbl_transactions (M-Pesa only)</li>";
echo "<li><strong>Active/Expired:</strong> Connected to tbl_user_recharges status</li>";
echo "<li><strong>Service Income:</strong> Connected via plan types in tbl_plans</li>";
echo "<li><strong>Hotspot Online:</strong> " . ($config['radius_enable'] ? "Connected to RADIUS radacct" : "RADIUS disabled") . "</li>";
echo "<li><strong>PPPoE Active:</strong> Connected to customer service_type + recharge status</li>";
echo "</ul>";

?>