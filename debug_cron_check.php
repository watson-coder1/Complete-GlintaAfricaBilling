<?php
/**
 * Debug script to test cron check logic
 */

require_once 'init.php';

$timestampFile = "$UPLOAD_PATH/cron_last_run.txt";
$current_time = time();

echo "=== CRON CHECK DEBUG ===\n";
echo "Timestamp file path: $timestampFile\n";
echo "File exists: " . (file_exists($timestampFile) ? 'YES' : 'NO') . "\n";

if (file_exists($timestampFile)) {
    $file_contents = file_get_contents($timestampFile);
    $lastRunTime = intval($file_contents);
    
    echo "File contents (raw): '$file_contents'\n";
    echo "Parsed timestamp: $lastRunTime\n";
    echo "Current time: $current_time\n";
    echo "Difference (seconds): " . ($current_time - $lastRunTime) . "\n";
    echo "Difference (minutes): " . round(($current_time - $lastRunTime) / 60, 2) . "\n";
    echo "Over 1 hour (3600s)? " . (($current_time - $lastRunTime) > 3600 ? 'YES - SHOW WARNING' : 'NO - OK') . "\n";
    
    // Test the formatted date
    $formatted_date = date('Y-m-d h:i:s A', $lastRunTime);
    echo "Formatted date: $formatted_date\n";
    echo "strtotime of formatted: " . strtotime($formatted_date) . "\n";
    echo "Difference with strtotime: " . ($current_time - strtotime($formatted_date)) . "\n";
    
} else {
    echo "Cron file not found!\n";
}
?>