<?php
/**
 * Enhanced Authentication Blocker Setup & Testing Script
 * Complete setup and verification of the authentication blocking system
 * 
 * @author Glinta Africa Development Team
 * @version 1.0
 */

require_once 'init.php';
require_once 'enhanced_authentication_blocker.php';

echo "=== Enhanced Authentication Blocker Setup & Test ===\n\n";

class AuthenticationBlockerSetup
{
    public static function runSetup()
    {
        echo "1. Creating database tables...\n";
        self::createTables();
        
        echo "\n2. Verifying system components...\n";
        self::verifyComponents();
        
        echo "\n3. Running basic functionality tests...\n";
        self::runBasicTests();
        
        echo "\n4. Testing authentication blocking scenarios...\n";
        self::testBlockingScenarios();
        
        echo "\n5. Setting up cron jobs...\n";
        self::setupCronJobs();
        
        echo "\n6. Final verification...\n";
        self::finalVerification();
        
        echo "\n=== Setup Complete ===\n";
        echo "The Enhanced Authentication Blocker system is now ready!\n\n";
        
        self::displayUsageInstructions();
    }
    
    private static function createTables()
    {
        try {
            // Initialize the blocker to create tables
            EnhancedAuthenticationBlocker::init();
            echo "  ✓ Database tables created successfully\n";
            
            // Verify tables exist
            $tables = ['tbl_blocked_mac_addresses', 'tbl_auth_attempts'];
            foreach ($tables as $table) {
                $exists = ORM::for_table($table)->find_one();
                echo "  ✓ Table {$table} verified\n";
            }
            
        } catch (Exception $e) {
            echo "  ✗ Error creating tables: " . $e->getMessage() . "\n";
            throw $e;
        }
    }
    
    private static function verifyComponents()
    {
        // Check if captive portal controller is enhanced
        $captivePortalPath = 'system/controllers/captive_portal.php';
        $content = file_get_contents($captivePortalPath);
        
        if (strpos($content, 'EnhancedAuthenticationBlocker') !== false) {
            echo "  ✓ Captive portal controller enhanced\n";
        } else {
            echo "  ✗ Captive portal controller not enhanced\n";
        }
        
        // Check if RADIUS manager is enhanced
        $radiusManagerPath = 'system/autoload/RadiusManager.php';
        $content = file_get_contents($radiusManagerPath);
        
        if (strpos($content, 'EnhancedAuthenticationBlocker') !== false) {
            echo "  ✓ RADIUS manager enhanced\n";
        } else {
            echo "  ✗ RADIUS manager not enhanced\n";
        }
        
        // Check if session manager is enhanced
        $sessionManagerPath = 'captive_portal_session_manager.php';
        if (file_exists($sessionManagerPath)) {
            $content = file_get_contents($sessionManagerPath);
            if (strpos($content, 'EnhancedAuthenticationBlocker') !== false) {
                echo "  ✓ Session manager enhanced\n";
            } else {
                echo "  ✗ Session manager not enhanced\n";
            }
        }
        
        // Check if templates exist
        $templates = [
            'ui/theme/default/captive_portal_blocked.tpl',
            'ui/theme/default/auth_blocker_admin.tpl',
            'ui/theme/default/auth_blocker_block.tpl'
        ];
        
        foreach ($templates as $template) {
            if (file_exists($template)) {
                echo "  ✓ Template {$template} exists\n";
            } else {
                echo "  ✗ Template {$template} missing\n";
            }
        }
    }
    
    private static function runBasicTests()
    {
        echo "  Testing basic functionality...\n";
        
        // Test 1: Check non-blocked MAC
        $testMac = 'test-' . substr(md5(time()), 0, 12);
        $result = EnhancedAuthenticationBlocker::isAuthenticationBlocked($testMac);
        
        if (!$result['blocked']) {
            echo "  ✓ Non-blocked MAC check works\n";
        } else {
            echo "  ✗ Non-blocked MAC check failed\n";
        }
        
        // Test 2: Block a MAC
        $blockResult = EnhancedAuthenticationBlocker::blockMacAddress($testMac, $testMac, 'test_block', 'Setup test');
        
        if ($blockResult['success']) {
            echo "  ✓ MAC blocking works\n";
        } else {
            echo "  ✗ MAC blocking failed: " . ($blockResult['error'] ?? 'Unknown error') . "\n";
        }
        
        // Test 3: Check blocked MAC
        $result = EnhancedAuthenticationBlocker::isAuthenticationBlocked($testMac);
        
        if ($result['blocked']) {
            echo "  ✓ Blocked MAC detection works\n";
        } else {
            echo "  ✗ Blocked MAC detection failed\n";
        }
        
        // Test 4: Unblock MAC
        $unblockResult = EnhancedAuthenticationBlocker::unblockMacAddress($testMac, 'setup_test_cleanup');
        
        if ($unblockResult['success']) {
            echo "  ✓ MAC unblocking works\n";
        } else {
            echo "  ✗ MAC unblocking failed: " . ($unblockResult['error'] ?? 'Unknown error') . "\n";
        }
        
        // Test 5: Verify unblocked
        $result = EnhancedAuthenticationBlocker::isAuthenticationBlocked($testMac);
        
        if (!$result['blocked']) {
            echo "  ✓ MAC unblocking verification works\n";
        } else {
            echo "  ✗ MAC still blocked after unblock\n";
        }
    }
    
    private static function testBlockingScenarios()
    {
        echo "  Creating test scenarios...\n";
        
        // Scenario 1: Expired session retry
        $expiredMac = 'expired-' . substr(md5(time()), 0, 8);
        
        // Create an expired recharge
        $expiredRecharge = ORM::for_table('tbl_user_recharges')->create();
        $expiredRecharge->username = $expiredMac;
        $expiredRecharge->plan_id = 1;
        $expiredRecharge->namebp = 'Test Plan';
        $expiredRecharge->recharged_on = date('Y-m-d', strtotime('-2 days'));
        $expiredRecharge->recharged_time = '10:00:00';
        $expiredRecharge->expiration = date('Y-m-d', strtotime('-1 day'));
        $expiredRecharge->time = '10:00:00';
        $expiredRecharge->status = 'off';
        $expiredRecharge->type = 'Hotspot';
        $expiredRecharge->save();
        
        // Test expired session blocking
        $result = EnhancedAuthenticationBlocker::isAuthenticationBlocked($expiredMac);
        
        if ($result['blocked'] && $result['reason'] === 'expired_session_retry') {
            echo "  ✓ Expired session retry blocking works\n";
        } else {
            echo "  ✗ Expired session retry blocking failed\n";
        }
        
        // Cleanup
        $expiredRecharge->delete();
        EnhancedAuthenticationBlocker::unblockMacAddress($expiredMac, 'test_cleanup');
        
        // Scenario 2: Suspicious activity
        $suspiciousMac = 'suspicious-' . substr(md5(time()), 0, 8);
        
        // Create multiple auth attempts
        for ($i = 0; $i < 12; $i++) {
            $attempt = ORM::for_table('tbl_auth_attempts')->create();
            $attempt->mac_address = $suspiciousMac;
            $attempt->ip_address = '192.168.1.100';
            $attempt->attempt_type = 'captive_portal';
            $attempt->attempt_time = date('Y-m-d H:i:s', strtotime('-' . (5 - $i) . ' minutes'));
            $attempt->save();
        }
        
        // Test suspicious activity blocking
        $result = EnhancedAuthenticationBlocker::isAuthenticationBlocked($suspiciousMac);
        
        if ($result['blocked'] && $result['reason'] === 'suspicious_activity') {
            echo "  ✓ Suspicious activity blocking works\n";
        } else {
            echo "  ✗ Suspicious activity blocking failed\n";
        }
        
        // Cleanup
        ORM::for_table('tbl_auth_attempts')->where('mac_address', $suspiciousMac)->delete_many();
        EnhancedAuthenticationBlocker::unblockMacAddress($suspiciousMac, 'test_cleanup');
        
        echo "  ✓ All blocking scenarios tested\n";
    }
    
    private static function setupCronJobs()
    {
        $cronJobs = [
            "# Enhanced Authentication Blocker - Process expired users every 5 minutes",
            "*/5 * * * * php " . __DIR__ . "/enhanced_authentication_blocker.php process-expired >> /var/log/auth_blocker.log 2>&1",
            "",
            "# Enhanced Authentication Blocker - Cleanup old records daily", 
            "0 2 * * * php " . __DIR__ . "/enhanced_authentication_blocker.php cleanup >> /var/log/auth_blocker.log 2>&1",
            "",
            "# Enhanced Session Monitor - Check expired sessions every minute",
            "* * * * * php " . __DIR__ . "/captive_portal_session_manager.php >> /var/log/session_manager.log 2>&1"
        ];
        
        echo "  Recommended cron jobs:\n";
        foreach ($cronJobs as $job) {
            if (!empty(trim($job)) && !str_starts_with($job, '#')) {
                echo "    {$job}\n";
            }
        }
        
        // Write to a cron file for easy installation
        file_put_contents('auth_blocker_cron.txt', implode("\n", $cronJobs));
        echo "  ✓ Cron job template saved to auth_blocker_cron.txt\n";
    }
    
    private static function finalVerification()
    {
        // Get statistics
        $stats = EnhancedAuthenticationBlocker::getBlockingStatistics();
        
        echo "  Current system statistics:\n";
        echo "    Active blocks: {$stats['active_blocks']}\n";
        echo "    Recent attempts (24h): {$stats['recent_attempts']}\n";
        echo "    Recent blocked attempts (24h): {$stats['recent_blocked_attempts']}\n";
        
        // Test admin interface accessibility
        if (file_exists('system/controllers/auth_blocker_admin.php')) {
            echo "  ✓ Admin interface available at: " . U . "auth_blocker_admin\n";
        } else {
            echo "  ✗ Admin interface not found\n";
        }
        
        echo "  ✓ System verification complete\n";
    }
    
    private static function displayUsageInstructions()
    {
        echo "USAGE INSTRUCTIONS:\n";
        echo "==================\n\n";
        
        echo "1. ADMIN INTERFACE:\n";
        echo "   Access: " . U . "auth_blocker_admin\n";
        echo "   Features: View blocked MACs, block/unblock addresses, view statistics\n\n";
        
        echo "2. COMMAND LINE TOOLS:\n";
        echo "   Block MAC:    php enhanced_authentication_blocker.php block <mac_address> [reason]\n";
        echo "   Unblock MAC:  php enhanced_authentication_blocker.php unblock <mac_address>\n";
        echo "   Statistics:   php enhanced_authentication_blocker.php stats\n";
        echo "   Process:      php enhanced_authentication_blocker.php process-expired\n";
        echo "   Cleanup:      php enhanced_authentication_blocker.php cleanup\n\n";
        
        echo "3. CRON JOBS:\n";
        echo "   Install the cron jobs from auth_blocker_cron.txt:\n";
        echo "   crontab -e  # Add the contents of auth_blocker_cron.txt\n\n";
        
        echo "4. HOW IT WORKS:\n";
        echo "   - Users who try to reconnect after session expiry are automatically blocked\n";
        echo "   - Blocks are removed when users make successful payments\n";
        echo "   - Suspicious activity (rapid attempts) triggers temporary blocks\n";
        echo "   - All authentication points (captive portal, RADIUS, vouchers) are protected\n\n";
        
        echo "5. MONITORING:\n";
        echo "   - Check logs in /logs/auth_blocker.log\n";
        echo "   - Monitor statistics via admin interface\n";
        echo "   - Set up alerts for high blocking rates\n\n";
        
        echo "6. TROUBLESHOOTING:\n";
        echo "   - If legitimate users are blocked, use admin interface to unblock\n";
        echo "   - Check auth_blocker.log for detailed blocking reasons\n";
        echo "   - Adjust suspicious activity thresholds in code if needed\n\n";
    }
}

// Run setup if called from command line
if (php_sapi_name() === 'cli') {
    try {
        AuthenticationBlockerSetup::runSetup();
    } catch (Exception $e) {
        echo "Setup failed: " . $e->getMessage() . "\n";
        exit(1);
    }
} else {
    // Web interface for setup
    if (isset($_GET['run_setup'])) {
        header('Content-Type: text/plain');
        try {
            AuthenticationBlockerSetup::runSetup();
        } catch (Exception $e) {
            echo "Setup failed: " . $e->getMessage() . "\n";
        }
    } else {
        echo "<h1>Enhanced Authentication Blocker Setup</h1>";
        echo "<p>This will set up and test the enhanced authentication blocking system.</p>";
        echo "<p><a href='?run_setup=1' class='btn btn-primary'>Run Setup</a></p>";
        echo "<p><strong>Note:</strong> This will create database tables and run tests.</p>";
    }
}
?>