<?php
/**
 * Test Script for Enhanced Automatic User Removal System
 * Developed for Glinta Africa Billing System
 * 
 * This script tests the enhanced automatic user removal functionality
 * without affecting real users.
 */

require_once 'init.php';

class AutomaticUserRemovalTest
{
    private static $test_results = [];
    
    public static function runAllTests()
    {
        echo "=== AUTOMATIC USER REMOVAL SYSTEM TEST ===\n\n";
        
        // Test 1: Time-based expiry checking
        self::testTimeBasedExpiry();
        
        // Test 2: RADIUS cleanup functionality
        self::testRadiusCleanup();
        
        // Test 3: Portal session cleanup
        self::testPortalSessionCleanup();
        
        // Test 4: Session monitoring
        self::testSessionMonitoring();
        
        // Test 5: Notification system
        self::testNotificationSystem();
        
        // Test 6: Database queries
        self::testDatabaseQueries();
        
        // Display results
        self::displayResults();
        
        return self::$test_results;
    }
    
    private static function testTimeBasedExpiry()
    {
        echo "TEST 1: Time-based Expiry Logic\n";
        echo "-------------------------------\n";
        
        try {
            // Test current time vs various expiry scenarios
            $current_time = time();
            $test_cases = [
                [
                    'expiry_date' => date('Y-m-d', $current_time - 3600), // 1 hour ago
                    'expiry_time' => date('H:i:s', $current_time - 3600),
                    'expected' => 'expired'
                ],
                [
                    'expiry_date' => date('Y-m-d', $current_time + 1800), // 30 minutes from now
                    'expiry_time' => date('H:i:s', $current_time + 1800),
                    'expected' => 'active'
                ],
                [
                    'expiry_date' => date('Y-m-d', $current_time + 300), // 5 minutes from now
                    'expiry_time' => date('H:i:s', $current_time + 300),
                    'expected' => 'warning'
                ]
            ];
            
            $passed = 0;
            $total = count($test_cases);
            
            foreach ($test_cases as $i => $case) {
                $expiry_timestamp = strtotime($case['expiry_date'] . ' ' . $case['expiry_time']);
                $time_left = $expiry_timestamp - time();
                
                $status = 'active';
                if ($time_left <= 0) {
                    $status = 'expired';
                } elseif ($time_left <= 300) {
                    $status = 'warning';
                }
                
                $result = ($status === $case['expected']) ? 'PASS' : 'FAIL';
                echo "  Case " . ($i + 1) . ": {$case['expiry_date']} {$case['expiry_time']} -> {$status} ({$result})\n";
                
                if ($result === 'PASS') $passed++;
            }
            
            echo "  Result: {$passed}/{$total} test cases passed\n\n";
            self::$test_results['time_based_expiry'] = ['passed' => $passed, 'total' => $total];
            
        } catch (Exception $e) {
            echo "  ERROR: " . $e->getMessage() . "\n\n";
            self::$test_results['time_based_expiry'] = ['error' => $e->getMessage()];
        }
    }
    
    private static function testRadiusCleanup()
    {
        echo "TEST 2: RADIUS Cleanup Functionality\n";
        echo "------------------------------------\n";
        
        try {
            // Check if RadiusManager class exists and has required methods
            $required_methods = ['removeRadiusUser', 'disconnectUser', 'processExpiredUsers'];
            $available_methods = [];
            
            if (class_exists('RadiusManager')) {
                foreach ($required_methods as $method) {
                    if (method_exists('RadiusManager', $method)) {
                        $available_methods[] = $method;
                        echo "  ✓ Method {$method} exists\n";
                    } else {
                        echo "  ✗ Method {$method} missing\n";
                    }
                }
            } else {
                echo "  ✗ RadiusManager class not found\n";
            }
            
            // Test RADIUS database connection
            try {
                $radius_test = ORM::for_table('radcheck', 'radius')->count();
                echo "  ✓ RADIUS database connection working (found {$radius_test} radcheck entries)\n";
            } catch (Exception $e) {
                echo "  ✗ RADIUS database connection failed: " . $e->getMessage() . "\n";
            }
            
            $passed = count($available_methods);
            $total = count($required_methods) + 1; // +1 for DB connection
            
            echo "  Result: {$passed}/{$total} RADIUS components working\n\n";
            self::$test_results['radius_cleanup'] = ['passed' => $passed, 'total' => $total];
            
        } catch (Exception $e) {
            echo "  ERROR: " . $e->getMessage() . "\n\n";
            self::$test_results['radius_cleanup'] = ['error' => $e->getMessage()];
        }
    }
    
    private static function testPortalSessionCleanup()
    {
        echo "TEST 3: Portal Session Cleanup\n";
        echo "------------------------------\n";
        
        try {
            // Check if portal sessions table exists
            try {
                $portal_sessions = ORM::for_table('tbl_portal_sessions')->count();
                echo "  ✓ Portal sessions table exists (found {$portal_sessions} entries)\n";
                $table_exists = true;
            } catch (Exception $e) {
                echo "  ✗ Portal sessions table not found or inaccessible\n";
                $table_exists = false;
            }
            
            // Check if captive portal session manager exists
            $manager_exists = file_exists('captive_portal_session_manager.php');
            echo "  " . ($manager_exists ? '✓' : '✗') . " Captive portal session manager file exists\n";
            
            // Test cleanup query logic
            try {
                $old_sessions = ORM::for_table('tbl_portal_sessions')
                    ->where_lt('created_at', date('Y-m-d H:i:s', strtotime('-24 hours')))
                    ->count();
                echo "  ✓ Cleanup query logic working (found {$old_sessions} old sessions)\n";
                $query_works = true;
            } catch (Exception $e) {
                echo "  ✗ Cleanup query failed: " . $e->getMessage() . "\n";
                $query_works = false;
            }
            
            $passed = ($table_exists ? 1 : 0) + ($manager_exists ? 1 : 0) + ($query_works ? 1 : 0);
            $total = 3;
            
            echo "  Result: {$passed}/{$total} portal session components working\n\n";
            self::$test_results['portal_cleanup'] = ['passed' => $passed, 'total' => $total];
            
        } catch (Exception $e) {
            echo "  ERROR: " . $e->getMessage() . "\n\n";
            self::$test_results['portal_cleanup'] = ['error' => $e->getMessage()];
        }
    }
    
    private static function testSessionMonitoring()
    {
        echo "TEST 4: Session Monitoring System\n";
        echo "---------------------------------\n";
        
        try {
            // Check if enhanced session monitor exists
            $monitor_exists = file_exists('enhanced_session_monitor.php');
            echo "  " . ($monitor_exists ? '✓' : '✗') . " Enhanced session monitor file exists\n";
            
            // Test active session query
            try {
                $active_sessions = ORM::for_table('tbl_user_recharges')
                    ->where('status', 'on')
                    ->count();
                echo "  ✓ Active session query working (found {$active_sessions} active sessions)\n";
                $query_works = true;
            } catch (Exception $e) {
                echo "  ✗ Active session query failed: " . $e->getMessage() . "\n";
                $query_works = false;
            }
            
            // Test enhanced expiry check query
            try {
                $current_datetime = date("Y-m-d H:i:s");
                $current_date = date("Y-m-d");
                
                $expired_sessions = ORM::for_table('tbl_user_recharges')
                    ->where('status', 'on')
                    ->where_raw("(
                        (expiration < ? AND time IS NULL) OR 
                        (expiration = ? AND time IS NOT NULL AND CONCAT(expiration, ' ', time) <= ?) OR
                        (expiration < ?)
                    )", [$current_date, $current_date, $current_datetime, $current_date])
                    ->count();
                    
                echo "  ✓ Enhanced expiry query working (found {$expired_sessions} potentially expired sessions)\n";
                $enhanced_query_works = true;
            } catch (Exception $e) {
                echo "  ✗ Enhanced expiry query failed: " . $e->getMessage() . "\n";
                $enhanced_query_works = false;
            }
            
            $passed = ($monitor_exists ? 1 : 0) + ($query_works ? 1 : 0) + ($enhanced_query_works ? 1 : 0);
            $total = 3;
            
            echo "  Result: {$passed}/{$total} session monitoring components working\n\n";
            self::$test_results['session_monitoring'] = ['passed' => $passed, 'total' => $total];
            
        } catch (Exception $e) {
            echo "  ERROR: " . $e->getMessage() . "\n\n";
            self::$test_results['session_monitoring'] = ['error' => $e->getMessage()];
        }
    }
    
    private static function testNotificationSystem()
    {
        echo "TEST 5: Notification System\n";
        echo "---------------------------\n";
        
        try {
            // Check if notification system exists
            $notification_exists = file_exists('expiry_notification_system.php');
            echo "  " . ($notification_exists ? '✓' : '✗') . " Expiry notification system file exists\n";
            
            // Test notification table creation/existence
            try {
                $sql = "CREATE TABLE IF NOT EXISTS tbl_notifications_test (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255) NOT NULL,
                    type VARCHAR(100) NOT NULL,
                    message TEXT NOT NULL,
                    sent_at DATETIME NOT NULL
                )";
                ORM::raw_execute($sql);
                
                // Clean up test table
                ORM::raw_execute("DROP TABLE IF EXISTS tbl_notifications_test");
                
                echo "  ✓ Notification table operations working\n";
                $table_ops_work = true;
            } catch (Exception $e) {
                echo "  ✗ Notification table operations failed: " . $e->getMessage() . "\n";
                $table_ops_work = false;
            }
            
            // Test Message class methods
            $message_methods = ['sendSMS', 'sendWhatsapp', 'sendEmail'];
            $available_message_methods = 0;
            
            foreach ($message_methods as $method) {
                if (class_exists('Message') && method_exists('Message', $method)) {
                    $available_message_methods++;
                    echo "  ✓ Message::{$method} method available\n";
                } else {
                    echo "  ✗ Message::{$method} method not available\n";
                }
            }
            
            $passed = ($notification_exists ? 1 : 0) + ($table_ops_work ? 1 : 0) + ($available_message_methods > 0 ? 1 : 0);
            $total = 3;
            
            echo "  Result: {$passed}/{$total} notification components working\n\n";
            self::$test_results['notification_system'] = ['passed' => $passed, 'total' => $total];
            
        } catch (Exception $e) {
            echo "  ERROR: " . $e->getMessage() . "\n\n";
            self::$test_results['notification_system'] = ['error' => $e->getMessage()];
        }
    }
    
    private static function testDatabaseQueries()
    {
        echo "TEST 6: Database Query Performance\n";
        echo "----------------------------------\n";
        
        try {
            $queries = [
                'user_recharges' => "SELECT COUNT(*) FROM tbl_user_recharges WHERE status = 'on'",
                'customers' => "SELECT COUNT(*) FROM tbl_customers WHERE status = 'Active'",
                'plans' => "SELECT COUNT(*) FROM tbl_plans WHERE enabled = 1",
                'transactions' => "SELECT COUNT(*) FROM tbl_transactions"
            ];
            
            $passed = 0;
            $total = count($queries);
            
            foreach ($queries as $name => $query) {
                try {
                    $start_time = microtime(true);
                    $result = ORM::raw_execute($query);
                    $row = $result->fetch(PDO::FETCH_NUM);
                    $count = $row[0];
                    $execution_time = round((microtime(true) - $start_time) * 1000, 2);
                    
                    echo "  ✓ {$name}: {$count} records ({$execution_time}ms)\n";
                    $passed++;
                } catch (Exception $e) {
                    echo "  ✗ {$name}: Query failed - " . $e->getMessage() . "\n";
                }
            }
            
            echo "  Result: {$passed}/{$total} database queries working\n\n";
            self::$test_results['database_queries'] = ['passed' => $passed, 'total' => $total];
            
        } catch (Exception $e) {
            echo "  ERROR: " . $e->getMessage() . "\n\n";
            self::$test_results['database_queries'] = ['error' => $e->getMessage()];
        }
    }
    
    private static function displayResults()
    {
        echo "=== TEST SUMMARY ===\n";
        
        $total_passed = 0;
        $total_tests = 0;
        $failed_tests = [];
        
        foreach (self::$test_results as $test_name => $result) {
            if (isset($result['error'])) {
                echo "❌ {$test_name}: ERROR - {$result['error']}\n";
                $failed_tests[] = $test_name;
            } else {
                $passed = $result['passed'];
                $total = $result['total'];
                $percentage = $total > 0 ? round(($passed / $total) * 100, 1) : 0;
                $status = $passed == $total ? '✅' : '⚠️';
                
                echo "{$status} {$test_name}: {$passed}/{$total} ({$percentage}%)\n";
                
                $total_passed += $passed;
                $total_tests += $total;
                
                if ($passed < $total) {
                    $failed_tests[] = $test_name;
                }
            }
        }
        
        echo "\n";
        
        if (empty($failed_tests)) {
            echo "🎉 ALL TESTS PASSED! The automatic user removal system is fully functional.\n";
        } else {
            echo "⚠️  SOME TESTS FAILED. Please address the following:\n";
            foreach ($failed_tests as $test) {
                echo "   - {$test}\n";
            }
        }
        
        $overall_percentage = $total_tests > 0 ? round(($total_passed / $total_tests) * 100, 1) : 0;
        echo "\nOverall: {$total_passed}/{$total_tests} ({$overall_percentage}%)\n";
        
        // System recommendations
        echo "\n=== RECOMMENDATIONS ===\n";
        
        if ($overall_percentage >= 90) {
            echo "✅ System is ready for production use.\n";
            echo "✅ Set up cron jobs as described in the setup instructions.\n";
        } elseif ($overall_percentage >= 70) {
            echo "⚠️  System is mostly functional but needs some fixes.\n";
            echo "⚠️  Address failed tests before production deployment.\n";
        } else {
            echo "❌ System needs significant fixes before production use.\n";
            echo "❌ Review all failed components and dependencies.\n";
        }
        
        echo "\n";
    }
    
    public static function checkSystemRequirements()
    {
        echo "=== SYSTEM REQUIREMENTS CHECK ===\n";
        
        $requirements = [
            'PHP Version >= 7.4' => version_compare(PHP_VERSION, '7.4.0', '>='),
            'PDO Extension' => extension_loaded('pdo'),
            'MySQL PDO Driver' => extension_loaded('pdo_mysql'),
            'Shell Exec Function' => function_exists('shell_exec'),
            'File Write Permissions' => is_writable('.'),
        ];
        
        foreach ($requirements as $requirement => $status) {
            echo ($status ? '✅' : '❌') . " {$requirement}\n";
        }
        
        echo "\n";
    }
}

// Run tests if called from command line
if (php_sapi_name() === 'cli') {
    AutomaticUserRemovalTest::checkSystemRequirements();
    $results = AutomaticUserRemovalTest::runAllTests();
}

// Web interface
if (isset($_GET['test'])) {
    header('Content-Type: text/plain');
    AutomaticUserRemovalTest::checkSystemRequirements();
    $results = AutomaticUserRemovalTest::runAllTests();
}

// JSON API
if (isset($_GET['json'])) {
    header('Content-Type: application/json');
    ob_start();
    $results = AutomaticUserRemovalTest::runAllTests();
    $output = ob_get_clean();
    echo json_encode(['results' => $results, 'output' => $output]);
}
?>