<?php
  require_once "init.php";

  echo "=== FIXED PAYMENT HEALING SCRIPT ===\n";

  // Find stuck sessions
  $stuck_sessions = ORM::for_table("tbl_portal_sessions")
      ->where("status", "processing")
      ->find_many();

  $healed = 0;
  $failed = 0;

  foreach ($stuck_sessions as $session) {
      echo "\nChecking session: " . $session->session_id . "\n";
      echo "Payment ID: " . $session->payment_id . "\n";

      // Look for payment by ID (not checkout_request_id)
      $payment = ORM::for_table("tbl_payment_gateway")
          ->where("id", $session->payment_id)
          ->find_one();

      if ($payment) {
          echo "Payment Status: " . $payment->status . "\n";

          if ($payment->status == 2) {
              // Payment successful - mark as completed
              $session->status = "completed";
              $session->save();
              $healed++;
              echo "✅ HEALED: Marked as completed\n";
          } else {
              // Payment failed or pending - mark as failed
              $session->status = "failed";
              $session->save();
              $failed++;
              echo "❌ FAILED: Payment status " . $payment->status . "\n";
          }
      } else {
          // No payment record - mark as failed
          $session->status = "failed";
          $session->save();
          $failed++;
          echo "❌ FAILED: No payment record\n";
      }
  }

  echo "\n=== RESULTS ===\n";
  echo "Healed (successful): $healed\n";
  echo "Failed (unsuccessful): $failed\n";
  echo "Users will now see appropriate success/failure messages\n";
  ?>
