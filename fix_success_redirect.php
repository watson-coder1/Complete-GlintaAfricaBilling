  <?php
  $file = "ui/ui/captive_portal_success.tpl";
  $content = file_get_contents($file);

  // Replace direct Google redirects with MikroTik authentication
  $content = str_replace(
      "window.location.href = 'https://www.google.com';",
      "window.location.href = 'http://192.168.88.1/login?username=' + encodeURIComponent(mac_address) + '&password=' +
  encodeURIComponent(mac_address) + '&dst=https://www.google.com';",
      $content
  );

  $content = str_replace(
      "window.location.replace('https://www.google.com');",
      "window.location.replace('http://192.168.88.1/login?username=' + encodeURIComponent(mac_address) + '&password=' +
  encodeURIComponent(mac_address) + '&dst=https://www.google.com');",
      $content
  );

  // Add MAC address variable
  $content = str_replace(
      "let timeLeft = 10;",
      "let timeLeft = 10;\n        let mac_address = '{$session->mac_address}' || 'unknown';",
      $content
  );

  file_put_contents($file, $content);
  echo "Success page redirect fixed!\n";
  EOF
