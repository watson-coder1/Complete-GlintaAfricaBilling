<?php

// Include the configuration file
include('/var/www/html/config.php');

register_menu("Radius NAS Status", true, "nas_status", 'RADIUS', '');

function nas_status()
{
    global $ui;

    // Ensure the admin is logged in
    _admin();

    // Use the database credentials defined in config.php
    global $db_host, $db_user, $db_password, $db_name;

    // Initialize database connection
    $conn = new mysqli($db_host, $db_user, $db_password, $db_name);

    // Check for database connection error
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $ui->assign('_title', 'Radius NAS Status');
    $ui->assign('_system_menu', 'radius');
    $admin = Admin::_info();
    $ui->assign('_admin', $admin);

    // Query to fetch data from the nas table
    $sql = "SELECT id, nasname, shortname FROM nas";
    $result = $conn->query($sql);

    $nasData = array();
    $onlineCount = 0;
    $offlineCount = 0;

    if ($result->num_rows > 0) {
        // Fetch each row and store it in the nasData array
        while ($row = $result->fetch_assoc()) {
            // Add a status field for each NAS
            $status = (pingNas($row['nasname'])) ? 'online' : 'offline';
            if ($status == 'online') {
                $onlineCount++;
            } else {
                $offlineCount++;
            }
            $nasData[] = array(
                'id' => $row['id'],
                'nasname' => $row['nasname'],
                'shortname' => $row['shortname'],
                'status' => $status
            );
        }
    } else {
        $ui->assign('nasData', array());
    }

    $ui->assign('nasData', $nasData);
    $ui->assign('onlineCount', $onlineCount);
    $ui->assign('offlineCount', $offlineCount);
    $ui->assign('nasStatusSummary', "$onlineCount / $offlineCount");
    $ui->display('nasstatus.tpl');

    $conn->close();
}

// Function to ping NAS and return status
function pingNas($nasIP)
{
    $pingresult = exec("ping -c 1 -w 1 $nasIP", $output, $status);
    return ($status == 0); // 0 means online, any other value means offline
}
?>
