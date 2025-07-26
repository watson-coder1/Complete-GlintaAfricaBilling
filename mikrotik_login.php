<?php
/* --- 1. Validate session ID ------------------------------------------------ */
$sessionId = $_GET['session'] ?? '';
if (!$sessionId) {
    exit('Session ID required');
}

/* --- 2. Look up completed portal session ---------------------------------- */
try {
    $pdo = new PDO('mysql:host=mysql;dbname=glinta_billing', 'glinta_user', 'Glinta2025!', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ]);
    $stmt = $pdo->prepare(
        "SELECT * FROM tbl_portal_sessions
         WHERE session_id = ? AND status = 'completed' LIMIT 1"
    );
    $stmt->execute([$sessionId]);
    $session = $stmt->fetch(PDO::FETCH_OBJ);
    if (!$session) {
        exit('Invalid or incomplete session');
    }
} catch (Exception $e) {
    exit('DB error: ' . $e->getMessage());
}

/* --- 3. Build MikroTik login URL ------------------------------------------ */
$mikrotik = json_decode($session->mikrotik_params ?: '{}', true);
$loginUrl   = $mikrotik['link-login-only'] ?? 'http://192.168.88.1/login';
$original   = $mikrotik['link-orig']       ?? 'https://www.google.com';
$username   = $session->mac_address;
$password   = $session->mac_address;
$authUrl    = $loginUrl . '?' .
              http_build_query([
                  'username' => $username,
                  'password' => $password,
                  'dst'      => $original,
              ]);
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Activating Internet</title>
<meta http-equiv="refresh" content="1;url=<?=$authUrl?>">
<style>
 body{font-family:Arial;text-align:center;padding:50px;background:#f5f5f5}
 .box{background:#fff;padding:30px;border-radius:10px;max-width:480px;margin:0 auto}
 .spinner{border:4px solid #ddd;border-top:4px solid #10b981;border-radius:50%;width:40px;height:40px;margin:20px auto;
          animation:spin 1s linear infinite}
 @keyframes spin{0%{transform:rotate(0)}100%{transform:rotate(360deg)}}
</style>
</head>
<body>
<div class="box">
 <h2>🌐 Connecting to Internet</h2>
 <div class="spinner"></div>
 <p>Authenticating hotspot session…</p>
 <p><small>MAC <?=htmlspecialchars($username)?></small></p>
</div>
<script>
setTimeout(()=>location.href="<?=htmlspecialchars($authUrl,ENT_QUOTES)?>",1000);
</script>
</body>
</html>
