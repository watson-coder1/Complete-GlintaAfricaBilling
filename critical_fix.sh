#!/bin/bash

echo "=== CRITICAL FIX: Stop duplicate session creation ==="

# Create the critical fix PHP file
cat > /tmp/critical_session_fix.php << 'EOF'
<?php
// CRITICAL FIX: Prevent duplicate session creation for authenticated users

// Add this to the beginning of captive_portal.php to prevent new sessions
// when user already has completed session or active RADIUS user

function hasActiveSession($mac_address) {
    // Check for completed session within last 24 hours
    $existingSession = ORM::for_table('tbl_portal_sessions')
        ->where('mac_address', $mac_address)
        ->where('status', 'completed')
        ->where_gt('created_at', date('Y-m-d H:i:s', strtotime('-24 hours')))
        ->find_one();
    
    if ($existingSession) {
        return $existingSession;
    }
    
    // Check for active RADIUS user
    $radiusUser = ORM::for_table('radcheck', 'radius')
        ->where('username', $mac_address)
        ->where('attribute', 'Auth-Type')
        ->where('value', 'Accept')
        ->find_one();
    
    if ($radiusUser) {
        // Check if not expired
        $expiration = ORM::for_table('radcheck', 'radius')
            ->where('username', $mac_address)
            ->where('attribute', 'Expiration')
            ->find_one();
        
        if ($expiration && strtotime($expiration->value) > time()) {
            return true;
        }
    }
    
    return false;
}

// Add this check at the beginning of the default case in captive_portal.php
if ($routes['1'] == '' || $routes['1'] == 'index') {
    $mac = $_GET['mac'] ?? $_SERVER['HTTP_CLIENT_IP'] ?? '';
    if ($mac && hasActiveSession($mac)) {
        // User already authenticated, redirect to success
        header('Location: ' . U . 'captive_portal/success/' . $mac);
        exit;
    }
}
EOF

echo ""
echo "CRITICAL STEPS TO FIX:"
echo ""
echo "1. Edit /var/www/glintaafrica/system/controllers/captive_portal.php"
echo "2. Add the hasActiveSession() function at the top after includes"
echo "3. Add the redirect check in the default case"
echo ""
echo "This prevents creating new pending sessions for already authenticated users!"