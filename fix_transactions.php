<?php

/**
 * Fix Transaction Data for Charts
 * Developed by Watsons Developers (watsonsdevelopers.com)
 */

require_once 'init.php';

echo "Creating sample transaction data...\n";

try {
    // Check existing data
    $existingCount = ORM::for_table('tbl_transactions')->count();
    echo "Existing transactions: $existingCount\n";
    
    if ($existingCount < 10) {
        echo "Creating sample transaction data for charts...\n";
        
        for ($month = 1; $month <= 12; $month++) {
            $numTransactions = rand(5, 15);
            for ($i = 0; $i < $numTransactions; $i++) {
                $transaction = ORM::for_table('tbl_transactions')->create();
                $transaction->invoice = 'SAMPLE_' . time() . '_' . $month . '_' . $i;
                $transaction->username = 'sample_user_' . rand(1, 10);
                $transaction->plan_name = 'Sample Plan ' . rand(1, 3);
                $transaction->price = rand(100, 1000);
                $transaction->recharged_on = date('Y-' . sprintf('%02d', $month) . '-' . sprintf('%02d', rand(1, 28)));
                $transaction->recharged_time = rand(6, 23) . ':' . rand(10, 59) . ':00';
                $transaction->expiration = date('Y-m-d', strtotime('+30 days'));
                $transaction->time = '23:59:59';
                $transaction->method = 'Sample Payment';
                $transaction->routers = 'Sample Router';
                $transaction->type = rand(0, 1) ? 'Hotspot' : 'PPPOE';
                $transaction->note = 'Sample data for charts';
                $transaction->admin_id = 1;
                
                $transaction->save();
            }
            echo "Created transactions for month $month\n";
        }
        
        echo "✅ Sample transaction data created successfully!\n";
    } else {
        echo "✅ Sufficient transaction data already exists\n";
    }
    
    // Verify the data
    $totalCount = ORM::for_table('tbl_transactions')->count();
    echo "Total transactions now: $totalCount\n";
    
    // Test monthly data query
    $monthlyData = ORM::for_table('tbl_transactions')
        ->select_expr('MONTH(recharged_on)', 'month')
        ->select_expr('COUNT(*)', 'count')
        ->select_expr('SUM(price)', 'total')
        ->where_raw('YEAR(recharged_on) = YEAR(CURRENT_DATE())')
        ->group_by_expr('MONTH(recharged_on)')
        ->find_many();
    
    echo "Monthly data available for " . count($monthlyData) . " months\n";
    
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

?>