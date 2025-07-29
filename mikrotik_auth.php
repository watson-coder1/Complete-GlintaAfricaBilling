<?php
/**
 * MikroTik Hotspot Authentication Endpoint
 * Handles authentication for users after successful payment
 */

// Include system initialization
require_once 'init.php';

// Set JSON response header
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    // Get authentication parameters
    $username = $_POST['username'] ?? $_GET['username'] ?? '';
    $password = $_POST['password'] ?? $_GET['password'] ?? '';
    $mac = $_POST['mac'] ?? $_GET['mac'] ?? '';
    $ip = $_POST['ip'] ?? $_GET['ip'] ?? '';
    $dst = $_POST['dst'] ?? $_GET['dst'] ?? 'https://www.google.com';
    
    _log("MikroTik Auth Request - Username: {$username}, MAC: {$mac}, IP: {$ip}, Destination: {$dst}", 'MikroTik-Auth', 0);
    
    if (empty($username) || empty($password)) {
        _log("MikroTik Auth Error: Missing username or password", 'MikroTik-Auth', 0);
        echo json_encode([
            'success' => false,
            'message' => 'Username and password required'
        ]);
        exit();
    }
    
    // Verify RADIUS credentials
    $radiusUser = ORM::for_table('radcheck', 'radius')
        ->where('username', $username)
        ->where('attribute', 'Cleartext-Password')
        ->where('value', $password)
        ->find_one();
    
    if (!$radiusUser) {
        _log("MikroTik Auth Error: Invalid credentials for {$username}", 'MikroTik-Auth', 0);
        echo json_encode([
            'success' => false,
            'message' => 'Invalid credentials'
        ]);
        exit();
    }
    
    // Check if user has active session
    $activeSession = ORM::for_table('tbl_user_recharges')
        ->where('username', $mac ?: $username)
        ->where('status', 'on')
        ->find_one();
    
    if (!$activeSession) {
        _log("MikroTik Auth Error: No active session for {$username}", 'MikroTik-Auth', 0);
        echo json_encode([
            'success' => false,
            'message' => 'No active session found'
        ]);
        exit();
    }
    
    // Build expiration datetime and check if not expired
    $expirationDateTime = $activeSession->expiration . ' ' . ($activeSession->time ?: '23:59:59');
    if (strtotime($expirationDateTime) <= time()) {
        _log("MikroTik Auth Error: Session expired for {$username} - Expired: {$expirationDateTime}", 'MikroTik-Auth', 0);
        echo json_encode([
            'success' => false,
            'message' => 'Session has expired'
        ]);
        exit();
    }
    
    // Authentication successful
    _log("MikroTik Auth Success: {$username} authenticated successfully - Session expires: {$expirationDateTime}", 'MikroTik-Auth', 0);
    
    // For web-based authentication, redirect to destination
    if (isset($_GET['web']) || $_SERVER['REQUEST_METHOD'] === 'GET') {
        // Store successful authentication in session/cookie for tracking
        setcookie('glinta_auth_success', $username, time() + 3600, '/');
        
        // Redirect to destination URL
        header('Location: ' . $dst);
        exit();
    }
    
    // For AJAX requests, return success
    echo json_encode([
        'success' => true,
        'message' => 'Authentication successful',
        'redirect_url' => $dst,
        'expires' => $expirationDateTime,
        'plan' => $activeSession->namebp
    ]);
    
} catch (Exception $e) {
    _log('MikroTik Auth Exception: ' . $e->getMessage(), 'MikroTik-Auth', 0);
    
    echo json_encode([
        'success' => false,
        'message' => 'Authentication error occurred'
    ]);
}
?>