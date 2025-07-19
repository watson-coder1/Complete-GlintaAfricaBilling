-- Create tbl_pg table for payment gateway configurations
-- This table is required for the Daraja payment gateway to work properly

CREATE TABLE IF NOT EXISTS `tbl_pg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gateway` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Payment gateway name',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Inactive, 1=Active',
  `pg_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'JSON configuration data',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gateway` (`gateway`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert Daraja gateway configuration record
INSERT INTO `tbl_pg` (`gateway`, `status`, `pg_data`) VALUES
('Daraja', 0, '{"consumer_key":"","consumer_secret":"","shortcode":"","passkey":"","environment":"sandbox","callback_url":"","timeout_url":""}')
ON DUPLICATE KEY UPDATE 
  `pg_data` = VALUES(`pg_data`),
  `updated_at` = CURRENT_TIMESTAMP;

-- Add Daraja to active payment gateways list in tbl_appconfig
INSERT INTO `tbl_appconfig` (`setting`, `value`) VALUES
('payment_gateway', 'Daraja')
ON DUPLICATE KEY UPDATE 
  `value` = CASE 
    WHEN `value` NOT LIKE '%Daraja%' THEN CONCAT(IFNULL(`value`, ''), ',Daraja')
    ELSE `value`
  END;