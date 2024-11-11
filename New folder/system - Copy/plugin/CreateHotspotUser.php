<?php
function Alloworigins()
{
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type");
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        exit;
    }
    $requestUri = $_SERVER['REQUEST_URI'];
    $queryString = parse_url($requestUri, PHP_URL_QUERY);
    $type = null;
    if ($queryString) {
        parse_str($queryString, $queryParameters);
        // Check if 'type' parameter exists
        if (isset($queryParameters['type'])) {
            $type = $queryParameters['type'];
            if ($type === "grant") {
                CreateHostspotUser();
                exit;
            } elseif ($type === "verify") {
                VerifyHotspot();
                exit;
            } elseif ($type === "voucher") {
                ReconnectVoucher();
                exit;

            } else {
                echo json_encode(['status' => 'error', 'code' => 400, 'message' => 'The  parameter is not present in the URL.']);
            }
        }
    }
}
function ReconnectVoucher() {
    header('Content-Type: application/json');

    $rawData = file_get_contents('php://input');
    $postData = json_decode($rawData, true);

    if (!isset($postData['voucher_code'])) {
        echo json_encode(['status' => 'error', 'code' => 400, 'message' => 'Missing voucherCode field']);
        return;
    }

    $voucherCode = $postData['voucher_code'];

    $voucher = ORM::for_table('tbl_voucher')
        ->where('code', $voucherCode)
        ->where('status', '0')
        ->find_one();

    if (!$voucher) {
        echo json_encode([
            'status' => 'error',
            'Resultcode' => '1',
            'voucher' => 'Not Found',
            'message' => 'Invalid Voucher code'
        ]);
        exit();
    }

    if ($voucher['status'] == '1') {
        echo json_encode([
            'status' => 'error',
            'Resultcode' => '3',
            'voucher' => 'Used',
            'message' => 'Voucher code is already used'
        ]);
        exit();
    }

    $planId = $voucher['id_plan'];
    $routername = $voucher['routers'];

    $router = ORM::for_table('tbl_routers')
        ->where('name', $routername)
        ->find_one();

    if (!$router) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Router not found'
        ]);
        exit();
    }

    $routerId = $router['id'];

    if (!ORM::for_table('tbl_plans')->where('id', $planId)->count() || !ORM::for_table('tbl_routers')->where('id', $routerId)->count()) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Unable to process your request, please refresh the page'
        ]);
        exit();
    }

    // Create a new user based on the voucher code
    $user = ORM::for_table('tbl_customers')->where('username', $voucherCode)->find_one();
    if (!$user) {
        $user = ORM::for_table('tbl_customers')->create();
        $user->username = $voucherCode;
        $user->password = '1234';
        $user->fullname = $voucherCode;
        $user->email = $voucherCode . '@gmail.com';
        $user->phonenumber = $voucherCode;
        $user->pppoe_password = '1234';
        $user->address = '';
        $user->service_type = 'Hotspot';
    }

    $user->router_id = $routerId;
    $user->save();

    // Update the voucher with the user ID
    $voucher->user = $user->id;
    $voucher->status = '1';  // Mark as used
    $voucher->save();

    if (Package::rechargeUser($user->id, $routername, $planId, 'Voucher', $voucherCode)) {
        echo json_encode([
            'status' => 'success',
            'Resultcode' => '2',
            'voucher' => 'activated',
            'message' => 'Voucher code has been activated',
            'username' => $user->username
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Failed to recharge user package'
        ]);
    }
}


function VerifyHotspot()
{
    header('Content-Type: application/json');
    $rawData = file_get_contents('php://input');
    $postData = json_decode($rawData, true);

    if (!$postData) {
        echo json_encode(['status' => 'error', 'code' => 400, 'message' => 'Invalid JSON DATA']);
        return;
    }

    if (!isset($postData['phone_number'])) {
        echo json_encode([
            'status' => 'error',
            'code' => 400,
            'message' => 'Missing required fields'
        ]);
        return;
    }

    $phone = $postData['phone_number'];
    $user = ORM::for_table('tbl_payment_gateway')
        ->where('username', $phone)
        ->order_by_desc('id')
        ->find_one();

    if ($user) {
        $status = $user->status;
        $mpesacode = $user->gateway_trx_id;
        $res = $user->pg_paid_response;

        if ($status == 2 && !empty($mpesacode)) {
            $data = [
                "Resultcode" => "3",
                "phone" => $phone,
                "tyhK" => "1234",
                "Message" => "We have received your transaction under the Mpesa Transaction $mpesacode. Please do not leave this page as we are redirecting you.",
                "Status" => "success"
            ];
            echo json_encode($data);
            return;
        }

        if ($res == "Not enough balance") {
            $data = [
                "Resultcode" => "2",
                "Message1" => "Insufficient Balance for the transaction",
                "Status" => "danger",
                "Redirect" => "Insufficient balance"
            ];
            echo json_encode($data);
            return;
        }

        if ($res == "Wrong Mpesa pin") {
            $data = [
                "Resultcode" => "2",
                "Message" => "You entered Wrong Mpesa pin, please resubmit",
                "Status" => "danger",
                "Redirect" => "Wrong Mpesa pin"
            ];
            echo json_encode($data);
            return;
        }

        if ($status == 4) {
            $data = [
                "Resultcode" => "2",
                "Message" => "You cancelled the transaction, you can enter phone number again to activate",
                "Status" => "info",
                "Redirect" => "Transaction Cancelled"
            ];
            echo json_encode($data);
            return;
        }

        if (empty($mpesacode)) {
            $data = [
                "Resultcode" => "1",
                "Message" => "A payment pop up has been sent to $phone. Please enter PIN to continue (Please do not leave or reload the page until redirected).",
                "Status" => "primary"
            ];
            echo json_encode($data);
            return;
        }
    } else {
        echo json_encode(['status' => 'error', 'code' => 404, 'message' => 'User not found']);
    }
}




function CreateHostspotUser()
{
    header('Content-Type: application/json');
    $rawData = file_get_contents('php://input');
    $postData = json_decode($rawData, true);

    if (!$postData) {
        echo json_encode(['status' => 'error', 'code' => 400, 'message' => 'Invalid JSON DATA']);
        return;
    }

    if (!isset($postData['phone_number'], $postData['plan_id'], $postData['router_id'])) {
        echo json_encode(['status' => 'error', 'code' => 400, 'message' => 'Missing required fields']);
        return;
    }

    $phone = $postData['phone_number'];
    $planId = $postData['plan_id'];
    $routerId = $postData['router_id'];

    // Normalize the phone number
    $phone = (substr($phone, 0, 1) == '+') ? str_replace('+', '', $phone) : $phone;
    $phone = (substr($phone, 0, 1) == '0') ? preg_replace('/^0/', '254', $phone) : $phone;
    $phone = (substr($phone, 0, 1) == '7') ? preg_replace('/^7/', '2547', $phone) : $phone; //cater for phone number prefix 2547XXXX
    $phone = (substr($phone, 0, 1) == '1') ? preg_replace('/^1/', '2541', $phone) : $phone; //cater for phone number prefix 2541XXXX
    $phone = (substr($phone, 0, 1) == '0') ? preg_replace('/^01/', '2541', $phone) : $phone;
    $phone = (substr($phone, 0, 1) == '0') ? preg_replace('/^07/', '2547', $phone) : $phone;

    if (strlen($phone) !== 12) {
        echo json_encode(['status' => 'error', 'code' => 1, 'message' => 'Phone number ' . $phone . ' is invalid. Please confirm.']);
        return;
    }

    if (strlen($phone) == 12 && !empty($planId) && !empty($routerId)) {
        $PlanExist = ORM::for_table('tbl_plans')->where('id', $planId)->count() > 0;
        $RouterExist = ORM::for_table('tbl_routers')->where('id', $routerId)->count() > 0;

        if (!$PlanExist) {
            echo json_encode(["status" => "error", "message" => "Plan does not exist. Please refresh the page."]);
            return;
        }
        
        if (!$RouterExist) {
            echo json_encode(["status" => "error", "message" => "Router does not exist. Please refresh the page."]);
            return;
        }
    }

    $Userexist = ORM::for_table('tbl_customers')->where('username', $phone)->find_one();

    if ($Userexist) {
        $Userexist->router_id = $routerId;
        $Userexist->save();
        InitiateStkpush($phone, $planId, $routerId);
    } else {
        try {
            $defpass = '1234';
            $defaddr = 'netXtreme';
            $defmail = $phone . '@gmail.com';

            $createUser = ORM::for_table('tbl_customers')->create();
            $createUser->username = $phone;
            $createUser->password = $defpass;
            $createUser->fullname = $phone;
            $createUser->router_id = $routerId;
            $createUser->phonenumber = $phone;
            $createUser->pppoe_password = $defpass;
            $createUser->address = $defaddr;
            $createUser->email = $defmail;
            $createUser->service_type = 'Hotspot';

            if ($createUser->save()) {
                InitiateStkpush($phone, $planId, $routerId);
            } else {
                echo json_encode(["status" => "error", "message" => "There was a system error when registering user, please contact support."]);
            }
        } catch (Exception $e) {
            echo json_encode(["status" => "error", "message" => "Error creating user: " . $e->getMessage()]);
        }
    }
}



function InitiateStkpush($phone, $planId, $routerId)
{
    $gateway = ORM::for_table('tbl_appconfig')
        ->where('setting', 'payment_gateway')
        ->find_one();
    $gateway = ($gateway) ? $gateway->value : null;
    if ($gateway == "MpesatillStk") {
        $url = U . "plugin/initiatetillstk";
    } elseif ($gateway == "BankStkPush") {
        $url = U . "plugin/initiatebankstk";
    } elseif ($gateway == "PaybillStk") {
        $url = U . "plugin/initiatePaybillStk";
    } elseif ($gateway == "mpesa") {
        $url = U . "plugin/initiatempesa";
    } else {
        $url = null; // or handle the default case appropriately
    }
    $Planname = ORM::for_table('tbl_plans')
        ->where('id', $planId)
        ->order_by_desc('id')
        ->find_one();
    $Findrouter = ORM::for_table('tbl_routers')
        ->where('id', $routerId)
        ->order_by_desc('id')
        ->find_one();
    $rname = $Findrouter->name;
    $price = $Planname->price;
    $Planname = $Planname->name_plan;
    $Checkorders = ORM::for_table('tbl_payment_gateway')
        ->where('username', $phone)
        ->where('status', 1)
        ->order_by_desc('id')
        ->find_many();
    if ($Checkorders) {
        foreach ($Checkorders as $Dorder) {
            $Dorder->delete();
        }
    }
    try {
        $d = ORM::for_table('tbl_payment_gateway')->create();
        $d->username = $phone;
        $d->gateway = $gateway;
        $d->plan_id = $planId;
        $d->plan_name = $Planname;
        $d->routers_id = $routerId;
        $d->routers = $rname;
        $d->price = $price;
        $d->payment_method = $gateway;
        $d->payment_channel = $gateway;
        $d->created_date = date('Y-m-d H:i:s');
        $d->paid_date = date('Y-m-d H:i:s');
        $d->expired_date = date('Y-m-d H:i:s');
        $d->pg_url_payment = $url;
        $d->status = 1;
        $d->save();
    } catch (Exception $e) {
        error_log('Error saving payment gateway record: ' . $e->getMessage());
        throw $e;
    }
    SendSTKcred($phone, $url);
}

function SendSTKcred($phone, $url)
{
    $link = $url;
    $fields = array(
        'username' => $phone,
        'phone' => $phone,
        'channel' => 'Yes',
    );
    $postvars = http_build_query($fields);
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $link);
    curl_setopt($ch, CURLOPT_POST, count($fields));
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postvars);
    $result = curl_exec($ch);
}

Alloworigins();
