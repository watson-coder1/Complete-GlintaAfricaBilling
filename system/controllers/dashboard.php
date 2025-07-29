<?php

/**
 *  PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *  by https://t.me/ibnux
 **/

_admin();
$ui->assign('_title', Lang::T('Dashboard'));
$ui->assign('_admin', $admin);

if (isset($_GET['refresh'])) {
    $files = scandir($CACHE_PATH);
    foreach ($files as $file) {
        $ext = pathinfo($file, PATHINFO_EXTENSION);
        if (is_file($CACHE_PATH . DIRECTORY_SEPARATOR . $file) && $ext == 'temp') {
            unlink($CACHE_PATH . DIRECTORY_SEPARATOR . $file);
        }
    }
    r2(U . 'dashboard', 's', 'Data Refreshed');
}

$reset_day = $config['reset_day'];
if (empty($reset_day)) {
    $reset_day = 1;
}
//first day of month
if (date("d") >= $reset_day) {
    $start_date = date('Y-m-' . $reset_day);
} else {
    $start_date = date('Y-m-' . $reset_day, strtotime("-1 MONTH"));
}

$current_date = date('Y-m-d');
$month_n = date('n');

$iday = ORM::for_table('tbl_transactions')
    ->where('recharged_on', $current_date)
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->sum('price');

if ($iday == '') {
    $iday = '0.00';
}
$ui->assign('iday', $iday);

$imonth = ORM::for_table('tbl_transactions')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)->sum('price');
if ($imonth == '') {
    $imonth = '0.00';
}
$ui->assign('imonth', $imonth);

if ($config['enable_balance'] == 'yes'){
    $cb = ORM::for_table('tbl_customers')->whereGte('balance', 0)->sum('balance');
    $ui->assign('cb', $cb);
}

// FIXED: Active users must not be expired (date validation added)
$u_act = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_gte('expiration', $current_date)
    ->count();
if (empty($u_act)) {
    $u_act = '0';
}
$ui->assign('u_act', $u_act);

// FIXED: Count expired users separately for accurate display
$u_expired = ORM::for_table('tbl_user_recharges')
    ->where('status', 'off')
    ->count();
if (empty($u_expired)) {
    $u_expired = '0';
}
$ui->assign('u_expired', $u_expired);

// Keep u_all for backward compatibility but clarify its meaning
$u_all = ORM::for_table('tbl_user_recharges')->count();
if (empty($u_all)) {
    $u_all = '0';
}
$ui->assign('u_all', $u_all);


$c_all = ORM::for_table('tbl_customers')->count();
if (empty($c_all)) {
    $c_all = '0';
}
$ui->assign('c_all', $c_all);

if ($config['hide_uet'] != 'yes') {
    //user expire with M-Pesa payment details - ordered by most recent first
    $query = ORM::for_table('tbl_user_recharges')
        ->select('tbl_user_recharges.*')
        ->select('tbl_payment_gateway.mpesa_phone_number', 'phone_number')
        ->select('tbl_payment_gateway.mpesa_receipt_number', 'receipt_number')
        ->left_outer_join('tbl_payment_gateway', ['tbl_user_recharges.username', '=', 'tbl_payment_gateway.username'])
        ->where_lte('tbl_user_recharges.expiration', $current_date)
        ->order_by_desc('tbl_user_recharges.recharged_on')
        ->order_by_desc('tbl_user_recharges.recharged_time');
    $expire = Paginator::findMany($query);

    // Get the total count of expired records for pagination
    $totalCount = ORM::for_table('tbl_user_recharges')
        ->where_lte('expiration', $current_date)
        ->count();

    // Pass the total count and current page to the paginator
    $paginator['total_count'] = $totalCount;

    // Assign the pagination HTML to the template variable
    $ui->assign('expire', $expire);
}

//activity log
$dlog = ORM::for_table('tbl_logs')->limit(5)->order_by_desc('id')->find_many();
$ui->assign('dlog', $dlog);
$log = ORM::for_table('tbl_logs')->count();
$ui->assign('log', $log);


if ($config['hide_vs'] != 'yes') {
    $cacheStocksfile = $CACHE_PATH . File::pathFixer('/VoucherStocks.temp');
    $cachePlanfile = $CACHE_PATH . File::pathFixer('/VoucherPlans.temp');
    //Cache for 5 minutes
    if (file_exists($cacheStocksfile) && time() - filemtime($cacheStocksfile) < 600) {
        $stocks = json_decode(file_get_contents($cacheStocksfile), true);
        $plans = json_decode(file_get_contents($cachePlanfile), true);
    } else {
        // Count stock
        $tmp = $v = ORM::for_table('tbl_plans')->select('id')->select('name_plan')->find_many();
        $plans = array();
        $stocks = array("used" => 0, "unused" => 0);
        $n = 0;
        foreach ($tmp as $plan) {
            $unused = ORM::for_table('tbl_voucher')
                ->where('id_plan', $plan['id'])
                ->where('status', 0)->count();
            $used = ORM::for_table('tbl_voucher')
                ->where('id_plan', $plan['id'])
                ->where('status', 1)->count();
            if ($unused > 0 || $used > 0) {
                $plans[$n]['name_plan'] = $plan['name_plan'];
                $plans[$n]['unused'] = $unused;
                $plans[$n]['used'] = $used;
                $stocks["unused"] += $unused;
                $stocks["used"] += $used;
                $n++;
            }
        }
        file_put_contents($cacheStocksfile, json_encode($stocks));
        file_put_contents($cachePlanfile, json_encode($plans));
    }
}

$cacheMRfile = File::pathFixer('/monthlyRegistered.temp');
//Cache for 1 hour
if (file_exists($cacheMRfile) && time() - filemtime($cacheMRfile) < 3600) {
    $monthlyRegistered = json_decode(file_get_contents($cacheMRfile), true);
} else {
    //Monthly Registered Customers
    $result = ORM::for_table('tbl_customers')
        ->select_expr('MONTH(created_at)', 'month')
        ->select_expr('COUNT(*)', 'count')
        ->where_raw('YEAR(created_at) = YEAR(NOW())')
        ->group_by_expr('MONTH(created_at)')
        ->find_many();

    $monthlyRegistered = [];
    foreach ($result as $row) {
        $monthlyRegistered[] = [
            'date' => $row->month,
            'count' => $row->count
        ];
    }
    file_put_contents($cacheMRfile, json_encode($monthlyRegistered));
}

// Monthly Registered Customers by Service Type (Hotspot/PPPoE) - Real Data
$cacheMRServicefile = $CACHE_PATH . File::pathFixer('/monthlyRegisteredByService.temp');
//Cache for 1 hour
if (file_exists($cacheMRServicefile) && time() - filemtime($cacheMRServicefile) < 3600) {
    $monthlyRegisteredByService = json_decode(file_get_contents($cacheMRServicefile), true);
} else {
    // Hotspot Registrations
    $hotspotResult = ORM::for_table('tbl_customers')
        ->select_expr('MONTH(created_at)', 'month')
        ->select_expr('COUNT(*)', 'count')
        ->where('service_type', 'Hotspot')
        ->where_raw('YEAR(created_at) = YEAR(NOW())')
        ->group_by_expr('MONTH(created_at)')
        ->find_many();

    // PPPoE Registrations
    $pppoeResult = ORM::for_table('tbl_customers')
        ->select_expr('MONTH(created_at)', 'month')
        ->select_expr('COUNT(*)', 'count')
        ->where('service_type', 'PPPoE')
        ->where_raw('YEAR(created_at) = YEAR(NOW())')
        ->group_by_expr('MONTH(created_at)')
        ->find_many();

    // Initialize arrays for all 12 months
    $monthlyRegisteredByService = [
        'hotspot' => [],
        'pppoe' => []
    ];

    // Fill hotspot data
    $hotspotData = [];
    foreach ($hotspotResult as $row) {
        $hotspotData[$row->month] = $row->count;
    }

    // Fill pppoe data
    $pppoeData = [];
    foreach ($pppoeResult as $row) {
        $pppoeData[$row->month] = $row->count;
    }

    // Create complete month arrays with zero defaults
    for ($month = 1; $month <= 12; $month++) {
        $monthlyRegisteredByService['hotspot'][] = [
            'month' => $month,
            'count' => isset($hotspotData[$month]) ? $hotspotData[$month] : 0
        ];
        $monthlyRegisteredByService['pppoe'][] = [
            'month' => $month,
            'count' => isset($pppoeData[$month]) ? $pppoeData[$month] : 0
        ];
    }

    file_put_contents($cacheMRServicefile, json_encode($monthlyRegisteredByService));
}

$cacheMSfile = $CACHE_PATH . File::pathFixer('/monthlySales.temp');
//Cache for 12 hours
if (file_exists($cacheMSfile) && time() - filemtime($cacheMSfile) < 43200) {
    $monthlySales = json_decode(file_get_contents($cacheMSfile), true);
} else {
    // Query to retrieve monthly data
    $results = ORM::for_table('tbl_transactions')
        ->select_expr('MONTH(recharged_on)', 'month')
        ->select_expr('SUM(price)', 'total')
        ->where_raw("YEAR(recharged_on) = YEAR(CURRENT_DATE())") // Filter by the current year
        ->where_not_equal('method', 'Customer - Balance')
        ->where_not_equal('method', 'Recharge Balance - Administrator')
        ->group_by_expr('MONTH(recharged_on)')
        ->find_many();

    // Create an array to hold the monthly sales data
    $monthlySales = array();

    // Iterate over the results and populate the array
    foreach ($results as $result) {
        $month = $result->month;
        $totalSales = $result->total;

        $monthlySales[$month] = array(
            'month' => $month,
            'totalSales' => $totalSales
        );
    }

    // Fill in missing months with zero sales
    for ($month = 1; $month <= 12; $month++) {
        if (!isset($monthlySales[$month])) {
            $monthlySales[$month] = array(
                'month' => $month,
                'totalSales' => 0
            );
        }
    }

    // Sort the array by month
    ksort($monthlySales);

    // Reindex the array
    $monthlySales = array_values($monthlySales);
    file_put_contents($cacheMSfile, json_encode($monthlySales));
}

// Monthly Sales by Service Type (Hotspot/PPPoE) - Real Data from Transactions
$cacheMSServicefile = $CACHE_PATH . File::pathFixer('/monthlySalesByService.temp');
//Cache for 12 hours
if (file_exists($cacheMSServicefile) && time() - filemtime($cacheMSServicefile) < 43200) {
    $monthlySalesByService = json_decode(file_get_contents($cacheMSServicefile), true);
} else {
    // Hotspot Sales (Real transactions from M-Pesa/payments)
    $hotspotSalesResult = ORM::for_table('tbl_transactions')
        ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
        ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
        ->select_expr('MONTH(tbl_transactions.recharged_on)', 'month')
        ->select_expr('SUM(tbl_transactions.price)', 'total')
        ->where('tbl_plans.type', 'Hotspot')
        ->where_raw('YEAR(tbl_transactions.recharged_on) = YEAR(NOW())')
        ->where_not_equal('tbl_transactions.method', 'Customer - Balance')
        ->where_not_equal('tbl_transactions.method', 'Recharge Balance - Administrator')
        ->group_by_expr('MONTH(tbl_transactions.recharged_on)')
        ->find_many();

    // PPPoE Sales (Real transactions from M-Pesa/payments)
    $pppoeSalesResult = ORM::for_table('tbl_transactions')
        ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
        ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
        ->select_expr('MONTH(tbl_transactions.recharged_on)', 'month')
        ->select_expr('SUM(tbl_transactions.price)', 'total')
        ->where('tbl_plans.type', 'PPPOE')
        ->where_raw('YEAR(tbl_transactions.recharged_on) = YEAR(NOW())')
        ->where_not_equal('tbl_transactions.method', 'Customer - Balance')
        ->where_not_equal('tbl_transactions.method', 'Recharge Balance - Administrator')
        ->group_by_expr('MONTH(tbl_transactions.recharged_on)')
        ->find_many();

    // Initialize arrays
    $monthlySalesByService = [
        'hotspot' => [],
        'pppoe' => []
    ];

    // Process hotspot sales data
    $hotspotSalesData = [];
    foreach ($hotspotSalesResult as $row) {
        $hotspotSalesData[$row->month] = $row->total ? $row->total : 0;
    }

    // Process pppoe sales data
    $pppoeSalesData = [];
    foreach ($pppoeSalesResult as $row) {
        $pppoeSalesData[$row->month] = $row->total ? $row->total : 0;
    }

    // Create complete month arrays with zero defaults
    for ($month = 1; $month <= 12; $month++) {
        $monthlySalesByService['hotspot'][] = [
            'month' => $month,
            'totalSales' => isset($hotspotSalesData[$month]) ? $hotspotSalesData[$month] : 0
        ];
        $monthlySalesByService['pppoe'][] = [
            'month' => $month,
            'totalSales' => isset($pppoeSalesData[$month]) ? $pppoeSalesData[$month] : 0
        ];
    }

    file_put_contents($cacheMSServicefile, json_encode($monthlySalesByService));
}

if ($config['router_check']) {
    $routeroffs = ORM::for_table('tbl_routers')->selects(['id', 'name', 'last_seen'])->where('status', 'Offline')->where('enabled', '1')->order_by_desc('name')->find_array();
    $ui->assign('routeroffs', $routeroffs);
}

$timestampFile = "$UPLOAD_PATH/cron_last_run.txt";
if (file_exists($timestampFile)) {
    $lastRunTime = intval(file_get_contents($timestampFile));
    $ui->assign('run_date', date('Y-m-d h:i:s A', $lastRunTime));
    $ui->assign('cron_last_run_timestamp', $lastRunTime);
}

// Real-time Active Users by Service Type
$cacheActiveUsersfile = $CACHE_PATH . File::pathFixer('/activeUsersByService.temp');
//Cache for 5 minutes (real-time data)
if (file_exists($cacheActiveUsersfile) && time() - filemtime($cacheActiveUsersfile) < 300) {
    $activeUsersByService = json_decode(file_get_contents($cacheActiveUsersfile), true);
} else {
    $activeUsersByService = [
        'hotspot_online' => 0,
        'pppoe_active' => 0,
        'hotspot_expired' => 0,
        'pppoe_expired' => 0
    ];

    // Hotspot Online Users (from RADIUS radacct table - Real active sessions)
    if ($config['radius_enable']) {
        try {
            $activeUsersByService['hotspot_online'] = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->count();
        } catch (Exception $e) {
            $activeUsersByService['hotspot_online'] = 0;
        }
    }

    // PPPoE Active Users (from customer table - Real active subscriptions)
    $activeUsersByService['pppoe_active'] = ORM::for_table('tbl_customers')
        ->where('service_type', 'PPPoE')
        ->where('status', 'Active')
        ->count();

    // FIXED: Hotspot Expired Users (proper join with plans table)
    $activeUsersByService['hotspot_expired'] = ORM::for_table('tbl_user_recharges')
        ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
        ->where('tbl_plans.type', 'Hotspot')
        ->where('tbl_user_recharges.status', 'off')
        ->where_lt('tbl_user_recharges.expiration', $current_date)
        ->count();

    // FIXED: PPPoE Expired Users (consistent with other counting methods)
    $activeUsersByService['pppoe_expired'] = ORM::for_table('tbl_user_recharges')
        ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
        ->where('tbl_plans.type', 'PPPOE')
        ->where('tbl_user_recharges.status', 'off')
        ->where_lt('tbl_user_recharges.expiration', $current_date)
        ->count();

    file_put_contents($cacheActiveUsersfile, json_encode($activeUsersByService));
}

// Today's Income by Service Type (Real-time)
$todayIncomeByService = [
    'hotspot' => 0,
    'pppoe' => 0
];

// Hotspot income today
$hotspotIncomeToday = ORM::for_table('tbl_transactions')
    ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'Hotspot')
    ->where('tbl_transactions.recharged_on', $current_date)
    ->where_not_equal('tbl_transactions.method', 'Customer - Balance')
    ->where_not_equal('tbl_transactions.method', 'Recharge Balance - Administrator')
    ->sum('tbl_transactions.price');

$todayIncomeByService['hotspot'] = $hotspotIncomeToday ?: 0;

// PPPoE income today
$pppoeIncomeToday = ORM::for_table('tbl_transactions')
    ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'PPPOE')
    ->where('tbl_transactions.recharged_on', $current_date)
    ->where_not_equal('tbl_transactions.method', 'Customer - Balance')
    ->where_not_equal('tbl_transactions.method', 'Recharge Balance - Administrator')
    ->sum('tbl_transactions.price');

$todayIncomeByService['pppoe'] = $pppoeIncomeToday ?: 0;

// Assign the monthly sales data to Smarty
$ui->assign('start_date', $start_date);
$ui->assign('current_date', $current_date);
$ui->assign('monthlySales', $monthlySales);
$ui->assign('xfooter', '');
$ui->assign('monthlyRegistered', $monthlyRegistered);
$ui->assign('stocks', $stocks);
$ui->assign('plans', $plans);

// Assign new service-specific analytics data
$ui->assign('monthlyRegisteredByService', $monthlyRegisteredByService);
$ui->assign('monthlySalesByService', $monthlySalesByService);
$ui->assign('activeUsersByService', $activeUsersByService);
$ui->assign('todayIncomeByService', $todayIncomeByService);

// =======================================================================
// REAL DATA INTEGRATION FOR ALL 8 DASHBOARD BOXES
// =======================================================================

// 1. HOTSPOT INCOME TODAY (from M-Pesa payments + manual recharges)
$hotspot_income_today = 0;

// From M-Pesa payments for Hotspot plans
$mpesa_hotspot_income = ORM::for_table('tbl_payment_gateway')
    ->join('tbl_plans', ['tbl_payment_gateway.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_payment_gateway.status', 2) // Paid
    ->where('tbl_payment_gateway.gateway', 'Daraja')
    ->where('tbl_plans.type', 'Hotspot')
    ->where_gte('tbl_payment_gateway.paid_date', $current_date . ' 00:00:00')
    ->where_lte('tbl_payment_gateway.paid_date', $current_date . ' 23:59:59')
    ->sum('tbl_payment_gateway.price');

// From manual transactions for Hotspot plans
$manual_hotspot_income = ORM::for_table('tbl_transactions')
    ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'Hotspot')
    ->where('tbl_transactions.recharged_on', $current_date)
    ->where_not_equal('tbl_transactions.method', 'Customer - Balance')
    ->sum('tbl_transactions.price');

// Only use transactions table to avoid double counting
$hotspot_income_today = $manual_hotspot_income ?: 0;

// 2. PPPOE INCOME TODAY (from M-Pesa payments + manual recharges)
$pppoe_income_today = 0;

// From M-Pesa payments for PPPoE plans
$mpesa_pppoe_income = ORM::for_table('tbl_payment_gateway')
    ->join('tbl_plans', ['tbl_payment_gateway.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_payment_gateway.status', 2) // Paid
    ->where('tbl_payment_gateway.gateway', 'Daraja')
    ->where('tbl_plans.type', 'PPPoE')
    ->where_gte('tbl_payment_gateway.paid_date', $current_date . ' 00:00:00')
    ->where_lte('tbl_payment_gateway.paid_date', $current_date . ' 23:59:59')
    ->sum('tbl_payment_gateway.price');

// From manual transactions for PPPoE plans
$manual_pppoe_income = ORM::for_table('tbl_transactions')
    ->join('tbl_user_recharges', ['tbl_transactions.invoice', '=', 'tbl_user_recharges.id'])
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'PPPoE')
    ->where('tbl_transactions.recharged_on', $current_date)
    ->where_not_equal('tbl_transactions.method', 'Customer - Balance')
    ->sum('tbl_transactions.price');

// Only use transactions table to avoid double counting
$pppoe_income_today = $manual_pppoe_income ?: 0;

// 3. HOTSPOT ONLINE USERS (from RADIUS radacct table - real active sessions)
$radius_online_hotspot = 0;

if ($config['radius_enable'] == 'yes' && !empty($config['radius_host'])) {
    try {
        // FIXED: Get active sessions from RADIUS with proper expiration check
        $radius_hotspot_sessions = ORM::for_table('radacct', 'radius')
            ->join('tbl_user_recharges', ['radacct.username', '=', 'tbl_user_recharges.username'], 'radius')
            ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'], 'radius')
            ->where_null('radacct.acctstoptime')
            ->where('tbl_plans.type', 'Hotspot')
            ->where('tbl_user_recharges.status', 'on')
            ->where_gte('tbl_user_recharges.expiration', $current_date)
            ->count();
        
        $radius_online_hotspot = $radius_hotspot_sessions;
    } catch (Exception $e) {
        // FIXED: Fallback with proper date validation
        $radius_online_hotspot = ORM::for_table('tbl_user_recharges')
            ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
            ->where('tbl_plans.type', 'Hotspot')
            ->where('tbl_user_recharges.status', 'on')
            ->where_gte('tbl_user_recharges.expiration', $current_date)
            ->count();
    }
} else {
    // FIXED: Fallback when RADIUS is disabled
    $radius_online_hotspot = ORM::for_table('tbl_user_recharges')
        ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
        ->where('tbl_plans.type', 'Hotspot')
        ->where('tbl_user_recharges.status', 'on')
        ->where_gte('tbl_user_recharges.expiration', $current_date)
        ->count();
}

// 4. PPPOE ACTIVE USERS (from user_recharges + customer status) - FIXED
$pppoe_active = ORM::for_table('tbl_user_recharges')
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->join('tbl_customers', ['tbl_user_recharges.customer_id', '=', 'tbl_customers.id'])
    ->where('tbl_plans.type', 'PPPOE')
    ->where('tbl_user_recharges.status', 'on')
    ->where('tbl_customers.status', 'Active')
    ->where_gte('tbl_user_recharges.expiration', $current_date)
    ->count();

$ui->assign('hotspot_income_today', $hotspot_income_today);
$ui->assign('pppoe_income_today', $pppoe_income_today);
$ui->assign('radius_online_hotspot', $radius_online_hotspot);
$ui->assign('pppoe_active', $pppoe_active);

// =======================================================================
// VERIFY TOP 4 BOXES ARE ALSO USING REAL DATA
// =======================================================================

// Re-verify Income Today includes M-Pesa transactions
$iday_total = ORM::for_table('tbl_transactions')
    ->where('recharged_on', $current_date)
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->sum('price');

// No need to add M-Pesa separately - it's already included in tbl_transactions
// This prevents double counting of M-Pesa payments
$total_income_today = $iday_total ?: 0;

// Update the iday variable to include M-Pesa
$ui->assign('iday', $total_income_today);

// Re-verify Income This Month includes M-Pesa transactions
$imonth_total = ORM::for_table('tbl_transactions')
    ->where_not_equal('method', 'Customer - Balance')
    ->where_not_equal('method', 'Recharge Balance - Administrator')
    ->where_gte('recharged_on', $start_date)
    ->where_lte('recharged_on', $current_date)
    ->sum('price');

// No need to add M-Pesa separately - it's already included in tbl_transactions
// This prevents double counting of M-Pesa payments
$total_income_month = $imonth_total ?: 0;

// Update the imonth variable to include M-Pesa
$ui->assign('imonth', $total_income_month);

// =======================================================================
// END REAL DATA INTEGRATION
// =======================================================================

run_hook('view_dashboard'); #HOOK
$ui->display('dashboard.tpl');
