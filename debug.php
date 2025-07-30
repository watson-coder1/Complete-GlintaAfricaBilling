<?php
$pdo = new PDO('mysql:host=mysql;dbname=glinta_billing', 'glinta_user', 'Glinta2025!');
echo '<h2>Completed Sessions</h2>';
$sessions = $pdo->query("SELECT session_id, mac_address, status, created_at FROM tbl_portal_sessions WHERE status='completed' ORDER BY id DESC LIMIT 5")->fetchAll();
if ($sessions) {
    echo '<table border=1><tr><th>Session</th><th>MAC</th><th>Status</th><th>Created</th></tr>';
    foreach ($sessions as $s) {
        echo '<tr><td>' . $s['session_id'] . '</td><td>' . $s['mac_address'] . '</td><td>' . $s['status'] . '</td><td>' . $s['created_at'] . '</td></tr>';
    }
    echo '</table>';
} else {
    echo 'No sessions';
}

echo '<h2>RADIUS Users</h2>';
$users = $pdo->query("SELECT username, value FROM radcheck WHERE attribute='Cleartext-Password' ORDER BY id DESC LIMIT 5")->fetchAll();
if ($users) {
    echo '<table border=1><tr><th>Username</th><th>Password</th></tr>';
    foreach ($users as $u) {
        echo '<tr><td>' . $u['username'] . '</td><td>' . $u['value'] . '</td></tr>';
    }
    echo '</table>';
} else {
    echo 'No users';
}
?>
