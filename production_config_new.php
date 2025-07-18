<?php

// Glinta Africa Production Configuration
// This file will be used in production instead of config.php

$protocol = (!empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] !== "off" || $_SERVER["SERVER_PORT"] == 443) ? "https://" : "http://";
$host = $_SERVER["HTTP_HOST"];
$baseDir = rtrim(dirname($_SERVER["SCRIPT_NAME"]), "/\\");
define("APP_URL", "https://glintaafrica.com");

// Environment: Production
$_app_stage = "Live";

// Database Configuration - Production
$db_host = "mysql";
$db_user = "glinta_user";
$db_pass = getenv('MYSQL_PASSWORD') ?: "your_secure_password";
$db_name = "glinta_billing";

// Database Radius - Production
$radius_host = "mysql";
$radius_user = "glinta_user";
$radius_pass = getenv('MYSQL_PASSWORD') ?: "your_secure_password";
$radius_name = "glinta_billing";

// Production Error Handling
if($_app_stage == "Live"){
    error_reporting(E_ERROR);
    ini_set("display_errors", 0);
    ini_set("display_startup_errors", 0);
    ini_set("log_errors", 1);
    ini_set("error_log", "/var/log/glinta/php_errors.log");
} else {
    error_reporting(E_ALL);
    ini_set("display_errors", 1);
    ini_set("display_startup_errors", 1);
}

// M-Pesa Production Configuration
$mpesa_config = [
    'environment' => 'production', // Changed to production
    'consumer_key' => getenv('MPESA_CONSUMER_KEY') ?: '',
    'consumer_secret' => getenv('MPESA_CONSUMER_SECRET') ?: '',
    'business_shortcode' => getenv('MPESA_BUSINESS_SHORTCODE') ?: '',
    'passkey' => getenv('MPESA_PASSKEY') ?: '',
    'callback_url' => 'https://glintaafrica.com/callback_mpesa.php',
    'timeout_url' => 'https://glintaafrica.com/timeout_mpesa.php',
    'result_url' => 'https://glintaafrica.com/result_mpesa.php',
    'queue_timeout_url' => 'https://glintaafrica.com/queue_timeout_mpesa.php',
    // Production URLs
    'auth_url' => 'https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials',
    'stk_push_url' => 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
    'stk_query_url' => 'https://api.safaricom.co.ke/mpesa/stkpushquery/v1/query',
];

// Company Information
$company_config = [
    'name' => 'Glinta Africa',
    'email' => 'support@glintaafrica.com',
    'phone' => '+254711503023',
    'address' => 'Nairobi, Kenya',
    'website' => 'https://glintaafrica.com',
];

// Production-specific settings
ini_set('expose_php', 'Off'); // Hide PHP version
ini_set('max_execution_time', 300); // 5 minutes for long operations
ini_set('memory_limit', '256M');
ini_set('upload_max_filesize', '50M');
ini_set('post_max_size', '50M');

// Timezone
date_default_timezone_set('Africa/Nairobi');

?>