# 🔒 Server Instructions: Restrict Access to Paying Customers Only

## What was changed in the codebase:

✅ **RadiusManager.php updated:**
- Re-enabled `removeRadiusUser()` function (was disabled for debugging)
- Removed `Auth-Type := Accept` bypass that allowed all MAC addresses
- Now requires proper RADIUS authentication with valid credentials

✅ **Created cleanup scripts:**
- `clear_radius_users.php` - Removes all existing RADIUS users from database
- `reset_access_control.sh` - Complete deployment script

## Server deployment steps:

### 1. Pull latest code
```bash
cd /var/www/html/system
git pull origin main
```

### 2. Clear all existing RADIUS users
```bash
php clear_radius_users.php
```

### 3. Remove FreeRADIUS MAC bypass configuration
```bash
# Remove the blanket MAC authentication from FreeRADIUS
docker exec -it glinta-web-prod sed -i '/User-Name =~ \/\^[0-9a-fA-F]/,/}/d' /etc/freeradius/3.0/sites-enabled/default

# Restart FreeRADIUS to apply changes
docker exec -it glinta-web-prod systemctl restart freeradius
```

### 4. Verify FreeRADIUS configuration
```bash
# Check that MAC bypass section is removed
docker exec -it glinta-web-prod grep -A 5 -B 5 "User-Name.*fA-F" /etc/freeradius/3.0/sites-enabled/default
# This should return no results
```

## What this achieves:

🎯 **RESULT:** Only customers who make M-Pesa payments will get internet access

- ❌ **Before:** All MAC addresses were automatically accepted (too permissive)
- ✅ **After:** Only MAC addresses with valid RADIUS accounts get access
- 🔄 **Flow:** Payment → RADIUS user created → Internet access granted
- ⏰ **Expiry:** Users automatically removed when time expires

## Testing the new system:

1. **Without payment:** Device should NOT get internet access
2. **With payment:** Device should get internet access after successful M-Pesa payment
3. **After expiry:** Device should lose internet access when time runs out

## Troubleshooting:

If users still get access without payment, check:
- FreeRADIUS logs: `docker exec -it glinta-web-prod tail -f /var/log/freeradius/radius.log`
- RADIUS database: Check if unauthorized users exist in `radcheck` table
- MikroTik logs: Check authentication attempts

## Original issue resolved:

✅ **User's request:** "no all currently should be removed and we start afresh only the one that will pay from now should access"

This has been fully implemented! 🎉