<?php
require_once 'init.php';

// Update the environment setting
$pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
if ($pg) {
    $pgData = json_decode($pg->pg_data, true);
    echo 'Current environment: ' . $pgData['environment'] . "\n";
    $pgData['environment'] = 'live';
    $pg->pg_data = json_encode($pgData);
    $pg->save();
    echo 'Environment updated to: live' . "\n";
    
    // Verify the change
    $updated_pg = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
    $updated_data = json_decode($updated_pg->pg_data, true);
    echo 'Verified environment is now: ' . $updated_data['environment'] . "\n";
} else {
    echo 'Daraja configuration not found' . "\n";
}
?>