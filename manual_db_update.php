<?php
/**
 * Manual Database Update Script
 * Run this to apply all missing database updates
 */

// Load config directly without full boot
require_once 'config.php';

// Create database connection
try {
    $db = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

echo "<h2>Manual Database Update</h2>";

// Get the updates from updates.json
$updates_file = 'system/updates.json';
$updates = json_decode(file_get_contents($updates_file), true);

// Critical updates that need to be applied
$critical_updates = [
    "2024.9.13" => [
        "ALTER TABLE `tbl_plans` CHANGE `type` `type` ENUM('Hotspot','PPPOE','VPN','Balance') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;",
        "ALTER TABLE `tbl_customers` CHANGE `service_type` `service_type` ENUM('Hotspot','PPPoE','VPN','Others') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Others' COMMENT 'For selecting user type';",
        "ALTER TABLE `tbl_transactions` CHANGE `type` `type` ENUM('Hotspot','PPPOE','VPN','Balance') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;",
        "CREATE TABLE IF NOT EXISTS `tbl_port_pool` ( `id` int(10) NOT NULL AUTO_INCREMENT , `public_ip` varchar(40) NOT NULL, `port_name` varchar(40) NOT NULL, `range_port` varchar(40) NOT NULL, `routers` varchar(40) NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;"
    ],
    "2024.10.10" => [
        "ALTER TABLE `tbl_users` ADD `login_token` VARCHAR(40) AFTER `last_login`;"
    ],
    "2024.10.17" => [
        "CREATE TABLE IF NOT EXISTS `tbl_meta` ( `id` int UNSIGNED NOT NULL AUTO_INCREMENT, `tbl` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Table name', `tbl_id` int NOT NULL COMMENT 'table value id', `name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL, `value` mediumtext COLLATE utf8mb4_general_ci, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This Table to add additional data for any table';"
    ],
    "2024.10.30" => [
        "ALTER TABLE `tbl_users` ADD `photo` VARCHAR(128) NOT NULL DEFAULT '/admin.default.png' AFTER `root`;",
        "ALTER TABLE `tbl_users` ADD `data` TEXT NULL DEFAULT NULL COMMENT 'to put additional data' AFTER `status`;"
    ],
    "2024.10.31" => [
        "ALTER TABLE `tbl_customers` ADD `photo` VARCHAR(128) NOT NULL DEFAULT '/user.default.jpg' AFTER `password`;"
    ]
];

// Also create payment gateway table if missing
$additional_tables = [
    "CREATE TABLE IF NOT EXISTS `tbl_pg` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `gateway` varchar(32) NOT NULL,
        `status` tinyint(1) NOT NULL DEFAULT '0',
        `pg_data` text,
        PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
    
    "CREATE TABLE IF NOT EXISTS `tbl_payment_gateway` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `username` varchar(45) NOT NULL,
        `gateway` varchar(20) NOT NULL DEFAULT '',
        `trx_invoice` varchar(25) NOT NULL DEFAULT '',
        `gateway_trx_id` varchar(512) NOT NULL DEFAULT '',
        `plan_id` int(11) NOT NULL,
        `plan_name` varchar(40) NOT NULL,
        `routers_id` int(11) NOT NULL DEFAULT '0',
        `routers` varchar(32) NOT NULL,
        `price` varchar(40) NOT NULL,
        `pg_url_payment` varchar(512) NOT NULL DEFAULT '',
        `pg_request` text,
        `pg_paid_response` text,
        `expired_date` datetime DEFAULT NULL,
        `created_date` datetime NOT NULL,
        `paid_date` datetime DEFAULT NULL,
        `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 unpaid 2 paid 3 failed 4 canceled',
        PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
    
    "CREATE TABLE IF NOT EXISTS `tbl_customers_inbox` (
        `id` int UNSIGNED NOT NULL AUTO_INCREMENT, 
        `customer_id` int NOT NULL, 
        `date_created` datetime NOT NULL, 
        `date_read` datetime DEFAULT NULL, 
        `subject` varchar(64) COLLATE utf8mb4_general_ci NOT NULL, 
        `body` TEXT NULL DEFAULT NULL, 
        `from` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'System' COMMENT 'System or Admin or Else',
        `admin_id` int NOT NULL DEFAULT '0' COMMENT 'other than admin is 0', 
        PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;"
];

$success = 0;
$failed = 0;

// Apply critical updates
foreach ($critical_updates as $version => $queries) {
    echo "<h3>Applying update $version</h3>";
    foreach ($queries as $query) {
        try {
            $db->exec($query);
            echo "<span style='color:green'>✓ Success: " . substr($query, 0, 60) . "...</span><br>";
            $success++;
        } catch (Exception $e) {
            if (strpos($e->getMessage(), 'Duplicate column') !== false || 
                strpos($e->getMessage(), 'already exists') !== false) {
                echo "<span style='color:orange'>⚠ Already exists: " . substr($query, 0, 60) . "...</span><br>";
            } else {
                echo "<span style='color:red'>✗ Failed: " . $e->getMessage() . "</span><br>";
                $failed++;
            }
        }
    }
}

// Apply additional tables
echo "<h3>Creating additional tables</h3>";
foreach ($additional_tables as $query) {
    try {
        $db->exec($query);
        echo "<span style='color:green'>✓ Table created successfully</span><br>";
        $success++;
    } catch (Exception $e) {
        if (strpos($e->getMessage(), 'already exists') !== false) {
            echo "<span style='color:orange'>⚠ Table already exists</span><br>";
        } else {
            echo "<span style='color:red'>✗ Failed: " . $e->getMessage() . "</span><br>";
            $failed++;
        }
    }
}

echo "<hr>";
echo "<h3>Summary:</h3>";
echo "<p>Successfully applied: $success updates</p>";
echo "<p>Failed: $failed updates</p>";
echo "<p><a href='./'>Go to Home</a></p>";