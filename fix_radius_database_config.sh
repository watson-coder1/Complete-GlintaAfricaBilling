#!/bin/bash

# Fix RADIUS Database Configuration
# This script fixes the database configuration mismatch

set -e

echo "=== FIXING RADIUS DATABASE CONFIGURATION ==="
echo "Timestamp: $(date)"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ ERROR: This script must be run with sudo"
    echo "Usage: sudo bash fix_radius_database_config.sh"
    exit 1
fi

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_message "🔍 Checking current FreeRADIUS SQL configuration..."

# Backup current SQL configuration
SQL_CONFIG="/etc/freeradius/3.0/mods-available/sql"
if [ -f "$SQL_CONFIG" ]; then
    cp "$SQL_CONFIG" "$SQL_CONFIG.backup-$(date +%Y%m%d-%H%M%S)"
    log_message "✅ SQL configuration backed up"
else
    log_message "❌ SQL configuration file not found at $SQL_CONFIG"
    exit 1
fi

# Update SQL configuration to use the correct database
log_message "🔧 Updating SQL configuration to use correct database..."

# Update the database name from glinta_billing to radius
sed -i 's/radius_db = "glinta_billing"/radius_db = "radius"/' "$SQL_CONFIG"

# Also ensure the server IP is correct for Docker
sed -i 's/server = "127.0.0.1"/server = "172.18.0.4"/' "$SQL_CONFIG"
sed -i 's/server = "localhost"/server = "172.18.0.4"/' "$SQL_CONFIG"

# Update login credentials if needed
sed -i 's/login = "radius"/login = "root"/' "$SQL_CONFIG"
sed -i 's/password = "radpass"/password = "Glinta2025!"/' "$SQL_CONFIG"

log_message "✅ SQL configuration updated"

# Create radius database and tables if they don't exist
log_message "🔧 Setting up radius database and tables..."

# Connect to MySQL and set up the radius database
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! << 'EOF'
CREATE DATABASE IF NOT EXISTS radius;
USE radius;

-- Create radcheck table
CREATE TABLE IF NOT EXISTS radcheck (
  id int(11) unsigned NOT NULL auto_increment,
  username varchar(64) NOT NULL default '',
  attribute varchar(64)  NOT NULL default '',
  op char(2) NOT NULL DEFAULT '==',
  value varchar(253) NOT NULL default '',
  PRIMARY KEY  (id),
  KEY username (username(32))
);

-- Create radreply table
CREATE TABLE IF NOT EXISTS radreply (
  id int(11) unsigned NOT NULL auto_increment,
  username varchar(64) NOT NULL default '',
  attribute varchar(64) NOT NULL default '',
  op char(2) NOT NULL DEFAULT '=',
  value varchar(253) NOT NULL default '',
  PRIMARY KEY  (id),
  KEY username (username(32))
);

-- Create radgroupcheck table
CREATE TABLE IF NOT EXISTS radgroupcheck (
  id int(11) unsigned NOT NULL auto_increment,
  groupname varchar(64) NOT NULL default '',
  attribute varchar(64)  NOT NULL default '',
  op char(2) NOT NULL DEFAULT '==',
  value varchar(253)  NOT NULL default '',
  PRIMARY KEY  (id),
  KEY groupname (groupname(32))
);

-- Create radgroupreply table
CREATE TABLE IF NOT EXISTS radgroupreply (
  id int(11) unsigned NOT NULL auto_increment,
  groupname varchar(64) NOT NULL default '',
  attribute varchar(64)  NOT NULL default '',
  op char(2) NOT NULL DEFAULT '=',
  value varchar(253)  NOT NULL default '',
  PRIMARY KEY  (id),
  KEY groupname (groupname(32))
);

-- Create radusergroup table
CREATE TABLE IF NOT EXISTS radusergroup (
  username varchar(64) NOT NULL default '',
  groupname varchar(64) NOT NULL default '',
  priority int(11) NOT NULL default '1',
  KEY username (username(32))
);

-- Create radacct table
CREATE TABLE IF NOT EXISTS radacct (
  radacctid bigint(21) NOT NULL auto_increment,
  acctsessionid varchar(64) NOT NULL default '',
  acctuniqueid varchar(32) NOT NULL default '',
  username varchar(64) NOT NULL default '',
  groupname varchar(64) NOT NULL default '',
  realm varchar(64) default '',
  nasipaddress varchar(15) NOT NULL default '',
  nasportid varchar(15) default NULL,
  nasporttype varchar(32) default NULL,
  acctstarttime datetime NULL default NULL,
  acctupdatetime datetime NULL default NULL,
  acctstoptime datetime NULL default NULL,
  acctinterval int(12) default NULL,
  acctsessiontime int(12) unsigned default NULL,
  acctauthentic varchar(32) default NULL,
  connectinfo_start varchar(50) default NULL,
  connectinfo_stop varchar(50) default NULL,
  acctinputoctets bigint(20) default NULL,
  acctoutputoctets bigint(20) default NULL,
  calledstationid varchar(50) NOT NULL default '',
  callingstationid varchar(50) NOT NULL default '',
  acctterminatecause varchar(32) NOT NULL default '',
  servicetype varchar(32) default NULL,
  framedprotocol varchar(32) default NULL,
  framedipaddress varchar(15) NOT NULL default '',
  PRIMARY KEY (radacctid),
  UNIQUE KEY acctuniqueid (acctuniqueid),
  KEY username (username),
  KEY framedipaddress (framedipaddress),
  KEY acctsessionid (acctsessionid),
  KEY acctsessiontime (acctsessiontime),
  KEY acctstarttime (acctstarttime),
  KEY acctinterval (acctinterval),
  KEY acctstoptime (acctstoptime),
  KEY nasipaddress (nasipaddress)
);

-- Create nas table
CREATE TABLE IF NOT EXISTS nas (
  id int(10) NOT NULL auto_increment,
  nasname varchar(128) NOT NULL,
  shortname varchar(32),
  type varchar(30) DEFAULT 'other',
  ports int(5),
  secret varchar(60) DEFAULT 'secret' NOT NULL,
  server varchar(64),
  community varchar(50),
  description varchar(200) DEFAULT 'RADIUS Client',
  PRIMARY KEY (id),
  KEY nasname (nasname)
);

-- Insert NAS configuration for MikroTik
INSERT INTO nas (nasname, shortname, type, ports, secret, description) 
VALUES ('192.168.100.24', 'mikrotik-network', 'mikrotik', 1812, 'testing123', 'MikroTik Hotspot Gateway')
ON DUPLICATE KEY UPDATE secret='testing123';

GRANT ALL PRIVILEGES ON radius.* TO 'root'@'%';
FLUSH PRIVILEGES;
EOF

log_message "✅ Radius database and tables created/verified"

# Test configuration
log_message "🧪 Testing FreeRADIUS configuration..."
if freeradius -C; then
    log_message "✅ FreeRADIUS configuration test passed"
else
    log_message "❌ FreeRADIUS configuration test failed"
    log_message "📋 Showing SQL configuration details:"
    grep -A 10 -B 10 "radius_db" "$SQL_CONFIG" || true
fi

# Restart FreeRADIUS
log_message "🔄 Restarting FreeRADIUS service..."
systemctl restart freeradius
sleep 3

# Check service status
if systemctl is-active --quiet freeradius; then
    log_message "✅ FreeRADIUS service restarted successfully"
else
    log_message "❌ FreeRADIUS service failed to start"
    systemctl status freeradius --no-pager
    exit 1
fi

# Add the test user to the correct database
log_message "🔧 Adding test user to radius database..."
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! radius << 'EOF'
INSERT INTO radcheck (username, attribute, op, value)
VALUES ('9C:BC:F0:79:23:9A', 'Cleartext-Password', ':=', '9C:BC:F0:79:23:9A')
ON DUPLICATE KEY UPDATE value='9C:BC:F0:79:23:9A';

INSERT INTO radcheck (username, attribute, op, value)
VALUES ('9C:BC:F0:79:23:9A', 'Auth-Type', ':=', 'Accept')
ON DUPLICATE KEY UPDATE value='Accept';

INSERT INTO radreply (username, attribute, op, value)
VALUES ('9C:BC:F0:79:23:9A', 'Session-Timeout', ':=', '3600')
ON DUPLICATE KEY UPDATE value='3600';
EOF

log_message "✅ Test user added to radius database"

# Test authentication
log_message "🧪 Testing RADIUS authentication..."
if timeout 10 radtest 9C:BC:F0:79:23:9A 9C:BC:F0:79:23:9A localhost 0 testing123; then
    log_message "✅ RADIUS authentication test successful!"
else
    log_message "⚠️ RADIUS authentication test failed - checking database entries..."
    
    # Show what's in the database
    docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! radius -e "SELECT * FROM radcheck WHERE username = '9C:BC:F0:79:23:9A';"
    
    # Run debug mode to see what's happening
    log_message "📋 Running FreeRADIUS in debug mode for 10 seconds..."
    timeout 10 freeradius -X > /tmp/radius_debug_output.log 2>&1 &
    sleep 5
    
    # Try authentication again
    radtest 9C:BC:F0:79:23:9A 9C:BC:F0:79:23:9A localhost 0 testing123 || true
    
    sleep 5
    pkill freeradius || true
    
    echo "=== DEBUG OUTPUT ==="
    tail -50 /tmp/radius_debug_output.log
    echo "=== END DEBUG ==="
fi

log_message "=== RADIUS DATABASE CONFIGURATION FIX COMPLETE ==="
log_message "🎉 Configuration Summary:"
log_message "   - Database: radius (was glinta_billing)"
log_message "   - Server: 172.18.0.4 (Docker MySQL)"
log_message "   - User: root"
log_message "   - Test user: 9C:BC:F0:79:23:9A"
log_message ""
log_message "🔧 Next steps:"
log_message "1. Test with real MAC addresses from your captive portal"
log_message "2. Monitor logs: tail -f /var/log/freeradius/radius.log"
log_message "3. Restart MikroTik to clear any cached authentication attempts"

echo
echo "Script completed! 🎉"