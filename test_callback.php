<?php
  require_once "init.php";

  echo "=== M-PESA CALLBACK ANALYSIS ===\n\n";

  // Check recent M-Pesa payments
  $recent_payments = ORM::for_table("tbl_payment_gateway")
      ->where_raw("paid_date >= DATE_SUB(NOW(), INTERVAL 24 HOUR)")
      ->order_by_desc("paid_date")
      ->find_many();

  echo "Recent M-Pesa payments (last 24 hours):\n";
  foreach ($recent_payments as $payment) {
      echo "- ID: " . $payment->id . ", Status: " . $payment->status . ", Phone: " . $payment->phone_number . ", Amount: " . $payment->price .       
  "\n";
  }

  echo "\n=== CALLBACK URL TEST ===\n";
  $callback_url = $config["web_url"] . "callback/daraja";
  echo "Callback URL should be: " . $callback_url . "\n";

  // Check if callback file exists
  if (file_exists("system/paymentgateway/Daraja.php")) {
      echo "Daraja.php exists\n";
  } else {
      echo "ERROR: Daraja.php missing\n";
  }

  echo "\n=== RECOMMENDATION ===\n";
  echo "1. Test M-Pesa payment manually\n";
  echo "2. Check server logs for callback errors\n";
  echo "3. Verify callback URL is accessible from outside\n";
  ?>
