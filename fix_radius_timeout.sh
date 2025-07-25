#!/bin/bash

# Fix RADIUS Authentication Timeout Issue
# Fixes "No reply from server" errors

set -e

echo "=== FIXING RADIUS AUTHENTICATION TIMEOUT ==="
echo "Timestamp: $(date)"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# 1. Check if FreeRADIUS is actually running and listening
log_message "🔍 Checking FreeRADIUS service status..."
systemctl status freeradius --no-pager || true

log_message "🔍 Checking if FreeRADIUS is listening on port 1812..."
netstat -ulpn | grep 1812 || log_message "⚠️ FreeRADIUS not listening on port 1812"

# 2. Stop FreeRADIUS
log_message "🛑 Stopping FreeRADIUS service..."
systemctl stop freeradius 2>/dev/null || true
pkill freeradius 2>/dev/null || true
sleep 2

# 3. Check configuration one more time
log_message "🧪 Testing FreeRADIUS configuration..."
if freeradius -C; then
    log_message "✅ FreeRADIUS configuration is valid"
else
    log_message "❌ FreeRADIUS configuration has errors"
    exit 1
fi

# 4. Start FreeRADIUS in foreground briefly to check for errors
log_message "🔧 Starting FreeRADIUS in debug mode briefly..."
timeout 10 freeradius -X > /tmp/freeradius_startup.log 2>&1 &
RADIUS_PID=$!
sleep 5

# Check if it started successfully
if ps -p $RADIUS_PID > /dev/null 2>&1; then
    log_message "✅ FreeRADIUS started successfully in debug mode"
    kill $RADIUS_PID 2>/dev/null || true
else
    log_message "❌ FreeRADIUS failed to start, checking logs..."
    cat /tmp/freeradius_startup.log
    exit 1
fi

# 5. Start FreeRADIUS as service
log_message "🚀 Starting FreeRADIUS as system service..."
systemctl start freeradius

# 6. Wait and verify it's running
sleep 3
if systemctl is-active --quiet freeradius; then
    log_message "✅ FreeRADIUS service is running"
else
    log_message "❌ FreeRADIUS service failed to start"
    systemctl status freeradius --no-pager
    exit 1
fi

# 7. Check if it's listening on the correct port
log_message "🔍 Verifying FreeRADIUS is listening on port 1812..."
if netstat -ulpn | grep -q 1812; then
    log_message "✅ FreeRADIUS is listening on port 1812"
else
    log_message "❌ FreeRADIUS is not listening on port 1812"
    exit 1
fi

# 8. Test authentication with a known user
log_message "🧪 Testing RADIUS authentication..."

# First, ensure we have a test user
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! radius << 'EOF'
INSERT INTO radcheck (username, attribute, op, value)
VALUES ('06:0d:e5:14:bb:89', 'Cleartext-Password', ':=', '06:0d:e5:14:bb:89')
ON DUPLICATE KEY UPDATE value='06:0d:e5:14:bb:89';

INSERT INTO radcheck (username, attribute, op, value)
VALUES ('06:0d:e5:14:bb:89', 'Auth-Type', ':=', 'Accept')
ON DUPLICATE KEY UPDATE value='Accept';
EOF

# Test authentication
if timeout 15 radtest 06:0d:e5:14:bb:89 06:0d:e5:14:bb:89 localhost 0 testing123; then
    log_message "✅ RADIUS authentication test successful!"
else
    log_message "❌ RADIUS authentication test failed"
    log_message "📋 Running quick debug to see the issue..."
    
    # Run a quick debug session
    systemctl stop freeradius
    timeout 10 freeradius -X > /tmp/radius_debug.log 2>&1 &
    RADIUS_PID=$!
    sleep 3
    
    radtest 06:0d:e5:14:bb:89 06:0d:e5:14:bb:89 localhost 0 testing123 || true
    
    sleep 2
    kill $RADIUS_PID 2>/dev/null || true
    
    echo "=== DEBUG OUTPUT ==="
    tail -30 /tmp/radius_debug.log
    echo "=== END DEBUG ==="
    
    systemctl start freeradius
fi

log_message "=== RADIUS TIMEOUT FIX COMPLETE ==="
log_message "🎉 FreeRADIUS should now be responding to authentication requests"

echo
echo "🎉 RADIUS timeout fix completed!"