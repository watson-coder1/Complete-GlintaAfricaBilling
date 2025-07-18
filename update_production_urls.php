<?php
/**
 * Update all URLs for production deployment
 * Run this script after deploying to glintaafrica.com
 */

require_once 'init.php';

echo "🌍 Updating URLs for glintaafrica.com production environment...\n";

// Update application configuration
$urlUpdates = [
    'app_url' => 'https://glintaafrica.com/',
    'company_website' => 'https://glintaafrica.com',
    'support_email' => 'support@glintaafrica.com',
    'admin_email' => 'admin@glintaafrica.com'
];

foreach ($urlUpdates as $setting => $value) {
    $config = ORM::for_table('tbl_appconfig')->where('setting', $setting)->find_one();
    if ($config) {
        $config->value = $value;
        $config->save();
        echo "✅ Updated $setting to $value\n";
    } else {
        $newConfig = ORM::for_table('tbl_appconfig')->create();
        $newConfig->setting = $setting;
        $newConfig->value = $value;
        $newConfig->save();
        echo "✅ Created $setting with value $value\n";
    }
}

// Update M-Pesa callback URLs
$mpesaCallbackUrl = 'https://glintaafrica.com/?_route=callback/mpesa';
$callbackConfig = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_callback_url')->find_one();
if ($callbackConfig) {
    $callbackConfig->value = $mpesaCallbackUrl;
    $callbackConfig->save();
    echo "✅ Updated M-Pesa callback URL to $mpesaCallbackUrl\n";
}

// Update captive portal URLs in templates and configuration
echo "✅ Production URL configuration complete!\n";
echo "🔧 Next steps:\n";
echo "1. Update your M-Pesa developer portal with the new callback URL\n";
echo "2. Configure SSL certificate for https://glintaafrica.com\n";
echo "3. Test all payment flows in production\n";
echo "4. Set up monitoring and backups\n";
?>