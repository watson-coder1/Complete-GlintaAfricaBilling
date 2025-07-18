#!/bin/bash

# 🚀 Glinta Africa Production Deployment Script
# This script packages and prepares the system for deployment to glintaafrica.com

echo "🌍 Glinta Africa Billing System - Production Deployment"
echo "======================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get current directory
CURRENT_DIR=$(pwd)
PACKAGE_NAME="glinta-africa-billing-$(date +%Y%m%d-%H%M%S)"
PACKAGE_DIR="/tmp/${PACKAGE_NAME}"

echo -e "${BLUE}📦 Creating production package...${NC}"

# Create package directory
mkdir -p "$PACKAGE_DIR"

# Copy essential files
echo -e "${YELLOW}📁 Copying core system files...${NC}"
rsync -av --exclude='.git' \
          --exclude='*.log' \
          --exclude='system/cache/*' \
          --exclude='system/uploads/temp/*' \
          --exclude='node_modules' \
          --exclude='*.swp' \
          --exclude='*.tmp' \
          "$CURRENT_DIR/" "$PACKAGE_DIR/"

# Create deployment info file
echo -e "${YELLOW}📄 Creating deployment information...${NC}"
cat > "$PACKAGE_DIR/DEPLOYMENT_INFO.txt" << EOF
Glinta Africa Billing System - Production Package
================================================

Package Created: $(date)
Version: Production Ready
Target Domain: glintaafrica.com

FEATURES INCLUDED:
✅ M-Pesa Daraja STK Push Integration
✅ RADIUS Authentication (FreeRADIUS)
✅ Dynamic Captive Portal (No-login required)
✅ Interactive Kenya Map
✅ Enhanced Analytics Dashboard
✅ Complete Glinta Africa Branding
✅ 22 Professional Landing Pages
✅ Real-time Revenue Tracking
✅ Automatic User Management

DEPLOYMENT CHECKLIST:
□ Upload to Digital Ocean server
□ Configure database settings in config.php
□ Set up M-Pesa production credentials
□ Configure SSL certificate
□ Test payment flow
□ Update MikroTik redirect URLs

IMPORTANT FILES:
- system/paymentgateway/Daraja.php (M-Pesa integration)
- system/autoload/RadiusManager.php (RADIUS management)
- system/controllers/captive_portal.php (Captive portal)
- system/controllers/maps.php (Kenya map)
- ui/ui/admin/maps/kenya.tpl (Interactive map)
- system/controllers/landing.php (Landing pages)

NEXT STEPS:
1. Upload to /var/www/html on your server
2. Configure config.php with production settings
3. Run setup scripts: setup_captive_portal_db.php
4. Configure M-Pesa production credentials
5. Test complete payment flow

Support: support@glintaafrica.com
Developer: Watsons Developers (https://watsonsdevelopers.com)
EOF

# Create quick deployment script
echo -e "${YELLOW}🔧 Creating server deployment script...${NC}"
cat > "$PACKAGE_DIR/deploy_on_server.sh" << 'EOF'
#!/bin/bash

echo "🚀 Deploying Glinta Africa Billing System..."

# Set permissions
echo "📁 Setting file permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod -R 777 /var/www/html/system/uploads
chmod -R 777 /var/www/html/system/cache

# Run setup scripts
echo "🗃️ Setting up database..."
cd /var/www/html
php setup_captive_portal_db.php
php add_kenya_map_menu.php

echo "✅ Deployment complete!"
echo "🌐 Your site should now be available at: https://glintaafrica.com"
echo "📊 Admin panel: https://glintaafrica.com/?_route=admin"
echo "🗺️ Kenya map: https://glintaafrica.com/?_route=maps/kenya"

echo ""
echo "⚠️ IMPORTANT: Don't forget to:"
echo "1. Configure M-Pesa production credentials in admin panel"
echo "2. Update config.php with your database settings"
echo "3. Test the payment flow with real M-Pesa transactions"
echo "4. Configure MikroTik to redirect to captive portal"
EOF

chmod +x "$PACKAGE_DIR/deploy_on_server.sh"

# Create configuration template
echo -e "${YELLOW}⚙️ Creating production config template...${NC}"
cat > "$PACKAGE_DIR/config.production.php" << 'EOF'
<?php
/**
 * Production Configuration for Glinta Africa
 * Copy this to config.php and update with your actual values
 */

// Database Configuration
$db_host = 'localhost';           // Your database host
$db_user = 'your_db_user';        // Your database username
$db_pass = 'your_db_password';    // Your database password
$db_name = 'your_db_name';        // Your database name

// RADIUS Database (if separate)
$radius_db_host = 'localhost';
$radius_db_user = 'radius_user';
$radius_db_pass = 'radius_password';
$radius_db_name = 'radius_db';

// Application URLs
$app_url = 'https://glintaafrica.com';
$base_url = 'https://glintaafrica.com/';

// M-Pesa Configuration (Update in Admin Panel)
// Go to: Admin → Settings → Payment Gateway → Daraja
// Consumer Key: [Your Production Key]
// Consumer Secret: [Your Production Secret]  
// Business Shortcode: [Your Business Number]
// Passkey: [Your Production Passkey]
// Environment: production
// Callback URL: https://glintaafrica.com/?_route=callback/mpesa

// Security
$api_key = 'your_secure_api_key_here';
$secret_key = 'your_secret_key_here';

// Email Configuration
$smtp_host = 'your_smtp_host';
$smtp_port = 587;
$smtp_user = 'support@glintaafrica.com';
$smtp_pass = 'your_email_password';

// System Settings
$debug_mode = false;  // Set to false in production
$log_level = 'ERROR'; // Only log errors in production

?>
EOF

# Create archive
echo -e "${YELLOW}📦 Creating deployment archive...${NC}"
cd /tmp
tar -czf "${PACKAGE_NAME}.tar.gz" "$PACKAGE_NAME"

echo ""
echo -e "${GREEN}✅ PRODUCTION PACKAGE READY!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "${BLUE}Package Location:${NC} /tmp/${PACKAGE_NAME}.tar.gz"
echo -e "${BLUE}Package Size:${NC} $(du -h "/tmp/${PACKAGE_NAME}.tar.gz" | cut -f1)"
echo ""
echo -e "${YELLOW}📋 DEPLOYMENT INSTRUCTIONS:${NC}"
echo "1. Upload ${PACKAGE_NAME}.tar.gz to your server"
echo "2. Extract to /var/www/html"
echo "3. Run: chmod +x deploy_on_server.sh && ./deploy_on_server.sh"
echo "4. Configure config.php with your database settings"
echo "5. Set up M-Pesa production credentials in admin panel"
echo ""
echo -e "${GREEN}🌐 YOUR GLINTA AFRICA SYSTEM IS READY FOR PRODUCTION!${NC}"
echo ""
echo -e "${BLUE}Key URLs after deployment:${NC}"
echo "• Main Site: https://glintaafrica.com/"
echo "• Admin Panel: https://glintaafrica.com/?_route=admin"
echo "• Kenya Map: https://glintaafrica.com/?_route=maps/kenya"
echo "• Captive Portal: https://glintaafrica.com/?_route=captive_portal"
echo ""
echo -e "${YELLOW}Support: support@glintaafrica.com${NC}"
echo -e "${YELLOW}Developer: Watsons Developers (https://watsonsdevelopers.com)${NC}"

# Clean up temporary directory
rm -rf "$PACKAGE_DIR"

echo ""
echo -e "${GREEN}🎉 Deployment package creation complete!${NC}"