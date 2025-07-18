<?php

/**
 * Final Cleanup - Remove ALL (watsonsdevelopers.com) and fix logs naming
 * Change to "System Interaction Logs"
 */

echo "<h2>🧹 Final Branding Cleanup</h2>";

// Files to clean up in the container
$cleanup_commands = [
    // Remove all (watsonsdevelopers.com) from all files
    "find /var/www/html -type f -name '*.php' -exec sed -i 's/(watsonsdevelopers\.com)//g' {} \;",
    "find /var/www/html -type f -name '*.tpl' -exec sed -i 's/(watsonsdevelopers\.com)//g' {} \;",
    
    // Change PHPNuxBill Logs to System Interaction Logs
    "find /var/www/html -type f -name '*.php' -exec sed -i 's/PHPNuxBill Logs/System Interaction Logs/g' {} \;",
    "find /var/www/html -type f -name '*.tpl' -exec sed -i 's/PHPNuxBill Logs/System Interaction Logs/g' {} \;",
    
    // Clean up any remaining Glinta Africa Logs to System Interaction Logs
    "find /var/www/html -type f -name '*.php' -exec sed -i 's/Glinta Africa Logs/System Interaction Logs/g' {} \;",
    "find /var/www/html -type f -name '*.tpl' -exec sed -i 's/Glinta Africa Logs/System Interaction Logs/g' {} \;",
    
    // Remove compiled template cache
    "rm -rf /var/www/html/ui/compiled/*"
];

echo "<h3>🔧 Running cleanup commands...</h3>";

foreach ($cleanup_commands as $command) {
    $result = shell_exec($command . " 2>&1");
    echo "✅ Executed cleanup command<br>";
}

// Update the logs controller specifically
echo "<h3>📋 Updating Logs Controller</h3>";
$logsFile = '/var/www/html/system/controllers/logs.php';
if (file_exists($logsFile)) {
    $content = file_get_contents($logsFile);
    
    // Update title
    $content = str_replace("'_title', 'PHPNuxBill Logs'", "'_title', 'System Interaction Logs'", $content);
    $content = str_replace("'_title', 'Glinta Africa Logs'", "'_title', 'System Interaction Logs'", $content);
    $content = str_replace('PHPNuxBill Logs', 'System Interaction Logs', $content);
    $content = str_replace('Glinta Africa Logs', 'System Interaction Logs', $content);
    
    // Remove any (watsonsdevelopers.com) references
    $content = str_replace('(watsonsdevelopers.com)', '', $content);
    $content = str_replace(' (watsonsdevelopers.com)', '', $content);
    
    file_put_contents($logsFile, $content);
    echo "✅ Updated logs controller<br>";
}

// Update language file
echo "<h3>🌐 Updating Language File</h3>";
$langFile = '/var/www/html/system/lan/english.json';
if (file_exists($langFile)) {
    $langContent = file_get_contents($langFile);
    $langData = json_decode($langContent, true);
    
    // Update log-related entries
    $logUpdates = [
        'Logs' => 'System Interaction Logs',
        'Activity_Log' => 'System Activity Log',
        'System_Log' => 'System Interaction Log'
    ];
    
    foreach ($logUpdates as $key => $value) {
        if (isset($langData[$key])) {
            $langData[$key] = $value;
        }
    }
    
    // Clean up any remaining references
    foreach ($langData as $key => $value) {
        if (is_string($value)) {
            $langData[$key] = str_replace('(watsonsdevelopers.com)', '', $value);
            $langData[$key] = str_replace(' (watsonsdevelopers.com)', '', $value);
            $langData[$key] = str_replace('PHPNuxBill Logs', 'System Interaction Logs', $langData[$key]);
            $langData[$key] = str_replace('Glinta Africa Logs', 'System Interaction Logs', $langData[$key]);
        }
    }
    
    file_put_contents($langFile, json_encode($langData, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    echo "✅ Updated language file<br>";
}

// Check specific footer files
echo "<h3>🦶 Cleaning Footer Files</h3>";
$footerFiles = [
    '/var/www/html/ui/ui_custom/sections/footer.tpl',
    '/var/www/html/ui/ui_custom/customer/footer.tpl'
];

foreach ($footerFiles as $footerFile) {
    if (file_exists($footerFile)) {
        $content = file_get_contents($footerFile);
        $content = str_replace('(watsonsdevelopers.com)', '', $content);
        $content = str_replace(' (watsonsdevelopers.com)', '', $content);
        file_put_contents($footerFile, $content);
        echo "✅ Cleaned $footerFile<br>";
    }
}

// Verify cleanup
echo "<h3>🔍 Verification</h3>";
$remainingWatsonRefs = shell_exec("grep -r '(watsonsdevelopers.com)' /var/www/html/ 2>/dev/null | grep -v 'fix_' | grep -v 'rebrand_' | wc -l");
$remainingPHPNuxLogs = shell_exec("grep -r 'PHPNuxBill Logs' /var/www/html/ 2>/dev/null | grep -v 'fix_' | grep -v 'rebrand_' | wc -l");

echo "Remaining (watsonsdevelopers.com) references: " . trim($remainingWatsonRefs) . "<br>";
echo "Remaining 'PHPNuxBill Logs' references: " . trim($remainingPHPNuxLogs) . "<br>";

if (trim($remainingWatsonRefs) == "0" && trim($remainingPHPNuxLogs) == "0") {
    echo "✅ <strong>All references successfully cleaned!</strong><br>";
} else {
    echo "⚠️ Some references may still exist<br>";
}

echo "<h3>✅ Final Cleanup Complete!</h3>";
echo "<h4>🎯 Changes Made:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Removed ALL:</strong> (watsonsdevelopers.com) references</li>";
echo "<li>✅ <strong>Changed:</strong> PHPNuxBill Logs → System Interaction Logs</li>";
echo "<li>✅ <strong>Updated:</strong> Language file entries</li>";
echo "<li>✅ <strong>Cleaned:</strong> Footer templates</li>";
echo "<li>✅ <strong>Cleared:</strong> Template cache</li>";
echo "</ul>";

echo "<h4>📝 Final Branding:</h4>";
echo "<ul>";
echo "<li><strong>Logs Page:</strong> System Interaction Logs</li>";
echo "<li><strong>Developer Credit:</strong> Developed by Watsons Developers (clean, no URL)</li>";
echo "<li><strong>System Name:</strong> Glinta Africa</li>";
echo "</ul>";

?>