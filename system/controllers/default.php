<?php
/**
 *  PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *  by https://t.me/ibnux
 **/

$adminId = Admin::getID();
$userId = User::getID();

if($adminId > 0){
    r2(U.'dashboard');
} elseif($userId > 0){
    r2(U.'home');
} else {
    // Show landing page for visitors
    r2(U.'landing/home-enhanced');
}
