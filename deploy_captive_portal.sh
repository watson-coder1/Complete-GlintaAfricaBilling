#!/bin/bash
# Captive Portal Deployment Script for Glinta Africa Billing System
# This script deploys the complete captive portal solution on the Digital Ocean server

echo "🚀 Deploying Captive Portal to Glinta Africa Server..."
echo "============================================"

# Navigate to the repository directory
cd /root/billing || {
    echo "❌ Error: /root/billing directory not found"
    exit 1
}

# Pull latest changes from GitHub
echo "📥 Pulling latest changes from GitHub..."
git pull origin main

# Check if pull was successful
if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to pull from GitHub"
    echo "Running git status to check current state..."
    git status
    exit 1
fi

# Copy files to web directory
echo "📁 Copying files to production directory..."
cp -r /root/billing/* /var/www/html/

# Set proper permissions
echo "🔐 Setting proper permissions..."
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
chmod -R 777 /var/www/html/logs
chmod -R 777 /var/www/html/ui/compiled

# Restart services
echo "🔄 Restarting services..."
docker restart glinta-web-prod
service freeradius restart

# Create logs directory if it doesn't exist
echo "📂 Ensuring logs directory exists..."
mkdir -p /var/www/html/logs
chown www-data:www-data /var/www/html/logs
chmod 777 /var/www/html/logs

# Test captive portal
echo "🧪 Testing captive portal..."
curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" https://glintaafrica.com/?_route=captive_portal

# Display important information
echo ""
echo "✅ Deployment Complete!"
echo "============================================"
echo "📋 Important URLs:"
echo "   - Captive Portal: https://glintaafrica.com/?_route=captive_portal"
echo "   - M-Pesa Callback: https://glintaafrica.com/callback/daraja"
echo ""
echo "📋 MikroTik Configuration:"
echo "   - Set hotspot login page to: https://glintaafrica.com/?_route=captive_portal"
echo "   - Add glintaafrica.com to walled garden"
echo ""
echo "📋 Testing:"
echo "   - Use ?mac=00:11:22:33:44:55&ip=192.168.1.100 for testing"
echo "   - Check logs at: /var/www/html/logs/captive_portal_debug.log"
echo ""
echo "📋 Monitor logs:"
echo "   - Portal Debug: tail -f /var/www/html/logs/captive_portal_debug.log"
echo "   - M-Pesa Callbacks: tail -f /var/www/html/logs/captive_portal_callbacks.log"
echo "   - FreeRADIUS: tail -f /var/log/freeradius/radius.log"