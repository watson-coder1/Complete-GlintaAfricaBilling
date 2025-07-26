<?php
require_once 'init.php';

echo "Setting up Captive Portal tables...\n";

try {
    // Check if checkout_request_id column exists
    $result = ORM::raw_execute("SHOW COLUMNS FROM tbl_payment_gateway WHERE Field = 'checkout_request_id'");
    $statement = ORM::get_last_statement();
    if ($statement->rowCount() == 0) {
        ORM::raw_execute("ALTER TABLE tbl_payment_gateway ADD COLUMN checkout_request_id varchar(100) DEFAULT NULL");
        echo "✓ Added checkout_request_id column\n";
    } else {
        echo "✓ checkout_request_id column already exists\n";
    }

    // Check if pg_request column exists
    $result = ORM::raw_execute("SHOW COLUMNS FROM tbl_payment_gateway WHERE Field = 'pg_request'");
    $statement = ORM::get_last_statement();
    if ($statement->rowCount() == 0) {
        ORM::raw_execute("ALTER TABLE tbl_payment_gateway ADD COLUMN pg_request text");
        echo "✓ Added pg_request column\n";
    } else {
        echo "✓ pg_request column already exists\n";
    }

    // Check if gateway_trx_id column exists
    $result = ORM::raw_execute("SHOW COLUMNS FROM tbl_payment_gateway WHERE Field = 'gateway_trx_id'");
    $statement = ORM::get_last_statement();
    if ($statement->rowCount() == 0) {
        ORM::raw_execute("ALTER TABLE tbl_payment_gateway ADD COLUMN gateway_trx_id varchar(100) DEFAULT NULL");
        echo "✓ Added gateway_trx_id column\n";
    } else {
        echo "✓ gateway_trx_id column already exists\n";
    }

    // Check if auto_renewal column exists in tbl_customers
    $result = ORM::raw_execute("SHOW COLUMNS FROM tbl_customers WHERE Field = 'auto_renewal'");
    $statement = ORM::get_last_statement();
    if ($statement->rowCount() == 0) {
        ORM::raw_execute("ALTER TABLE tbl_customers ADD COLUMN auto_renewal tinyint(1) DEFAULT 0");
        echo "✓ Added auto_renewal column\n";
    } else {
        echo "✓ auto_renewal column already exists\n";
    }

    echo "\n✓ Database setup completed!\n";
    echo "\nNext: Set up cron job on host:\n";
    echo "* * * * * docker exec glinta-web-prod php /var/www/html/captive_portal_session_monitor.php\n";

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
