-- Create tbl_pg table for payment gateway configuration
CREATE TABLE IF NOT EXISTS `tbl_pg` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `gateway` varchar(50) NOT NULL,
    `pg_data` text,
    `status` tinyint(1) DEFAULT 0,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `gateway` (`gateway`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert Daraja configuration with 'live' environment
INSERT INTO `tbl_pg` (`gateway`, `pg_data`, `status`) 
VALUES ('Daraja', '{"consumer_key":"","consumer_secret":"","shortcode":"","passkey":"","environment":"live","callback_url":"https://glintaafrica.com/callback_mpesa.php","timeout_url":"https://glintaafrica.com/timeout_mpesa.php"}', 1)
ON DUPLICATE KEY UPDATE 
pg_data = JSON_SET(pg_data, '$.environment', 'live');