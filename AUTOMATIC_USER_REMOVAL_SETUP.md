# Enhanced Automatic User Removal System Setup Guide

## Overview

This enhanced automatic user removal system provides comprehensive management of user access expiry, including:

- **Precise hour/minute-based expiry** (not just date-based)
- **Immediate RADIUS disconnection** using radclient
- **Portal session cleanup**
- **Real-time session monitoring**
- **Automatic expiry notifications**
- **Comprehensive logging and error handling**

## System Components

### 1. Enhanced Core System Files

- **`system/cron.php`** - Enhanced main cron job with precise time handling
- **`system/autoload/RadiusManager.php`** - Enhanced RADIUS management with immediate disconnection
- **`captive_portal_session_manager.php`** - Portal session cleanup
- **`enhanced_session_monitor.php`** - Real-time session monitoring
- **`expiry_notification_system.php`** - Automatic user notifications
- **`radius_cron.php`** - RADIUS-specific maintenance tasks

## Installation Steps

### 1. Verify System Requirements

Run the test script to check if your system is ready:

```bash
cd /path/to/billing/system
php test_automatic_user_removal.php
```

### 2. Set Up Cron Jobs

Add the following cron jobs to your server:

#### Main Expiry Cron (Run every 5 minutes)
```bash
*/5 * * * * /usr/bin/php /path/to/billing/system/system/cron.php >> /var/log/billing_cron.log 2>&1
```

#### Real-time Session Monitor (Run every minute)
```bash
* * * * * /usr/bin/php /path/to/billing/system/enhanced_session_monitor.php >> /var/log/session_monitor.log 2>&1
```

#### RADIUS Maintenance (Run every 5 minutes)
```bash
*/5 * * * * /usr/bin/php /path/to/billing/system/radius_cron.php >> /var/log/radius_cron.log 2>&1
```

#### Expiry Notifications (Run every 10 minutes)
```bash
*/10 * * * * /usr/bin/php /path/to/billing/system/expiry_notification_system.php >> /var/log/expiry_notifications.log 2>&1
```

#### Portal Session Cleanup (Run every 15 minutes)
```bash
*/15 * * * * /usr/bin/php /path/to/billing/system/captive_portal_session_manager.php >> /var/log/portal_cleanup.log 2>&1
```

### 3. Complete Crontab Example

```bash
# Edit crontab
crontab -e

# Add these lines:
# Enhanced Billing System Cron Jobs
*/5 * * * * /usr/bin/php /var/www/html/billing/system/cron.php >> /var/log/billing_cron.log 2>&1
* * * * * /usr/bin/php /var/www/html/billing/enhanced_session_monitor.php >> /var/log/session_monitor.log 2>&1
*/5 * * * * /usr/bin/php /var/www/html/billing/radius_cron.php >> /var/log/radius_cron.log 2>&1
*/10 * * * * /usr/bin/php /var/www/html/billing/expiry_notification_system.php >> /var/log/expiry_notifications.log 2>&1
*/15 * * * * /usr/bin/php /var/www/html/billing/captive_portal_session_manager.php >> /var/log/portal_cleanup.log 2>&1
```

### 4. Create Log Directories

```bash
sudo mkdir -p /var/log/billing
sudo chown www-data:www-data /var/log/billing
sudo chmod 755 /var/log/billing
```

### 5. Configure Log Rotation

Create `/etc/logrotate.d/billing-system`:

```
/var/log/billing_cron.log
/var/log/session_monitor.log
/var/log/radius_cron.log
/var/log/expiry_notifications.log
/var/log/portal_cleanup.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 644 www-data www-data
}
```

## Configuration

### 1. RADIUS Configuration

Ensure your RADIUS server is properly configured with:

- **NAS clients** properly defined in `nas` table
- **COA/POD ports** open (usually 3799)
- **radclient** utility installed and accessible

```bash
# Test radclient installation
which radclient
```

### 2. Database Configuration

The system uses the existing database structure but adds enhanced queries. Ensure:

- **Database connection** is working
- **RADIUS database** connection is configured
- **Proper indexes** exist on frequently queried tables

### 3. Notification Configuration

Configure in your billing system admin panel:

- **SMS Gateway** (if using SMS notifications)
- **WhatsApp API** (if using WhatsApp notifications)  
- **Email Settings** (if using email notifications)
- **Notification preferences** per user type

## Testing and Verification

### 1. Run Initial Test

```bash
cd /path/to/billing/system
php test_automatic_user_removal.php
```

### 2. Manual Test Individual Components

```bash
# Test main cron
php system/cron.php

# Test session monitor
php enhanced_session_monitor.php

# Test RADIUS cron
php radius_cron.php

# Test notifications
php expiry_notification_system.php

# Test portal cleanup
php captive_portal_session_manager.php
```

### 3. Monitor Logs

```bash
# Watch main cron log
tail -f /var/log/billing_cron.log

# Watch session monitor
tail -f /var/log/session_monitor.log

# Watch all logs
tail -f /var/log/billing_cron.log /var/log/session_monitor.log /var/log/radius_cron.log
```

## How It Works

### 1. Precise Time-Based Expiry

The enhanced system now checks both date AND time for expiry:

```php
// Old method (date only)
WHERE expiration <= '2024-01-15'

// New method (precise time)
WHERE (
    (expiration < '2024-01-15' AND time IS NULL) OR 
    (expiration = '2024-01-15' AND time IS NOT NULL AND CONCAT(expiration, ' ', time) <= '2024-01-15 14:30:00') OR
    (expiration < '2024-01-15')
)
```

### 2. Immediate Disconnection Process

When a user expires:

1. **Database Update**: Mark session as 'off'
2. **Device Removal**: Remove from MikroTik/router
3. **RADIUS Cleanup**: Remove all RADIUS entries
4. **Immediate Disconnect**: Send radclient POD packet
5. **Portal Cleanup**: Expire portal sessions
6. **Session Termination**: Mark accounting sessions as stopped
7. **Notification**: Send expiry notification

### 3. Multi-Layer Monitoring

The system uses multiple monitoring layers:

- **Main Cron**: Primary expiry processing (every 5 minutes)
- **Session Monitor**: Real-time monitoring (every minute)
- **RADIUS Cron**: RADIUS-specific monitoring (every 5 minutes)
- **Portal Manager**: Portal session cleanup (every 15 minutes)

## Package Duration Examples

### 1-Hour Package
- **Created**: 2024-01-15 13:00:00
- **Expires**: 2024-01-15 14:00:00
- **Removal**: Exactly at 14:00:00 (or within 1 minute)

### 30-Minute Package
- **Created**: 2024-01-15 13:00:00
- **Expires**: 2024-01-15 13:30:00
- **Removal**: Exactly at 13:30:00 (or within 1 minute)

### 1-Day Package
- **Created**: 2024-01-15 13:00:00
- **Expires**: 2024-01-16 23:59:59
- **Removal**: At end of 2024-01-16

## Troubleshooting

### Common Issues

1. **Users not disconnecting immediately**
   - Check if radclient is installed
   - Verify NAS configuration
   - Check RADIUS server COA/POD settings
   - Monitor RADIUS logs

2. **Cron jobs not running**
   - Verify crontab syntax
   - Check PHP path: `which php`
   - Verify file permissions
   - Check system logs: `tail -f /var/log/syslog | grep CRON`

3. **RADIUS errors**
   - Verify RADIUS database connection
   - Check RadiusManager class loading
   - Verify NAS secrets and IP addresses

4. **High CPU usage**
   - Reduce cron frequency if needed
   - Add database indexes
   - Optimize queries

### Debug Mode

Enable debug mode by adding this to any script:

```php
define('CAPTIVE_PORTAL_DEBUG_MODE', true);
```

### Log Locations

- **Main System**: `/var/log/billing_cron.log`
- **Session Monitor**: `/var/log/session_monitor.log`
- **RADIUS**: `/var/log/radius_cron.log`
- **Notifications**: `/var/log/expiry_notifications.log`
- **Portal**: `/var/log/portal_cleanup.log`
- **Application Logs**: `storage/logs/` (in billing system)

## Performance Optimization

### Database Indexes

Add these indexes for optimal performance:

```sql
-- User recharges indexes
ALTER TABLE tbl_user_recharges ADD INDEX idx_status_expiry (status, expiration);
ALTER TABLE tbl_user_recharges ADD INDEX idx_status_type (status, type);
ALTER TABLE tbl_user_recharges ADD INDEX idx_username_status (username, status);

-- RADIUS indexes
ALTER TABLE radacct ADD INDEX idx_username_stop (username, acctstoptime);
ALTER TABLE radacct ADD INDEX idx_acctstarttime (acctstarttime);
ALTER TABLE radcheck ADD INDEX idx_username_attr (username, attribute);

-- Portal sessions indexes  
ALTER TABLE tbl_portal_sessions ADD INDEX idx_mac_status (mac_address, status);
ALTER TABLE tbl_portal_sessions ADD INDEX idx_created_status (created_at, status);
```

### System Resources

- **Memory**: Minimum 1GB RAM recommended
- **CPU**: Multi-core recommended for high-traffic systems
- **Disk**: SSD recommended for database operations
- **Network**: Stable connection to RADIUS server

## Security Considerations

1. **Log File Permissions**: Ensure logs are readable only by authorized users
2. **Database Security**: Use dedicated database users with minimal permissions  
3. **RADIUS Secrets**: Use strong, unique secrets for each NAS
4. **Cron Security**: Run crons as dedicated user, not root
5. **API Security**: Restrict web API access if enabled

## Maintenance

### Daily Tasks
- Monitor log files for errors
- Check system resource usage
- Verify cron job execution

### Weekly Tasks
- Rotate and archive logs
- Update database statistics
- Review notification delivery rates

### Monthly Tasks
- Clean old accounting records
- Update system documentation
- Review and optimize queries

## Support

If you encounter issues:

1. **Run the test script**: `php test_automatic_user_removal.php`
2. **Check logs** for detailed error messages
3. **Verify system requirements** and dependencies
4. **Test individual components** manually
5. **Monitor database performance** and optimize if needed

This enhanced system ensures that users are immediately removed from internet access when their packages expire, preventing unauthorized continued browsing while maintaining system performance and reliability.