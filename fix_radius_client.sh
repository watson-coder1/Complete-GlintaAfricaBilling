#!/bin/bash

echo "=== Checking FreeRADIUS Client Configuration ==="

# Check current client configuration
echo "Current clients.conf:"
sudo cat /etc/freeradius/3.0/clients.conf

echo ""
echo "=== Checking what IP MikroTik is connecting FROM ==="

# Check recent RADIUS authentication attempts in logs
echo "Recent RADIUS attempts from MikroTik:"
sudo grep -i "from client" /var/log/freeradius/radius.log | tail -10

echo ""
echo "=== Checking if MikroTik external IP needs to be added ==="

# The issue might be that MikroTik is connecting from a different IP than configured
echo "MikroTik may be connecting from a different external IP than 41.90.70.9"
echo ""
echo "Run these commands on the server:"
echo ""
echo "1. Check what IP MikroTik requests are coming from:"
echo "   sudo tail -f /var/log/freeradius/radius.log | grep 'from client'"
echo ""  
echo "2. Then add that IP to FreeRADIUS clients.conf:"
echo "   sudo nano /etc/freeradius/3.0/clients.conf"
echo ""
echo "3. Add this section with the correct IP:"
echo "client mikrotik-actual {"
echo "    ipaddr = [THE_ACTUAL_IP_FROM_LOGS]"
echo "    secret = radius123"
echo "    shortname = mikrotik-actual"
echo "    require_message_authenticator = no"
echo "}"
echo ""
echo "4. Restart FreeRADIUS:"
echo "   sudo systemctl restart freeradius"