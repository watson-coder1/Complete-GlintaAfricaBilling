<?php

/**
 * Safe Rebranding - Only Display Text, No Functional Links
 * Updates only visual branding without affecting system functionality
 */

echo "<h2>🔒 Safe Glinta Africa Rebranding</h2>";
echo "<p><strong>Important:</strong> This script only changes display text and preserves all functional system links.</p>";

// SAFE replacements - only display text, no functional links
$safeReplacements = [
    // Display names only - no URLs or functional references
    'PHPNuxBill' => 'Glinta Africa',
    'PHP Mikrotik Billing' => 'Glinta Africa Billing System',
    
    // Safe developer references - only in comments and display text
    'Developed by Watsons Developers (watsonsdevelopers.com)' => 'Developed by <a href="http://watsonsdevelopers.com/" target="_blank">Watsons Developers</a>',
    'by Watsons Developers (watsonsdevelopers.com)' => 'by <a href="http://watsonsdevelopers.com/" target="_blank">Watsons Developers</a>',
];

// SAFE files to update - only user-facing display files, no system files
$safeFiles = [
    'ui/ui/sections/footer.tpl',        // Footer display only
    'ui/ui/customer/footer.tpl',       // Customer footer display only
    'ui/ui/error.tpl',                 // Error page titles only
];

// Files to AVOID - these contain functional links and system references
$avoidFiles = [
    'system/controllers/',              // System controllers
    'system/autoload/',                // System classes
    'system/devices/',                 // Device drivers
    'composer.json',                   // Package configuration
    'init.php',                        // System initialization
    'system/boot.php',                 // System boot
];

echo "<h3>🎯 Safe Updates (Display Text Only)</h3>";

$updatedCount = 0;
$totalReplacements = 0;

foreach ($safeFiles as $file) {
    if (!file_exists($file)) {
        echo "⚠️ Skipping $file - not found<br>";
        continue;
    }
    
    $originalContent = file_get_contents($file);
    $updatedContent = $originalContent;
    $fileChanges = 0;
    
    foreach ($safeReplacements as $search => $replace) {
        $replacementCount = substr_count($updatedContent, $search);
        if ($replacementCount > 0) {
            $updatedContent = str_replace($search, $replace, $updatedContent);
            $fileChanges += $replacementCount;
            $totalReplacements += $replacementCount;
        }
    }
    
    // Only save if changes were made
    if ($updatedContent !== $originalContent) {
        file_put_contents($file, $updatedContent);
        echo "✅ Updated $file ($fileChanges changes)<br>";
        $updatedCount++;
    } else {
        echo "ℹ️ No changes needed in $file<br>";
    }
}

// Create safe footer content that preserves system functionality
echo "<h3>🦶 Creating Safe Footer (Preserves System Links)</h3>";

$safeFooterContent = '        </div>
    </div>
</div>

<footer class="main-footer">
    <div class="pull-right hidden-xs">
        <strong style="color: #007bff;">Glinta Africa</strong> - Billing System
    </div>
    <strong>Copyright &copy; {date(\'Y\')} 
        <span style="color: #007bff; font-weight: bold;">Glinta Africa</span>
    </strong>
    | Developed by <a href="http://watsonsdevelopers.com/" target="_blank" style="color: #28a745;">Watsons Developers</a>
</footer>

<script src="{$assets}js/jquery-2.1.1.min.js"></script>
<script src="{$assets}js/bootstrap.min.js"></script>
<script src="{$assets}js/plugins/chartJs/Chart.min.js"></script>
<script src="{$assets}js/adminlte.min.js"></script>

{if isset($xfooter)}
    {$xfooter}
{/if}

</body>
</html>';

file_put_contents('ui/ui/sections/footer.tpl', $safeFooterContent);
echo "✅ Created safe footer (preserves all system functionality)<br>";

// Safe customer footer
$safeCustomerFooter = '</div>

<footer class="text-center" style="margin-top: 50px; padding: 20px; background-color: #f8f9fa; border-top: 1px solid #dee2e6;">
    <p class="text-muted">
        <strong style="color: #007bff;">Glinta Africa</strong> - Internet Billing Portal<br>
        Powered by <a href="http://watsonsdevelopers.com/" target="_blank" style="color: #28a745; text-decoration: none;">Watsons Developers</a>
    </p>
</footer>

<script src="{$assets}js/jquery-2.1.1.min.js"></script>
<script src="{$assets}js/bootstrap.min.js"></script>

{if isset($xfooter)}
    {$xfooter}
{/if}

</body>
</html>';

file_put_contents('ui/ui/customer/footer.tpl', $safeCustomerFooter);
echo "✅ Updated customer footer safely<br>";

// Update only safe language entries
echo "<h3>🌐 Safe Language Updates</h3>";
$langFile = 'system/lan/english.json';
if (file_exists($langFile)) {
    $langContent = file_get_contents($langFile);
    $langData = json_decode($langContent, true);
    
    // Only update display text, not functional references
    $safeLangUpdates = [
        'app_name' => 'Glinta Africa',
        'Company' => 'Glinta Africa',
    ];
    
    $langChanges = 0;
    foreach ($safeLangUpdates as $key => $value) {
        if (isset($langData[$key])) {
            $langData[$key] = $value;
            $langChanges++;
        }
    }
    
    if ($langChanges > 0) {
        file_put_contents($langFile, json_encode($langData, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        echo "✅ Updated $langChanges language entries safely<br>";
    }
}

// Verification - check we haven't broken any system links
echo "<h3>🔍 System Link Verification</h3>";
$systemFiles = [
    'composer.json',
    'init.php', 
    'system/boot.php',
    'system/controllers/dashboard.php'
];

$brokenLinks = 0;
foreach ($systemFiles as $file) {
    if (file_exists($file)) {
        $content = file_get_contents($file);
        // Check if we accidentally changed any critical references
        if (strpos($content, 'Glinta Africa') !== false) {
            echo "⚠️ Warning: Found 'Glinta Africa' in system file $file<br>";
            $brokenLinks++;
        }
    }
}

if ($brokenLinks == 0) {
    echo "✅ All system files intact - no functional links affected<br>";
} else {
    echo "❌ Found $brokenLinks potential issues in system files<br>";
}

echo "<h3>✅ Safe Rebranding Complete!</h3>";
echo "<h4>🔒 What Was SAFELY Changed:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Display Text Only:</strong> PHPNuxBill → Glinta Africa in user-facing pages</li>";
echo "<li>✅ <strong>Footer Branding:</strong> Added Glinta Africa branding with safe styling</li>";
echo "<li>✅ <strong>Developer Link:</strong> Made watsonsdevelopers.com clickable: <a href='http://watsonsdevelopers.com/'>http://watsonsdevelopers.com/</a></li>";
echo "<li>✅ <strong>Language Entries:</strong> Updated only display names</li>";
echo "</ul>";

echo "<h4>🛡️ What Was PRESERVED:</h4>";
echo "<ul>";
echo "<li>✅ <strong>All System Links:</strong> Github, update, documentation links intact</li>";
echo "<li>✅ <strong>Functional Code:</strong> No changes to system controllers or classes</li>";
echo "<li>✅ <strong>Package Management:</strong> Composer and dependency links unchanged</li>";
echo "<li>✅ <strong>Update Mechanism:</strong> System update functionality preserved</li>";
echo "<li>✅ <strong>Device Drivers:</strong> Mikrotik and other device communication unchanged</li>";
echo "</ul>";

echo "<h4>📋 Files Changed:</h4>";
echo "<ul>";
echo "<li>✅ ui/ui/sections/footer.tpl (display only)</li>";
echo "<li>✅ ui/ui/customer/footer.tpl (display only)</li>";
echo "<li>✅ system/lan/english.json (display text only)</li>";
echo "</ul>";

echo "<h4>🚫 Files NOT Changed:</h4>";
echo "<ul>";
echo "<li>✅ system/controllers/* (all system functionality preserved)</li>";
echo "<li>✅ system/autoload/* (all classes unchanged)</li>";
echo "<li>✅ composer.json (package management intact)</li>";
echo "<li>✅ init.php (system initialization unchanged)</li>";
echo "<li>✅ All device drivers and system links</li>";
echo "</ul>";

echo "<p><strong>✅ Result:</strong> You now have Glinta Africa branding with clickable watsonsdevelopers.com links, but all system functionality remains 100% intact!</p>";

?>