<?php
/**
 * Pricing Page Controller
 */

$ui->assign('_title', 'Pricing Plans - Glinta Africa');
$ui->assign('page_type', 'landing');
$ui->assign('current_page', 'pricing');
$ui->assign('app_url', APP_URL);
$ui->assign('_url', APP_URL . '/?_route=');

$structuredData = [
    '@context' => 'https://schema.org',
    '@type' => 'Organization',
    'name' => 'Glinta Africa',
    'url' => 'https://glintaafrica.com'
];

$ui->assign('structured_data', json_encode($structuredData));
$ui->display('landing-pricing.tpl');
?>