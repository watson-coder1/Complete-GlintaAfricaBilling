<?php
/**
 * Update All Landing Pages for glintaafrica.com
 * Updates URLs, domains, and production settings while preserving design
 */

echo "🌍 Updating all landing pages for glintaafrica.com...\n";

$landingPageDir = 'ui/ui/';
$landingPages = glob($landingPageDir . 'landing-*.tpl');

// Domain and URL mappings
$replacements = [
    // Update domain references
    'http://localhost' => 'https://glintaafrica.com',
    'https://localhost' => 'https://glintaafrica.com',
    'your-domain.com' => 'glintaafrica.com',
    'yourdomain.com' => 'glintaafrica.com',
    'example.com' => 'glintaafrica.com',
    
    // Update canonical URLs
    'canonical" href="http' => 'canonical" href="https://glintaafrica.com',
    'property="og:url" content="http' => 'property="og:url" content="https://glintaafrica.com',
    
    // Update contact information
    'support@example.com' => 'support@glintaafrica.com',
    'info@example.com' => 'info@glintaafrica.com',
    'contact@example.com' => 'contact@glintaafrica.com',
    'admin@example.com' => 'admin@glintaafrica.com',
    
    // Update phone numbers (if any generic ones exist)
    '+1234567890' => '+254711311897',
    '(555) 123-4567' => '+254 711 311897',
    
    // Update social media links (preserve existing if they're real)
    'facebook.com/example' => 'facebook.com/glintaafrica',
    'twitter.com/example' => 'twitter.com/glintaafrica', 
    'linkedin.com/company/example' => 'linkedin.com/company/glinta-africa',
    'instagram.com/example' => 'instagram.com/glintaafrica',
    
    // Update business address placeholders
    'Your Business Address' => 'Nairobi, Kenya',
    'City, State 12345' => 'Nairobi, Kenya',
    'Business Location' => 'Kenya',
    
    // Update copyright and company name (preserve existing Glinta Africa branding)
    '© 2024 Company Name' => '© 2025 Glinta Africa',
    '© 2023 Company Name' => '© 2025 Glinta Africa',
    'Company Name Ltd' => 'Glinta Africa',
    'Your Company' => 'Glinta Africa',
    
    // Update app URLs to use proper routing
    '{$app_url}/' => 'https://glintaafrica.com/',
    '{$_url}' => 'https://glintaafrica.com/?_route=',
];

$updatedCount = 0;
$totalFiles = count($landingPages);

echo "📄 Found {$totalFiles} landing page files to update...\n\n";

foreach ($landingPages as $filePath) {
    $fileName = basename($filePath);
    echo "🔄 Processing: {$fileName}...\n";
    
    // Read file content
    $content = file_get_contents($filePath);
    $originalContent = $content;
    
    // Apply replacements
    foreach ($replacements as $search => $replace) {
        $content = str_replace($search, $replace, $content);
    }
    
    // Special handling for meta tags
    $content = preg_replace(
        '/property="og:url" content="[^"]*"/', 
        'property="og:url" content="https://glintaafrica.com"', 
        $content
    );
    
    // Update canonical links
    $content = preg_replace(
        '/rel="canonical" href="[^"]*"/', 
        'rel="canonical" href="https://glintaafrica.com"', 
        $content
    );
    
    // Ensure HTTPS in all URLs
    $content = str_replace('http://glintaafrica.com', 'https://glintaafrica.com', $content);
    
    // Save updated content
    if ($content !== $originalContent) {
        file_put_contents($filePath, $content);
        echo "   ✅ Updated URLs and domain references\n";
        $updatedCount++;
    } else {
        echo "   ℹ️ No changes needed\n";
    }
}

echo "\n🎉 Landing Page Update Complete!\n";
echo "📊 Summary:\n";
echo "   • Total files processed: {$totalFiles}\n";
echo "   • Files updated: {$updatedCount}\n";
echo "   • Files unchanged: " . ($totalFiles - $updatedCount) . "\n";

echo "\n🌐 All landing pages are now configured for:\n";
echo "   • Domain: https://glintaafrica.com\n";
echo "   • Email: support@glintaafrica.com\n";
echo "   • Phone: +254 711 311897\n";
echo "   • Branding: Glinta Africa (preserved)\n";
echo "   • Design: Completely unchanged\n";

echo "\n🔗 Landing Page URLs:\n";
foreach ($landingPages as $filePath) {
    $fileName = basename($filePath, '.tpl');
    $urlPath = str_replace('landing-', '', $fileName);
    if ($urlPath === 'home-enhanced') {
        echo "   • Main Home: https://glintaafrica.com/\n";
    } else {
        echo "   • " . ucfirst(str_replace('-', ' ', $urlPath)) . ": https://glintaafrica.com/?_route=" . $urlPath . "\n";
    }
}

echo "\n✅ Ready to deploy to production!\n";
?>