#!/bin/bash

# 🧹 Clean Server and Deploy Glinta Africa System
# This script safely backs up, cleans, and deploys your new billing system

echo "🌍 Glinta Africa - Server Cleanup & Fresh Deployment"
echo "====================================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create backup directory
BACKUP_DIR="/root/backup_$(date +%Y%m%d_%H%M%S)"
echo -e "${BLUE}📦 Creating backup directory: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Backup existing website
if [ -d "/var/www/html" ]; then
    echo -e "${YELLOW}📁 Backing up existing website...${NC}"
    cp -r /var/www/html "$BACKUP_DIR/website_backup"
    echo -e "${GREEN}✅ Website backup completed${NC}"
else
    echo -e "${YELLOW}ℹ️ No existing website found${NC}"
fi

# Backup databases
echo -e "${YELLOW}🗃️ Backing up databases...${NC}"
if command -v mysqldump &> /dev/null; then
    mysqldump --all-databases > "$BACKUP_DIR/all_databases_backup.sql" 2>/dev/null && \
    echo -e "${GREEN}✅ Database backup completed${NC}" || \
    echo -e "${YELLOW}⚠️ No databases to backup${NC}"
else
    echo -e "${YELLOW}ℹ️ MySQL not found, skipping database backup${NC}"
fi

# Backup web server config
if [ -d "/etc/apache2" ]; then
    cp -r /etc/apache2 "$BACKUP_DIR/apache2_config"
    echo -e "${GREEN}✅ Apache config backed up${NC}"
fi

if [ -d "/etc/nginx" ]; then
    cp -r /etc/nginx "$BACKUP_DIR/nginx_config"
    echo -e "${GREEN}✅ Nginx config backed up${NC}"
fi

echo -e "${GREEN}📦 Backup completed at: $BACKUP_DIR${NC}"

# Ask for confirmation before cleanup
echo ""
echo -e "${YELLOW}⚠️ IMPORTANT: About to clean the server${NC}"
echo -e "${YELLOW}Backup created at: $BACKUP_DIR${NC}"
echo ""
read -p "Continue with cleanup? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ Cleanup cancelled by user${NC}"
    exit 1
fi

# Stop web services
echo -e "${BLUE}🛑 Stopping web services...${NC}"
systemctl stop apache2 2>/dev/null && echo -e "${GREEN}✅ Apache stopped${NC}" || echo -e "${YELLOW}ℹ️ Apache not running${NC}"
systemctl stop nginx 2>/dev/null && echo -e "${GREEN}✅ Nginx stopped${NC}" || echo -e "${YELLOW}ℹ️ Nginx not running${NC}"

# Clean web directory
echo -e "${BLUE}🧹 Cleaning /var/www/html...${NC}"
if [ -d "/var/www/html" ]; then
    rm -rf /var/www/html/*
    rm -rf /var/www/html/.[^.]*
    echo -e "${GREEN}✅ Web directory cleaned${NC}"
else
    mkdir -p /var/www/html
    echo -e "${GREEN}✅ Web directory created${NC}"
fi

# Clean temporary files
echo -e "${BLUE}🧹 Cleaning temporary files...${NC}"
rm -rf /tmp/* 2>/dev/null || true
rm -rf /var/tmp/* 2>/dev/null || true
echo -e "${GREEN}✅ Temporary files cleaned${NC}"

# Clean Docker if present
if command -v docker &> /dev/null; then
    echo -e "${BLUE}🐳 Cleaning Docker containers...${NC}"
    docker stop $(docker ps -aq) 2>/dev/null || true
    docker rm $(docker ps -aq) 2>/dev/null || true
    docker system prune -f 2>/dev/null || true
    echo -e "${GREEN}✅ Docker cleaned${NC}"
fi

# Deploy new system
echo ""
echo -e "${BLUE}🚀 Deploying Glinta Africa Billing System...${NC}"
cd /var/www/

# Clone from GitHub
echo -e "${YELLOW}📥 Cloning from GitHub...${NC}"
git clone https://github.com/watson-coder1/GlintaAfricaBilling-with-radius-final.git html

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Successfully cloned from GitHub${NC}"
else
    echo -e "${RED}❌ Failed to clone from GitHub${NC}"
    echo -e "${YELLOW}📁 Restoring from backup...${NC}"
    cp -r "$BACKUP_DIR/website_backup/"* /var/www/html/ 2>/dev/null || true
    exit 1
fi

# Set permissions
echo -e "${YELLOW}🔐 Setting file permissions...${NC}"
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod -R 777 /var/www/html/system/uploads
chmod -R 777 /var/www/html/system/cache

# Make scripts executable
chmod +x /var/www/html/deploy_to_production.sh
chmod +x /var/www/html/*.sh

echo -e "${GREEN}✅ Permissions set correctly${NC}"

# Run deployment setup
echo -e "${BLUE}⚙️ Running deployment setup...${NC}"
cd /var/www/html

# Copy config template
if [ -f "config.sample.php" ]; then
    cp config.sample.php config.php
    echo -e "${GREEN}✅ Config file created${NC}"
fi

# Run setup scripts
echo -e "${YELLOW}🗃️ Setting up database...${NC}"
php setup_captive_portal_db.php 2>/dev/null && echo -e "${GREEN}✅ Captive portal DB setup${NC}" || echo -e "${YELLOW}⚠️ Run setup_captive_portal_db.php manually${NC}"
php add_kenya_map_menu.php 2>/dev/null && echo -e "${GREEN}✅ Kenya map menu added${NC}" || echo -e "${YELLOW}⚠️ Run add_kenya_map_menu.php manually${NC}"

# Start web services
echo -e "${BLUE}🚀 Starting web services...${NC}"
systemctl start apache2 2>/dev/null && echo -e "${GREEN}✅ Apache started${NC}" || echo -e "${YELLOW}ℹ️ Apache not available${NC}"
systemctl start nginx 2>/dev/null && echo -e "${GREEN}✅ Nginx started${NC}" || echo -e "${YELLOW}ℹ️ Nginx not available${NC}"

# Final status
echo ""
echo -e "${GREEN}🎉 DEPLOYMENT COMPLETED SUCCESSFULLY!${NC}"
echo -e "${GREEN}====================================${NC}"
echo ""
echo -e "${BLUE}📋 Deployment Summary:${NC}"
echo -e "   • Backup created: ${YELLOW}$BACKUP_DIR${NC}"
echo -e "   • Server cleaned: ${GREEN}✅${NC}"
echo -e "   • System deployed: ${GREEN}✅${NC}"
echo -e "   • Permissions set: ${GREEN}✅${NC}"
echo ""
echo -e "${BLUE}🌐 Your website should now be available at:${NC}"
echo -e "   • Main site: ${YELLOW}https://glintaafrica.com/${NC}"
echo -e "   • Admin panel: ${YELLOW}https://glintaafrica.com/?_route=admin${NC}"
echo -e "   • Kenya map: ${YELLOW}https://glintaafrica.com/?_route=maps/kenya${NC}"
echo ""
echo -e "${YELLOW}⚠️ IMPORTANT NEXT STEPS:${NC}"
echo -e "1. Edit config.php with your database settings"
echo -e "2. Configure M-Pesa production credentials in admin panel"
echo -e "3. Test the complete payment flow"
echo -e "4. Update MikroTik to redirect to your captive portal"
echo ""
echo -e "${BLUE}📞 Support:${NC}"
echo -e "   • Email: ${YELLOW}support@glintaafrica.com${NC}"
echo -e "   • Developer: ${YELLOW}Watsons Developers${NC}"
echo -e "   • Repository: ${YELLOW}https://github.com/watson-coder1/GlintaAfricaBilling-with-radius-final${NC}"
echo ""
echo -e "${GREEN}🚀 Your Glinta Africa Billing System is ready! 🇰🇪${NC}"