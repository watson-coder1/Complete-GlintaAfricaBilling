<?php
/**
 * About Page Controller
 */

$ui->assign('_title', 'About Us - Glinta Africa');
$ui->assign('page_type', 'landing');
$ui->assign('current_page', 'about');
$ui->assign('app_url', APP_URL);
$ui->assign('_url', APP_URL . '/?_route=');

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
    ]
];

$ui->assign('structured_data', json_encode($structuredData));
$ui->display('landing-about.tpl');
?>