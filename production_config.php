<?php
/**
 * Production Configuration for glintaafrica.com
 * Update these values for your production environment
 */

// Database Configuration
$db_host = 'localhost'; // Production database server
$db_port = '3306';
$db_name = 'glinta_billing';
$db_username = 'glinta_user';
$db_password = 'your_secure_password_here';

// Application URL
$app_url = 'https://glintaafrica.com/';

// M-Pesa Production Credentials (replace with your live credentials)
$mpesa_config = [
    'consumer_key' => 'your_production_consumer_key',
    'consumer_secret' => 'your_production_consumer_secret',
    'business_shortcode' => 'your_business_shortcode',
    'passkey' => 'your_production_passkey',
    'callback_url' => 'https://glintaafrica.com/?_route=callback/mpesa',
    'environment' => 'production' // Change to 'production' for live
];

// RADIUS Configuration
$radius_config = [
    'host' => 'localhost', // RADIUS database server
    'port' => '3306',
    'database' => 'radius',
    'username' => 'radius_user',
    'password' => 'radius_password'
];

// Email Configuration
$email_config = [
    'smtp_host' => 'smtp.gmail.com',
    'smtp_port' => 587,
    'smtp_username' => 'support@glintaafrica.com',
    'smtp_password' => 'your_email_password',
    'from_email' => 'support@glintaafrica.com',
    'from_name' => 'Glinta Africa Support'
];

// Security Settings
$security_config = [
    'admin_session_timeout' => 3600, // 1 hour
    'max_login_attempts' => 5,
    'password_min_length' => 8,
    'enable_2fa' => true
];

// Captive Portal Settings
$portal_config = [
    'portal_url' => 'https://glintaafrica.com/?_route=captive_portal',
    'success_redirect' => 'https://google.com',
    'support_email' => 'support@glintaafrica.com',
    'support_phone' => '0711311897',
    'company_name' => 'Glinta Africa',
    'company_website' => 'https://glintaafrica.com'
];

// SSL and Security Headers
$ssl_config = [
    'force_https' => true,
    'hsts_enabled' => true,
    'csrf_protection' => true
];

echo "Production configuration template created!\n";
echo "Please update the values above with your actual production credentials.\n";
?>