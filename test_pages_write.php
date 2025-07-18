<?php
// Test pages directory write permissions

$pages_dir = __DIR__ . '/pages';
$test_file = $pages_dir . '/test_write_' . time() . '.html';

echo "Testing pages directory write permissions...\n\n";

echo "Pages directory: $pages_dir\n";
echo "Directory exists: " . (is_dir($pages_dir) ? 'YES' : 'NO') . "\n";
echo "Directory readable: " . (is_readable($pages_dir) ? 'YES' : 'NO') . "\n";
echo "Directory writable: " . (is_writable($pages_dir) ? 'YES' : 'NO') . "\n";
echo "Directory permissions: " . substr(sprintf('%o', fileperms($pages_dir)), -4) . "\n";
echo "Directory owner: " . posix_getpwuid(fileowner($pages_dir))['name'] . "\n";
echo "Current user: " . get_current_user() . "\n";
echo "PHP user: " . exec('whoami') . "\n";

echo "\nTrying to write test file...\n";
$result = file_put_contents($test_file, 'Test content');

if ($result !== false) {
    echo "SUCCESS: Wrote $result bytes to test file\n";
    echo "Test file exists: " . (file_exists($test_file) ? 'YES' : 'NO') . "\n";
    
    // Clean up
    unlink($test_file);
    echo "Test file deleted\n";
} else {
    echo "FAILED: Could not write to test file\n";
    echo "Last error: " . error_get_last()['message'] . "\n";
}

// Test specific page files
echo "\n\nChecking specific page files:\n";
$page_files = ['Announcement.html', 'Privacy_Policy.html', 'Terms_and_Conditions.html', 'Registration_Info.html'];

foreach ($page_files as $file) {
    $file_path = $pages_dir . '/' . $file;
    if (file_exists($file_path)) {
        echo "\n$file:\n";
        echo "  Exists: YES\n";
        echo "  Writable: " . (is_writable($file_path) ? 'YES' : 'NO') . "\n";
        echo "  Permissions: " . substr(sprintf('%o', fileperms($file_path)), -4) . "\n";
        echo "  Size: " . filesize($file_path) . " bytes\n";
    } else {
        echo "\n$file: NOT FOUND\n";
    }
}

// Test SELinux (if applicable)
echo "\n\nSELinux status:\n";
echo exec('getenforce 2>&1') . "\n";

?>