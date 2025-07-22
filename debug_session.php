<?php
/**
 * Debug Session Status Checker
 * Check MAC address session and payment status
 */

require_once 'init.php';

// Get MAC address from parameter
$mac = $_GET['mac'] ?? '';

if (!$mac) {
    echo "Usage: debug_session.php?mac=MAC_ADDRESS";
    exit;
}

// Check session
$session = ORM::for_table('tbl_portal_sessions')
    ->where('mac_address', $mac)
    ->order_by_desc('id')
    ->find_one();

// Check payment
$payment = null;
if ($session && $session->payment_id) {
    $payment = ORM::for_table('tbl_payment_gateway')
        ->where('id', $session->payment_id)
        ->find_one();
}

// Check user recharge
$userRecharge = ORM::for_table('tbl_user_recharges')
    ->where('username', $mac)
    ->where('status', 'on')
    ->where_gt('expiration', date('Y-m-d H:i:s'))
    ->find_one();

// Check RADIUS user
$radiusUser = ORM::for_table('radcheck', 'radius')
    ->where('username', $mac)
    ->where('attribute', 'Cleartext-Password')
    ->find_one();

?>
<!DOCTYPE html>
<html>
<head>
    <title>Session Debug for <?php echo htmlspecialchars($mac); ?></title>
    <style>
        body { font-family: monospace; background: #1a1a1a; color: #00ff00; padding: 20px; }
        .section { margin: 20px 0; padding: 15px; border: 1px solid #333; background: #2a2a2a; }
        .success { color: #00ff00; }
        .error { color: #ff0000; }
        .warning { color: #ffaa00; }
        .info { color: #00aaff; }
        pre { background: #333; padding: 10px; overflow-x: auto; }
    </style>
</head>
<body>
    <h1>🔍 Session Debug for MAC: <?php echo htmlspecialchars($mac); ?></h1>
    
    <div class="section">
        <h2>📊 Session Status</h2>
        <?php if ($session): ?>
            <div class="success">✅ Session Found</div>
            <pre><?php print_r($session->as_array()); ?></pre>
        <?php else: ?>
            <div class="error">❌ No Session Found</div>
        <?php endif; ?>
    </div>
    
    <div class="section">
        <h2>💳 Payment Status</h2>
        <?php if ($payment): ?>
            <div class="success">✅ Payment Found</div>
            <div class="info">Status: <?php echo $payment->status; ?> (2 = Success)</div>
            <pre><?php print_r($payment->as_array()); ?></pre>
        <?php else: ?>
            <div class="error">❌ No Payment Found</div>
        <?php endif; ?>
    </div>
    
    <div class="section">
        <h2>🔄 User Recharge Status</h2>
        <?php if ($userRecharge): ?>
            <div class="success">✅ Active Recharge Found</div>
            <pre><?php print_r($userRecharge->as_array()); ?></pre>
        <?php else: ?>
            <div class="error">❌ No Active Recharge Found</div>
        <?php endif; ?>
    </div>
    
    <div class="section">
        <h2>🔐 RADIUS User Status</h2>
        <?php if ($radiusUser): ?>
            <div class="success">✅ RADIUS User Exists</div>
            <?php
            $allRadiusAttrs = ORM::for_table('radcheck', 'radius')
                ->where('username', $mac)
                ->find_many();
            foreach ($allRadiusAttrs as $attr):
            ?>
                <div><?php echo $attr->attribute; ?>: <?php echo $attr->value; ?></div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="error">❌ No RADIUS User Found</div>
        <?php endif; ?>
    </div>
    
    <div class="section">
        <h2>🎯 Diagnosis</h2>
        <?php
        if ($session && $payment && $payment->status == 2 && $userRecharge && $radiusUser) {
            echo '<div class="success">✅ EVERYTHING LOOKS GOOD - Should have internet access!</div>';
        } else {
            echo '<div class="error">❌ ISSUES FOUND:</div>';
            if (!$session) echo '<div class="error">- No portal session</div>';
            if (!$payment) echo '<div class="error">- No payment record</div>';
            if ($payment && $payment->status != 2) echo '<div class="error">- Payment not successful (status: ' . $payment->status . ')</div>';
            if (!$userRecharge) echo '<div class="error">- No active user recharge</div>';
            if (!$radiusUser) echo '<div class="error">- No RADIUS user</div>';
        }
        ?>
    </div>
    
    <div class="section">
        <h2>🔧 Quick Actions</h2>
        <a href="?mac=<?php echo urlencode($mac); ?>&action=force_radius" style="color: #00aaff;">Force Create RADIUS User</a><br>
        <a href="?mac=<?php echo urlencode($mac); ?>&action=force_recharge" style="color: #00aaff;">Force Create User Recharge</a>
    </div>
</body>
</html>

<?php
// Handle quick actions
if (isset($_GET['action']) && $session && $payment && $payment->status == 2) {
    if ($_GET['action'] == 'force_radius' && !$radiusUser) {
        // Force create RADIUS user
        require_once 'system/autoload/RadiusManager.php';
        $plan = ORM::for_table('tbl_plans')->find_one($session->plan_id);
        $result = RadiusManager::createHotspotUser($mac, $mac, $plan, date('Y-m-d H:i:s', strtotime('+2 hours')));
        echo '<script>alert("RADIUS user creation result: ' . $result['message'] . '"); location.reload();</script>';
    }
    
    if ($_GET['action'] == 'force_recharge' && !$userRecharge) {
        // Force create user recharge
        $plan = ORM::for_table('tbl_plans')->find_one($session->plan_id);
        if ($plan) {
            $newRecharge = ORM::for_table('tbl_user_recharges')->create();
            $newRecharge->customer_id = 0;
            $newRecharge->username = $mac;
            $newRecharge->plan_id = $plan->id();
            $newRecharge->namebp = $plan->name_plan;
            $newRecharge->recharged_on = date('Y-m-d');
            $newRecharge->recharged_time = date('H:i:s');
            $newRecharge->expiration = date('Y-m-d H:i:s', strtotime('+2 hours'));
            $newRecharge->time = date('H:i:s');
            $newRecharge->status = 'on';
            $newRecharge->method = 'M-Pesa STK Push';
            $newRecharge->routers = 'Main Router';
            $newRecharge->type = 'Hotspot';
            $newRecharge->admin_id = 1;
            $newRecharge->save();
            echo '<script>alert("User recharge created successfully!"); location.reload();</script>';
        }
    }
}
?>