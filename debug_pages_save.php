<?php
/**
 * Debug pages save issue
 */
require_once 'init.php';

// Test parameters
$action = 'Announcement';
$test_content = '<h1>Test Announcement</h1><p>This is a test ' . date('Y-m-d H:i:s') . '</p>';

echo "<h2>Pages Save Debug</h2>";

// Check PAGES_PATH
echo "<h3>1. PAGES_PATH Check:</h3>";
echo "PAGES_PATH constant: " . $PAGES_PATH . "<br>";
echo "Directory exists: " . (is_dir($PAGES_PATH) ? 'YES' : 'NO') . "<br>";
echo "Directory writable: " . (is_writable($PAGES_PATH) ? 'YES' : 'NO') . "<br>";

// Build file path
$path = "$PAGES_PATH/" . str_replace(".", "", $action) . ".html";
echo "<h3>2. File Path Check:</h3>";
echo "Full path: " . $path . "<br>";
echo "File exists: " . (file_exists($path) ? 'YES' : 'NO') . "<br>";
echo "File writable: " . (is_writable($path) ? 'YES' : 'NO') . "<br>";

// Test write
echo "<h3>3. Write Test:</h3>";
$result = @file_put_contents($path, $test_content);

if ($result !== false) {
    echo "<span style='color:green'>SUCCESS: Wrote $result bytes</span><br>";
    
    // Read back
    $read_content = file_get_contents($path);
    echo "Content matches: " . ($read_content === $test_content ? 'YES' : 'NO') . "<br>";
} else {
    echo "<span style='color:red'>FAILED: Could not write file</span><br>";
    $error = error_get_last();
    echo "Error: " . ($error ? $error['message'] : 'Unknown') . "<br>";
}

// Check PHP settings
echo "<h3>4. PHP Settings:</h3>";
echo "open_basedir: " . (ini_get('open_basedir') ?: 'Not set') . "<br>";
echo "safe_mode: " . (ini_get('safe_mode') ? 'ON' : 'OFF') . "<br>";
echo "disable_functions: " . ini_get('disable_functions') . "<br>";

// Check disk space
echo "<h3>5. Disk Space:</h3>";
$free_space = disk_free_space($PAGES_PATH);
echo "Free space: " . number_format($free_space / 1024 / 1024, 2) . " MB<br>";

// Manual file_put_contents simulation
echo "<h3>6. Manual Write Test:</h3>";
$fp = @fopen($path, 'w');
if ($fp) {
    $write_result = fwrite($fp, $test_content);
    fclose($fp);
    echo "Manual write: " . ($write_result !== false ? "SUCCESS ($write_result bytes)" : "FAILED") . "<br>";
} else {
    echo "Could not open file for writing<br>";
}

echo "<hr>";
echo "<a href='?_route=pages/Announcement'>Go to Announcement page editor</a>";
?>