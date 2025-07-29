<?php
/**
 * Fix for Captive Portal Redirect Issue
 * This script ensures proper MikroTik authentication after payment
 * 
 * Run this on your Digital Ocean server to fix the redirect loop issue
 */

// Step 1: Update the success page template to include proper MikroTik authentication
$success_template_fix = <<<'EOF'
<!-- Add this JavaScript section to the success page to handle MikroTik authentication -->
<script>
// MikroTik Authentication Handler
(function() {
    // Get MikroTik parameters from URL or session
    var mikrotikParams = {
        'link-login': '{$mikrotik_link_login|default:"http://192.168.88.1/login"}',
        'link-login-only': '{$mikrotik_link_login_only|default:"http://192.168.88.1/login"}',
        'link-orig': '{$mikrotik_link_orig|default:"https://www.google.com"}',
        'link-orig-esc': '{$mikrotik_link_orig_esc|default:"https://www.google.com"}',
        'mac': '{$mac_address}',
        'ip': '{$mikrotik_ip|default:$session->ip_address}',
        'username': '{$mac_address}',
        'password': '{$mac_address}',
        'dst': '{$mikrotik_dst|default:"https://www.google.com"}',
        'popup': 'true'
    };
    
    console.log('MikroTik params:', mikrotikParams);
    
    // Function to authenticate with MikroTik
    function authenticateWithMikrotik() {
        // Get RADIUS credentials from PHP
        var radiusUsername = '{if $user_recharge}{$user_recharge->username|replace:":":""}{else}{$mac_address|replace:":":""}{/if}';
        var radiusPassword = '{if $customer}{$customer->password}{else}{$mac_address}{/if}';
        
        console.log('Authenticating with RADIUS username:', radiusUsername);
        
        // Build authentication URL
        var authUrl = mikrotikParams['link-login-only'] + 
            '?username=' + encodeURIComponent(radiusUsername) +
            '&password=' + encodeURIComponent(radiusPassword) +
            '&dst=' + encodeURIComponent(mikrotikParams['link-orig']);
        
        console.log('Auth URL:', authUrl);
        
        // Create invisible iframe for authentication
        var iframe = document.createElement('iframe');
        iframe.style.display = 'none';
        iframe.src = authUrl;
        document.body.appendChild(iframe);
        
        // Also try form submission method
        setTimeout(function() {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = mikrotikParams['link-login-only'];
            form.target = '_blank';
            
            var fields = {
                'username': radiusUsername,
                'password': radiusPassword,
                'dst': mikrotikParams['link-orig'],
                'popup': 'true'
            };
            
            for (var key in fields) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = fields[key];
                form.appendChild(input);
            }
            
            document.body.appendChild(form);
            form.submit();
            
            // Redirect to destination after authentication
            setTimeout(function() {
                window.location.href = mikrotikParams['link-orig'];
            }, 2000);
        }, 1000);
    }
    
    // Authenticate immediately when page loads
    window.addEventListener('load', function() {
        console.log('Page loaded, starting MikroTik authentication...');
        authenticateWithMikrotik();
    });
    
    // Also authenticate when countdown reaches 0
    window.authenticateWithMikrotik = authenticateWithMikrotik;
})();
</script>
EOF;

echo "Fix Script for Captive Portal Redirect Issue\n";
echo "============================================\n\n";

// Step 2: Update the callback to ensure proper RADIUS user creation
$callback_fix = <<<'PHP'
// Add this to the activate_hotspot_service function in callback_mpesa.php
// After creating RADIUS user, ensure MAC authentication is enabled

// For MAC-based authentication, create additional entries
$mac_without_colons = str_replace(':', '', strtolower($mac_address));

// Create Auth-Type entry for MAC authentication
$radcheck_auth = ORM::for_table('radcheck', 'radius')->create();
$radcheck_auth->username = $mac_without_colons;
$radcheck_auth->attribute = 'Auth-Type';
$radcheck_auth->op = ':=';
$radcheck_auth->value = 'Accept';
$radcheck_auth->save();

// Create Calling-Station-Id check
$radcheck_mac = ORM::for_table('radcheck', 'radius')->create();
$radcheck_mac->username = $mac_without_colons;
$radcheck_mac->attribute = 'Calling-Station-Id';
$radcheck_mac->op = '==';
$radcheck_mac->value = $mac_address;
$radcheck_mac->save();

// Enable simultaneous use
$radcheck_simul = ORM::for_table('radcheck', 'radius')->create();
$radcheck_simul->username = $mac_without_colons;
$radcheck_simul->attribute = 'Simultaneous-Use';
$radcheck_simul->op = ':=';
$radcheck_simul->value = '1';
$radcheck_simul->save();
PHP;

// Step 3: Create MikroTik authentication endpoint
$auth_endpoint = <<<'PHP'
<?php
/**
 * MikroTik Authentication Endpoint
 * Place this file as: mikrotik_auth.php
 */

require_once 'init.php';

header('Content-Type: application/json');

// Get parameters
$mac = $_REQUEST['mac'] ?? '';
$ip = $_REQUEST['ip'] ?? '';
$session_id = $_REQUEST['session_id'] ?? '';

if (empty($mac)) {
    die(json_encode(['success' => false, 'message' => 'MAC address required']));
}

// Clean MAC address
$mac = strtolower(preg_replace('/[^a-f0-9:]/', '', $mac));
$mac_no_colons = str_replace(':', '', $mac);

// Check if user has active session
$active_recharge = ORM::for_table('tbl_user_recharges')
    ->where('username', $mac)
    ->where('status', 'on')
    ->where_gt('expiration', date('Y-m-d'))
    ->find_one();

if (!$active_recharge) {
    die(json_encode(['success' => false, 'message' => 'No active session found']));
}

// Get RADIUS credentials
$radcheck = ORM::for_table('radcheck', 'radius')
    ->where('username', $mac_no_colons)
    ->where('attribute', 'Cleartext-Password')
    ->find_one();

if (!$radcheck) {
    die(json_encode(['success' => false, 'message' => 'RADIUS user not found']));
}

// Return authentication details
echo json_encode([
    'success' => true,
    'username' => $mac_no_colons,
    'password' => $radcheck->value,
    'mac' => $mac,
    'expires' => $active_recharge->expiration,
    'plan' => $active_recharge->namebp
]);
PHP;

// Step 4: Update captive portal controller to handle authentication better
$controller_fix = <<<'PHP'
// Add this to the success case in captive_portal.php controller

// After finding the session and before displaying the template:

// Get RADIUS credentials for the user
$radius_username = str_replace(':', '', strtolower($session->mac_address));
$radius_user = ORM::for_table('radcheck', 'radius')
    ->where('username', $radius_username)
    ->where('attribute', 'Cleartext-Password')
    ->find_one();

if ($radius_user) {
    $ui->assign('radius_username', $radius_username);
    $ui->assign('radius_password', $radius_user->value);
} else {
    // Fallback to MAC address
    $ui->assign('radius_username', $radius_username);
    $ui->assign('radius_password', $session->mac_address);
}

// Ensure we have MikroTik parameters
$ui->assign('mikrotik_link_login', $_GET['link-login'] ?? 'http://192.168.88.1/login');
$ui->assign('mikrotik_link_login_only', $_GET['link-login-only'] ?? 'http://192.168.88.1/login');
$ui->assign('mikrotik_link_orig', $_GET['link-orig'] ?? 'https://www.google.com');
$ui->assign('mikrotik_mac', $_GET['mac'] ?? $session->mac_address);
$ui->assign('mikrotik_ip', $_GET['ip'] ?? $session->ip_address);
PHP;

// Step 5: Create deployment instructions
echo "DEPLOYMENT INSTRUCTIONS:\n";
echo "========================\n\n";

echo "1. SSH into your Digital Ocean server:\n";
echo "   ssh root@YOUR_SERVER_IP\n\n";

echo "2. Navigate to your web directory:\n";
echo "   cd /var/www/glintaafrica\n\n";

echo "3. Create the MikroTik auth endpoint:\n";
echo "   nano mikrotik_auth.php\n";
echo "   [Paste the auth endpoint code above]\n\n";

echo "4. Update the success template:\n";
echo "   - Edit ui/ui/captive_portal_success.tpl\n";
echo "   - Add the JavaScript authentication code above\n";
echo "   - Place it before the existing countdown script\n\n";

echo "5. Update the captive portal controller:\n";
echo "   - Edit system/controllers/captive_portal.php\n";
echo "   - In the 'success' case, add the RADIUS credential lookup\n";
echo "   - Add the code before $ui->display('captive_portal_success.tpl');\n\n";

echo "6. Update the callback for MAC authentication:\n";
echo "   - Edit callback_mpesa.php\n";
echo "   - In activate_hotspot_service function\n";
echo "   - Add MAC authentication entries as shown above\n\n";

echo "7. Configure MikroTik Hotspot:\n";
echo "   - Login to your MikroTik router\n";
echo "   - Go to IP > Hotspot > Server Profiles\n";
echo "   - Edit your profile and set:\n";
echo "     * Login By: MAC, HTTP CHAP\n";
echo "     * MAC Auth. Mode: Use RADIUS\n";
echo "     * MAC Auth. Password: Same as username\n\n";

echo "8. Update RADIUS configuration:\n";
echo "   - Ensure your RADIUS server accepts MAC authentication\n";
echo "   - Check that MAC addresses are formatted correctly\n\n";

echo "9. Clear cache and restart services:\n";
echo "   docker-compose -f docker-compose.production.yml restart\n";
echo "   rm -rf ui/compiled/*\n\n";

echo "10. Test the fix:\n";
echo "    - Connect to WiFi\n";
echo "    - Make a payment\n";
echo "    - Verify you're redirected to Google successfully\n\n";

// Additional debugging tips
echo "\nDEBUGGING TIPS:\n";
echo "===============\n\n";

echo "1. Check RADIUS logs:\n";
echo "   docker logs glinta-freeradius-prod -f\n\n";

echo "2. Monitor captive portal logs:\n";
echo "   tail -f logs/captive_portal_debug.log\n\n";

echo "3. Check MikroTik logs:\n";
echo "   /log print where topics~\"hotspot\"\n\n";

echo "4. Verify RADIUS users:\n";
echo "   docker exec -it glinta-mysql-prod mysql -u root -p\n";
echo "   USE radius;\n";
echo "   SELECT * FROM radcheck WHERE username LIKE '%YOUR_MAC%';\n\n";

echo "\nCOMMON ISSUES:\n";
echo "==============\n\n";

echo "1. If redirect still loops:\n";
echo "   - Check MikroTik hotspot profile settings\n";
echo "   - Ensure MAC authentication is enabled\n";
echo "   - Verify RADIUS shared secret matches\n\n";

echo "2. If authentication fails:\n";
echo "   - Check MAC address format (with/without colons)\n";
echo "   - Verify RADIUS password is correct\n";
echo "   - Check firewall rules on MikroTik\n\n";

echo "3. If Google doesn't load:\n";
echo "   - Check DNS settings on MikroTik\n";
echo "   - Verify NAT rules are correct\n";
echo "   - Test with a different destination URL\n\n";

echo "\nScript completed! Follow the instructions above to fix the redirect issue.\n";