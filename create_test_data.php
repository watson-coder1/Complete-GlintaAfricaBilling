<?php

/**
 * Create Test Data to Verify Dashboard Connections
 * Creates sample customers, plans, and transactions
 */

require_once 'init.php';

echo "<h2>🧪 Creating Test Data to Verify Dashboard</h2>";

// 1. Create test plans
echo "<h3>📦 Creating Test Plans</h3>";

// Hotspot plan
$hotspotPlan = ORM::for_table('tbl_plans')->create();
$hotspotPlan->name_plan = 'Test Hotspot 1GB';
$hotspotPlan->type = 'Hotspot';
$hotspotPlan->price = 100;
$hotspotPlan->validity = 1;
$hotspotPlan->validity_unit = 'Day';
$hotspotPlan->routers = '1';
$hotspotPlan->enabled = 1;
$hotspotPlan->save();
echo "✅ Created Hotspot plan (ID: " . $hotspotPlan->id . ")<br>";

// PPPoE plan
$pppoePlan = ORM::for_table('tbl_plans')->create();
$pppoePlan->name_plan = 'Test PPPoE 5GB';
$pppoePlan->type = 'PPPOE';
$pppoePlan->price = 200;
$pppoePlan->validity = 7;
$pppoePlan->validity_unit = 'Day';
$pppoePlan->routers = '1';
$pppoePlan->enabled = 1;
$pppoePlan->save();
echo "✅ Created PPPoE plan (ID: " . $pppoePlan->id . ")<br>";

// 2. Create test customers
echo "<h3>👥 Creating Test Customers</h3>";

// Hotspot customer
$hotspotCustomer = ORM::for_table('tbl_customers')->create();
$hotspotCustomer->username = 'testuser_hotspot';
$hotspotCustomer->password = 'password123';
$hotspotCustomer->fullname = 'Test Hotspot User';
$hotspotCustomer->address = 'Test Address';
$hotspotCustomer->phonenumber = '254700000001';
$hotspotCustomer->email = 'hotspot@test.com';
$hotspotCustomer->service_type = 'Hotspot';
$hotspotCustomer->created_at = date('Y-m-d H:i:s');
$hotspotCustomer->save();
echo "✅ Created Hotspot customer (ID: " . $hotspotCustomer->id . ")<br>";

// PPPoE customer
$pppoeCustomer = ORM::for_table('tbl_customers')->create();
$pppoeCustomer->username = 'testuser_pppoe';
$pppoeCustomer->password = 'password123';
$pppoeCustomer->fullname = 'Test PPPoE User';
$pppoeCustomer->address = 'Test Address';
$pppoeCustomer->phonenumber = '254700000002';
$pppoeCustomer->email = 'pppoe@test.com';
$pppoeCustomer->service_type = 'PPPoE';
$pppoeCustomer->created_at = date('Y-m-d H:i:s');
$pppoeCustomer->save();
echo "✅ Created PPPoE customer (ID: " . $pppoeCustomer->id . ")<br>";

// 3. Create test user recharges
echo "<h3>🔄 Creating Test User Recharges</h3>";

// Hotspot recharge
$hotspotRecharge = ORM::for_table('tbl_user_recharges')->create();
$hotspotRecharge->customer_id = $hotspotCustomer->id;
$hotspotRecharge->username = $hotspotCustomer->username;
$hotspotRecharge->plan_id = $hotspotPlan->id;
$hotspotRecharge->namebp = $hotspotPlan->name_plan;
$hotspotRecharge->recharged_on = date('Y-m-d');
$hotspotRecharge->recharged_time = date('H:i:s');
$hotspotRecharge->expiration = date('Y-m-d', strtotime('+1 day'));
$hotspotRecharge->time = date('H:i:s', strtotime('+1 day'));
$hotspotRecharge->status = 'on';
$hotspotRecharge->type = 'Hotspot';
$hotspotRecharge->routers = '1';
$hotspotRecharge->save();
echo "✅ Created Hotspot recharge (ID: " . $hotspotRecharge->id . ")<br>";

// PPPoE recharge
$pppoeRecharge = ORM::for_table('tbl_user_recharges')->create();
$pppoeRecharge->customer_id = $pppoeCustomer->id;
$pppoeRecharge->username = $pppoeCustomer->username;
$pppoeRecharge->plan_id = $pppoePlan->id;
$pppoeRecharge->namebp = $pppoePlan->name_plan;
$pppoeRecharge->recharged_on = date('Y-m-d');
$pppoeRecharge->recharged_time = date('H:i:s');
$pppoeRecharge->expiration = date('Y-m-d', strtotime('+7 days'));
$pppoeRecharge->time = date('H:i:s', strtotime('+7 days'));
$pppoeRecharge->status = 'on';
$pppoeRecharge->type = 'PPPOE';
$pppoeRecharge->routers = '1';
$pppoeRecharge->save();
echo "✅ Created PPPoE recharge (ID: " . $pppoeRecharge->id . ")<br>";

// 4. Create test transactions (M-Pesa)
echo "<h3>💳 Creating Test M-Pesa Transactions</h3>";

// Hotspot transaction
$hotspotTransaction = ORM::for_table('tbl_transactions')->create();
$hotspotTransaction->invoice = $hotspotRecharge->id;
$hotspotTransaction->username = $hotspotCustomer->username;
$hotspotTransaction->plan_name = $hotspotPlan->name_plan;
$hotspotTransaction->price = $hotspotPlan->price;
$hotspotTransaction->recharged_on = date('Y-m-d');
$hotspotTransaction->recharged_time = date('H:i:s');
$hotspotTransaction->expiration = date('Y-m-d', strtotime('+1 day'));
$hotspotTransaction->time = date('H:i:s', strtotime('+1 day'));
$hotspotTransaction->method = 'M-Pesa STK Push';
$hotspotTransaction->routers = '1';
$hotspotTransaction->save();
echo "✅ Created Hotspot M-Pesa transaction: KES " . $hotspotPlan->price . "<br>";

// PPPoE transaction
$pppoeTransaction = ORM::for_table('tbl_transactions')->create();
$pppoeTransaction->invoice = $pppoeRecharge->id;
$pppoeTransaction->username = $pppoeCustomer->username;
$pppoeTransaction->plan_name = $pppoePlan->name_plan;
$pppoeTransaction->price = $pppoePlan->price;
$pppoeTransaction->recharged_on = date('Y-m-d');
$pppoeTransaction->recharged_time = date('H:i:s');
$pppoeTransaction->expiration = date('Y-m-d', strtotime('+7 days'));
$pppoeTransaction->time = date('H:i:s', strtotime('+7 days'));
$pppoeTransaction->method = 'M-Pesa STK Push';
$pppoeTransaction->routers = '1';
$pppoeTransaction->save();
echo "✅ Created PPPoE M-Pesa transaction: KES " . $pppoePlan->price . "<br>";

// 5. Create RADIUS session for Hotspot user
echo "<h3>🌐 Creating Test RADIUS Session</h3>";
try {
    $radiusSession = ORM::for_table('radacct', 'radius')->create();
    $radiusSession->username = $hotspotCustomer->username;
    $radiusSession->groupname = 'hotspot';
    $radiusSession->realm = '';
    $radiusSession->nasipaddress = '192.168.1.1';
    $radiusSession->nasportid = '1';
    $radiusSession->nasporttype = 'Ethernet';
    $radiusSession->acctstarttime = date('Y-m-d H:i:s');
    $radiusSession->acctupdatetime = date('Y-m-d H:i:s');
    $radiusSession->acctstoptime = null; // Active session
    $radiusSession->acctinputoctets = 1024000;
    $radiusSession->acctoutputoctets = 2048000;
    $radiusSession->calledstationid = 'AP-Test';
    $radiusSession->callingstationid = '00:11:22:33:44:55';
    $radiusSession->acctterminatecause = '';
    $radiusSession->servicetype = 'Framed-User';
    $radiusSession->framedprotocol = 'PPP';
    $radiusSession->framedipaddress = '192.168.100.10';
    $radiusSession->save();
    echo "✅ Created active RADIUS session for hotspot user<br>";
} catch (Exception $e) {
    echo "⚠️ Could not create RADIUS session: " . $e->getMessage() . "<br>";
}

// 6. Clear cache to refresh dashboard data
echo "<h3>🗑️ Clearing Cache</h3>";
$cacheFiles = glob('storage/cache/*.temp');
foreach ($cacheFiles as $file) {
    unlink($file);
}
echo "✅ Cleared dashboard cache<br>";

// 7. Verify test data
echo "<h3>✅ Test Data Summary</h3>";
echo "<ul>";
echo "<li><strong>Plans Created:</strong> 1 Hotspot (KES 100), 1 PPPoE (KES 200)</li>";
echo "<li><strong>Customers Created:</strong> 1 Hotspot, 1 PPPoE</li>";
echo "<li><strong>Active Recharges:</strong> 2 (both currently active)</li>";
echo "<li><strong>M-Pesa Transactions:</strong> KES " . ($hotspotPlan->price + $pppoePlan->price) . " total today</li>";
echo "<li><strong>Service Breakdown:</strong> Hotspot KES " . $hotspotPlan->price . ", PPPoE KES " . $pppoePlan->price . "</li>";
echo "<li><strong>RADIUS Session:</strong> 1 active hotspot user</li>";
echo "</ul>";

echo "<h3>📊 Expected Dashboard Values:</h3>";
echo "<ul>";
echo "<li><strong>Income Today:</strong> KES " . ($hotspotPlan->price + $pppoePlan->price) . "</li>";
echo "<li><strong>Income This Month:</strong> KES " . ($hotspotPlan->price + $pppoePlan->price) . "</li>";
echo "<li><strong>Active/Expired:</strong> 2/0</li>";
echo "<li><strong>Customers:</strong> 2</li>";
echo "<li><strong>Hotspot Income Today:</strong> KES " . $hotspotPlan->price . "</li>";
echo "<li><strong>PPPoE Income Today:</strong> KES " . $pppoePlan->price . "</li>";
echo "<li><strong>Hotspot Online:</strong> 1</li>";
echo "<li><strong>PPPoE Active:</strong> 1</li>";
echo "</ul>";

echo "<p><strong>🎯 Now refresh your dashboard to see real data!</strong></p>";

?>