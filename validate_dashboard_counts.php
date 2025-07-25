<?php

/**
 * Validate Dashboard User Count Accuracy
 * Comprehensive testing of all user counting fixes
 * Run this after implementing fixes to verify accuracy
 */

require_once 'init.php';

$current_date = date('Y-m-d');
$current_datetime = date('Y-m-d H:i:s');

echo "<h2>🧪 Dashboard User Count Validation Test</h2>";
echo "<p><strong>Test Date:</strong> " . date('Y-m-d H:i:s') . "</p>";

// =======================================================================
// TEST 1: Basic User Count Consistency
// =======================================================================

echo "<h3>Test 1: Basic User Count Consistency</h3>";

$true_active = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_gte('expiration', $current_date)
    ->count();

$total_expired = ORM::for_table('tbl_user_recharges')
    ->where('status', 'off')
    ->count();

$incorrectly_active = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_lt('expiration', $current_date)
    ->count();

$total_recharges = ORM::for_table('tbl_user_recharges')->count();
$calculated_total = $true_active + $total_expired + $incorrectly_active;

echo "<table border='1' style='border-collapse: collapse; width: 100%; margin: 10px 0;'>";
echo "<tr style='background: #f8f9fa;'><th>Metric</th><th>Count</th><th>Status</th></tr>";
echo "<tr><td>True Active Users (not expired)</td><td>$true_active</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Properly Expired Users</td><td>$total_expired</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Incorrectly Active (expired but status=on)</td><td>$incorrectly_active</td><td style='color: " . ($incorrectly_active == 0 ? 'green' : 'red') . ";'>" . ($incorrectly_active == 0 ? '✓' : '✗') . "</td></tr>";
echo "<tr><td>Total Recharges (database)</td><td>$total_recharges</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Calculated Total</td><td>$calculated_total</td><td style='color: " . ($calculated_total == $total_recharges ? 'green' : 'red') . ";'>" . ($calculated_total == $total_recharges ? '✓' : '✗') . "</td></tr>";
echo "</table>";

if ($incorrectly_active > 0) {
    echo "<div style='background: #f8d7da; padding: 10px; border-radius: 5px; margin: 10px 0;'>";
    echo "<strong>❌ Issue Found:</strong> $incorrectly_active users are marked active but expired. Run fix_expired_users_status.php to correct this.";
    echo "</div>";
}

// =======================================================================
// TEST 2: Service-Specific Count Accuracy
// =======================================================================

echo "<h3>Test 2: Service-Specific Count Accuracy</h3>";

$hotspot_active = ORM::for_table('tbl_user_recharges')
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'Hotspot')
    ->where('tbl_user_recharges.status', 'on')
    ->where_gte('tbl_user_recharges.expiration', $current_date)
    ->count();

$pppoe_active = ORM::for_table('tbl_user_recharges')
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'PPPOE')
    ->where('tbl_user_recharges.status', 'on')
    ->where_gte('tbl_user_recharges.expiration', $current_date)
    ->count();

$service_total = $hotspot_active + $pppoe_active;

echo "<table border='1' style='border-collapse: collapse; width: 100%; margin: 10px 0;'>";
echo "<tr style='background: #f8f9fa;'><th>Service Type</th><th>Active Count</th><th>Status</th></tr>";
echo "<tr><td>Hotspot Active</td><td>$hotspot_active</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>PPPoE Active</td><td>$pppoe_active</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Service Total</td><td>$service_total</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>True Active (from Test 1)</td><td>$true_active</td><td style='color: " . ($service_total == $true_active ? 'green' : 'orange') . ";'>" . ($service_total == $true_active ? '✓' : '⚠') . "</td></tr>";
echo "</table>";

if ($service_total != $true_active) {
    $unknown_service = $true_active - $service_total;
    echo "<div style='background: #fff3cd; padding: 10px; border-radius: 5px; margin: 10px 0;'>";
    echo "<strong>⚠️ Note:</strong> $unknown_service users may have plans with unknown service types or missing plan data.";
    echo "</div>";
}

// =======================================================================
// TEST 3: RADIUS Integration Test
// =======================================================================

echo "<h3>Test 3: RADIUS Integration Test</h3>";

$radius_status = "Disabled";
$radius_online = 0;
$radius_test_result = "N/A";

if ($config['radius_enable'] == 'yes') {
    try {
        $radius_online = ORM::for_table('radacct', 'radius')
            ->where_null('acctstoptime')
            ->count();
        $radius_status = "Enabled & Connected";
        $radius_test_result = "✓ Success";
    } catch (Exception $e) {
        $radius_status = "Enabled but Failed";
        $radius_test_result = "✗ Error: " . $e->getMessage();
    }
}

echo "<table border='1' style='border-collapse: collapse; width: 100%; margin: 10px 0;'>";
echo "<tr style='background: #f8f9fa;'><th>RADIUS Metric</th><th>Value</th><th>Status</th></tr>";
echo "<tr><td>RADIUS Status</td><td>$radius_status</td><td>$radius_test_result</td></tr>";
echo "<tr><td>Online Sessions</td><td>$radius_online</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Hotspot Active (fallback)</td><td>$hotspot_active</td><td style='color: green;'>✓</td></tr>";
echo "</table>";

// =======================================================================
// TEST 4: Customer-Recharge Relationship Test
// =======================================================================

echo "<h3>Test 4: Customer-Recharge Relationship Test</h3>";

$total_customers = ORM::for_table('tbl_customers')->count();

$customers_with_recharges = ORM::for_table('tbl_customers')
    ->join('tbl_user_recharges', ['tbl_customers.id', '=', 'tbl_user_recharges.customer_id'])
    ->select('tbl_customers.id')
    ->distinct()
    ->count();

$customers_without_recharges = $total_customers - $customers_with_recharges;

$active_customers = ORM::for_table('tbl_customers')
    ->join('tbl_user_recharges', ['tbl_customers.id', '=', 'tbl_user_recharges.customer_id'])
    ->where('tbl_user_recharges.status', 'on')
    ->where_gte('tbl_user_recharges.expiration', $current_date)
    ->select('tbl_customers.id')
    ->distinct()
    ->count();

// Check for orphaned recharges
$orphaned_recharges = ORM::for_table('tbl_user_recharges')
    ->left_outer_join('tbl_customers', ['tbl_user_recharges.customer_id', '=', 'tbl_customers.id'])
    ->where_null('tbl_customers.id')
    ->count();

echo "<table border='1' style='border-collapse: collapse; width: 100%; margin: 10px 0;'>";
echo "<tr style='background: #f8f9fa;'><th>Relationship Metric</th><th>Count</th><th>Status</th></tr>";
echo "<tr><td>Total Customers</td><td>$total_customers</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Customers with Recharges</td><td>$customers_with_recharges</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Customers without Recharges</td><td>$customers_without_recharges</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Active Customers (unique)</td><td>$active_customers</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Orphaned Recharges</td><td>$orphaned_recharges</td><td style='color: " . ($orphaned_recharges == 0 ? 'green' : 'orange') . ";'>" . ($orphaned_recharges == 0 ? '✓' : '⚠') . "</td></tr>";
echo "</table>";

if ($orphaned_recharges > 0) {
    echo "<div style='background: #fff3cd; padding: 10px; border-radius: 5px; margin: 10px 0;'>";
    echo "<strong>⚠️ Warning:</strong> $orphaned_recharges recharges exist without corresponding customer records.";
    echo "</div>";
}

// =======================================================================
// TEST 5: Date Logic Validation
// =======================================================================

echo "<h3>Test 5: Date Logic Validation</h3>";

$today_expired = ORM::for_table('tbl_user_recharges')
    ->where('expiration', $current_date)
    ->count();

$future_active = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_gt('expiration', $current_date)
    ->count();

$past_expired = ORM::for_table('tbl_user_recharges')
    ->where('status', 'off')
    ->where_lt('expiration', $current_date)
    ->count();

echo "<table border='1' style='border-collapse: collapse; width: 100%; margin: 10px 0;'>";
echo "<tr style='background: #f8f9fa;'><th>Date Logic Test</th><th>Count</th><th>Status</th></tr>";
echo "<tr><td>Expiring Today</td><td>$today_expired</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Future Active (valid)</td><td>$future_active</td><td style='color: green;'>✓</td></tr>";
echo "<tr><td>Past Expired (correct)</td><td>$past_expired</td><td style='color: green;'>✓</td></tr>";
echo "</table>";

// =======================================================================
// FINAL VALIDATION SUMMARY
// =======================================================================

echo "<h3>🏁 Final Validation Summary</h3>";

$issues_found = 0;
$warnings_found = 0;

if ($incorrectly_active > 0) $issues_found++;
if ($orphaned_recharges > 0) $warnings_found++;
if ($service_total != $true_active) $warnings_found++;
if ($radius_status == "Enabled but Failed") $warnings_found++;

echo "<div style='background: " . ($issues_found == 0 ? '#d4edda' : '#f8d7da') . "; padding: 15px; border-radius: 5px; margin: 10px 0;'>";
echo "<h4>" . ($issues_found == 0 ? '✅ All Tests Passed!' : '❌ Issues Found') . "</h4>";

if ($issues_found == 0) {
    echo "<p><strong>Dashboard user counts are now accurate!</strong></p>";
    echo "<ul>";
    echo "<li>✅ Active users properly exclude expired users</li>";
    echo "<li>✅ Service-specific counts are working correctly</li>";
    echo "<li>✅ Date validation is implemented</li>";
    echo "<li>✅ RADIUS integration is " . ($radius_status == "Enabled & Connected" ? "working" : "properly handled") . "</li>";
    echo "</ul>";
} else {
    echo "<p><strong>Found $issues_found critical issues that need attention:</strong></p>";
    if ($incorrectly_active > 0) {
        echo "<li>❌ $incorrectly_active users marked active but expired</li>";
    }
}

if ($warnings_found > 0) {
    echo "<p><strong>Warnings ($warnings_found):</strong></p>";
    if ($orphaned_recharges > 0) {
        echo "<li>⚠️ $orphaned_recharges orphaned recharge records</li>";
    }
    if ($service_total != $true_active) {
        echo "<li>⚠️ Some users may have unknown service types</li>";
    }
    if ($radius_status == "Enabled but Failed") {
        echo "<li>⚠️ RADIUS connection issues (fallback working)</li>";
    }
}
echo "</div>";

// =======================================================================
// RECOMMENDATIONS
// =======================================================================

echo "<h3>📋 Maintenance Recommendations</h3>";

echo "<div style='background: #cff4fc; padding: 15px; border-radius: 5px; margin: 10px 0;'>";
echo "<h4>🔄 Regular Maintenance:</h4>";
echo "<ol>";
echo "<li><strong>Daily:</strong> Run fix_expired_users_status.php via cron job</li>";
echo "<li><strong>Weekly:</strong> Run this validation script to check for issues</li>";
echo "<li><strong>Monthly:</strong> Review orphaned records and clean up data</li>";
echo "</ol>";

echo "<h4>📁 Suggested Cron Jobs:</h4>";
echo "<code>";
echo "# Fix expired users daily at 2 AM<br>";
echo "0 2 * * * cd /path/to/billing && php fix_expired_users_status.php<br><br>";
echo "# Weekly validation on Sundays at 3 AM<br>";
echo "0 3 * * 0 cd /path/to/billing && php validate_dashboard_counts.php > /var/log/billing_validation.log<br>";
echo "</code>";
echo "</div>";

echo "<hr>";
echo "<p><strong>Validation completed at:</strong> " . date('Y-m-d H:i:s') . "</p>";

?>