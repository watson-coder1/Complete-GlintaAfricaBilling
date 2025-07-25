<?php

// Fix path for both direct execution and cron execution
if (file_exists("../init.php")) {
    include "../init.php";
} else if (file_exists("/var/www/html/init.php")) {
    include "/var/www/html/init.php";
} else {
    include "init.php";
}
$lockFile = "$CACHE_PATH/router_monitor.lock";

if (!is_dir($CACHE_PATH)) {
    echo "Directory '$CACHE_PATH' does not exist. Exiting...\n";
    exit;
}

$lock = fopen($lockFile, 'c');

if ($lock === false) {
    echo "Failed to open lock file. Exiting...\n";
    exit;
}

if (!flock($lock, LOCK_EX | LOCK_NB)) {
    echo "Script is already running. Exiting...\n";
    fclose($lock);
    exit;
}


$isCli = true;
if (php_sapi_name() !== 'cli') {
    $isCli = false;
    echo "<pre>";
}
echo "PHP Time\t" . date('Y-m-d H:i:s') . "\n";
$res = ORM::raw_execute('SELECT NOW() AS WAKTU;');
$statement = ORM::get_last_statement();
$rows = array();
while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
    echo "MYSQL Time\t" . $row['WAKTU'] . "\n";
}

$_c = $config;


$textExpired = Lang::getNotifText('expired');

// Enhanced expiry check: handle both date-only and precise time-based expiry
$current_datetime = date("Y-m-d H:i:s");
$current_date = date("Y-m-d");

// Get all active recharges that might be expired
$d = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_raw("(
        (expiration < ? AND time IS NULL) OR 
        (expiration = ? AND time IS NOT NULL AND CONCAT(expiration, ' ', time) <= ?) OR
        (expiration < ?)
    )", [$current_date, $current_date, $current_datetime, $current_date])
    ->find_many();
echo "Found " . count($d) . " user(s)\n";
run_hook('cronjob'); #HOOK

foreach ($d as $ds) {
    $date_now = strtotime(date("Y-m-d H:i:s"));
    
    // Handle both time-based and date-only expiry
    if (!empty($ds['time'])) {
        $expiration = strtotime($ds['expiration'] . ' ' . $ds['time']);
        $expiry_display = $ds['expiration'] . ' ' . $ds['time'];
    } else {
        // For date-only expiry, set to end of day
        $expiration = strtotime($ds['expiration'] . ' 23:59:59');
        $expiry_display = $ds['expiration'] . ' (end of day)';
    }
    
    echo $expiry_display . " : " . (($isCli) ? $ds['username'] : Lang::maskText($ds['username']));
    if ($date_now >= $expiration) {
        echo " : EXPIRED \r\n";
        $u = ORM::for_table('tbl_user_recharges')->where('id', $ds['id'])->find_one();
        $c = ORM::for_table('tbl_customers')->where('id', $ds['customer_id'])->find_one();
        $p = ORM::for_table('tbl_plans')->where('id', $u['plan_id'])->find_one();
		if (empty($c)) {
			$c = $u;
		}
        $dvc = Package::getDevice($p);
        if ($_app_stage != 'demo') {
            if (file_exists($dvc)) {
                require_once $dvc;
                (new $p['device'])->remove_customer($c, $p);
            } else {
                echo "Cron error Devices $p[device] not found, cannot disconnect $c[username]";
                Message::sendTelegram("Cron error Devices $p[device] not found, cannot disconnect $c[username]");
            }
        }
        
        // Enhanced cleanup: Remove from RADIUS and portal sessions immediately
        if ($p['type'] == 'Hotspot' && $_app_stage != 'demo') {
            try {
                // Clean RADIUS entries for immediate disconnection
                if (class_exists('RadiusManager')) {
                    RadiusManager::removeRadiusUser($c['username']);
                    RadiusManager::disconnectUser($c['username']);
                    echo "RADIUS cleanup completed for user: " . $c['username'] . "\n";
                }
                
                // Clean portal sessions
                $portalSession = ORM::for_table('tbl_portal_sessions')
                    ->where('mac_address', $c['username'])
                    ->where_in('status', ['completed', 'active'])
                    ->find_one();
                    
                if ($portalSession) {
                    $portalSession->status = 'expired';
                    $portalSession->expired_at = date('Y-m-d H:i:s');
                    $portalSession->save();
                    echo "Portal session expired for user: " . $c['username'] . "\n";
                }
                
                // Force disconnect from active sessions in radacct
                $activeRadSessions = ORM::for_table('radacct', 'radius')
                    ->where('username', $c['username'])
                    ->where_null('acctstoptime')
                    ->find_many();
                    
                foreach ($activeRadSessions as $radSession) {
                    $radSession->acctstoptime = date('Y-m-d H:i:s');
                    $radSession->acctterminatecause = 'Session-Timeout';
                    $radSession->save();
                }
                
                if (count($activeRadSessions) > 0) {
                    echo "Terminated " . count($activeRadSessions) . " active RADIUS sessions for: " . $c['username'] . "\n";
                }
                
            } catch (Exception $e) {
                echo "Error during enhanced cleanup for " . $c['username'] . ": " . $e->getMessage() . "\n";
                Message::sendTelegram("Cron cleanup error for user $c[username]: " . $e->getMessage());
            }
        }
        
        echo Message::sendPackageNotification($c, $u['namebp'], $p['price'], $textExpired, $config['user_notification_expired']) . "\n";
        //update database user dengan status off
        $u->status = 'off';
        $u->save();

        // autorenewal from deposit
        if ($config['enable_balance'] == 'yes' && $c['auto_renewal']) {
            list($bills, $add_cost) = User::getBills($ds['customer_id']);
            if ($add_cost != 0) {
                if (!empty($add_cost)) {
                    $p['price'] += $add_cost;
                }
            }
            if ($p && $c['balance'] >= $p['price']) {
                if (Package::rechargeUser($ds['customer_id'], $ds['routers'], $p['id'], 'Customer', 'Balance')) {
                    // if success, then get the balance
                    Balance::min($ds['customer_id'], $p['price']);
                    echo "plan enabled: $p[enabled] | User balance: $c[balance] | price $p[price]\n";
                    echo "auto renewall Success\n";
                } else {
                    echo "plan enabled: $p[enabled] | User balance: $c[balance] | price $p[price]\n";
                    echo "auto renewall Failed\n";
                    Message::sendTelegram("FAILED RENEWAL #cron\n\n#u$c[username] #buy #Hotspot \n" . $p['name_plan'] .
                        "\nRouter: " . $p['routers'] .
                        "\nPrice: " . $p['price']);
                }
            } else {
                echo "no renewall | plan enabled: $p[enabled] | User balance: $c[balance] | price $p[price]\n";
            }
        } else {
            echo "no renewall | balance $config[enable_balance] auto_renewal $c[auto_renewal]\n";
        }
    } else {
        echo " : ACTIVE \r\n";
    }
}


if ($config['router_check']) {
    echo "Checking router status...\n";
    $routers = ORM::for_table('tbl_routers')->where('enabled', '1')->find_many();
    if (!$routers) {
        echo "No active routers found in the database.\n";
        flock($lock, LOCK_UN);
        fclose($lock);
        unlink($lockFile);
        exit;
    }

    $offlineRouters = [];
    $errors = [];

    foreach ($routers as $router) {
        // check if custom port
        if (strpos($router->ip_address, ':') === false){
            $ip = $router->ip_address;
            $port = 8728;
        } else {
            [$ip, $port] = explode(':', $router->ip_address);
        }
        $isOnline = false;

        try {
            $timeout = 5;
            if (is_callable('fsockopen') && false === stripos(ini_get('disable_functions'), 'fsockopen')) {
                $fsock = @fsockopen($ip, $port, $errno, $errstr, $timeout);
                if ($fsock) {
                    fclose($fsock);
                    $isOnline = true;
                } else {
                    throw new Exception("Unable to connect to $ip on port $port using fsockopen: $errstr ($errno)");
                }
            } elseif (is_callable('stream_socket_client') && false === stripos(ini_get('disable_functions'), 'stream_socket_client')) {
                $connection = @stream_socket_client("$ip:$port", $errno, $errstr, $timeout);
                if ($connection) {
                    fclose($connection);
                    $isOnline = true;
                } else {
                    throw new Exception("Unable to connect to $ip on port $port using stream_socket_client: $errstr ($errno)");
                }
            } else {
                throw new Exception("Neither fsockopen nor stream_socket_client are enabled on the server.");
            }
        } catch (Exception $e) {
            _log($e->getMessage());
            $errors[] = "Error with router $ip: " . $e->getMessage();
        }

        if ($isOnline) {
            $router->last_seen = date('Y-m-d H:i:s');
            $router->status = 'Online';
        } else {
            $router->status = 'Offline';
            $offlineRouters[] = $router;
        }

        $router->save();
    }

    if (!empty($offlineRouters)) {
        $message = "Dear Administrator,\n";
        $message .= "The following routers are offline:\n";
        foreach ($offlineRouters as $router) {
            $message .= "Name: {$router->name}, IP: {$router->ip_address}, Last Seen: {$router->last_seen}\n";
        }
        $message .= "\nPlease check the router's status and take appropriate action.\n\nBest regards,\nRouter Monitoring System";

        $adminEmail = $config['mail_from'];
        $subject = "Router Offline Alert";
        Message::SendEmail($adminEmail, $subject, $message);
        sendTelegram($message);
    }

    if (!empty($errors)) {
        $message = "The following errors occurred during router monitoring:\n";
        foreach ($errors as $error) {
            $message .= "$error\n";
        }

        $adminEmail = $config['mail_from'];
        $subject = "Router Monitoring Error Alert";
        Message::SendEmail($adminEmail, $subject, $message);
        sendTelegram($message);
    }
    echo "Router monitoring finished\n";
}


if (defined('PHP_SAPI') && PHP_SAPI === 'cli') {
    echo "Cronjob finished\n";
} else {
    echo "</pre>";
}

flock($lock, LOCK_UN);
fclose($lock);
unlink($lockFile);

$timestampFile = "$UPLOAD_PATH/cron_last_run.txt";
file_put_contents($timestampFile, time());


run_hook('cronjob_end'); #HOOK