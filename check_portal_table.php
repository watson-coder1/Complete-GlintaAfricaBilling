<?php
/**
 * Check if portal sessions table exists and create if missing
 */

require_once 'init.php';

echo "=== Portal Sessions Table Check ===\n";

try {
    // Try to query the table
    $test = ORM::for_table('tbl_portal_sessions')->limit(1)->find_one();
    echo "✅ tbl_portal_sessions table exists\n";
    
    // Count existing sessions
    $count = ORM::for_table('tbl_portal_sessions')->count();
    echo "Current sessions in table: $count\n";
    
    if ($count > 0) {
        echo "\nRecent sessions:\n";
        $recent = ORM::for_table('tbl_portal_sessions')
            ->order_by_desc('created_at')
            ->limit(5)
            ->find_many();
        
        foreach ($recent as $session) {
            echo "- {$session->session_id} | {$session->status} | {$session->created_at}\n";
        }
    }
    
} catch (Exception $e) {
    echo "❌ Error accessing tbl_portal_sessions: " . $e->getMessage() . "\n";
    echo "Creating table...\n";
    
    try {
        $sql = "CREATE TABLE IF NOT EXISTS `tbl_portal_sessions` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `session_id` varchar(50) NOT NULL,
            `mac_address` varchar(20) DEFAULT NULL,
            `ip_address` varchar(45) DEFAULT NULL,
            `user_agent` text,
            `plan_id` int(11) DEFAULT NULL,
            `phone_number` varchar(20) DEFAULT NULL,
            `amount` decimal(10,2) DEFAULT NULL,
            `payment_id` int(11) DEFAULT NULL,
            `checkout_request_id` varchar(100) DEFAULT NULL,
            `mikrotik_user` varchar(50) DEFAULT NULL,
            `status` varchar(20) DEFAULT 'pending',
            `expiry_warning_sent` tinyint(1) DEFAULT 0,
            `expires_at` datetime DEFAULT NULL,
            `created_at` datetime NOT NULL,
            `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `session_id` (`session_id`),
            KEY `mac_address` (`mac_address`),
            KEY `status` (`status`),
            KEY `created_at` (`created_at`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        
        ORM::raw_execute($sql);
        echo "✅ Created tbl_portal_sessions table\n";
        
    } catch (Exception $createError) {
        echo "❌ Failed to create table: " . $createError->getMessage() . "\n";
    }
}

echo "\n=== Test Complete ===\n";