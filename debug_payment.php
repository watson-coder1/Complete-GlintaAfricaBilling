<?php
require_once "init.php";

$session = ORM::for_table("tbl_portal_sessions")
    ->order_by_desc("id")
    ->find_one();

if ($session) {
    echo "Latest session ID: " . $session->session_id . "\n";
    echo "Payment ID: " . $session->payment_id . "\n";
    echo "Status: " . $session->status . "\n";

    if ($session->payment_id) {
        $payment = ORM::for_table("tbl_payment_gateway")
            ->where("id", $session->payment_id)
            ->find_one();

        if ($payment) {
            echo "Payment found - Status: " . $payment->status . "\n";
        } else {
            echo "Payment NOT found with ID: " . $session->payment_id . "\n";
        }
    }
} else {
    echo "No sessions found\n";
}
