<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);

require_once "init.php";

echo "Testing captive portal payment template...\n";

$template_path = "ui/ui/captive_portal_payment.tpl";
if (file_exists($template_path)) {
    echo "✅ Template file exists at: " . $template_path . "\n";
} else {
    echo "❌ Template file NOT found at: " . $template_path . "\n";
}

global $ui;
echo "\nSmarty template directories:\n";
print_r($ui->getTemplateDir());

try {
    echo "\nAttempting to display template...\n";
    $ui->assign("_title", "Test Payment");
    $ui->assign("_url", "http://test");
    $ui->display("captive_portal_payment.tpl");
} catch (Exception $e) {
    echo "❌ Error displaying template: " . $e->getMessage() . "\n";
}
?>
