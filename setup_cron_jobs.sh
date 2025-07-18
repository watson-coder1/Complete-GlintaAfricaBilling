#!/bin/bash

# Cron Jobs Setup Script for PHPNuxBill + RADIUS
# Developed by Watsons Developers (watsonsdevelopers.com)

echo "🔧 Setting up Cron Jobs for PHPNuxBill + RADIUS System"
echo "=================================================="

# Check if running as root or with sudo
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run as root or with sudo"
    echo "Usage: sudo bash setup_cron_jobs.sh"
    exit 1
fi

# Backup existing crontab
echo "📋 Backing up existing crontab..."
crontab -l > /tmp/crontab_backup_$(date +%Y%m%d_%H%M%S).txt 2>/dev/null || echo "No existing crontab found"

# Create new cron entries
echo "⚙️  Adding PHPNuxBill cron jobs..."

# Add cron jobs to current crontab
(crontab -l 2>/dev/null; cat << 'EOF'

# PHPNuxBill Main System Cron Job (every 5 minutes)
# Handles user expiry, account management, etc.
*/5 * * * * docker exec nuxbill php /var/www/html/cron.php >> /var/log/phpnuxbill_cron.log 2>&1

# RADIUS Session Management Cron Job (every 5 minutes)  
# Handles RADIUS user expiry, session timeouts, data limits
*/5 * * * * docker exec nuxbill php /var/www/html/radius_cron.php >> /var/log/radius_cron.log 2>&1

# Daily cleanup and maintenance (2 AM every day)
0 2 * * * docker exec nuxbill php -r "require_once 'init.php'; RadiusManager::cleanOldRecords(90);" >> /var/log/radius_cleanup.log 2>&1

# Weekly log rotation (Sunday 3 AM)
0 3 * * 0 find /var/log/ -name "*phpnuxbill*.log" -size +10M -exec truncate -s 0 {} \; 2>/dev/null
0 3 * * 0 find /var/log/ -name "*radius*.log" -size +10M -exec truncate -s 0 {} \; 2>/dev/null

EOF
) | crontab -

# Create log directory if it doesn't exist
mkdir -p /var/log

# Set proper permissions for log files
touch /var/log/phpnuxbill_cron.log
touch /var/log/radius_cron.log  
touch /var/log/radius_cleanup.log
chmod 644 /var/log/*phpnuxbill*.log
chmod 644 /var/log/*radius*.log

echo "✅ Cron jobs have been added successfully!"
echo ""
echo "📋 Added Cron Jobs:"
echo "├── PHPNuxBill Main Cron: Every 5 minutes"
echo "├── RADIUS Session Management: Every 5 minutes"
echo "├── Daily RADIUS Cleanup: 2 AM daily"
echo "└── Weekly Log Rotation: Sunday 3 AM"
echo ""
echo "📊 Log Files Created:"
echo "├── /var/log/phpnuxbill_cron.log"
echo "├── /var/log/radius_cron.log"
echo "└── /var/log/radius_cleanup.log"
echo ""
echo "🔍 To verify cron jobs are installed:"
echo "   crontab -l"
echo ""
echo "📈 To monitor cron job execution:"
echo "   tail -f /var/log/phpnuxbill_cron.log"
echo "   tail -f /var/log/radius_cron.log"
echo ""
echo "🎉 Setup Complete! Your system will now:"
echo "   ✅ Automatically expire user sessions"
echo "   ✅ Manage RADIUS authentication"
echo "   ✅ Clean up old records"
echo "   ✅ Rotate log files"
echo ""
echo "⚠️  Important: Make sure Docker containers are running:"
echo "   docker ps | grep nuxbill"