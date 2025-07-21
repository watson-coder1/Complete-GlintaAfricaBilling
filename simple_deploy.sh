#!/bin/bash
# Simple Captive Portal Deployment for Glinta Africa
echo "🚀 Deploying Captive Portal Files..."

# Download latest files directly from GitHub
echo "📥 Downloading captive portal controller..."
wget -O /tmp/captive_portal.php https://raw.githubusercontent.com/watson-coder1/Complete-GlintaAfricaBilling/main/system/controllers/captive_portal.php

echo "📥 Downloading Daraja payment gateway..."
wget -O /tmp/Daraja.php https://raw.githubusercontent.com/watson-coder1/Complete-GlintaAfricaBilling/main/system/paymentgateway/Daraja.php

echo "📥 Downloading RADIUS manager..."
wget -O /tmp/RadiusManager.php https://raw.githubusercontent.com/watson-coder1/Complete-GlintaAfricaBilling/main/system/autoload/RadiusManager.php

echo "📥 Downloading callback handler..."
wget -O /tmp/callback_mpesa.php https://raw.githubusercontent.com/watson-coder1/Complete-GlintaAfricaBilling/main/callback_mpesa.php

echo "📥 Downloading setup script..."
wget -O /tmp/setup_captive_portal_db.php https://raw.githubusercontent.com/watson-coder1/Complete-GlintaAfricaBilling/main/setup_captive_portal_db.php

# Create directories if they don't exist
mkdir -p /var/www/html/system/controllers
mkdir -p /var/www/html/system/paymentgateway  
mkdir -p /var/www/html/system/autoload
mkdir -p /var/www/html/logs

# Copy files to production
echo "📁 Installing files..."
cp /tmp/captive_portal.php /var/www/html/system/controllers/
cp /tmp/Daraja.php /var/www/html/system/paymentgateway/
cp /tmp/RadiusManager.php /var/www/html/system/autoload/
cp /tmp/callback_mpesa.php /var/www/html/
cp /tmp/setup_captive_portal_db.php /var/www/html/

# Set permissions
echo "🔐 Setting permissions..."
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
chmod -R 777 /var/www/html/logs

# Restart services
echo "🔄 Restarting services..."
docker restart glinta-web-prod 2>/dev/null || echo "Docker container not found, continuing..."
service freeradius restart 2>/dev/null || echo "FreeRADIUS not found, continuing..."

# Setup database tables
echo "🗃️ Setting up database..."
cd /var/www/html && php setup_captive_portal_db.php

# Test the portal
echo "🧪 Testing portal..."
curl -s -o /dev/null -w "Captive Portal Status: %{http_code}\n" "https://glintaafrica.com/?_route=captive_portal" || echo "Could not test - check manually"

echo ""
echo "✅ Deployment Complete!"
echo "=================================================="
echo "🌐 Portal URL: https://glintaafrica.com/?_route=captive_portal"
echo "🔗 For MikroTik: https://glintaafrica.com/?_route=captive_portal"
echo "📞 M-Pesa Callback: https://glintaafrica.com/callback_mpesa.php"
echo ""
echo "📋 Next Steps:"
echo "1. Configure MikroTik hotspot login page"
echo "2. Add glintaafrica.com to walled garden"
echo "3. Test with: ?mac=00:11:22:33:44:55&ip=192.168.1.100"
echo ""
echo "📊 Monitor logs:"
echo "- Portal: tail -f /var/www/html/logs/captive_portal_debug.log"
echo "- Callbacks: tail -f /var/www/html/logs/captive_portal_callbacks.log"