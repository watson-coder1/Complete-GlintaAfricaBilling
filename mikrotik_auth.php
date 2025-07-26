<?php
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
?>