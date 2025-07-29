<?php
/**
 * Debug script to test authentication flow
 */

require_once 'init.php';
require_once 'enhanced_authentication_blocker.php';

echo "=== DEBUGGING AUTHENTICATION FLOW ===\n";
echo "Testing MAC: 32:e4:ef:86:8f:43\n\n";

// First, verify hasActiveSession works
echo "1. Testing hasActiveSession method directly...\n";
$reflection = new ReflectionClass('EnhancedAuthenticationBlocker');
$method = $reflection->getMethod('hasActiveSession');
$method->setAccessible(true);
$activeResult = $method->invoke(null, '32:e4:ef:86:8f:43');
echo "hasActiveSession result: " . json_encode($activeResult, JSON_PRETTY_PRINT) . "\n\n";

// Now test the full flow
echo "2. Testing full isAuthenticationBlocked method...\n";
$result = EnhancedAuthenticationBlocker::isAuthenticationBlocked('32:e4:ef:86:8f:43', 'captive_portal');
echo "isAuthenticationBlocked result: " . json_encode($result, JSON_PRETTY_PRINT) . "\n\n";

// Test if the issue is with the return structure
if ($result && !$result['blocked']) {
    echo "3. Authentication is not blocked, but does it have active session info?\n";
    if (isset($result['has_active_session'])) {
        echo "✅ Method correctly detected active session\n";
    } else {
        echo "❌ Method did NOT detect active session (this is the bug)\n";
    }
}
?>