#!/bin/bash

# Docker RADIUS Configuration Fix
# Handles both containerized and host-based FreeRADIUS setups

set -e

echo "=== DOCKER RADIUS CONFIGURATION FIX ==="
echo "Timestamp: $(date)"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ ERROR: This script must be run with sudo"
    echo "Usage: sudo bash fix_docker_radius.sh"
    exit 1
fi

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_message "🔍 Detecting RADIUS setup type..."

# Check if FreeRADIUS is running in Docker
RADIUS_CONTAINER=$(docker ps -q --filter "name=radius" 2>/dev/null | head -1)
FREERADIUS_CONTAINER=$(docker ps -q --filter "name=freeradius" 2>/dev/null | head -1)

if [ ! -z "$RADIUS_CONTAINER" ] || [ ! -z "$FREERADIUS_CONTAINER" ]; then
    log_message "📦 Found RADIUS running in Docker container"
    CONTAINER_ID=${RADIUS_CONTAINER:-$FREERADIUS_CONTAINER}
    
    log_message "🔧 Configuring containerized FreeRADIUS..."
    
    # Configure FreeRADIUS inside the container
    docker exec -it "$CONTAINER_ID" bash -c "
        # Update SQL configuration
        sed -i 's/server = \"localhost\"/server = \"mysql\"/' /etc/freeradius/3.0/mods-available/sql
        sed -i 's/server = \"127.0.0.1\"/server = \"mysql\"/' /etc/freeradius/3.0/mods-available/sql
        sed -i 's/login = \"radius\"/login = \"root\"/' /etc/freeradius/3.0/mods-available/sql
        sed -i 's/password = \"radpass\"/password = \"Glinta2025!\"/' /etc/freeradius/3.0/mods-available/sql
        sed -i 's/radius_db = \"radius\"/radius_db = \"radius\"/' /etc/freeradius/3.0/mods-available/sql
        
        # Enable SQL module
        ln -sf /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/sql
        
        # Test configuration
        freeradius -C
    "
    
    log_message "🔄 Restarting RADIUS container..."
    docker restart "$CONTAINER_ID"
    
elif [ -f "/etc/freeradius/3.0/mods-available/sql" ]; then
    log_message "🖥️ Found FreeRADIUS running on host system"
    
    # Get MySQL container IP
    MYSQL_CONTAINER=$(docker ps -q --filter "name=mysql" | head -1)
    if [ -z "$MYSQL_CONTAINER" ]; then
        MYSQL_CONTAINER=$(docker ps -q --filter "name=glinta-mysql" | head -1)
    fi
    
    if [ ! -z "$MYSQL_CONTAINER" ]; then
        MYSQL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$MYSQL_CONTAINER")
        log_message "🔍 Found MySQL container IP: $MYSQL_IP"
    else
        MYSQL_IP="172.18.0.4"  # Default Docker network IP
        log_message "⚠️ Using default MySQL IP: $MYSQL_IP"
    fi
    
    # Backup current SQL configuration
    SQL_CONFIG="/etc/freeradius/3.0/mods-available/sql"
    cp "$SQL_CONFIG" "$SQL_CONFIG.backup-$(date +%Y%m%d-%H%M%S)"
    log_message "✅ SQL configuration backed up"
    
    # Update SQL configuration for Docker MySQL
    log_message "🔧 Updating SQL configuration for Docker MySQL..."
    
    # Update database connection settings
    sed -i "s/server = \"localhost\"/server = \"$MYSQL_IP\"/" "$SQL_CONFIG"
    sed -i "s/server = \"127.0.0.1\"/server = \"$MYSQL_IP\"/" "$SQL_CONFIG"
    sed -i 's/login = "radius"/login = "root"/' "$SQL_CONFIG"
    sed -i 's/password = "radpass"/password = "Glinta2025!"/' "$SQL_CONFIG"
    sed -i 's/radius_db = "glinta_billing"/radius_db = "radius"/' "$SQL_CONFIG"
    sed -i 's/radius_db = "radius"/radius_db = "radius"/' "$SQL_CONFIG"
    
    log_message "✅ SQL configuration updated for Docker MySQL"
    
    # Enable SQL module
    ln -sf /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/sql
    
    # Test configuration before restarting
    log_message "🧪 Testing FreeRADIUS configuration..."
    if freeradius -C; then
        log_message "✅ FreeRADIUS configuration test passed"
    else
        log_message "❌ FreeRADIUS configuration test failed"
        log_message "📋 Configuration details:"
        grep -A 5 -B 5 "server\|login\|password\|radius_db" "$SQL_CONFIG"
        exit 1
    fi
    
    # Restart FreeRADIUS
    log_message "🔄 Restarting FreeRADIUS service..."
    systemctl restart freeradius || {
        log_message "❌ FreeRADIUS restart failed. Checking logs..."
        journalctl -xeu freeradius.service --no-pager -n 20
        exit 1
    }
    
else
    log_message "❌ No FreeRADIUS installation found"
    log_message "💡 Installing FreeRADIUS on host system..."
    
    apt-get update
    apt-get install -y freeradius freeradius-mysql freeradius-utils
    
    # Recursive call after installation
    bash "$0"
    exit 0
fi

# Setup radius database in MySQL container
log_message "🔧 Setting up radius database in MySQL container..."

MYSQL_CONTAINER=$(docker ps -q --filter "name=mysql" | head -1)
if [ -z "$MYSQL_CONTAINER" ]; then
    MYSQL_CONTAINER=$(docker ps -q --filter "name=glinta-mysql" | head -1)
fi

if [ ! -z "$MYSQL_CONTAINER" ]; then
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

    log_message "✅ Radius database setup completed"
else
    log_message "❌ No MySQL container found"
    exit 1
fi

# Test the setup
log_message "🧪 Testing RADIUS setup..."

# Check service status
if [ ! -z "$RADIUS_CONTAINER" ] || [ ! -z "$FREERADIUS_CONTAINER" ]; then
    CONTAINER_ID=${RADIUS_CONTAINER:-$FREERADIUS_CONTAINER}
    if docker ps | grep -q "$CONTAINER_ID"; then
        log_message "✅ RADIUS container is running"
    else
        log_message "❌ RADIUS container is not running"
    fi
elif systemctl is-active --quiet freeradius; then
    log_message "✅ FreeRADIUS service is running on host"
else
    log_message "❌ FreeRADIUS service is not running on host"
    systemctl status freeradius --no-pager
fi

# Install PHP if needed for testing
if ! command -v php &> /dev/null; then
    log_message "📦 Installing PHP for testing..."
    apt-get install -y php-cli php-mysql
fi

# Test database connection
log_message "🔍 Testing database connection..."
docker exec -i "$MYSQL_CONTAINER" mysql -u root -pGlinta2025! radius -e "SELECT COUNT(*) as users FROM radcheck;" 2>/dev/null || {
    log_message "❌ Database connection test failed"
    exit 1
}

log_message "✅ Database connection test passed"

log_message "=== DOCKER RADIUS CONFIGURATION COMPLETE ==="
log_message "🎉 Configuration Summary:"
log_message "   - Database: radius"
log_message "   - MySQL Container: $(docker ps --format 'table {{.Names}}' | grep mysql)"
log_message "   - Test user: 9C:BC:F0:79:23:9A"
log_message ""
log_message "🔧 Next steps:"
log_message "1. Test integration: php test_radius_integration.php"
log_message "2. Test authentication: docker exec -it $(docker ps -q --filter 'name=mysql') mysql -u root -pGlinta2025! radius -e 'SELECT * FROM radcheck;'"
log_message "3. Monitor RADIUS logs for authentication attempts"

echo
echo "Script completed! 🎉"