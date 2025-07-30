<?php
  require_once "init.php";

  echo "=== DETAILED SESSION ANALYSIS ===\n";

  $stuck = ORM::for_table("tbl_portal_sessions")
      ->where("status", "processing")
      ->where_raw("created_at < DATE_SUB(NOW(), INTERVAL 10 MINUTE)")
      ->find_many();

  foreach ($stuck as $session) {
      echo "\nSession: " . $session->session_id . "\n";
      echo "MAC: " . $session->mac_address . "\n";
      echo "Payment ID: " . $session->payment_id . "\n";
      echo "Created: " . $session->created_at . "\n";

      // Check all payments with this checkout_request_id
      $payments = ORM::for_table("tbl_payment_gateway")
          ->where("checkout_request_id", $session->payment_id)
          ->find_many();

      if (count($payments) > 0) {
          foreach ($payments as $payment) {
              echo "  Payment Status: " . $payment->status . "\n";
              echo "  Phone: " . $payment->phone_number . "\n";
              echo "  Amount: " . $payment->price . "\n";
          }
      } else {
          echo "  No payment record found\n";
      }
  }
  ?>
