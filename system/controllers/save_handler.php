<?php

/**
 * Enhanced Save Handler with Timeout Prevention
 * Handles save operations with better error handling and user feedback
 */

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

// Set longer execution time for save operations
set_time_limit(120);
ini_set('max_execution_time', 120);

// Buffer output to prevent timeout issues
ob_start();

try {
    // Include system initialization
    require_once '../init.php';
    
    _admin();
    
    // Get save parameters
    $action = _post('action', '');
    $content = _post('html', '');
    $save_type = _post('save_type', 'manual'); // manual, auto, retry
    $attempt = (int)_post('attempt', 1);
    
    // Validate input
    if (empty($action) || empty($content)) {
        throw new Exception('Missing required parameters');
    }
    
    // Log save attempt
    error_log("Save attempt {$attempt} for action: {$action}, type: {$save_type}");
    
    // Sanitize action name
    $action = str_replace(".", "", $action);
    $path = "$PAGES_PATH/{$action}.html";
    
    // Check permissions
    if (!in_array($admin['user_type'], ['SuperAdmin', 'Admin'])) {
        throw new Exception('Insufficient permissions');
    }
    
    // Validate file path
    if (!is_dir($PAGES_PATH)) {
        throw new Exception('Pages directory does not exist');
    }
    
    // Check if file is writable
    if (file_exists($path) && !is_writable($path)) {
        throw new Exception('File is not writable. Check file permissions.');
    }
    
    if (!is_writable(dirname($path))) {
        throw new Exception('Directory is not writable. Check directory permissions.');
    }
    
    // Create backup before saving (for manual saves)
    if ($save_type === 'manual' && file_exists($path)) {
        $backup_path = $path . '.backup.' . date('Y-m-d-H-i-s');
        if (!copy($path, $backup_path)) {
            error_log("Warning: Could not create backup for {$path}");
        }
    }
    
    // Validate content (basic XSS protection)
    if (strlen($content) > 10 * 1024 * 1024) { // 10MB limit
        throw new Exception('Content is too large (max 10MB)');
    }
    
    // Attempt to save with multiple methods
    $save_successful = false;
    $save_methods = [
        'file_put_contents' => function($path, $content) {
            return file_put_contents($path, $content, LOCK_EX);
        },
        'fwrite' => function($path, $content) {
            $handle = fopen($path, 'w');
            if (!$handle) return false;
            $result = fwrite($handle, $content);
            fclose($handle);
            return $result;
        },
        'temp_and_rename' => function($path, $content) {
            $temp_path = $path . '.tmp.' . uniqid();
            $result = file_put_contents($temp_path, $content, LOCK_EX);
            if ($result && rename($temp_path, $path)) {
                return $result;
            }
            if (file_exists($temp_path)) {
                unlink($temp_path);
            }
            return false;
        }
    ];
    
    $last_error = '';
    foreach ($save_methods as $method_name => $method) {
        try {
            $result = $method($path, $content);
            if ($result !== false) {
                $save_successful = true;
                error_log("Save successful using method: {$method_name}");
                break;
            }
        } catch (Exception $e) {
            $last_error = $e->getMessage();
            error_log("Save method {$method_name} failed: " . $last_error);
        }
    }
    
    if (!$save_successful) {
        throw new Exception("All save methods failed. Last error: {$last_error}");
    }
    
    // Verify the save by reading back
    $saved_content = file_get_contents($path);
    if ($saved_content !== $content) {
        throw new Exception('Save verification failed - content mismatch');
    }
    
    // Handle template saving for vouchers
    if ($action === 'Voucher' && _post('template_save') === 'yes') {
        $template_name = _post('template_name', '');
        if (!empty($template_name)) {
            $template_path = "$PAGES_PATH/vouchers/{$template_name}.html";
            if (!is_dir("$PAGES_PATH/vouchers/")) {
                mkdir("$PAGES_PATH/vouchers/", 0755, true);
            }
            file_put_contents($template_path, $content);
        }
    }
    
    // Run hooks
    run_hook('save_pages');
    
    // Prepare success response
    $response = [
        'success' => true,
        'message' => 'Content saved successfully',
        'action' => $action,
        'save_type' => $save_type,
        'attempt' => $attempt,
        'file_size' => strlen($content),
        'timestamp' => date('Y-m-d H:i:s')
    ];
    
    // For auto-saves, return minimal response
    if ($save_type === 'auto') {
        $response['message'] = 'Auto-saved';
    }
    
    // Clear output buffer and send response
    ob_end_clean();
    header('Content-Type: application/json');
    echo json_encode($response);
    
} catch (Exception $e) {
    // Clear output buffer
    ob_end_clean();
    
    // Log the error
    error_log("Save error: " . $e->getMessage());
    
    // Prepare error response
    $error_response = [
        'success' => false,
        'error' => $e->getMessage(),
        'action' => isset($action) ? $action : 'unknown',
        'save_type' => isset($save_type) ? $save_type : 'unknown',
        'attempt' => isset($attempt) ? $attempt : 1,
        'timestamp' => date('Y-m-d H:i:s')
    ];
    
    // Add troubleshooting info for certain errors
    if (strpos($e->getMessage(), 'writable') !== false) {
        $error_response['troubleshooting'] = [
            'check_permissions' => "chmod 755 {$PAGES_PATH}",
            'check_ownership' => "chown www-data:www-data {$PAGES_PATH}/*",
            'check_selinux' => 'Check SELinux context if enabled'
        ];
    }
    
    // Send error response
    http_response_code(400);
    header('Content-Type: application/json');
    echo json_encode($error_response);
}

exit;
?>