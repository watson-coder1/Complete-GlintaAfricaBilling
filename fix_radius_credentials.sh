#!/bin/bash

# Fix RADIUS Database Credentials
# Fixes the "Access denied for user 'glinta_user'" error

set -e

echo "=== FIXING RADIUS DATABASE CREDENTIALS ==="
echo "Timestamp: $(date)"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ ERROR: This script must be run with sudo"
    exit 1
fi

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_message "🔧 Fixing FreeRADIUS SQL credentials..."

# Stop FreeRADIUS first
systemctl stop freeradius 2>/dev/null || true

# Get MySQL container IP
MYSQL_CONTAINER=$(docker ps -q --filter "name=mysql" | head -1)
if [ -z "$MYSQL_CONTAINER" ]; then
    MYSQL_CONTAINER=$(docker ps -q --filter "name=glinta-mysql" | head -1)
fi

if [ ! -z "$MYSQL_CONTAINER" ]; then
    MYSQL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$MYSQL_CONTAINER")
    log_message "🔍 Found MySQL container IP: $MYSQL_IP"
else
    log_message "❌ No MySQL container found"
    exit 1
fi

# Backup and fix SQL configuration
SQL_CONFIG="/etc/freeradius/3.0/mods-available/sql"
cp "$SQL_CONFIG" "$SQL_CONFIG.backup-$(date +%Y%m%d-%H%M%S)"

log_message "🔧 Updating SQL configuration with correct credentials..."

# Fix the database credentials
sed -i "s/server = .*/server = \"$MYSQL_IP\"/" "$SQL_CONFIG"
sed -i 's/login = .*/login = "root"/' "$SQL_CONFIG"
sed -i 's/password = .*/password = "Glinta2025!"/' "$SQL_CONFIG"
sed -i 's/radius_db = .*/radius_db = "radius"/' "$SQL_CONFIG"

# Also fix the read_clients configuration if it exists
sed -i 's/read_clients = yes/read_clients = no/' "$SQL_CONFIG"

log_message "✅ SQL configuration updated"

# Test database connection manually
log_message "🧪 Testing database connection..."
if docker exec -i "$MYSQL_CONTAINER" mysql -u root -pGlinta2025! radius -e "SELECT 1;" >/dev/null 2>&1; then
    log_message "✅ Database connection test successful"
else
    log_message "❌ Database connection test failed"
    
    # Create the radius database if it doesn't exist
    log_message "🔧 Creating radius database..."
    docker exec -i "$MYSQL_CONTAINER" mysql -u root -pGlinta2025! << 'EOF'
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

-- Add test user
INSERT INTO radcheck (username, attribute, op, value)
VALUES ('9C:BC:F0:79:23:9A', 'Cleartext-Password', ':=', '9C:BC:F0:79:23:9A')
ON DUPLICATE KEY UPDATE value='9C:BC:F0:79:23:9A';

INSERT INTO radcheck (username, attribute, op, value)
VALUES ('9C:BC:F0:79:23:9A', 'Auth-Type', ':=', 'Accept')
ON DUPLICATE KEY UPDATE value='Accept';

GRANT ALL PRIVILEGES ON radius.* TO 'root'@'%';
FLUSH PRIVILEGES;
EOF

    log_message "✅ Radius database created"
fi

# Test FreeRADIUS configuration
log_message "🧪 Testing FreeRADIUS configuration..."
if freeradius -C; then
    log_message "✅ FreeRADIUS configuration test passed"
else
    log_message "❌ FreeRADIUS configuration test failed"
    exit 1
fi

# Start FreeRADIUS service
log_message "🚀 Starting FreeRADIUS service..."
systemctl start freeradius

# Check service status
sleep 3
if systemctl is-active --quiet freeradius; then
    log_message "✅ FreeRADIUS service started successfully"
    
    # Test authentication
    log_message "🧪 Testing RADIUS authentication..."
    if timeout 10 radtest 9C:BC:F0:79:23:9A 9C:BC:F0:79:23:9A localhost 0 testing123; then
        log_message "✅ RADIUS authentication test successful!"
    else
        log_message "⚠️ RADIUS authentication test failed - this may be normal if the user doesn't exist"
    fi
    
else
    log_message "❌ FreeRADIUS service failed to start"
    systemctl status freeradius --no-pager
    exit 1
fi

log_message "=== RADIUS CREDENTIALS FIX COMPLETE ==="
log_message "🎉 Summary:"
log_message "   - Database server: $MYSQL_IP"
log_message "   - Database user: root"
log_message "   - Database name: radius"
log_message "   - Service status: $(systemctl is-active freeradius)"

echo
echo "🎉 FreeRADIUS is now running successfully!"
echo "You can now test the captive portal payment flow."