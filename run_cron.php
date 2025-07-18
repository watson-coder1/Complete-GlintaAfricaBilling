<?php
// Wrapper for cron.php to fix path issues
chdir("/var/www/html");
include "init.php";
$lockFile = "$CACHE_PATH/router_monitor.lock";

if (\!is_dir($CACHE_PATH)) {
    echo "Directory \"$CACHE_PATH\" does not exist. Exiting...\n";
    exit;
}

// Include the rest of the cron.php logic
include "system/cron.php";
