<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);

echo "=== Daraja Debug Test ===\n";

try {
    require_once "/var/www/html/init.php";
    echo "✅ init.php loaded\n";
} catch (Exception $e) {
    echo "❌ init.php error: " . $e->getMessage() . "\n";
    exit;
}

try {
    require_once "/var/www/html/system/paymentgateway/Daraja.php";
    echo "✅ Daraja.php included\n";
} catch (Exception $e) {
    echo "❌ Daraja.php error: " . $e->getMessage() . "\n";
    exit;
}

if (class_exists("Daraja")) {
    echo "✅ Daraja class exists\n";

    try {
        $daraja = new Daraja();
        echo "✅ Daraja class instantiated\n";

        echo "Testing send_request method...\n";
        $result = $daraja->send_request([
            "phone_number" => "254711503023",
            "amount" => 10,
            "invoice" => "TEST123",
            "description" => "Test Payment"
        ]);

        echo "✅ send_request called\n";
        echo "Result: " . json_encode($result) . "\n";

    } catch (Exception $e) {
        echo "❌ Class error: " . $e->getMessage() . "\n";
    }
} else {
    echo "❌ Daraja class does not exist\n";
}
?>
