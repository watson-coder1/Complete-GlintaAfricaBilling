<?php
  require_once "init.php";

  echo "=== SEARCHING FOR PAYMENT RECORDS ===\n\n";

  $payment_ids = [78, 88, 92, 119];

  foreach ($payment_ids as $id) {
      echo "Checking Payment ID: $id\n";

      // Check by ID field
      $payment_by_id = ORM::for_table("tbl_payment_gateway")
          ->where("id", $id)
          ->find_one();

      if ($payment_by_id) {
          echo "  Found by ID: Status=" . $payment_by_id->status . ", CheckoutID=" . $payment_by_id->checkout_request_id . "\n";
      } else {
          echo "  NOT FOUND by ID\n";
      }

      // Check by checkout_request_id
      $payment_by_checkout = ORM::for_table("tbl_payment_gateway")
          ->where("checkout_request_id", $id)
          ->find_one();

      if ($payment_by_checkout) {
          echo "  Found by CheckoutID: ID=" . $payment_by_checkout->id . ", Status=" . $payment_by_checkout->status . "\n";
      }
  }

  echo "\n=== ALL RECENT PAYMENTS ===\n";
  $all_payments = ORM::for_table("tbl_payment_gateway")
      ->order_by_desc("id")
      ->limit(10)
      ->find_many();

  foreach ($all_payments as $p) {
      echo "ID: " . $p->id . ", CheckoutID: " . $p->checkout_request_id . ", Status: " . $p->status . ", Phone: " . $p->phone_number . "\n";      
  }
  ?>
