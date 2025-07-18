<?php

/**
 * Clean Duplicate Graphs - Keep only enhanced versions
 * Removes old Monthly Registered Customers and Total Monthly Sales graphs
 */

echo "<h2>🧹 Cleaning Duplicate Graphs</h2>";

// Read the dashboard template
$dashboardFile = 'ui/ui_custom/dashboard.tpl';
$content = file_get_contents($dashboardFile);

echo "<h3>📊 Removing Old Graphs</h3>";

// Remove old Monthly Registered Customers graph
$oldRegPattern = '/{if \$_c\[\'hide_mrc\'\] != \'yes\'\}[\s\S]*?<canvas class="chart" id="chart"[\s\S]*?<\/div>[\s\S]*?{\/if}/';
$content = preg_replace($oldRegPattern, '', $content);
echo "✅ Removed old Monthly Registered Customers graph<br>";

// Remove old Total Monthly Sales graph
$oldSalesPattern = '/{if \$_c\[\'hide_tms\'\] != \'yes\'\}[\s\S]*?<canvas class="chart" id="salesChart"[\s\S]*?<\/div>[\s\S]*?{\/if}/';
$content = preg_replace($oldSalesPattern, '', $content);
echo "✅ Removed old Total Monthly Sales graph<br>";

// Remove old JavaScript for Monthly Registered Customers
$oldRegJsPattern = '/{if \$_c\[\'hide_mrc\'\] != \'yes\'\}[\s\S]*?var ctx = document\.getElementById\(\'chart\'\)[\s\S]*?{\/literal}[\s\S]*?{\/if}/';
$content = preg_replace($oldRegJsPattern, '', $content);
echo "✅ Removed old Monthly Registered Customers JavaScript<br>";

// Remove old JavaScript for Total Monthly Sales
$oldSalesJsPattern = '/{if \$_c\[\'hide_tmc\'\] != \'yes\'\}[\s\S]*?var ctx = document\.getElementById\(\'salesChart\'\)[\s\S]*?function findMonthData[\s\S]*?{\/literal}[\s\S]*?{\/if}/';
$content = preg_replace($oldSalesJsPattern, '', $content);
echo "✅ Removed old Total Monthly Sales JavaScript<br>";

// Clean up any double line breaks
$content = preg_replace("/\n\n\n+/", "\n\n", $content);

// Save the cleaned template
file_put_contents($dashboardFile, $content);
echo "✅ Saved cleaned dashboard template<br>";

// Clear template cache
shell_exec("rm -rf ui/compiled/*");
echo "✅ Cleared template cache<br>";

echo "<h3>✅ Cleanup Complete!</h3>";
echo "<h4>🎯 What Changed:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Removed:</strong> Old 'Monthly Registered Customers' graph (single total)</li>";
echo "<li>✅ <strong>Removed:</strong> Old 'Total Monthly Sales' graph (single total)</li>";
echo "<li>✅ <strong>Kept:</strong> Enhanced graphs with Hotspot/PPPoE breakdown</li>";
echo "<li>✅ <strong>Kept:</strong> Real-time metrics and M-Pesa only revenue tracking</li>";
echo "</ul>";

echo "<h4>📊 Now Showing Only:</h4>";
echo "<ul>";
echo "<li><strong>Monthly Customer Registrations:</strong> Stacked bar chart by service type</li>";
echo "<li><strong>Monthly Revenue:</strong> Line chart by service type (M-Pesa only)</li>";
echo "<li><strong>Service Analytics:</strong> Real-time active users and income</li>";
echo "<li><strong>User Insights:</strong> Pie chart of active/expired/inactive users</li>";
echo "</ul>";

?>