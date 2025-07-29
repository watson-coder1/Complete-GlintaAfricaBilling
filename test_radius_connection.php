<?php
/**
 * Test RADIUS database connection and activation
 */

require_once 'config.php';

echo "=== Testing RADIUS Database Connection ===\n\n";

// Test main database connection
echo "1. Testing main database connection:\n";
try {
    $pdo_main = new PDO(
        "mysql:host={$db_host};dbname={$db_name};charset=utf8mb4",
        $db_user,
        $db_pass,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    echo "✅ Main database connection successful\n";
} catch (Exception $e) {
    echo "❌ Main database connection failed: " . $e->getMessage() . "\n";
    exit(1);
}

// Test RADIUS database connection
echo "\n2. Testing RADIUS database connection:\n";
try {
    $pdo_radius = new PDO(
        "mysql:host={$radius_host};dbname={$radius_name};charset=utf8mb4",
        $radius_user,
        $radius_pass,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    echo "✅ RADIUS database connection successful\n";
} catch (Exception $e) {
    echo "❌ RADIUS database connection failed: " . $e->getMessage() . "\n";
    echo "Trying alternate connection...\n";
    
    // Try with different credentials
    try {
        $pdo_radius = new PDO(
            "mysql:host={$radius_host};dbname={$radius_name};charset=utf8mb4",
            'root',
            'GlintaRoot2025!',
            [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
        );
        echo "✅ RADIUS database connection successful with root\n";
    } catch (Exception $e2) {
        echo "❌ RADIUS database connection failed with root: " . $e2->getMessage() . "\n";
        exit(1);
    }
}

// Check if RADIUS tables exist
echo "\n3. Checking RADIUS tables:\n";
$tables = ['radcheck', 'radreply', 'radacct'];
foreach ($tables as $table) {
    try {
        $stmt = $pdo_radius->query("SELECT COUNT(*) FROM {$table}");
        $count = $stmt->fetchColumn();
        echo "✅ Table '{$table}' exists with {$count} records\n";
    } catch (Exception $e) {
        echo "❌ Table '{$table}' not found or error: " . $e->getMessage() . "\n";
    }
}

// Test creating a sample RADIUS user
echo "\n4. Testing RADIUS user creation:\n";
$test_mac = '00:11:22:33:44:55';
$test_username = str_replace(':', '', strtolower($test_mac));

try {
    // Clean up any existing test user
    $stmt = $pdo_radius->prepare("DELETE FROM radcheck WHERE username = ?");
    $stmt->execute([$test_username]);
    
    // Create test user
    $stmt = $pdo_radius->prepare("INSERT INTO radcheck (username, attribute, op, value) VALUES (?, ?, ?, ?)");
    $stmt->execute([$test_username, 'Cleartext-Password', ':=', $test_mac]);
    
    echo "✅ Test RADIUS user created successfully\n";
    
    // Verify user exists
    $stmt = $pdo_radius->prepare("SELECT * FROM radcheck WHERE username = ?");
    $stmt->execute([$test_username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($user) {
        echo "✅ Test user verified in database\n";
        echo "   Username: {$user['username']}\n";
        echo "   Attribute: {$user['attribute']}\n";
        echo "   Value: {$user['value']}\n";
    } else {
        echo "❌ Test user not found after creation\n";
    }
    
    // Clean up
    $stmt = $pdo_radius->prepare("DELETE FROM radcheck WHERE username = ?");
    $stmt->execute([$test_username]);
    echo "✅ Test user cleaned up\n";
    
} catch (Exception $e) {
    echo "❌ RADIUS user creation failed: " . $e->getMessage() . "\n";
}

echo "\n=== Test Complete ===\n";
?>