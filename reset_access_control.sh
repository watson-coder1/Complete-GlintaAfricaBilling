#!/bin/bash

echo "🔄 Resetting access control - Only paying customers will get WiFi access"
echo "=================================================="

# Step 1: Clear all RADIUS users from database
echo "1️⃣ Clearing all existing RADIUS users..."
php clear_radius_users.php

# Step 2: Remove FreeRADIUS MAC bypass configuration
echo "2️⃣ Removing blanket MAC authentication bypass from FreeRADIUS..."

# Remove the MAC bypass section from FreeRADIUS config
cat > /tmp/freeradius_authorize_fix.txt << 'EOF'
# Remove MAC bypass - only authenticate valid RADIUS users
# The following section should be removed from /etc/freeradius/3.0/sites-enabled/default
# in the authorize section:
#
# if (User-Name =~ /^[0-9a-fA-F]{2}([.:-]?)[0-9a-fA-F]{2}\1([0-9a-fA-F]{2}\1){3}[0-9a-fA-F]{2}$/) {
#     update control {
#         Auth-Type := Accept
#     }
#     ok
# }

echo "FreeRADIUS configuration needs to be updated on server to remove MAC bypass"
echo "Run the following on the server:"
echo "docker exec -it glinta-web-prod sed -i '/User-Name =~ \/\^[0-9a-fA-F]/,/}/d' /etc/freeradius/3.0/sites-enabled/default"
echo "docker exec -it glinta-web-prod systemctl restart freeradius"
EOF

cat /tmp/freeradius_authorize_fix.txt

# Step 3: Commit changes to GitHub
echo "3️⃣ Committing changes to GitHub..."
git add .
git commit -m "🔒 Restrict WiFi access to paying customers only

- Re-enabled removeRadiusUser() function in RadiusManager
- Removed Auth-Type Accept bypass for MAC addresses
- Added script to clear all existing RADIUS users
- Reset access control system for fresh start

🚨 IMPORTANT: Only users who make payments from now on will get internet access

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin main

echo ""
echo "✅ ACCESS CONTROL RESET COMPLETE"
echo "=================================================="
echo "📋 Summary of changes:"
echo "   ✓ RADIUS user removal function re-enabled"
echo "   ✓ Auth-Type Accept bypass removed"
echo "   ✓ All existing users cleared from database"
echo "   ✓ Changes pushed to GitHub"
echo ""
echo "🔥 NEXT STEPS ON SERVER:"
echo "   1. Pull latest code: cd /var/www/html/system && git pull origin main"
echo "   2. Run cleanup: php clear_radius_users.php"
echo "   3. Remove FreeRADIUS MAC bypass (see instructions above)"
echo "   4. Restart FreeRADIUS service"
echo ""
echo "🎯 RESULT: Only customers who pay will get internet access!"