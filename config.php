<?php

// Force HTTPS since SSL certificate is installed
$protocol = "https://";
$host = $_SERVER["HTTP_HOST"];
$baseDir = rtrim(dirname($_SERVER["SCRIPT_NAME"]), "/\\");
define("APP_URL", $protocol . $host . $baseDir);

// Live, Dev, Demo
$_app_stage = "Live";

// Database SpeedRadius - Use correct root password
$db_host	    = "glinta-mysql-prod";
$db_user        = "root";
$db_pass    	= "Glinta2025!";
$db_name	    = "glinta_billing";

// Database Radius - Use same database as main app since RADIUS tables are in same DB
$radius_host	    = "glinta-mysql-prod";
$radius_user        = "root";
$radius_pass    	= "Glinta2025!";
$radius_name	    = "glinta_billing";

if($_app_stage!="Live"){
    error_reporting(E_ERROR);
    ini_set("display_errors", 1);
    ini_set("display_startup_errors", 1);
}else{
    error_reporting(E_ERROR);
    ini_set("display_errors", 0);
    ini_set("display_startup_errors", 0);
}