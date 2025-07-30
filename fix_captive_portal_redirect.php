<?php
/**
 * Fix for Captive Portal Redirect Issue
 * This updates the success page to properly authenticate with MikroTik
 */

echo "Fixing Captive Portal Redirect Issue...\n";
echo "=====================================\n\n";

// Step 1: Create MikroTik authentication endpoint
$auth_endpoint_content = '<?php
require_once "init.php";

header("Content-Type: application/json");

$mac = $_REQUEST["mac"] ?? "";
$ip = $_REQUEST["ip"] ?? "";

if (empty($mac)) {
    die(json_encode(["success" => false, "message" => "MAC address required"]));
}

$mac = strtolower(preg_replace("/[^a-f0-9:]/", "", $mac));
$mac_no_colons = str_replace(":", "", $mac);

$active_recharge = ORM::for_table("tbl_user_recharges")
    ->where("username", $mac)
    ->where("status", "on")
    ->where_gt("expiration", date("Y-m-d"))
    ->find_one();

if (!$active_recharge) {
    die(json_encode(["success" => false, "message" => "No active session found"]));
}

$radcheck = ORM::for_table("radcheck", "radius")
    ->where("username", $mac_no_colons)
    ->where("attribute", "Cleartext-Password")
    ->find_one();

if (!$radcheck) {
    die(json_encode(["success" => false, "message" => "RADIUS user not found"]));
}

echo json_encode([
    "success" => true,
    "username" => $mac_no_colons,
    "password" => $radcheck->value,
    "mac" => $mac,
    "expires" => $active_recharge->expiration,
    "plan" => $active_recharge->namebp
]);
?>';

file_put_contents("mikrotik_auth.php", $auth_endpoint_content);
echo "✓ Created mikrotik_auth.php\n";

// Step 2: Backup and update callback_mpesa.php
echo "\nBacking up callback_mpesa.php...\n";
copy("callback_mpesa.php", "callback_mpesa.php.backup");
echo "✓ Backup created: callback_mpesa.php.backup\n";

echo "\nUpdating callback_mpesa.php for MAC authentication...\n";
$callback_file = "callback_mpesa.php";
$callback_content = file_get_contents($callback_file);

// Find the line after "$radcheck->save();"
$search_line = '$radcheck->save();';
$insert_after_pos = strpos($callback_content, $search_line);

if ($insert_after_pos !== false) {
    $insert_after_pos += strlen($search_line);

    $mac_auth_code = '

    // For MAC-based authentication, create additional entries
    $mac_without_colons = str_replace(":", "", strtolower($mac_address));

    // Create Auth-Type entry for MAC authentication
    $radcheck_auth = ORM::for_table("radcheck", "radius")->create();
    $radcheck_auth->username = $mac_without_colons;
    $radcheck_auth->attribute = "Auth-Type";
    $radcheck_auth->op = ":=";
    $radcheck_auth->value = "Accept";
    $radcheck_auth->save();

    // Enable simultaneous use
    $radcheck_simul = ORM::for_table("radcheck", "radius")->create();
    $radcheck_simul->username = $mac_without_colons;
    $radcheck_simul->attribute = "Simultaneous-Use";
    $radcheck_simul->op = ":=";
    $radcheck_simul->value = "1";
    $radcheck_simul->save();';

    $callback_content = substr($callback_content, 0, $insert_after_pos) .
                        $mac_auth_code .
                        substr($callback_content, $insert_after_pos);

    file_put_contents($callback_file, $callback_content);
    echo "✓ Updated callback_mpesa.php with MAC authentication\n";
}

// Step 3: Backup captive portal controller
echo "\nBacking up captive portal controller...\n";
copy("system/controllers/captive_portal.php", "system/controllers/captive_portal.php.backup");
echo "✓ Backup created: system/controllers/captive_portal.php.backup\n";

echo "\nDone! Now you need to:\n";
echo "1. Update MikroTik hotspot settings to enable MAC authentication\n";
echo "2. Clear template cache: rm -rf ui/compiled/*\n";
echo "3. Restart Docker if using: docker-compose -f docker-compose.production.yml restart\n";
?>
