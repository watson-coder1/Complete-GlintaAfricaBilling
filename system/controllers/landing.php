<?php

/**
 * Landing Pages Controller
 * Handles all landing page routes for glintaafrica.com
 */

$action = $routes['1'] ?? 'home-enhanced';

// Map of routes to template files
$landingPages = [
    'home' => 'landing-home.tpl',
    'home-enhanced' => 'landing-home-enhanced.tpl',
    'about' => 'landing-about.tpl',
    'services' => 'landing-services.tpl',
    'services-enhanced' => 'landing-services-enhanced.tpl',
    'features' => 'landing-features.tpl',
    'pricing' => 'landing-pricing.tpl',
    'enterprise' => 'landing-enterprise.tpl',
    'professional' => 'landing-professional.tpl',
    'professional-real' => 'landing-professional-real.tpl',
    'contact' => 'landing-contact.tpl',
    'help' => 'landing-help.tpl',
    'documentation' => 'landing-documentation.tpl',
    'security' => 'landing-security.tpl',
    'blog' => 'landing-blog.tpl',
    'blog-article' => 'landing-blog-article.tpl',
    'community' => 'landing-community.tpl',
    'privacy' => 'landing-privacy.tpl',
    'terms' => 'landing-terms.tpl',
    'simple' => 'landing-simple.tpl',
    'stable' => 'landing-stable.tpl',
    'final' => 'landing-final.tpl'
];

// Set page-specific titles
$pageTitles = [
    'home' => 'Glinta Africa - Transforming Internet Access Across Africa',
    'home-enhanced' => 'Glinta Africa - Powering Africa\'s Digital Revolution',
    'about' => 'About Us - Glinta Africa',
    'services' => 'Our Services - Glinta Africa',
    'services-enhanced' => 'Premium Services - Glinta Africa', 
    'features' => 'Features - Glinta Africa',
    'pricing' => 'Pricing Plans - Glinta Africa',
    'enterprise' => 'Enterprise Solutions - Glinta Africa',
    'professional' => 'Professional Packages - Glinta Africa',
    'professional-real' => 'Professional Solutions - Glinta Africa',
    'contact' => 'Contact Us - Glinta Africa',
    'help' => 'Help & Support - Glinta Africa',
    'documentation' => 'Documentation - Glinta Africa',
    'security' => 'Security Features - Glinta Africa',
    'blog' => 'Blog - Glinta Africa',
    'blog-article' => 'Blog Article - Glinta Africa',
    'community' => 'Community - Glinta Africa',
    'privacy' => 'Privacy Policy - Glinta Africa',
    'terms' => 'Terms of Service - Glinta Africa',
    'simple' => 'Simple Solutions - Glinta Africa',
    'stable' => 'Stable Platform - Glinta Africa',
    'final' => 'Complete Solution - Glinta Africa'
];

// Check if the requested page exists
if (isset($landingPages[$action])) {
    $templateFile = $landingPages[$action];
    $pageTitle = $pageTitles[$action] ?? 'Glinta Africa';
    
    // Set template variables
    $ui->assign('_title', $pageTitle);
    $ui->assign('page_type', 'landing');
    $ui->assign('current_page', $action);
    $ui->assign('app_url', 'https://glintaafrica.com');
    $ui->assign('_url', 'https://glintaafrica.com/?_route=');
    
    // Add structured data for SEO
    $structuredData = [
        '@context' => 'https://schema.org',
        '@type' => 'Organization',
        'name' => 'Glinta Africa',
        'url' => 'https://glintaafrica.com',
        'logo' => 'https://glintaafrica.com/ui/ui/images/logo.png',
        'contactPoint' => [
            '@type' => 'ContactPoint',
            'telephone' => '+254-711-311897',
            'contactType' => 'customer service',
            'email' => 'support@glintaafrica.com'
        ],
        'address' => [
            '@type' => 'PostalAddress',
            'addressCountry' => 'KE',
            'addressLocality' => 'Nairobi'
        ],
        'sameAs' => [
            'https://facebook.com/glintaafrica',
            'https://twitter.com/glintaafrica',
            'https://linkedin.com/company/glinta-africa'
        ]
    ];
    
    $ui->assign('structured_data', json_encode($structuredData));
    
    // Display the landing page
    $ui->display($templateFile);
    
} else {
    // Page not found - redirect to home
    header('Location: https://glintaafrica.com/?_route=home-enhanced');
    exit;
}

?>