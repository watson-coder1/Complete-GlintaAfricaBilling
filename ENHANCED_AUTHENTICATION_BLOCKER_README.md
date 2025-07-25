# Enhanced Authentication Blocker System

**Prevents users from re-logging in without making a new payment after their package expires**

## Overview

The Enhanced Authentication Blocker is a comprehensive system designed to prevent users from regaining internet access after their package expires without making a fresh payment. This addresses a critical security vulnerability where users could potentially reconnect by simply re-authenticating or trying different methods.

## Key Features

### 🔒 **Complete Authentication Protection**
- **Captive Portal Blocking**: Prevents expired users from accessing the payment portal
- **RADIUS Authentication Blocking**: Blocks RADIUS user creation for expired sessions
- **Voucher Redemption Blocking**: Prevents voucher usage by blocked devices
- **Session Validation**: Comprehensive checks at all authentication points

### 📱 **MAC Address Tracking**
- **Device Fingerprinting**: Tracks devices using MAC addresses and device fingerprints
- **Persistent Blocking**: Blocks persist across device restarts and reconnection attempts
- **Multiple MAC Format Support**: Supports standard MAC addresses and generated device IDs

### 🚨 **Intelligent Blocking Logic**
- **Expired Session Detection**: Automatically blocks users who try to reconnect after expiry
- **Suspicious Activity Detection**: Blocks devices making rapid authentication attempts
- **Payment Status Verification**: Checks for new payments before allowing access
- **Active Session Prevention**: Prevents duplicate sessions for the same device

### 🛡️ **Security Features**
- **Automatic Blocking**: Expired users are immediately blocked when sessions end
- **Attempt Tracking**: Logs all authentication attempts for security monitoring
- **Temporary Blocks**: Time-based blocks for suspicious activity
- **Admin Override**: Manual block/unblock capabilities for administrators

## System Architecture

### Core Components

1. **EnhancedAuthenticationBlocker** (`enhanced_authentication_blocker.php`)
   - Main blocking logic and MAC management
   - Database operations for blocked addresses
   - Authentication status checking

2. **Enhanced Captive Portal** (`system/controllers/captive_portal.php`)
   - Integrated blocking checks at landing, payment, and voucher stages
   - User-friendly blocked page display
   - Session management with blocking logic

3. **Enhanced RADIUS Manager** (`system/autoload/RadiusManager.php`)
   - RADIUS user creation with authentication checks
   - Prevents RADIUS user creation for blocked MACs

4. **Enhanced Session Manager** (`captive_portal_session_manager.php`)
   - Automatic blocking of expired users
   - Session cleanup with blocking integration

5. **Admin Interface** (`system/controllers/auth_blocker_admin.php`)
   - Web-based management interface
   - Blocked MAC viewing, blocking, and unblocking
   - Statistics and monitoring

### Database Schema

#### `tbl_blocked_mac_addresses`
```sql
CREATE TABLE IF NOT EXISTS `tbl_blocked_mac_addresses` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `mac_address` varchar(20) NOT NULL,
    `username` varchar(100) DEFAULT NULL,
    `reason` varchar(255) DEFAULT 'expired_session',
    `blocked_at` datetime NOT NULL,
    `expires_at` datetime DEFAULT NULL,
    `last_attempt` datetime DEFAULT NULL,
    `attempt_count` int(11) DEFAULT 0,
    `status` enum('active','lifted','expired') DEFAULT 'active',
    `created_by` varchar(50) DEFAULT 'system',
    `notes` text,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_mac_active` (`mac_address`, `status`),
    KEY `mac_address` (`mac_address`),
    KEY `blocked_at` (`blocked_at`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### `tbl_auth_attempts`
```sql
CREATE TABLE IF NOT EXISTS `tbl_auth_attempts` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `mac_address` varchar(20) NOT NULL,
    `ip_address` varchar(45) DEFAULT NULL,
    `attempt_type` enum('captive_portal','radius','voucher') NOT NULL,
    `attempt_time` datetime NOT NULL,
    `user_agent` text,
    `session_id` varchar(50) DEFAULT NULL,
    `blocked` tinyint(1) DEFAULT 0,
    `reason` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `mac_address` (`mac_address`),
    KEY `attempt_time` (`attempt_time`),
    KEY `blocked` (`blocked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## Installation & Setup

### 1. Run Setup Script
```bash
php setup_enhanced_authentication_blocker.php
```

### 2. Set Up Cron Jobs
Add these to your crontab (`crontab -e`):

```bash
# Process expired users every 5 minutes
*/5 * * * * php /path/to/enhanced_authentication_blocker.php process-expired

# Cleanup old records daily
0 2 * * * php /path/to/enhanced_authentication_blocker.php cleanup

# Session monitoring every minute
* * * * * php /path/to/captive_portal_session_manager.php
```

### 3. Configure Templates
Ensure these template files are in place:
- `ui/theme/default/captive_portal_blocked.tpl`
- `ui/theme/default/auth_blocker_admin.tpl`
- `ui/theme/default/auth_blocker_block.tpl`

## How It Works

### Authentication Flow
```
1. User connects to WiFi → MikroTik redirects to captive portal
2. System checks MAC address against blocked list
3. If blocked → Show blocked page with reason
4. If not blocked → Allow portal access
5. User makes payment/uses voucher
6. System creates internet session
7. When session expires → MAC automatically blocked
8. Future connection attempts → Blocked until new payment
```

### Blocking Scenarios

#### 1. **Expired Session Retry**
- **Trigger**: User with expired session tries to reconnect
- **Detection**: Checks for expired `tbl_user_recharges` without new payment
- **Action**: Block with reason `expired_session_retry`
- **Resolution**: User must make new payment

#### 2. **Suspicious Activity**
- **Trigger**: Multiple rapid authentication attempts (>10 in 5 minutes)
- **Detection**: Counts recent attempts in `tbl_auth_attempts`
- **Action**: Temporary block with reason `suspicious_activity`
- **Resolution**: Automatic unblock after 5 minutes or admin intervention

#### 3. **Manual Block**
- **Trigger**: Administrator manually blocks MAC
- **Detection**: Direct admin action
- **Action**: Block with custom reason and duration
- **Resolution**: Admin unblock or automatic expiry

## Usage

### Command Line Interface

```bash
# Check MAC status
php enhanced_authentication_blocker.php check aa:bb:cc:dd:ee:ff

# Block a MAC address
php enhanced_authentication_blocker.php block aa:bb:cc:dd:ee:ff security_threat

# Unblock a MAC address
php enhanced_authentication_blocker.php unblock aa:bb:cc:dd:ee:ff

# Process expired users
php enhanced_authentication_blocker.php process-expired

# Get statistics
php enhanced_authentication_blocker.php stats

# Cleanup old records
php enhanced_authentication_blocker.php cleanup
```

### Web Admin Interface

Access the admin interface at: `https://yoursite.com/auth_blocker_admin`

Features:
- View all blocked MAC addresses
- Block/unblock addresses manually
- View detailed blocking statistics
- Monitor recent authentication attempts
- Bulk operations on multiple MACs
- Export blocked MACs to CSV

### API Endpoints

```php
// Check if MAC is blocked
GET /auth_blocker_admin?action=check&mac=aa:bb:cc:dd:ee:ff

// Get statistics
GET /auth_blocker_admin?action=stats

// Process expired users
GET /auth_blocker_admin?action=process_expired

// Cleanup old records
GET /auth_blocker_admin?action=cleanup
```

## Configuration

### Blocking Thresholds
Edit `enhanced_authentication_blocker.php` to adjust:

```php
// Suspicious activity detection
$timeframe_minutes = 5;  // Check last 5 minutes
$max_attempts = 10;      // Max 10 attempts in timeframe

// Block durations
$default_block_duration = null;  // Permanent by default
```

### Block Reasons
Standard block reasons:
- `expired_session_retry` - User reconnecting after expiry
- `suspicious_activity` - Too many rapid attempts
- `session_expired` - Session expired (auto-block)
- `manual_block` - Administrator action
- `policy_violation` - Terms of service violation
- `security_threat` - Security concern
- `maintenance` - System maintenance

## Monitoring & Logging

### Log Files
- `/logs/auth_blocker.log` - Main authentication blocking log
- `/logs/captive_portal_debug.log` - Captive portal integration log
- `/logs/captive_portal_session_manager.log` - Session management log

### Statistics Monitoring
The system provides real-time statistics:
```php
$stats = EnhancedAuthenticationBlocker::getBlockingStatistics();
// Returns: active_blocks, recent_attempts, recent_blocked_attempts, blocks_by_reason
```

### Alert Thresholds
Monitor these metrics and set up alerts:
- High number of active blocks (may indicate system issues)
- Excessive blocked attempts (potential attack)
- Low blocking rate with high expired users (system malfunction)

## Troubleshooting

### Common Issues

#### 1. **Legitimate Users Blocked**
- **Cause**: System incorrectly identified user as expired
- **Solution**: Use admin interface to unblock MAC address
- **Prevention**: Verify session expiry logic and payment processing

#### 2. **Users Not Being Blocked**
- **Cause**: Blocking system not integrated properly
- **Solution**: Run setup script and verify all components
- **Check**: Cron jobs running, database tables exist, code integration

#### 3. **Too Many Suspicious Activity Blocks**
- **Cause**: Thresholds too low for normal usage patterns
- **Solution**: Adjust `$max_attempts` and `$timeframe_minutes` values
- **Monitor**: Authentication attempt patterns

### Debug Steps

1. **Check System Status**
```bash
php setup_enhanced_authentication_blocker.php
```

2. **Verify MAC Status**
```bash
php enhanced_authentication_blocker.php check <mac_address>
```

3. **Check Logs**
```bash
tail -f /logs/auth_blocker.log
tail -f /logs/captive_portal_debug.log
```

4. **Test Blocking**
```bash
# Block test MAC
php enhanced_authentication_blocker.php block test-mac test_reason

# Verify blocked
php enhanced_authentication_blocker.php check test-mac

# Unblock
php enhanced_authentication_blocker.php unblock test-mac
```

## Security Considerations

### Best Practices
1. **Regular Monitoring**: Check blocking statistics daily
2. **Log Analysis**: Review authentication attempt patterns
3. **Threshold Tuning**: Adjust blocking thresholds based on usage patterns
4. **Backup Plans**: Have manual override procedures for system issues
5. **User Communication**: Inform users about new payment requirements

### Potential Bypasses
The system prevents common bypass attempts:
- ✅ MAC address spoofing (uses device fingerprinting)
- ✅ Multiple connection attempts (suspicious activity detection)
- ✅ Different authentication methods (all protected)
- ✅ Session recreation (persistent blocking)
- ✅ Time-based bypasses (proper expiry checking)

## Maintenance

### Regular Tasks
- **Daily**: Review blocking statistics and unusual patterns
- **Weekly**: Clean up old authentication attempt records
- **Monthly**: Analyze blocking effectiveness and adjust thresholds
- **Quarterly**: Review and update block reasons and policies

### Updates
When updating the system:
1. Backup database tables
2. Test in staging environment
3. Monitor logs after deployment
4. Have rollback procedure ready

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review log files for error details
3. Use the admin interface for immediate issues
4. Contact system administrator with log excerpts

---

**Version**: 1.0  
**Author**: Glinta Africa Development Team  
**Last Updated**: 2024  
**Compatibility**: Glinta Africa Billing System v2.0+