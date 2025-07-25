# Dashboard User Count Accuracy Fixes

## Overview

This document outlines comprehensive fixes implemented to resolve user count accuracy issues in the billing system dashboard. The fixes address multiple problems including expired user status inconsistencies, service-specific counting errors, and RADIUS integration issues.

## Problems Identified

### 1. **Active User Count Inaccuracy**
- **Issue**: Users marked as 'active' (status='on') but with expired dates were being counted as active
- **Impact**: Dashboard showed inflated active user counts
- **Root Cause**: Missing date validation in active user queries

### 2. **Inconsistent Service-Specific Counts**
- **Issue**: Hotspot vs PPPoE user counts were inconsistent
- **Impact**: Service analytics showed incorrect data
- **Root Cause**: Different logic for counting users by service type

### 3. **RADIUS Integration Problems**
- **Issue**: RADIUS connection failures caused incorrect online user counts
- **Impact**: Real-time user monitoring was unreliable
- **Root Cause**: No fallback mechanism when RADIUS is unavailable

### 4. **Expired User Status Management**
- **Issue**: Users remained marked as 'on' even after expiration
- **Impact**: Database inconsistency and incorrect reporting
- **Root Cause**: No automated status updates for expired users

### 5. **Template Display Issues**
- **Issue**: Dashboard template used incorrect calculation for expired users
- **Impact**: Confusing user count display (Active/Expired format)
- **Root Cause**: Template calculated expired as `$u_all - $u_act`

## Fixes Implemented

### 1. **Updated Dashboard Controller** (`system/controllers/dashboard.php`)

#### Active User Count Fix
```php
// BEFORE (incorrect)
$u_act = ORM::for_table('tbl_user_recharges')->where('status', 'on')->count();

// AFTER (correct)
$u_act = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_gte('expiration', $current_date)
    ->count();
```

#### Expired User Count Fix
```php
// NEW: Separate count for expired users
$u_expired = ORM::for_table('tbl_user_recharges')
    ->where('status', 'off')
    ->count();
```

#### Service-Specific Count Fixes
```php
// Hotspot Online Users - Fixed with proper date validation
$radius_online_hotspot = ORM::for_table('tbl_user_recharges')
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->where('tbl_plans.type', 'Hotspot')
    ->where('tbl_user_recharges.status', 'on')
    ->where_gte('tbl_user_recharges.expiration', $current_date)
    ->count();

// PPPoE Active Users - Fixed with consistent logic
$pppoe_active = ORM::for_table('tbl_user_recharges')
    ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
    ->join('tbl_customers', ['tbl_user_recharges.customer_id', '=', 'tbl_customers.id'])
    ->where('tbl_plans.type', 'PPPOE')
    ->where('tbl_user_recharges.status', 'on')
    ->where('tbl_customers.status', 'Active')
    ->where_gte('tbl_user_recharges.expiration', $current_date)
    ->count();
```

#### RADIUS Integration Fix
```php
// Added fallback mechanism when RADIUS is unavailable
if ($config['radius_enable'] == 'yes' && !empty($config['radius_host'])) {
    try {
        // Try RADIUS connection
        $radius_online_hotspot = ORM::for_table('radacct', 'radius')
            ->where_null('acctstoptime')
            ->count();
    } catch (Exception $e) {
        // Fallback to user_recharges table
        $radius_online_hotspot = ORM::for_table('tbl_user_recharges')
            ->join('tbl_plans', ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
            ->where('tbl_plans.type', 'Hotspot')
            ->where('tbl_user_recharges.status', 'on')
            ->where_gte('tbl_user_recharges.expiration', $current_date)
            ->count();
    }
}
```

### 2. **Updated Dashboard Template** (`ui/ui/dashboard.tpl`)

#### Display Fix
```smarty
<!-- BEFORE (incorrect calculation) -->
<h3>{$u_act}/{$u_all-$u_act}</h3>

<!-- AFTER (correct display) -->
<h3>{$u_act}/{$u_expired}</h3>
```

### 3. **Created Maintenance Scripts**

#### `fix_dashboard_user_counts.php`
- Comprehensive analysis and fixing of user count issues
- Identifies and corrects data inconsistencies
- Provides detailed reporting of problems and fixes

#### `fix_expired_users_status.php`
- Automated script to update expired user statuses
- Updates RADIUS tables when applicable
- Clears relevant cache files
- Logs maintenance actions

#### `validate_dashboard_counts.php`
- Comprehensive testing suite for user count accuracy
- Validates all counting logic and relationships
- Provides detailed test results and recommendations
- Suitable for regular monitoring

## File Changes Summary

### Modified Files
1. **`/system/controllers/dashboard.php`** - Core dashboard logic fixes
2. **`/ui/ui/dashboard.tpl`** - Template display corrections

### New Files Created
1. **`fix_dashboard_user_counts.php`** - Initial fix and analysis script
2. **`fix_expired_users_status.php`** - Automated maintenance script
3. **`validate_dashboard_counts.php`** - Validation and testing script
4. **`DASHBOARD_USER_COUNT_FIXES.md`** - This documentation

## Key Improvements

### 1. **Accurate Active User Counting**
- Active users now properly exclude expired users
- Date validation prevents counting expired users as active
- Consistent logic across all dashboard components

### 2. **Proper Service-Type Separation**
- Hotspot and PPPoE users counted correctly
- Consistent joining logic between tables
- Proper plan type filtering

### 3. **Robust RADIUS Integration**
- Fallback mechanism when RADIUS is unavailable
- Proper error handling for connection issues
- Real-time online user tracking when possible

### 4. **Automated Maintenance**
- Scheduled status updates for expired users
- Cache management and clearing
- Activity logging for audit trails

### 5. **Comprehensive Validation**
- Test suite to verify counting accuracy
- Relationship validation between tables
- Early warning system for data inconsistencies

## Maintenance Recommendations

### Daily Maintenance
```bash
# Fix expired users (run at 2:00 AM daily)
0 2 * * * cd /path/to/billing && php fix_expired_users_status.php
```

### Weekly Validation
```bash
# Validate counts (run Sunday 3:00 AM)
0 3 * * 0 cd /path/to/billing && php validate_dashboard_counts.php > /var/log/billing_validation.log
```

### Monthly Review
- Review validation logs for recurring issues
- Check for orphaned records and clean up data
- Update maintenance scripts if needed

## Expected Results

After implementing these fixes, the dashboard should display:

1. **Accurate Active User Counts**: Only users with valid, non-expired subscriptions
2. **Correct Service Analytics**: Proper separation of Hotspot vs PPPoE metrics
3. **Reliable Online User Tracking**: Real-time data with RADIUS or fallback counts
4. **Consistent Data Relationships**: Proper correlation between customers and recharges
5. **Automated Data Hygiene**: Regular cleanup of expired user statuses

## Testing the Fixes

1. Run `fix_dashboard_user_counts.php` to apply initial fixes
2. Run `validate_dashboard_counts.php` to verify accuracy
3. Check dashboard display for correct counts
4. Set up automated maintenance scripts
5. Monitor counts over time for consistency

## Troubleshooting

### If counts still appear incorrect:
1. Run the validation script to identify specific issues
2. Check for orphaned records in the database
3. Verify RADIUS connectivity if using RADIUS features
4. Ensure cron jobs are running for automated maintenance

### For RADIUS issues:
1. Check RADIUS server connectivity
2. Verify database connection settings
3. Test fallback counting mechanism
4. Review RADIUS logs for connection errors

## Conclusion

These comprehensive fixes address all identified user count accuracy issues in the dashboard. The implementation includes both immediate fixes and long-term maintenance solutions to prevent future problems. Regular monitoring and maintenance will ensure continued accuracy of user counts and dashboard reliability.