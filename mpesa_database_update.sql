-- M-Pesa Daraja Database Updates
-- Add M-Pesa specific fields to tbl_payment_gateway

ALTER TABLE tbl_payment_gateway 
ADD COLUMN mpesa_receipt_number VARCHAR(20) DEFAULT '' COMMENT 'M-Pesa receipt number',
ADD COLUMN mpesa_phone_number VARCHAR(15) DEFAULT '' COMMENT 'Customer phone number',
ADD COLUMN mpesa_amount DECIMAL(10,2) DEFAULT 0.00 COMMENT 'Paid amount from M-Pesa',
ADD COLUMN checkout_request_id VARCHAR(50) DEFAULT '' COMMENT 'STK Push checkout request ID';

-- Add M-Pesa configuration to tbl_appconfig
INSERT INTO tbl_appconfig (setting, value) VALUES
('daraja_consumer_key', ''),
('daraja_consumer_secret', ''),
('daraja_passkey', ''),
('daraja_shortcode', ''),
('daraja_environment', 'sandbox'),
('daraja_callback_url', ''),
('daraja_enabled', '0')
ON DUPLICATE KEY UPDATE setting = VALUES(setting);

-- Add index for faster lookups
ALTER TABLE tbl_payment_gateway 
ADD INDEX idx_checkout_request_id (checkout_request_id),
ADD INDEX idx_mpesa_receipt (mpesa_receipt_number);

-- Update payment_gateway setting to include Daraja
UPDATE tbl_appconfig 
SET value = CONCAT(IFNULL(value, ''), ',Daraja') 
WHERE setting = 'payment_gateway' AND value NOT LIKE '%Daraja%';

-- If payment_gateway setting doesn't exist, create it
INSERT INTO tbl_appconfig (setting, value) 
SELECT 'payment_gateway', 'Daraja' 
WHERE NOT EXISTS (SELECT 1 FROM tbl_appconfig WHERE setting = 'payment_gateway');