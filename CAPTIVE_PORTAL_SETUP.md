# Glinta Africa Captive Portal Setup Guide

## Overview
The captive portal allows users to purchase internet packages via M-Pesa STK push and get automatically connected for a specified duration.

## Features
- ✅ M-Pesa STK Push payment integration
- ✅ Automatic user creation and authentication
- ✅ Time-based access control (e.g., 1 hour for 10 KSH)
- ✅ Automatic disconnection after expiration
- ✅ Voucher code support
- ✅ Real-time session monitoring
- ✅ MAC address-based authentication

## Setup Instructions

### 1. Database Setup
Run the setup script to create necessary tables:
```bash
php setup_captive_portal_tables.php
```

### 2. Configure M-Pesa Daraja
1. Go to Admin Panel > Payment Gateway > Daraja
2. Enter your M-Pesa credentials:
   - Consumer Key
   - Consumer Secret
   - Business Shortcode
   - Passkey
   - Environment (sandbox/live)
   - Callback URL: `https://yourdomain.com/captive_portal/callback`

### 3. Set Up Cron Jobs
Add these to your crontab:
```bash
# Main expiration monitor (runs every 5 minutes)
*/5 * * * * php /path/to/your/system/cron.php

# Captive portal session monitor (runs every minute)
* * * * * php /path/to/your/captive_portal_session_monitor.php
```

### 4. Configure MikroTik Hotspot

#### Step 1: Create Hotspot Server
```
/ip hotspot setup
```
Follow the wizard to set up basic hotspot.

#### Step 2: Configure Walled Garden
Allow access to your captive portal domain:
```
/ip hotspot walled-garden
add dst-host="yourdomain.com" action=allow
add dst-host="*.safaricom.co.ke" action=allow
```

#### Step 3: Set Login Page
```
/ip hotspot profile
set [find] login-by=mac-as-username,cookie
set [find] mac-auth-mode=immediate
set [find] login-page="https://yourdomain.com/captive_portal?mac=$(mac)&ip=$(ip)"
```

#### Step 4: Configure RADIUS (if using RADIUS)
```
/radius
add address=your-radius-server secret=your-radius-secret service=hotspot
```

#### Step 5: Set User Profile Limits
```
/ip hotspot user profile
add name="1hour" session-timeout=1h shared-users=1
add name="2hours" session-timeout=2h shared-users=1
add name="daily" session-timeout=1d shared-users=1
```

### 5. Create Hotspot Plans
1. Go to Admin Panel > Services > Hotspot Plans
2. Create plans matching your needs:
   - Name: "1 Hour Access"
   - Price: 10
   - Validity: 1
   - Validity Unit: Hours
   - Type: Hotspot

### 6. Test the Flow

1. **Connect to WiFi Hotspot**
   - User connects to your WiFi
   - Gets redirected to captive portal

2. **Select Package**
   - User sees available packages
   - Selects desired package (e.g., 1 hour for 10 KSH)

3. **Enter Phone Number**
   - User enters M-Pesa phone number
   - Clicks "Pay with M-Pesa"

4. **Complete Payment**
   - User receives STK push on phone
   - Enters M-Pesa PIN
   - Payment is processed

5. **Automatic Connection**
   - System creates user account
   - Assigns selected plan
   - User gets internet access
   - Shows success page

6. **Automatic Disconnection**
   - After 1 hour, user is automatically disconnected
   - Must purchase again to continue

## Portal URLs

- Main Portal: `https://yourdomain.com/captive_portal`
- Payment Status: `https://yourdomain.com/captive_portal/payment/[session_id]`
- Success Page: `https://yourdomain.com/captive_portal/success/[session_id]`
- M-Pesa Callback: `https://yourdomain.com/captive_portal/callback`

## Troubleshooting

### Check Logs
```bash
tail -f system/uploads/captive_portal_debug.log
tail -f system/uploads/captive_portal_callbacks.log
tail -f system/uploads/captive_portal_disconnections.log
tail -f system/uploads/daraja_stk_push.log
```

### Common Issues

1. **STK Push Not Received**
   - Check M-Pesa configuration
   - Verify phone number format (254XXXXXXXXX)
   - Check Daraja API credentials

2. **User Not Disconnected After Expiration**
   - Verify cron job is running
   - Check session monitor logs
   - Ensure RADIUS/MikroTik connection

3. **Cannot Access Portal**
   - Add domain to MikroTik walled garden
   - Check nginx/apache configuration
   - Verify SSL certificate

### Manual Session Check
```sql
-- Check active sessions
SELECT * FROM tbl_portal_sessions WHERE status = 'completed';

-- Check user recharges
SELECT * FROM tbl_user_recharges WHERE username LIKE '%:%:%:%:%:%' AND status = 'on';
```

## Security Considerations

1. **SSL Certificate**: Always use HTTPS for the portal
2. **Walled Garden**: Only allow necessary domains
3. **Session Timeout**: Set reasonable session timeouts
4. **Payment Validation**: Always verify M-Pesa callbacks
5. **Rate Limiting**: Implement rate limiting for payment requests

## Customization

### Modify Portal Design
Edit: `ui/ui/captive_portal_landing.tpl`

### Change Payment Flow
Edit: `system/controllers/captive_portal.php`

### Adjust Expiration Logic
Edit: `captive_portal_session_monitor.php`

## Support
For issues or questions:
- Email: support@glintaafrica.com
- Phone: 0711311897