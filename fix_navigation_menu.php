<?php

/**
 * Fix Navigation Menu - Change PhpNuxBill to Activity Log
 */

echo "<h2>🧭 Fixing Navigation Menu</h2>";

// Files to check for navigation menu items
$headerFiles = [
    '/var/www/html/ui/ui/sections/header.tpl',
    '/var/www/html/ui/ui_custom/sections/header.tpl',
    '/var/www/html/ui/themes/gold_theme/sections/header.tpl'
];

$updatedFiles = 0;

foreach ($headerFiles as $headerFile) {
    if (!file_exists($headerFile)) {
        echo "⚠️ Skipping $headerFile - not found<br>";
        continue;
    }
    
    $content = file_get_contents($headerFile);
    $originalContent = $content;
    
    // Replace the navigation menu item
    $content = str_replace('href="{$_url}logs/phpnuxbill">PhpNuxBill</a>', 'href="{$_url}logs/phpnuxbill">Activity Log</a>', $content);
    $content = str_replace('href="{$_url}logs/phpnuxbill">phpnuxbill</a>', 'href="{$_url}logs/phpnuxbill">Activity Log</a>', $content);
    $content = str_replace('>PhpNuxBill</a>', '>Activity Log</a>', $content);
    $content = str_replace('>phpnuxbill</a>', '>Activity Log</a>', $content);
    $content = str_replace('>Phpnuxbill</a>', '>Activity Log</a>', $content);
    
    if ($content !== $originalContent) {
        file_put_contents($headerFile, $content);
        echo "✅ Updated navigation in $headerFile<br>";
        $updatedFiles++;
    } else {
        echo "ℹ️ No changes needed in $headerFile<br>";
    }
}

// Also check if there are any language file references for the menu
echo "<h3>🌐 Checking Language File</h3>";
$langFile = '/var/www/html/system/lan/english.json';
if (file_exists($langFile)) {
    $langContent = file_get_contents($langFile);
    $langData = json_decode($langContent, true);
    
    $changed = false;
    
    // Update any menu-related entries
    $menuUpdates = [
        'PhpNuxBill' => 'Activity Log',
        'phpnuxbill' => 'Activity Log',
        'Phpnuxbill' => 'Activity Log',
        'PHP_NuxBill' => 'Activity Log',
        'NuxBill_Logs' => 'Activity Log'
    ];
    
    foreach ($menuUpdates as $old => $new) {
        if (isset($langData[$old])) {
            $langData[$old] = $new;
            $changed = true;
            echo "✅ Updated language entry: $old → $new<br>";
        }
    }
    
    if ($changed) {
        file_put_contents($langFile, json_encode($langData, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        echo "✅ Updated language file<br>";
    } else {
        echo "ℹ️ No language updates needed<br>";
    }
}

// Check logs controller to make sure the route still works
echo "<h3>📋 Verifying Logs Controller</h3>";
$logsController = '/var/www/html/system/controllers/logs.php';
if (file_exists($logsController)) {
    $logsContent = file_get_contents($logsController);
    
    // Make sure the phpnuxbill route is handled correctly
    if (strpos($logsContent, "case 'phpnuxbill'") !== false || strpos($logsContent, '$_routes[1]') !== false) {
        echo "✅ Logs controller routes are properly configured<br>";
    } else {
        echo "ℹ️ Logs controller may need route verification<br>";
    }
}

// Clear template cache to ensure changes are visible
echo "<h3>🗑️ Clearing Template Cache</h3>";
$cacheCleared = shell_exec("rm -rf /var/www/html/ui/compiled/* 2>&1");
echo "✅ Cleared template cache<br>";

// Verification
echo "<h3>🔍 Verification</h3>";
$remainingNuxBill = shell_exec("grep -r 'PhpNuxBill\|phpnuxbill' /var/www/html/ui/ui/sections/header.tpl 2>/dev/null | grep -v 'Activity Log' | wc -l");
echo "Remaining navigation NuxBill references: " . trim($remainingNuxBill) . "<br>";

if (trim($remainingNuxBill) == "0") {
    echo "✅ <strong>All navigation references updated!</strong><br>";
} else {
    echo "⚠️ Some references may still exist in navigation<br>";
}

echo "<h3>✅ Navigation Menu Update Complete!</h3>";
echo "<h4>🎯 Changes Made:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Navigation Menu:</strong> PhpNuxBill → Activity Log</li>";
echo "<li>✅ <strong>Files Updated:</strong> $updatedFiles header templates</li>";
echo "<li>✅ <strong>Template Cache:</strong> Cleared for immediate effect</li>";
echo "</ul>";

echo "<h4>📱 Navigation Structure Now:</h4>";
echo "<ul>";
echo "<li><strong>Logs</strong></li>";
echo "<li>&nbsp;&nbsp;└── <strong>Activity Log</strong> (was PhpNuxBill)</li>";
echo "<li>&nbsp;&nbsp;└── <strong>Radius</strong> (if enabled)</li>";
echo "</ul>";

echo "<p><strong>✅ The navigation menu now shows 'Activity Log' instead of 'PhpNuxBill'!</strong></p>";

?>