<?php
/**
 * Payment Flow Testing Script
 * Tests the complete captive portal payment flow without actually processing payments
 * Use this to debug issues with the payment process
 */

require_once('system/autoload.php');

// Get parameters
$action = $_GET['action'] ?? 'menu';
$sessionId = $_GET['session_id'] ?? '';
$mac = $_GET['mac'] ?? '00:11:22:33:44:55';

?>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Flow Test - Glinta Africa</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 10px; }
        .section { margin: 20px 0; padding: 15px; background: #f9f9f9; border-radius: 5px; }
        .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
        .info { background: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; }
        .btn { padding: 10px 15px; margin: 5px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn:hover { background: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin: 10px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background: #f2f2f2; }
        pre { background: #f8f9fa; padding: 10px; border-radius: 3px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🧪 Payment Flow Test - Glinta Africa</h1>
        
        <?php if ($action === 'menu'): ?>
        
        <div class="section info">
            <h3>Test Options</h3>
            <p>Use this tool to test and debug the captive portal payment flow.</p>
            
            <a href="?action=check_config" class="btn">1. Check Configuration</a>
            <a href="?action=test_session&mac=<?= $mac ?>" class="btn">2. Test Session Creation</a>
            <a href="?action=check_payments" class="btn">3. Check Recent Payments</a>
            <a href="?action=check_logs" class="btn">4. Check Debug Logs</a>
            <a href="?action=simulate_callback" class="btn">5. Simulate M-Pesa Callback</a>
        </div>
        
        <?php elseif ($action === 'check_config'): ?>
        
        <div class="section">
            <h3>🔧 Configuration Check</h3>
            
            <?php
            // Check M-Pesa configuration
            $mpesa_config = ORM::for_table('tbl_pg')->where('gateway', 'Daraja')->find_one();
            if ($mpesa_config && $mpesa_config->status) {
                echo '<div class="success">✅ M-Pesa Daraja gateway is configured and enabled</div>';
                $config_data = json_decode($mpesa_config->pg_data, true);
                echo '<pre>' . print_r($config_data, true) . '</pre>';
            } else {
                echo '<div class="error">❌ M-Pesa Daraja gateway is not configured or disabled</div>';
            }
            
            // Check database tables
            $tables = ['tbl_portal_sessions', 'tbl_payment_gateway', 'tbl_user_recharges', 'tbl_transactions'];
            foreach ($tables as $table) {
                $count = ORM::for_table($table)->count();
                echo "<div class='info'>📊 Table $table: $count records</div>";
            }
            ?>
        </div>
        
        <?php elseif ($action === 'test_session'): ?>
        
        <div class="section">
            <h3>🔄 Session Creation Test</h3>
            
            <?php
            try {
                // Create test session
                $testSessionId = uniqid('test_', true);
                $session = ORM::for_table('tbl_portal_sessions')->create();
                $session->session_id = $testSessionId;
                $session->mac_address = $mac;
                $session->ip_address = '192.168.1.100';
                $session->user_agent = 'Test Agent';
                $session->created_at = date('Y-m-d H:i:s');
                $session->expires_at = date('Y-m-d H:i:s', strtotime('+2 hours'));
                $session->status = 'pending';
                $session->save();
                
                echo '<div class="success">✅ Test session created successfully</div>';
                echo '<div class="info">Session ID: ' . $testSessionId . '</div>';
                echo '<div class="info">MAC Address: ' . $mac . '</div>';
                
                echo '<a href="?action=test_payment&session_id=' . $testSessionId . '" class="btn">Test Payment Flow</a>';
                
            } catch (Exception $e) {
                echo '<div class="error">❌ Session creation failed: ' . $e->getMessage() . '</div>';
            }
            ?>
        </div>
        
        <?php elseif ($action === 'test_payment'): ?>
        
        <div class="section">
            <h3>💳 Payment Flow Test</h3>
            
            <?php
            if (empty($sessionId)) {
                echo '<div class="error">❌ Session ID required</div>';
            } else {
                $session = ORM::for_table('tbl_portal_sessions')
                    ->where('session_id', $sessionId)
                    ->find_one();
                
                if ($session) {
                    echo '<div class="success">✅ Session found</div>';
                    echo '<div class="info">Session Status: ' . $session->status . '</div>';
                    echo '<div class="info">MAC Address: ' . $session->mac_address . '</div>';
                    
                    // Create test payment record
                    $payment = ORM::for_table('tbl_payment_gateway')->create();
                    $payment->username = $session->mac_address;
                    $payment->gateway = 'Daraja';
                    $payment->plan_id = 1; // Assume plan ID 1 exists
                    $payment->plan_name = 'Test Plan';
                    $payment->price = 50;
                    $payment->created_date = date('Y-m-d H:i:s');
                    $payment->status = 1; // Pending
                    $payment->trx_invoice = 'TEST-' . time();
                    $payment->checkout_request_id = 'test_checkout_' . time();
                    $payment->save();
                    
                    // Update session with payment ID
                    $session->payment_id = $payment->id();
                    $session->status = 'processing';
                    $session->save();
                    
                    echo '<div class="success">✅ Test payment record created</div>';
                    echo '<div class="info">Payment ID: ' . $payment->id() . '</div>';
                    echo '<div class="info">Checkout Request ID: ' . $payment->checkout_request_id . '</div>';
                    
                    echo '<a href="?action=complete_payment&payment_id=' . $payment->id() . '&session_id=' . $sessionId . '" class="btn">Simulate Successful Payment</a>';
                } else {
                    echo '<div class="error">❌ Session not found</div>';
                }
            }
            ?>
        </div>
        
        <?php elseif ($action === 'complete_payment'): ?>
        
        <div class="section">
            <h3>✅ Payment Completion Test</h3>
            
            <?php
            $paymentId = $_GET['payment_id'] ?? '';
            
            if (empty($paymentId) || empty($sessionId)) {
                echo '<div class="error">❌ Payment ID and Session ID required</div>';
            } else {
                $payment = ORM::for_table('tbl_payment_gateway')
                    ->where('id', $paymentId)
                    ->find_one();
                
                $session = ORM::for_table('tbl_portal_sessions')
                    ->where('session_id', $sessionId)
                    ->find_one();
                
                if ($payment && $session) {
                    // Mark payment as successful
                    $payment->status = 2; // Paid
                    $payment->paid_date = date('Y-m-d H:i:s');
                    $payment->gateway_trx_id = 'TEST_TRX_' . time();
                    $payment->save();
                    
                    echo '<div class="success">✅ Payment marked as successful</div>';
                    
                    // Now test the callback logic
                    $plan = ORM::for_table('tbl_plans')->where('id', 1)->find_one();
                    
                    if ($plan) {
                        // Create user recharge
                        $userRecharge = ORM::for_table('tbl_user_recharges')->create();
                        $userRecharge->customer_id = 0;
                        $userRecharge->username = $session->mac_address;
                        $userRecharge->plan_id = $plan->id();
                        $userRecharge->namebp = $plan->name_plan;
                        $userRecharge->recharged_on = date('Y-m-d');
                        $userRecharge->recharged_time = date('H:i:s');
                        $userRecharge->expiration = date('Y-m-d H:i:s', strtotime('+2 hours'));
                        $userRecharge->time = date('H:i:s');
                        $userRecharge->status = 'on';
                        $userRecharge->type = 'Hotspot';
                        $userRecharge->routers = 'Main Router';
                        $userRecharge->method = 'Test Payment';
                        $userRecharge->save();
                        
                        echo '<div class="success">✅ User recharge created</div>';
                        
                        // Mark session as completed
                        $session->status = 'completed';
                        $session->save();
                        
                        echo '<div class="success">✅ Session marked as completed</div>';
                        echo '<div class="info">Now test the status check and success page</div>';
                        
                        echo '<a href="' . U . 'captive_portal/status/' . $sessionId . '?ajax=1" class="btn" target="_blank">Test Status Check</a>';
                        echo '<a href="' . U . 'captive_portal/success/' . $sessionId . '" class="btn" target="_blank">Test Success Page</a>';
                    } else {
                        echo '<div class="error">❌ No plan found with ID 1</div>';
                    }
                } else {
                    echo '<div class="error">❌ Payment or session not found</div>';
                }
            }
            ?>
        </div>
        
        <?php elseif ($action === 'check_payments'): ?>
        
        <div class="section">
            <h3>💰 Recent Payments</h3>
            
            <?php
            $payments = ORM::for_table('tbl_payment_gateway')
                ->where('gateway', 'Daraja')
                ->where_gte('created_date', date('Y-m-d H:i:s', strtotime('-24 hours')))
                ->order_by_desc('created_date')
                ->limit(10)
                ->find_many();
            
            if (count($payments) > 0) {
                echo '<table>';
                echo '<tr><th>ID</th><th>Username</th><th>Amount</th><th>Status</th><th>Created</th><th>Checkout ID</th></tr>';
                
                foreach ($payments as $payment) {
                    $statusText = [0 => 'Failed', 1 => 'Pending', 2 => 'Paid', 3 => 'Cancelled'][$payment->status] ?? 'Unknown';
                    echo '<tr>';
                    echo '<td>' . $payment->id() . '</td>';
                    echo '<td>' . $payment->username . '</td>';
                    echo '<td>KES ' . $payment->price . '</td>';
                    echo '<td>' . $statusText . '</td>';
                    echo '<td>' . $payment->created_date . '</td>';
                    echo '<td>' . ($payment->checkout_request_id ?? 'N/A') . '</td>';
                    echo '</tr>';
                }
                echo '</table>';
            } else {
                echo '<div class="info">No recent payments found</div>';
            }
            ?>
        </div>
        
        <?php elseif ($action === 'check_logs'): ?>
        
        <div class="section">
            <h3>📋 Debug Logs</h3>
            
            <?php
            $logFile = __DIR__ . '/system/uploads/captive_portal_debug.log';
            $callbackLogFile = __DIR__ . '/system/uploads/captive_portal_callbacks.log';
            
            if (file_exists($logFile)) {
                echo '<h4>Debug Log (Last 20 lines):</h4>';
                $lines = file($logFile);
                $lastLines = array_slice($lines, -20);
                echo '<pre>' . htmlspecialchars(implode('', $lastLines)) . '</pre>';
            } else {
                echo '<div class="info">Debug log file not found</div>';
            }
            
            if (file_exists($callbackLogFile)) {
                echo '<h4>Callback Log (Last 10 lines):</h4>';
                $lines = file($callbackLogFile);
                $lastLines = array_slice($lines, -10);
                echo '<pre>' . htmlspecialchars(implode('', $lastLines)) . '</pre>';
            } else {
                echo '<div class="info">Callback log file not found</div>';
            }
            ?>
        </div>
        
        <?php endif; ?>
        
        <div class="section">
            <a href="?action=menu" class="btn">🏠 Back to Menu</a>
            <a href="<?= U ?>captive_portal" class="btn">🌐 Go to Captive Portal</a>
        </div>
    </div>
</body>
</html>