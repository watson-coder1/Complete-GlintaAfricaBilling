<?php
/**
 * Fix for pages save issue
 * This script patches the pages.php controller to debug the issue
 */

$controller_path = 'system/controllers/pages.php';
$backup_path = 'system/controllers/pages.php.backup';

// Create backup
if (!file_exists($backup_path)) {
    copy($controller_path, $backup_path);
    echo "Created backup: $backup_path\n";
}

// Read the controller
$content = file_get_contents($controller_path);

// Find the save section
$search = 'if (file_put_contents($path, $html)) {';
$replace = '// Debug save issue
        error_log("Pages save debug - Path: " . $path);
        error_log("Pages save debug - Content length: " . strlen($html));
        error_log("Pages save debug - Path exists: " . (file_exists($path) ? "YES" : "NO"));
        error_log("Pages save debug - Path writable: " . (is_writable($path) ? "YES" : "NO"));
        
        // Try direct write test
        $test_result = @file_put_contents($path . ".test", "test");
        error_log("Pages save debug - Test write: " . ($test_result !== false ? "SUCCESS" : "FAILED"));
        if ($test_result !== false) {
            @unlink($path . ".test");
        }
        
        $write_result = @file_put_contents($path, $html);
        error_log("Pages save debug - Write result: " . var_export($write_result, true));
        
        if ($write_result !== false) {';

// Check if already patched
if (strpos($content, 'Pages save debug') === false) {
    $content = str_replace($search, $replace, $content);
    file_put_contents($controller_path, $content);
    echo "Patched pages.php controller with debug code\n";
} else {
    echo "Controller already patched\n";
}

// Also create a simpler fix - override error message
$search2 = 'r2(U . \'pages/\' . $action, \'e\', Lang::T("Failed to save page, make sure i can write to folder pages, <i>chmod 664 pages/*.html<i>"));';
$replace2 = '// Enhanced error message
            $error_msg = "Failed to save page. ";
            $error_msg .= "Path: " . $path . " ";
            $error_msg .= "Exists: " . (file_exists($path) ? "YES" : "NO") . " ";
            $error_msg .= "Writable: " . (is_writable($path) ? "YES" : "NO") . " ";
            $error_msg .= "Dir writable: " . (is_writable(dirname($path)) ? "YES" : "NO") . " ";
            $error_msg .= "Error: " . (error_get_last() ? error_get_last()[\'message\'] : \'None\');
            r2(U . \'pages/\' . $action, \'e\', $error_msg);';

$content = str_replace($search2, $replace2, $content);
file_put_contents($controller_path, $content);

echo "Enhanced error reporting added\n";
echo "\nNow try saving a page again and check the error message for more details.\n";
?>