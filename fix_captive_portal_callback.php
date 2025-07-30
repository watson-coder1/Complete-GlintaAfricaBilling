<?php
require_once "init.php";

echo "Checking captive portal payment flow...\n";

// Check recent captive portal sessions
$sessions = ORM::for_table("tbl_portal_sessions")
    ->order_by_desc("id")
    ->limit(5)
    ->find_many();

echo "\nRecent portal sessions:\n";
foreach ($sessions as $s) {
    echo "Session: {$s->session_id}, MAC: {$s->mac_address}, Payment ID: {$s->payment_id}, Status: {$s->status}\n";
}

// Check if callbacks are being logged
$callback_log = "/var/www/html/captive_portal_callbacks.log";
if (file_exists($callback_log)) {
    echo "\nRecent callbacks:\n";
    echo substr(file_get_contents($callback_log), -500);
} else {
    echo "\nNo callback log found\n";
}

// Update the captive portal controller to use the main callback
$controller = file_get_contents("/var/www/html/system/controllers/captive_portal.php");

// Find the STK push callback URL setting
if (strpos($controller, "CallBackURL") !== false) {
    echo "\nCurrent callback URL in captive portal: ";
    preg_match("/CallBackURL.*?=>.*?[\"']([^\"']+)[\"']/", $controller, $matches);
    if ($matches) {
        echo $matches[1] . "\n";
    }
}

echo "\nTo fix the issue, the captive portal should use the main callback URL.\n";
