#!/bin/bash

echo "=== Automatically Fixing FreeRADIUS Configuration ==="

# Backup current configuration
sudo cp /etc/freeradius/3.0/clients.conf /etc/freeradius/3.0/clients.conf.backup.$(date +%Y%m%d_%H%M%S)

# Fix the RADIUS secret mismatch
sudo sed -i '/client mikrotik {/,/^}/ s/secret = GlintaRadius2025/secret = radius123/' /etc/freeradius/3.0/clients.conf

echo "✅ Updated FreeRADIUS client secret to match MikroTik configuration"

# Restart FreeRADIUS
echo "🔄 Restarting FreeRADIUS..."
sudo systemctl restart freeradius

# Wait for service to start
sleep 2

# Test authentication
echo "🧪 Testing RADIUS authentication..."
echo ""
radtest 1a:8e:62:ff:0b:02 1a:8e:62:ff:0b:02 localhost 0 testing123

echo ""
echo "✅ If you see 'Access-Accept' above, FreeRADIUS is now working correctly!"
echo ""
echo "📥 Now pulling latest code updates..."
cd /var/www/glintaafrica
git pull origin main

echo ""
echo "🎯 DONE! Test the complete payment flow now!"