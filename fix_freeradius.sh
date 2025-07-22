#!/bin/bash

echo "=== Fixing FreeRADIUS Configuration ==="

# Create FreeRADIUS client configuration for MikroTik
cat > /tmp/mikrotik_client.conf << 'EOF'
# MikroTik external client
client mikrotik-external {
    ipaddr = 0.0.0.0/0
    secret = radius123
    require_message_authenticator = no
    nas_type = mikrotik
}
EOF

echo "Run these commands on your server:"
echo ""
echo "1. Add MikroTik client to FreeRADIUS:"
echo "   sudo nano /etc/freeradius/3.0/clients.conf"
echo "   # Add this at the end:"
echo "   client mikrotik-external {"
echo "       ipaddr = 0.0.0.0/0"
echo "       secret = radius123"
echo "       require_message_authenticator = no"
echo "       nas_type = mikrotik"
echo "   }"
echo ""
echo "2. Restart FreeRADIUS:"
echo "   sudo systemctl restart freeradius"
echo ""
echo "3. Test RADIUS authentication:"
echo "   radtest 1a:8e:62:ff:0b:02 1a:8e:62:ff:0b:02 localhost 0 testing123"
echo ""
echo "4. Check if response shows 'Access-Accept'"