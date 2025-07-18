# Billing System Database Overview

## Database: nuxbill

### Core Tables

#### 1. **tbl_users** - Admin/Staff Users
- `id` - Primary key
- `username` - Login username
- `password` - Encrypted password
- `fullname` - Full name
- `user_type` - SuperAdmin, Admin, Sales, etc.
- `status` - Active/Inactive

#### 2. **tbl_customers** - Customer/Subscriber Information
- Personal details (name, phone, email, address)
- Service information
- Account status
- Balance information

#### 3. **tbl_plans** - Internet Packages/Plans
- `name_plan` - Plan name
- `price` - Plan price
- `type` - Hotspot/PPPOE/Balance
- `limit_type` - Time_Limit/Data_Limit/Both_Limit
- `time_limit` & `time_unit` - Duration limits
- `data_limit` & `data_unit` - Data limits
- `validity` & `validity_unit` - Plan validity period
- `is_radius` - Whether plan uses RADIUS

#### 4. **tbl_user_recharges** - Active Customer Subscriptions
- Links customers to their active plans
- Tracks expiration dates
- Usage statistics

#### 5. **tbl_transactions** - Payment History
- All financial transactions
- Payment methods
- Transaction dates and amounts

#### 6. **tbl_voucher** - Prepaid Vouchers
- Voucher codes
- Associated plans
- Usage status

### Network Configuration Tables

#### 7. **tbl_routers** - Mikrotik Routers
- Router name and IP address
- API credentials
- Status and coverage area

#### 8. **tbl_bandwidth** - Bandwidth Profiles
- Upload/download speeds
- Burst limits
- Rate limiting configuration

#### 9. **tbl_pool** - IP Address Pools
- IP ranges for customer assignment

### RADIUS Tables (FreeRADIUS Schema)

#### 10. **nas** - Network Access Servers
- NAS identifier and IP
- Shared secrets
- Port configurations

#### 11. **radcheck** - User Authentication
- Username/password pairs
- Check attributes

#### 12. **radreply** - Reply Attributes
- Attributes sent back after authentication

#### 13. **radacct** - Accounting Records
- Session information
- Data usage tracking
- Connection times

#### 14. **radusergroup** - User Group Mappings
- Links users to groups

#### 15. **radgroupcheck/radgroupreply** - Group Attributes
- Group-level check and reply attributes

### System Tables

#### 16. **tbl_appconfig** - Application Settings
- System configuration
- Feature toggles
- General settings

#### 17. **tbl_payment_gateway** - Payment Gateway Configurations
- Gateway credentials
- Active payment methods

#### 18. **tbl_logs** - System Logs
- User activities
- System events

## Current Status:
- ✅ Database created and connected
- ✅ All tables installed
- ✅ Admin user exists (username: admin)
- ❌ No routers configured yet
- ❌ No internet plans created yet
- ❌ No customers registered yet
- ❌ No NAS configured for RADIUS yet

## Next Steps:
1. Add Mikrotik routers
2. Create bandwidth profiles
3. Create internet plans
4. Configure payment gateways
5. Set up RADIUS NAS if using FreeRADIUS