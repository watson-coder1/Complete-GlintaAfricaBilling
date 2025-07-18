<?php
/**
 * Debug Daraja Form - Direct Check
 * Run this to see what's actually happening with the form
 */

// Include the system files
require_once 'init.php';

// Force admin access for testing
$_SESSION['uid'] = 1;

// Check if Daraja.php exists
$daraja_file = 'system/paymentgateway/Daraja.php';
if (!file_exists($daraja_file)) {
    die("❌ Daraja.php not found at: $daraja_file");
}

// Include the Daraja file
include $daraja_file;

// Check if function exists
if (!function_exists('Daraja_show_config')) {
    die("❌ Daraja_show_config function not found");
}

// Get the configuration
$ui->assign('_title', 'Debug - M-Pesa Daraja Configuration');
$ui->assign('_system_menu', 'paymentgateway');

// Set test values
$ui->assign('daraja_consumer_key', 'test_consumer_key');
$ui->assign('daraja_consumer_secret', 'test_consumer_secret');
$ui->assign('daraja_passkey', 'test_passkey');
$ui->assign('daraja_business_shortcode', '174379');
$ui->assign('daraja_environment', 'sandbox');
$ui->assign('daraja_callback_url', 'https://glintaafrica.com/?_route=callback/mpesa');
$ui->assign('daraja_timeout_url', 'https://glintaafrica.com/?_route=callback/mpesa');
$ui->assign('daraja_sandbox_mode', '1');
$ui->assign('daraja_status', 'Active');

// Add debug JavaScript
$debug_js = '
<script>
window.onload = function() {
    console.log("=== DARAJA FORM DEBUG ===");
    
    // Check all input fields
    var inputs = document.querySelectorAll("input");
    console.log("Total input fields found: " + inputs.length);
    
    inputs.forEach(function(input) {
        if (input.name === "callback_url" || input.name === "timeout_url") {
            console.log("Field: " + input.name);
            console.log("  - ID: " + input.id);
            console.log("  - Type: " + input.type);
            console.log("  - ReadOnly: " + input.readOnly);
            console.log("  - Disabled: " + input.disabled);
            console.log("  - Value: " + input.value);
            
            // Force enable
            input.readOnly = false;
            input.disabled = false;
            input.style.backgroundColor = "#ffff99";
            console.log("  - FORCED ENABLED!");
        }
    });
    
    // Specific check
    var callbackField = document.querySelector(\'input[name="callback_url"]\');
    if (callbackField) {
        console.log("✅ Callback URL field found by name selector");
        callbackField.style.border = "3px solid green";
    } else {
        console.log("❌ Callback URL field NOT found by name selector");
    }
    
    // Check by ID
    var callbackById = document.getElementById("callback_url");
    if (callbackById) {
        console.log("✅ Callback URL field found by ID");
    } else {
        console.log("❌ Callback URL field NOT found by ID");
    }
};
</script>

<div style="background: yellow; padding: 20px; margin: 20px 0;">
    <h2>🔍 DEBUG MODE ACTIVE</h2>
    <p>Check browser console (F12) for field information</p>
    <p>Yellow background = fields should be forced enabled</p>
    <p>Green border = callback URL field found</p>
</div>
';

// Display the template with debug
ob_start();
$ui->display('paymentgateway/Daraja.tpl');
$output = ob_get_clean();

// Inject debug JavaScript before closing body tag
$output = str_replace('</body>', $debug_js . '</body>', $output);

echo $output;
?>