<?php
require_once "init.php";

echo "=== PAYMENT HEALING SCRIPT ===\n";
echo "Time: " . date("Y-m-d H:i:s") . "\n\n";

// Find stuck portal sessions
$stuck = ORM::for_table("tbl_portal_sessions")
    ->where("status", "processing")
    ->where_raw("created_at < DATE_SUB(NOW(), INTERVAL 10 MINUTE)")
    ->find_many();

$healed = 0;

foreach ($stuck as $session) {
    echo "Checking session: " . $session->session_id . "\n";

    // Check if payment exists and is paid
    $payment = ORM::for_table("tbl_payment_gateway")
        ->where("checkout_request_id", $session->payment_id)
        ->where("status", 2)
        ->find_one();

    if ($payment) {
        $session->status = "completed";
        $session->save();
        $healed++;
        echo "  - HEALED: Marked as completed\n";
    } else {
        echo "  - No completed payment found\n";
    }
}

echo "\nResult: Healed $healed payments\n";
?>
