  <?php
  // Simple test to see what MikroTik URL is being generated
  $loginUrl = 'http://192.168.88.1/login';
  $username = 'aa:bb:cc:dd:ee:ff'; // Test MAC
  $password = 'aa:bb:cc:dd:ee:ff';
  $dst = 'https://www.google.com';

  $authUrl = $loginUrl . '?' .
      'username=' . urlencode($username) .
      '&password=' . urlencode($password) .
      '&dst=' . urlencode($dst);

  echo 'Generated MikroTik Auth URL:' . PHP_EOL;
  echo $authUrl . PHP_EOL;
  echo PHP_EOL;
  echo 'Try accessing this URL in browser to test MikroTik redirect:' . PHP_EOL;
  echo $authUrl . PHP_EOL;
  EOF
