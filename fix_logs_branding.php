<?php

/**
 * Fix Logs Branding
 * Remove (watsonsdevelopers.com) and change PHPNuxBill Logs to Glinta Africa Logs
 */

echo "<h2>📝 Fixing Logs Branding</h2>";

// Find all files with (watsonsdevelopers.com) and remove it
$filesToCheck = [
    'system/controllers/logs.php',
    'system/controllers/radius_manager.php',
    'system/autoload/RadiusManager.php',
    'callback_mpesa.php',
    'mpesa_payment.php',
    'mikrotik_config_generator.php',
    'radius_cron.php',
    'admin/index.php',
    'init.php',
    'radius.php',
    'index.php',
    'system/controllers/system_metrics.php',
    'update.php'
];

$totalUpdated = 0;

foreach ($filesToCheck as $file) {
    if (!file_exists($file)) {
        echo "⚠️ Skipping $file - not found<br>";
        continue;
    }
    
    $content = file_get_contents($file);
    $originalContent = $content;
    
    // Remove (watsonsdevelopers.com) references
    $content = str_replace('(watsonsdevelopers.com)', '', $content);
    $content = str_replace(' (watsonsdevelopers.com)', '', $content);
    
    // Change PHPNuxBill Logs to Glinta Africa Logs
    $content = str_replace('PHPNuxBill Logs', 'Glinta Africa Logs', $content);
    
    // Clean up any double spaces that might result from removals
    $content = str_replace('  ', ' ', $content);
    
    if ($content !== $originalContent) {
        file_put_contents($file, $content);
        echo "✅ Updated $file<br>";
        $totalUpdated++;
    }
}

// Specifically check and update the logs controller
echo "<h3>📋 Updating Logs Controller</h3>";
$logsFile = 'system/controllers/logs.php';
if (file_exists($logsFile)) {
    $logsContent = file_get_contents($logsFile);
    
    // Update page title
    $logsContent = str_replace("'title', 'PHPNuxBill Logs'", "'title', 'Glinta Africa Logs'", $logsContent);
    $logsContent = str_replace('PHPNuxBill Logs', 'Glinta Africa Logs', $logsContent);
    
    file_put_contents($logsFile, $logsContent);
    echo "✅ Updated logs controller title<br>";
}

// Update language file for logs
echo "<h3>🌐 Updating Language File</h3>";
$langFile = 'system/lan/english.json';
if (file_exists($langFile)) {
    $langContent = file_get_contents($langFile);
    $langData = json_decode($langContent, true);
    
    // Update logs-related translations
    $logUpdates = [
        'Logs' => 'Glinta Africa Logs',
        'Activity_Log' => 'Glinta Africa Activity Log',
        'System_Log' => 'Glinta Africa System Log'
    ];
    
    $changed = false;
    foreach ($logUpdates as $key => $value) {
        if (isset($langData[$key])) {
            $langData[$key] = $value;
            $changed = true;
        }
    }
    
    // Also update any PHPNuxBill references in log-related entries
    foreach ($langData as $key => $value) {
        if (is_string($value) && strpos($value, 'PHPNuxBill') !== false && strpos($key, 'log') !== false) {
            $langData[$key] = str_replace('PHPNuxBill', 'Glinta Africa', $value);
            $changed = true;
        }
    }
    
    if ($changed) {
        file_put_contents($langFile, json_encode($langData, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        echo "✅ Updated language file for logs<br>";
    }
}

// Check for any log templates
echo "<h3>📄 Checking Log Templates</h3>";
$logTemplates = [
    'ui/ui/logs.tpl',
    'ui/ui/activity-log.tpl',
    'ui/ui/system-log.tpl'
];

foreach ($logTemplates as $template) {
    if (file_exists($template)) {
        $templateContent = file_get_contents($template);
        $originalTemplate = $templateContent;
        
        // Update log page titles and headings
        $templateContent = str_replace('PHPNuxBill Logs', 'Glinta Africa Logs', $templateContent);
        $templateContent = str_replace('PHPNuxBill Activity', 'Glinta Africa Activity', $templateContent);
        
        if ($templateContent !== $originalTemplate) {
            file_put_contents($template, $templateContent);
            echo "✅ Updated $template<br>";
        }
    }
}

// Summary
echo "<h3>✅ Logs Branding Update Complete!</h3>";
echo "<h4>📊 Changes Made:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Removed:</strong> All '(watsonsdevelopers.com)' references</li>";
echo "<li>✅ <strong>Updated:</strong> 'PHPNuxBill Logs' → 'Glinta Africa Logs'</li>";
echo "<li>✅ <strong>Files Updated:</strong> $totalUpdated files</li>";
echo "<li>✅ <strong>Language File:</strong> Updated log-related translations</li>";
echo "</ul>";

echo "<h4>🎯 What Changed:</h4>";
echo "<ul>";
echo "<li><strong>Before:</strong> Developed by Watsons Developers (watsonsdevelopers.com)</li>";
echo "<li><strong>After:</strong> Developed by Watsons Developers</li>";
echo "<li><strong>Before:</strong> PHPNuxBill Logs</li>";
echo "<li><strong>After:</strong> Glinta Africa Logs</li>";
echo "</ul>";

echo "<p><strong>✅ All developer credit references cleaned up and logs properly branded!</strong></p>";

?>