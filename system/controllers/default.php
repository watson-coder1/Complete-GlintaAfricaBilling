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
    // Redirect to customer login
    r2(U.'login');
}
