<?php
echo '<h2>🌐 Connectivity Test</h2>';
echo '<p>🔍 Testing from server to external and internal services:</p>';

// Test connection to Google
$ch = curl_init('https://www.google.com');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 5);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
$result = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);
echo '<p>✅ Google test: HTTP ' . $httpCode . ' - ' . ($result ? 'Success' : 'Failed') . '</p>';

// Test access to MikroTik login page
$ch = curl_init('http://192.168.88.1/login');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 5);
$mikrotik = curl_exec($ch);
$mikrotikCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);
echo '<p>📡 MikroTik login page: HTTP ' . $mikrotikCode . ' - ' . ($mikrotik ? 'Accessible' : 'Not accessible') . '</p>';

// Check active RADIUS sessions
try {
    $pdo = new PDO('mysql:host=mysql;dbname=glinta_billing', 'glinta_user', 'Glinta2025!');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $activeSessions = $pdo->query("SELECT COUNT(*) as count FROM radacct WHERE acctstoptime IS NULL")->fetch();
    echo '<p>📈 Active RADIUS sessions: ' . $activeSessions['count'] . '</p>';

    $recentAuth = $pdo->query("SELECT username, authdate FROM radpostauth ORDER BY id DESC LIMIT 5")->fetchAll();
    if ($recentAuth) {
        echo '<h3>🕵️‍♂️ Recent Authentication Attempts:</h3>';
        foreach ($recentAuth as $auth) {
            echo '<p>' . htmlspecialchars($auth['username']) . ' at ' . $auth['authdate'] . '</p>';
        }
    } else {
        echo '<p>⚠️ No recent authentication attempts found</p>';
    }
} catch (PDOException $e) {
    echo '<p>❌ Database error: ' . $e->getMessage() . '</p>';
}
?>
