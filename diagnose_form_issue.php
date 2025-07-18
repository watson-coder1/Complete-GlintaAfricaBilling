<?php
/**
 * Diagnostic Script for Daraja Form Issue
 * This script checks the exact HTML output of the form
 */

echo "<h1>🔍 Daraja Form Diagnostic Tool</h1>";
echo "<style>body{font-family:Arial,sans-serif;margin:20px;} .code{background:#f8f9fa;padding:15px;border:1px solid #ddd;border-radius:5px;overflow-x:auto;} .success{color:green;} .error{color:red;} .warning{color:orange;}</style>";

// Check if template file exists and is readable
$template_path = __DIR__ . '/ui/ui/paymentgateway/Daraja.tpl';
echo "<h2>📁 File System Check:</h2>";

if (file_exists($template_path)) {
    echo "<p class='success'>✅ Template file exists: $template_path</p>";
    
    // Read the template file
    $template_content = file_get_contents($template_path);
    
    // Check for callback URL field
    if (strpos($template_content, 'name="callback_url"') !== false) {
        echo "<p class='success'>✅ Callback URL field found with correct name</p>";
    } else {
        echo "<p class='error'>❌ Callback URL field not found or wrong name</p>";
    }
    
    // Check for readonly attribute
    if (strpos($template_content, 'readonly') !== false) {
        echo "<p class='error'>❌ WARNING: 'readonly' attribute still found in template</p>";
    } else {
        echo "<p class='success'>✅ No 'readonly' attributes found</p>";
    }
    
    // Check input type
    if (strpos($template_content, 'type="text"') !== false) {
        echo "<p class='success'>✅ Input type is 'text' (correct)</p>";
    } else if (strpos($template_content, 'type="url"') !== false) {
        echo "<p class='warning'>⚠️ Input type is 'url' (might cause issues)</p>";
    }
    
    // Extract the callback URL field HTML
    $pattern = '/<input[^>]*name="callback_url"[^>]*>/';
    if (preg_match($pattern, $template_content, $matches)) {
        echo "<h3>🔍 Callback URL Field HTML:</h3>";
        echo "<div class='code'>" . htmlspecialchars($matches[0]) . "</div>";
    }
    
    // Extract the timeout URL field HTML
    $pattern = '/<input[^>]*name="timeout_url"[^>]*>/';
    if (preg_match($pattern, $template_content, $matches)) {
        echo "<h3>🔍 Timeout URL Field HTML:</h3>";
        echo "<div class='code'>" . htmlspecialchars($matches[0]) . "</div>";
    }
    
} else {
    echo "<p class='error'>❌ Template file not found: $template_path</p>";
}

// Check PHP handler file
$php_path = __DIR__ . '/system/paymentgateway/Daraja.php';
echo "<h2>🐘 PHP Handler Check:</h2>";

if (file_exists($php_path)) {
    echo "<p class='success'>✅ PHP handler exists: $php_path</p>";
    
    $php_content = file_get_contents($php_path);
    
    // Check if it handles callback_url
    if (strpos($php_content, '_post(\'callback_url\')') !== false) {
        echo "<p class='success'>✅ PHP handler processes callback_url correctly</p>";
    } else {
        echo "<p class='error'>❌ PHP handler doesn't handle callback_url</p>";
    }
    
} else {
    echo "<p class='error'>❌ PHP handler not found: $php_path</p>";
}

echo "<h2>🧪 Test Form:</h2>";
echo "<p>Below is a simple test form with the same field structure:</p>";

echo '<form method="post" style="border:1px solid #ddd; padding:20px; background:#f9f9f9; border-radius:5px;">';
echo '<h4>Test Callback URL Field:</h4>';
echo '<input type="text" name="callback_url" value="https://glintaafrica.com/?_route=callback/mpesa" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ccc;">';
echo '<h4>Test Timeout URL Field:</h4>';
echo '<input type="text" name="timeout_url" value="https://glintaafrica.com/?_route=callback/mpesa" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ccc;">';
echo '<br><button type="submit" style="padding:10px 20px; background:#28a745; color:white; border:none; border-radius:3px;">Test Submit</button>';
echo '</form>';

if ($_POST) {
    echo "<h3>📝 Form Submission Results:</h3>";
    echo "<div class='code'>";
    echo "Callback URL: " . htmlspecialchars($_POST['callback_url'] ?? 'Not received') . "<br>";
    echo "Timeout URL: " . htmlspecialchars($_POST['timeout_url'] ?? 'Not received') . "<br>";
    echo "</div>";
}

echo "<h2>🔧 Quick Fixes:</h2>";
echo "<p>If the fields still don't work:</p>";
echo "<ol>";
echo "<li><strong>Clear browser cache:</strong> Ctrl+F5 or try incognito mode</li>";
echo "<li><strong>Check browser console:</strong> F12 → Console tab for JavaScript errors</li>";
echo "<li><strong>Try different browser:</strong> Test in Chrome, Firefox, Edge</li>";
echo "<li><strong>Disable browser extensions:</strong> Some extensions block form fields</li>";
echo "</ol>";

echo "<hr>";
echo "<p><strong>Next Steps:</strong></p>";
echo "<ol>";
echo "<li>Test the form above - can you type in the fields?</li>";
echo "<li>Check your actual Daraja form at: <a href='https://glintaafrica.com/?_route=paymentgateway/Daraja' target='_blank'>https://glintaafrica.com/?_route=paymentgateway/Daraja</a></li>";
echo "<li>Report back what happens</li>";
echo "</ol>";

?>