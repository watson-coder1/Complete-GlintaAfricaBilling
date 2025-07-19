<?php

/**
 * Mikrotik Configuration Generator
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * Generates Mikrotik RouterOS configuration for RADIUS integration
 */

require_once 'init.php';

// Check admin access using the same method as other controllers
try {
    $admin = Admin::_info();
    if (!$admin) {
        header('Location: ' . U . 'login');
        exit;
    }
} catch (Exception $e) {
    header('Location: ' . U . 'login');
    exit;
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mikrotik Configuration Generator</title>
    <link rel="stylesheet" href="ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="ui/ui/fonts/font-awesome/css/font-awesome.min.css">
    <style>
        body { padding: 20px; }
        .config-box {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin: 10px 0;
            font-family: 'Courier New', monospace;
            font-size: 12px;
        }
        .copy-btn {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fa fa-router"></i> Mikrotik Configuration Generator</h1>
        
        <div class="alert alert-info">
            <h4><i class="fa fa-info-circle"></i> How to Use</h4>
            <ol>
                <li>Copy the configuration commands below</li>
                <li>Connect to your Mikrotik router via Winbox or SSH</li>
                <li>Paste the commands into the terminal</li>
                <li>Test the connection with the test commands</li>
            </ol>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <h3>1. RADIUS Server Configuration</h3>
                <div class="config-box">
/radius<br>
add address=<?php echo $_SERVER['SERVER_ADDR'] ?? 'YOUR_SERVER_IP'; ?> secret=radius123 service=hotspot,login comment="PHPNuxBill RADIUS"<br>
add address=<?php echo $_SERVER['SERVER_ADDR'] ?? 'YOUR_SERVER_IP'; ?> secret=radius123 service=hotspot,login comment="PHPNuxBill RADIUS Backup"<br>
<br>
# Enable RADIUS for system users<br>
/user aaa<br>
set use-radius=yes<br>
</div>
                <button class="btn btn-primary copy-btn" onclick="copyToClipboard('radius-config')">
                    <i class="fa fa-copy"></i> Copy RADIUS Config
                </button>
            </div>
            
            <div class="col-md-6">
                <h3>2. Hotspot Setup</h3>
                <div class="config-box">
# Create hotspot interface<br>
/interface bridge<br>
add name=hotspot-bridge<br>
<br>
/ip hotspot<br>
add name=hotspot1 interface=hotspot-bridge address-pool=hotspot-pool profile=hsprof1<br>
<br>
# Create IP pool for hotspot clients<br>
/ip pool<br>
add name=hotspot-pool ranges=192.168.10.10-192.168.10.100<br>
<br>
# Set IP address for hotspot interface<br>
/ip address<br>
add address=192.168.10.1/24 interface=hotspot-bridge<br>
</div>
                <button class="btn btn-primary copy-btn" onclick="copyToClipboard('hotspot-config')">
                    <i class="fa fa-copy"></i> Copy Hotspot Config
                </button>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <h3>3. Hotspot Profile Configuration</h3>
                <div class="config-box">
/ip hotspot profile<br>
set hsprof1 \<br>
&nbsp;&nbsp;dns-name="wifi.local" \<br>
&nbsp;&nbsp;hotspot-address=192.168.10.1 \<br>
&nbsp;&nbsp;html-directory=hotspot \<br>
&nbsp;&nbsp;http-cookie-lifetime=1d \<br>
&nbsp;&nbsp;http-proxy=0.0.0.0:0 \<br>
&nbsp;&nbsp;login-by=cookie,http-chap \<br>
&nbsp;&nbsp;radius-accounting=yes \<br>
&nbsp;&nbsp;radius-default-domain="" \<br>
&nbsp;&nbsp;radius-interim-update=5m \<br>
&nbsp;&nbsp;radius-location-id="" \<br>
&nbsp;&nbsp;radius-location-name="" \<br>
&nbsp;&nbsp;radius-mac-format=XX:XX:XX:XX:XX:XX \<br>
&nbsp;&nbsp;use-radius=yes<br>
</div>
                <button class="btn btn-primary copy-btn" onclick="copyToClipboard('profile-config')">
                    <i class="fa fa-copy"></i> Copy Profile Config
                </button>
            </div>
            
            <div class="col-md-6">
                <h3>4. PPPoE Server Configuration</h3>
                <div class="config-box">
# Enable PPPoE server<br>
/interface pppoe-server server<br>
add interface=ether2 service-name=internet default-profile=pppoe-profile one-session-per-host=yes<br>
<br>
# Create PPPoE profile<br>
/ppp profile<br>
add name=pppoe-profile \<br>
&nbsp;&nbsp;local-address=10.0.0.1 \<br>
&nbsp;&nbsp;remote-address=pppoe-pool \<br>
&nbsp;&nbsp;use-radius=yes \<br>
&nbsp;&nbsp;only-one=yes<br>
<br>
# Create IP pool for PPPoE clients<br>
/ip pool<br>
add name=pppoe-pool ranges=10.0.0.10-10.0.0.100<br>
</div>
                <button class="btn btn-primary copy-btn" onclick="copyToClipboard('pppoe-config')">
                    <i class="fa fa-copy"></i> Copy PPPoE Config
                </button>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <h3>5. DHCP Server for Hotspot</h3>
                <div class="config-box">
/ip dhcp-server<br>
add address-pool=hotspot-dhcp interface=hotspot-bridge name=hotspot-dhcp<br>
<br>
/ip pool<br>
add name=hotspot-dhcp ranges=192.168.10.50-192.168.10.200<br>
<br>
/ip dhcp-server network<br>
add address=192.168.10.0/24 gateway=192.168.10.1 dns-server=8.8.8.8,8.8.4.4<br>
</div>
                <button class="btn btn-primary copy-btn" onclick="copyToClipboard('dhcp-config')">
                    <i class="fa fa-copy"></i> Copy DHCP Config
                </button>
            </div>
            
            <div class="col-md-6">
                <h3>6. Firewall Rules</h3>
                <div class="config-box">
# Allow RADIUS traffic<br>
/ip firewall filter<br>
add action=accept chain=input protocol=udp port=1812,1813 src-address=<?php echo $_SERVER['SERVER_ADDR'] ?? 'YOUR_SERVER_IP'; ?> comment="RADIUS Auth/Acct"<br>
<br>
# NAT for hotspot users<br>
/ip firewall nat<br>
add action=masquerade chain=srcnat src-address=192.168.10.0/24 comment="Hotspot NAT"<br>
<br>
# NAT for PPPoE users<br>
add action=masquerade chain=srcnat src-address=10.0.0.0/24 comment="PPPoE NAT"<br>
</div>
                <button class="btn btn-primary copy-btn" onclick="copyToClipboard('firewall-config')">
                    <i class="fa fa-copy"></i> Copy Firewall Config
                </button>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <h3>7. Test Commands</h3>
                <div class="config-box">
# Test RADIUS connectivity<br>
/radius incoming<br>
monitor [find] once<br>
<br>
# Check hotspot active users<br>
/ip hotspot active print<br>
<br>
# Check PPPoE active sessions<br>
/ppp active print<br>
<br>
# Monitor RADIUS packets<br>
/radius incoming<br>
monitor [find] duration=10<br>
<br>
# Check system logs<br>
/log print where topics~"radius"<br>
</div>
                <button class="btn btn-success copy-btn" onclick="copyToClipboard('test-config')">
                    <i class="fa fa-copy"></i> Copy Test Commands
                </button>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <h3>8. Captive Portal Integration</h3>
                <div class="alert alert-warning">
                    <h4><i class="fa fa-exclamation-triangle"></i> Important Notes</h4>
                    <ul>
                        <li><strong>RADIUS Secret:</strong> Use <code>radius123</code> or change it in both Mikrotik and PHPNuxBill</li>
                        <li><strong>Server IP:</strong> Replace <code><?php echo $_SERVER['SERVER_ADDR'] ?? 'YOUR_SERVER_IP'; ?></code> with your actual server IP</li>
                        <li><strong>Redirect URL:</strong> Set hotspot login page to: <code>http://<?php echo $_SERVER['SERVER_NAME'] ?? 'your-domain.com'; ?>/mpesa_payment.php</code></li>
                        <li><strong>Network Ranges:</strong> Adjust IP ranges based on your network setup</li>
                        <li><strong>DNS Settings:</strong> Configure appropriate DNS servers for your location</li>
                    </ul>
                </div>
                
                <div class="config-box">
# Set custom login page for hotspot<br>
/ip hotspot walled-garden<br>
add dst-host=<?php echo $_SERVER['SERVER_NAME'] ?? 'your-domain.com'; ?> comment="Payment Portal"<br>
add dst-host=safaricom.co.ke comment="M-Pesa API"<br>
<br>
# Set login page URL<br>
/ip hotspot profile<br>
set hsprof1 login-by=http-chap,cookie \<br>
&nbsp;&nbsp;http-proxy=0.0.0.0:0 \<br>
&nbsp;&nbsp;html-directory=hotspot<br>
</div>
                <button class="btn btn-info copy-btn" onclick="copyToClipboard('portal-config')">
                    <i class="fa fa-copy"></i> Copy Portal Config
                </button>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <h4>Setup Verification Checklist</h4>
                    </div>
                    <div class="panel-body">
                        <div class="checkbox">
                            <label><input type="checkbox"> RADIUS server configured with correct IP and secret</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Hotspot interface and profile created</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> PPPoE server configured (if using PPPoE)</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> DHCP server configured for hotspot clients</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Firewall rules allow RADIUS traffic</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> NAT rules configured for internet access</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Walled garden configured for payment portal</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Test user created and verified</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function copyToClipboard(configType) {
            const configBoxes = document.querySelectorAll('.config-box');
            let textToCopy = '';
            
            // Find the right config box based on the button clicked
            const button = event.target.closest('button');
            const configBox = button.previousElementSibling;
            
            if (configBox && configBox.classList.contains('config-box')) {
                textToCopy = configBox.innerText;
            }
            
            // Create temporary textarea to copy text
            const textarea = document.createElement('textarea');
            textarea.value = textToCopy;
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand('copy');
            document.body.removeChild(textarea);
            
            // Show feedback
            const originalText = button.innerHTML;
            button.innerHTML = '<i class="fa fa-check"></i> Copied!';
            button.classList.remove('btn-primary', 'btn-success', 'btn-info');
            button.classList.add('btn-success');
            
            setTimeout(() => {
                button.innerHTML = originalText;
                button.classList.remove('btn-success');
                button.classList.add('btn-primary');
            }, 2000);
        }
    </script>
</body>
</html>