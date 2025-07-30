<?php
  $loginUrl = "http://192.168.88.1/login";
  $username = "aa:bb:cc:dd:ee:ff";
  $password = "aa:bb:cc:dd:ee:ff";
  $dst = "https://www.google.com";
  $authUrl = $loginUrl . "?username=" . urlencode($username) . "&password=" . urlencode($password) . "&dst=" . urlencode($dst);
  echo "Generated MikroTik Auth URL:\n";
  echo $authUrl . "\n";
  ?>
