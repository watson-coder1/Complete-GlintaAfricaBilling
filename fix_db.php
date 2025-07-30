<?php
require_once "init.php";
try {
    $cols = ["checkout_request_id", "pg_request", "gateway_trx_id"];
    foreach($cols as $col) {
        $r = ORM::raw_execute("SHOW COLUMNS FROM tbl_payment_gateway WHERE Field = ?", [$col]);
        if (ORM::get_last_statement()->rowCount() == 0) {
            if ($col == "pg_request") {
                ORM::raw_execute("ALTER TABLE tbl_payment_gateway ADD COLUMN $col TEXT");
            } else {
                ORM::raw_execute("ALTER TABLE tbl_payment_gateway ADD COLUMN $col VARCHAR(100) DEFAULT NULL");
            }
            echo "✓ Added $col\n";
        } else {
            echo "✓ $col already exists\n";
        }
    }
    echo "✓ Done!\n";
} catch(Exception $e) { echo "Error: " . $e->getMessage(); }
