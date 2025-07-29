# Complete Guide to Fix M-PESA STK and RADIUS Issues

## Overview
This guide will help you:
1. Fix M-PESA STK Push not working on captive portal
2. Fix internet access not being granted after payment
3. Migrate from external RADIUS to Docker-integrated RADIUS

## Step 1: Update Environment Configuration

First, update your `.env` file with your actual M-PESA credentials:

```bash
# Edit the .env file
nano .env

# Add your actual M-PESA credentials:
MPESA_CONSUMER_KEY=your_actual_consumer_key
MPESA_CONSUMER_SECRET=your_actual_consumer_secret
MPESA_BUSINESS_SHORTCODE=your_actual_shortcode
MPESA_PASSKEY=your_actual_passkey
```

## Step 2: Stop External RADIUS

Since you have RADIUS running in Docker, stop the external one:

```bash
# Stop and disable external FreeRADIUS
sudo systemctl stop freeradius
sudo systemctl disable freeradius

# Check if it's stopped
sudo systemctl status freeradius
```

## Step 3: Configure Docker RADIUS

Update the config.php to use Docker RADIUS:

```bash
# Edit config.php
nano config.php

# Update RADIUS connection settings:
$radius_host = "mysql";  # Use Docker service name
$radius_user = "glinta_user";
$radius_pass = "Glinta2025!";
$radius_name = "glinta_billing";
```

## Step 4: Fix M-PESA STK Push Issue

The main issue is in the captive portal redirect after payment. Apply these fixes:

### 4.1 Update Captive Portal Success Template

Edit `ui/ui/captive_portal_success.tpl` and add this JavaScript before the existing countdown script:

```javascript
<script>
// MikroTik Authentication Handler
(function() {
    // Get MikroTik parameters
    var mikrotikParams = {
        'link-login': '{$mikrotik_link_login|default:"http://192.168.88.1/login"}',
        'link-login-only': '{$mikrotik_link_login_only|default:"http://192.168.88.1/login"}',
        'link-orig': '{$mikrotik_link_orig|default:"https://www.google.com"}',
        'mac': '{$mac_address}',
        'username': '{$mac_address|replace:":":""}',
        'password': '{$mac_address}'
    };
    
    // Function to authenticate with MikroTik
    function authenticateWithMikrotik() {
        var radiusUsername = '{$mac_address|replace:":":""}';
        var radiusPassword = '{$mac_address}';
        
        // Build authentication URL
        var authUrl = mikrotikParams['link-login-only'] + 
            '?username=' + encodeURIComponent(radiusUsername) +
            '&password=' + encodeURIComponent(radiusPassword) +
            '&dst=' + encodeURIComponent(mikrotikParams['link-orig']);
        
        // Create form submission
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
        
        // Redirect after authentication
        setTimeout(function() {
            window.location.href = mikrotikParams['link-orig'];
        }, 2000);
    }
    
    // Authenticate when page loads
    window.addEventListener('load', function() {
        authenticateWithMikrotik();
    });
})();
</script>
```

### 4.2 Update M-PESA Callback

Edit `callback_mpesa.php` and ensure MAC authentication entries are created:

Add this code in the `activate_hotspot_service` function after creating the main RADIUS user:

```php
// For MAC-based authentication
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
```

## Step 5: Configure MikroTik Hotspot

Login to your MikroTik router and configure:

```
# Via Terminal/SSH:
/ip hotspot profile
set [find] login-by=mac,http-chap mac-auth-mode=use-radius mac-auth-password=same-as-username

# Configure RADIUS client
/radius
add address=YOUR_DOCKER_HOST_IP secret=radius123 service=hotspot

# Enable MAC authentication
/ip hotspot
set [find] address-pool=dhcp_pool1 idle-timeout=5m keepalive-timeout=none login-timeout=none
```

## Step 6: Restart Services

```bash
# Stop all containers first
docker-compose -f docker-compose.production.yml down

# Start in correct order
docker-compose -f docker-compose.production.yml up -d mysql
sleep 10
docker-compose -f docker-compose.production.yml up -d freeradius
sleep 5
docker-compose -f docker-compose.production.yml up -d web phpmyadmin redis

# Check status
docker-compose -f docker-compose.production.yml ps

# Clear cache
rm -rf ui/compiled/*
```

## Step 7: Test the System

1. Connect to WiFi hotspot
2. You should be redirected to captive portal
3. Select a plan and click "Pay Now"
4. Enter phone number for M-PESA STK Push
5. Complete payment on your phone
6. You should be redirected to success page and then to Google

## Troubleshooting

### Check Logs:
```bash
# RADIUS logs
docker logs glinta-radius-prod -f

# Captive portal logs
tail -f system/uploads/captive_portal_debug.log

# M-PESA logs
tail -f MpesaStk.log
```

### Verify RADIUS Users:
```bash
# Connect to MySQL
docker exec -it glinta-mysql-prod mysql -u root -p

# Check RADIUS users
USE glinta_billing;
SELECT * FROM radcheck WHERE username LIKE '%mac%';
```

### Common Issues:

1. **Redirect Loop**: Ensure MikroTik MAC authentication is enabled
2. **Payment Not Processing**: Check M-PESA credentials in .env
3. **No Internet After Payment**: Verify RADIUS user was created correctly

## Important Notes:

1. The Docker RADIUS is now your primary RADIUS server
2. Update any firewall rules to allow UDP ports 1812/1813
3. Ensure your MikroTik can reach the Docker host IP
4. The RADIUS shared secret is: radius123

## Clean Server Commands:

If you need to remove the external RADIUS completely:
```bash
# Remove FreeRADIUS packages
sudo apt-get remove --purge freeradius freeradius-mysql
sudo apt-get autoremove

# Clean up configuration
sudo rm -rf /etc/freeradius
```