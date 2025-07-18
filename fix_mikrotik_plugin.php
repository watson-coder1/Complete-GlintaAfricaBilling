<?php
/**
 * Fix script to add null checks to all Mikrotik Monitor functions
 */

$file = 'system/plugin/mikrotik_monitor.php';
$content = file_get_contents($file);

// List of functions that need fixing
$functions_to_fix = [
    'mikrotik_monitor_get_traffic',
    'mikrotik_monitor_get_ppp_users',
    'mikrotik_monitor_get_hotspot_users',
    'mikrotik_monitor_get_resources_json'
];

foreach ($functions_to_fix as $func) {
    // Pattern to find function and the lines that need protection
    $pattern = "/function $func\(\)\s*\{\s*global \$routes;\s*\$router = \$routes\['2'\];\s*\$mikrotik = ORM::for_table\('tbl_routers'\)->where\('enabled', '1'\)->find_one\(\$router\);\s*\$client = Mikrotik::getClient\(\$mikrotik\['ip_address'\], \$mikrotik\['username'\], \$mikrotik\['password'\]\);/";
    
    $replacement = "function $func()
{
    global \$routes;
    \$router = \$routes['2'];
    \$mikrotik = ORM::for_table('tbl_routers')->where('enabled', '1')->find_one(\$router);
    
    if (!\$mikrotik) {
        return [];
    }
    
    \$client = Mikrotik::getClient(\$mikrotik['ip_address'], \$mikrotik['username'], \$mikrotik['password']);
    
    if (!\$client) {
        return [];
    }";
    
    $content = preg_replace($pattern, $replacement, $content);
}

// Save the fixed content
file_put_contents($file, $content);
echo "Fixed Mikrotik Monitor plugin functions.\n";
?>