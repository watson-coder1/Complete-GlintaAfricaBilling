<?php
require_once "init.php";

// Test loading the payment page components
$sessionId = "portal_687d3e5a2e5022.45445848";

$session = ORM::for_table("tbl_portal_sessions")
    ->where("session_id", $sessionId)
    ->find_one();

if ($session) {
    echo "Session found!\n";

    // Check plan
    $plan = ORM::for_table("tbl_plans")
        ->where("id", $session->plan_id)
        ->find_one();

    if ($plan) {
        echo "Plan found: " . $plan->name_plan . "\n";
    } else {
        echo "Plan NOT found with ID: " . $session->plan_id . "\n";
    }

    // Check payment
    $payment = ORM::for_table("tbl_payment_gateway")
        ->where("id", $session->payment_id)
        ->find_one();

    if ($payment) {
        echo "Payment found - Status: " . $payment->status . "\n";
    } else {
        echo "Payment NOT found with ID: " . $session->payment_id . "\n";
    }
} else {
    echo "Session NOT found\n";
}
