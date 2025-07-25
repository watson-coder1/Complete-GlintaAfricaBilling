# Remove MikroTik Bypass - Force All Users to Pay

## Quick Steps to Remove Bypass

### 1. **Connect to MikroTik**
```bash
# Via SSH
ssh admin@[mikrotik-ip]

# Or use WinBox/WebFig
```

### 2. **Check Current Bypasses**

Look for these common bypass methods:

#### A. IP Bindings (Static Bypass)
```bash
/ip hotspot ip-binding print
```
Look for entries with `type=bypassed`

#### B. Walled Garden (Domain Bypass)
```bash
/ip hotspot walled-garden print
```

#### C. Address List Bypass
```bash
/ip firewall address-list print where list=bypass
# or
/ip firewall address-list print
```

#### D. MAC Address Bypass
```bash
/ip hotspot user print where mac-address=[your-mac]
```

### 3. **Remove Your Phone's Bypass**

#### If it's IP Binding:
```bash
# Find your entry
/ip hotspot ip-binding print

# Remove it (replace X with the number)
/ip hotspot ip-binding remove X
```

#### If it's in Address List:
```bash
# Find your IP/MAC
/ip firewall address-list print

# Remove it
/ip firewall address-list remove [find address="your-ip"]
# or
/ip firewall address-list remove [find list="bypass"]
```

#### If it's a Hotspot User:
```bash
# Find the user
/ip hotspot user print

# Remove bypassed user
/ip hotspot user remove [find name="your-username"]
```

### 4. **Check Firewall Rules**
```bash
# Look for rules that might bypass certain IPs
/ip firewall nat print
/ip firewall filter print
```

### 5. **Find Your Device's Details**
```bash
# See all active hotspot users
/ip hotspot active print

# See all DHCP leases
/ip dhcp-server lease print

# Find your phone's MAC address
/ip arp print
```

## Complete Removal Script

```bash
# This script removes all common bypasses
# BE CAREFUL - This will force ALL users to authenticate

# 1. Remove all bypassed IP bindings
/ip hotspot ip-binding remove [find type=bypassed]

# 2. Clear bypass address lists
/ip firewall address-list remove [find list~"bypass"]

# 3. Remove any NAT bypass rules
/ip firewall nat remove [find comment~"bypass"]

# 4. Reset walled garden to defaults
/ip hotspot walled-garden
remove [find comment~"bypass"]

# 5. Remove static hotspot users without profiles
/ip hotspot user remove [find profile=""]
```

## Ensure Your Billing System Controls Access

### 1. **Verify Hotspot Settings**
```bash
/ip hotspot print
/ip hotspot profile print
```

### 2. **Set Login Method**
```bash
/ip hotspot profile set [find] login-by=mac-as-username
```

### 3. **Force Re-authentication**
```bash
# Disconnect all active users
/ip hotspot active remove [find]

# Clear cookies
/ip hotspot cookie remove [find]
```

## Prevent Future Bypasses

### 1. **Disable Trial Mode**
```bash
/ip hotspot user profile set [find] rate-limit="" session-timeout=00:00:00
```

### 2. **Set Strict Authentication**
```bash
/ip hotspot set [find] address-pool=dhcp_pool1 idle-timeout=5m keepalive-timeout=none
```

### 3. **Monitor for Bypasses**
Create a script to alert on unauthorized access:
```bash
/system script add name=detect-bypass source={
    :local bypassCount [/ip hotspot ip-binding print count-only where type=bypassed]
    :if ($bypassCount > 0) do={
        :log warning "ALERT: $bypassCount bypassed IPs detected!"
    }
}

/system scheduler add name=check-bypass interval=5m on-event=detect-bypass
```

## Quick Commands to Find Your Phone

```bash
# If you know your phone's IP
/ip hotspot ip-binding print where address="192.168.88.XXX"

# If you know your MAC address
/ip hotspot host print where mac-address="XX:XX:XX:XX:XX:XX"

# See all currently connected devices
/ip hotspot active print

# Find by device name (if hostname is visible)
/ip dhcp-server lease print where host-name~"iPhone" 
# or
/ip dhcp-server lease print where host-name~"Android"
```

## After Removing Bypass

1. Your phone will be disconnected from internet
2. Connect to WiFi again
3. You'll be redirected to the payment portal
4. Make payment to regain access
5. The billing system will automatically create your access

## Important Notes

- Removing bypasses affects immediately
- All bypassed devices will lose internet access
- Make sure your billing system is working before removing bypasses
- Keep one admin access method available (like WinBox on cable)

Need help identifying which bypass method was used? Run:
```bash
/export compact
```
And look for entries with your phone's MAC address or IP.