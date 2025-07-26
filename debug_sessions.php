<?php
$db_host = 'mysql';
$db_user = 'glinta_user';
$db_pass = getenv('MYSQL_PASSWORD') ?: 'Glinta2025!';
$db_name = 'glinta_billing';

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo '<h2>Recent Completed Sessions</h2>';
    $stmt = $pdo->prepare("SELECT session_id, mac_address, status, created_at FROM tbl_portal_sessions WHERE status='completed' ORDER BY id DESC LIMIT 5");
    $stmt->execute();
    $sessions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($sessions) {
        echo '<table border="1" style="border-collapse: collapse; width: 100%;">';
        echo '<tr><th>Session ID</th><th>MAC Address</th><th>Status</th><th>Created</th></tr>';
        foreach ($sessions as $session) {
            echo '<tr>';
            echo '<td>' . $session['session_id'] . '</td>';
            echo '<td>' . $session['mac_address'] . '</td>';
            echo '<td>' . $session['status'] . '</td>';
            echo '<td>' . $session['created_at'] . '</td>';
            echo '</tr>';
        }
        echo '</table>';
    } else {
        echo '<p>No completed sessions found</p>';
    }

    echo '<h2>Recent RADIUS Users</h2>';
    $stmt = $pdo->prepare("SELECT username, value FROM radcheck WHERE attribute='Cleartext-Password' ORDER BY id DESC LIMIT 5");
    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($users) {
        echo '<table border="1" style="border-collapse: collapse; width: 100%;">';
        echo '<tr><th>Username (MAC)</th><th>Password</th></tr>';
        foreach ($users as $user) {
            echo '<tr>';
            echo '<td>' . $user['username'] . '</td>';
            echo '<td>' . $user['value'] . '</td>';
            echo '</tr>';
        }
        echo '</table>';
    } else {
        echo '<p>No RADIUS users found</p>';
    }

} catch (Exception $e) {
    echo 'Database error: ' . $e->getMessage();
}
?>
