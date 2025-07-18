<?php

/**
 * Rebrand System from PHPNuxBill to Glinta Africa
 * Replace watsonsdeveloper with clickable hyperlinks
 * Developed by Watsons Developers (watsonsdevelopers.com)
 */

echo "<h2>🔄 Rebranding System to Glinta Africa</h2>";

// Define the replacements
$replacements = [
    'PHPNuxBill' => 'Glinta Africa',
    'PHP Mikrotik Billing' => 'Glinta Africa Billing System',
    'watsonsdevelopers.com' => '<a href="https://watsonsdevelopers.com" target="_blank">watsonsdevelopers.com</a>',
    'Watsons Developers (watsonsdevelopers.com)' => '<a href="https://watsonsdevelopers.com" target="_blank">Watsons Developers</a>',
    'Developed by Watsons Developers (watsonsdevelopers.com)' => 'Developed by <a href="https://watsonsdevelopers.com" target="_blank">Watsons Developers</a>',
    'by Watsons Developers (watsonsdevelopers.com)' => 'by <a href="https://watsonsdevelopers.com" target="_blank">Watsons Developers</a>'
];

// Files to update (focusing on important user-facing files)
$filesToUpdate = [
    'ui/ui/sections/footer.tpl',
    'ui/ui/customer/footer.tpl', 
    'ui/ui/error.tpl',
    'system/lan/english.json',
    'mikrotik_config_generator.php',
    'radius_cron.php',
    'callback_mpesa.php',
    'mpesa_payment.php',
    'system/controllers/radius_manager.php',
    'system/autoload/RadiusManager.php',
    'ui/ui/radius-dashboard.tpl',
    'ui/ui/radius-sessions.tpl',
    'ui/ui/radius-users.tpl',
    'ui/ui/radius-statistics.tpl',
    'ui/ui/radius-cleanup.tpl',
    'ui/ui/radius-test.tpl',
    'ui/ui/paymentgateway/Daraja.tpl'
];

$updatedFiles = 0;
$totalReplacements = 0;

foreach ($filesToUpdate as $file) {
    if (!file_exists($file)) {
        echo "⚠️ Skipping $file - file not found<br>";
        continue;
    }
    
    $originalContent = file_get_contents($file);
    $updatedContent = $originalContent;
    $fileReplacements = 0;
    
    // Apply all replacements
    foreach ($replacements as $search => $replace) {
        $newContent = str_replace($search, $replace, $updatedContent);
        $replacementCount = substr_count($updatedContent, $search);
        
        if ($replacementCount > 0) {
            $updatedContent = $newContent;
            $fileReplacements += $replacementCount;
            $totalReplacements += $replacementCount;
        }
    }
    
    // Save if changes were made
    if ($updatedContent !== $originalContent) {
        file_put_contents($file, $updatedContent);
        echo "✅ Updated $file ($fileReplacements replacements)<br>";
        $updatedFiles++;
    } else {
        echo "ℹ️ No changes needed in $file<br>";
    }
}

// Update language file specifically
echo "<h3>📝 Updating Language Files</h3>";
$langFile = 'system/lan/english.json';
if (file_exists($langFile)) {
    $langContent = file_get_contents($langFile);
    $langData = json_decode($langContent, true);
    
    // Update specific language keys
    $langUpdates = [
        'Community' => 'Glinta Community',
        'Documentation' => 'Glinta Docs',
        'App_Name' => 'Glinta Africa',
        'Company' => 'Glinta Africa',
        'footer_text' => 'Powered by Glinta Africa'
    ];
    
    $langReplacements = 0;
    foreach ($langUpdates as $key => $value) {
        if (isset($langData[$key])) {
            $langData[$key] = $value;
            $langReplacements++;
        }
    }
    
    // Also update any PHPNuxBill references in language values
    foreach ($langData as $key => $value) {
        if (is_string($value) && strpos($value, 'PHPNuxBill') !== false) {
            $langData[$key] = str_replace('PHPNuxBill', 'Glinta Africa', $value);
            $langReplacements++;
        }
    }
    
    if ($langReplacements > 0) {
        file_put_contents($langFile, json_encode($langData, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        echo "✅ Updated language file ($langReplacements changes)<br>";
    }
}

// Create a custom CSS file for footer branding
echo "<h3>🎨 Creating Custom Branding CSS</h3>";
$customCSS = "
/* Glinta Africa Custom Branding */
.footer-brand {
    font-weight: bold;
    color: #007bff;
}

.developer-link {
    color: #28a745;
    text-decoration: none;
    font-weight: 500;
}

.developer-link:hover {
    color: #1e7e34;
    text-decoration: underline;
}

.brand-logo {
    color: #007bff;
    font-weight: bold;
    font-size: 1.2em;
}
";

file_put_contents('ui/ui/css/glinta-branding.css', $customCSS);
echo "✅ Created custom branding CSS<br>";

// Update main footer template with better branding
echo "<h3>🦶 Updating Footer Template</h3>";
$footerFile = 'ui/ui/sections/footer.tpl';
if (file_exists($footerFile)) {
    $footerContent = '        </div>
    </div>
</div>

<footer class="main-footer">
    <div class="pull-right hidden-xs">
        <strong class="footer-brand">Glinta Africa</strong> - Advanced Billing System
    </div>
    <strong>Copyright &copy; {date(\'Y\')} 
        <a href="https://glintaafrica.com" class="brand-logo" target="_blank">Glinta Africa</a>
    </strong>
    | Developed by <a href="https://watsonsdevelopers.com" class="developer-link" target="_blank">Watsons Developers</a>
</footer>

<script src="{$assets}js/jquery-2.1.1.min.js"></script>
<script src="{$assets}js/bootstrap.min.js"></script>
<script src="{$assets}js/plugins/chartJs/Chart.min.js"></script>
<script src="{$assets}js/adminlte.min.js"></script>
<link rel="stylesheet" href="{$assets}css/glinta-branding.css">

{if isset($xfooter)}
    {$xfooter}
{/if}

</body>
</html>';
    
    file_put_contents($footerFile, $footerContent);
    echo "✅ Updated main footer with Glinta Africa branding<br>";
}

// Update customer footer as well
$customerFooterFile = 'ui/ui/customer/footer.tpl';
if (file_exists($customerFooterFile)) {
    $customerFooterContent = '</div>

<footer class="text-center" style="margin-top: 50px; padding: 20px; background-color: #f8f9fa; border-top: 1px solid #dee2e6;">
    <p class="text-muted">
        <strong class="footer-brand">Glinta Africa</strong> - Internet Billing Portal<br>
        Powered by <a href="https://watsonsdevelopers.com" class="developer-link" target="_blank">Watsons Developers</a>
    </p>
</footer>

<script src="{$assets}js/jquery-2.1.1.min.js"></script>
<script src="{$assets}js/bootstrap.min.js"></script>
<link rel="stylesheet" href="{$assets}css/glinta-branding.css">

{if isset($xfooter)}
    {$xfooter}
{/if}

</body>
</html>';
    
    file_put_contents($customerFooterFile, $customerFooterContent);
    echo "✅ Updated customer footer with Glinta Africa branding<br>";
}

echo "<h3>✅ Rebranding Complete!</h3>";
echo "<h4>📊 Summary:</h4>";
echo "<ul>";
echo "<li>✅ <strong>Files Updated:</strong> $updatedFiles</li>";
echo "<li>✅ <strong>Total Replacements:</strong> $totalReplacements</li>";
echo "<li>✅ <strong>Brand Name:</strong> PHPNuxBill → Glinta Africa</li>";
echo "<li>✅ <strong>Developer Links:</strong> Made clickable hyperlinks</li>";
echo "<li>✅ <strong>Custom CSS:</strong> Created for consistent branding</li>";
echo "</ul>";

echo "<h4>🎯 Changes Made:</h4>";
echo "<ul>";
echo "<li><strong>PHPNuxBill</strong> → <strong>Glinta Africa</strong></li>";
echo "<li><strong>watsonsdevelopers.com</strong> → <strong><a href='#'>Clickable Link</a></strong></li>";
echo "<li><strong>Footer Branding</strong> → Professional Glinta Africa branding</li>";
echo "<li><strong>Language Files</strong> → Updated with new brand name</li>";
echo "</ul>";

echo "<h4>🚀 Next Steps:</h4>";
echo "<ol>";
echo "<li>Deploy updated files to your Docker container</li>";
echo "<li>Clear browser cache to see changes</li>";
echo "<li>Check footer and admin pages for new branding</li>";
echo "<li>Optionally add Glinta Africa logo to login pages</li>";
echo "</ol>";

?>