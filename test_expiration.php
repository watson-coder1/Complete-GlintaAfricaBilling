<?php
require_once 'init.php';

// Test creating a user recharge record
try {
    echo "Testing user recharge creation...\n";
    
    // Get a test plan
    $plan = ORM::for_table('tbl_plans')->limit(1)->find_one();
    if (!$plan) {
        echo "No plans found in database\n";
        exit;
    }
    
    echo "Using plan: {$plan->name_plan}\n";
    echo "Plan type: {$plan->typebp}\n";
    echo "Limit type: {$plan->limit_type}\n";
    echo "Time unit: {$plan->time_unit}\n";
    echo "Time limit: {$plan->time_limit}\n";
    
    // Test creating a recharge
    $recharge = ORM::for_table('tbl_user_recharges')->create();
    
    // Show all required fields
    $sql = "SHOW COLUMNS FROM tbl_user_recharges WHERE `Null` = 'NO' AND `Default` IS NULL";
    $result = ORM::get_db()->query($sql);
    echo "\nRequired fields without defaults:\n";
    foreach ($result as $row) {
        echo "- {$row['Field']}\n";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>