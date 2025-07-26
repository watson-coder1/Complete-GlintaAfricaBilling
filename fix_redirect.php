<?php
  $file = "ui/ui/captive_portal_success.tpl";
  $content = file_get_contents($file);

  // Fix the redirects
  $content = str_replace(
      "window.location.href = 'https://www.google.com'",
      "window.location.href = 'http://192.168.88.1/login?username=' + encodeURIComponent(username) + '&password=' +
  encodeURIComponent(password) + '&dst=https://www.google.com'",
      $content
  );

  file_put_contents($file, $content);
  echo "Fixed redirect to use MikroTik login\n";
  
