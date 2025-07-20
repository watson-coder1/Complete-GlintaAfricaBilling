<?php
/**
 * Test script to verify Daraja class is working
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h1>Daraja Class Test</h1>";

// Test basic PHP functionality
echo "<h2>1. Basic PHP Test</h2>";
try {
    require_once 'init.php';
    echo "✅ init.php loaded successfully<br>";
} catch (Exception $e) {
    echo "❌ Error loading init.php: " . $e->getMessage() . "<br>";
    exit;
}

// Test Daraja file inclusion
echo "<h2>2. Daraja File Test</h2>";
try {
    require_once 'system/paymentgateway/Daraja.php';
    echo "✅ Daraja.php included successfully<br>";
} catch (Exception $e) {
    echo "❌ Error including Daraja.php: " . $e->getMessage() . "<br>";
    exit;
}

// Test class instantiation
echo "<h2>3. Class Instantiation Test</h2>";
try {
    $daraja = new Daraja();
    echo "✅ Daraja class instantiated successfully<br>";
    
    if ($daraja->isEnabled()) {
        echo "✅ Daraja gateway is enabled<br>";
    } else {
        echo "⚠️ Daraja gateway is not enabled (this is expected if not configured)<br>";
    }
    
} catch (Exception $e) {
    echo "❌ Error instantiating Daraja class: " . $e->getMessage() . "<br>";
    exit;
}

// Test method availability
echo "<h2>4. Method Availability Test</h2>";
$methods = ['send_request', 'isEnabled', 'getConfig'];
foreach ($methods as $method) {
    if (method_exists($daraja, $method)) {
        echo "✅ Method '$method' exists<br>";
    } else {
        echo "❌ Method '$method' missing<br>";
    }
}

// Test configuration loading
echo "<h2>5. Configuration Test</h2>";
try {
    $config = $daraja->getConfig();
    if ($config) {
        echo "✅ Configuration loaded successfully<br>";
        echo "Environment: " . ($config['environment'] ?? 'not set') . "<br>";
        echo "Shortcode: " . ($config['shortcode'] ?? 'not set') . "<br>";
    } else {
        echo "⚠️ No configuration found (gateway may not be configured)<br>";
    }
} catch (Exception $e) {
    echo "❌ Error loading configuration: " . $e->getMessage() . "<br>";
}

// Test send_request method structure (without actually sending)
echo "<h2>6. Send Request Method Test</h2>";
try {
    // Test with invalid parameters to see if method works
    $result = $daraja->send_request([]);
    echo "✅ send_request method callable<br>";
    echo "Result: " . json_encode($result) . "<br>";
} catch (Exception $e) {
    echo "❌ Error calling send_request: " . $e->getMessage() . "<br>";
}

echo "<h2>Test Complete!</h2>";
echo "If all tests pass, the Daraja class should work in the captive portal.";

?>