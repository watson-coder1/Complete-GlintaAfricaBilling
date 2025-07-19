<?php
register_menu("Data Usage", true, "data_usage_admin", 'SERVICES', '');

function data_usage_admin()
{
    global $ui;
    _admin();
    $ui->assign('_title', 'User Data Usage');
    $ui->assign('_system_menu', '');
    $admin = Admin::_info();
    $ui->assign('_admin', $admin);
    
    $search = $_POST['q'] ?? '';
    
    // Check if radius database tables exist
    if (!isRadiusTableExist('radacct')) {
        echo "<div style=\"padding: 20px; font-family: Arial;\">
        <h2>User Data Usage</h2>
        <div style=\"background: #f0f8ff; padding: 15px; border-left: 4px solid #007cba;\">
        <h3>No Data Available</h3>
        <p>No data usage records found yet.</p>
        <p>Data will appear here once users start accessing the internet through your system.</p>
        </div>
        </div>";
        return;
    }
    
    $total = data_usage_admin_count_user_data($search);
    $data = data_usage_admin_fetch_user_data($search, 1, 50);

    echo "<div style=\"padding: 20px; font-family: Arial;\">
    <h2>User Data Usage</h2>
    <form method=\"POST\" style=\"margin-bottom: 20px;\">
        <input type=\"text\" name=\"q\" value=\"" . htmlspecialchars($search) . "\" placeholder=\"Search username\" style=\"padding: 8px; margin-right: 10px;\">
        <button type=\"submit\" style=\"padding: 8px 15px;\">Search</button>
    </form>";

    if ($total == 0) {
        echo "<div style=\"background: #f0f8ff; padding: 15px; border-left: 4px solid #007cba;\">
        <h3>No Data Available</h3>
        <p>No data usage records found yet.</p>
        <p>Data will appear here once users start accessing the internet through your system.</p>
        </div>";
    } else {
        echo "<p><strong>Total Records: " . $total . "</strong></p>
        <table style=\"width: 100%; border-collapse: collapse;\">
        <tr style=\"background: #f5f5f5;\">
            <th style=\"border: 1px solid #ddd; padding: 10px;\">Username</th>
            <th style=\"border: 1px solid #ddd; padding: 10px;\">Downloaded</th>
            <th style=\"border: 1px solid #ddd; padding: 10px;\">Uploaded</th>
            <th style=\"border: 1px solid #ddd; padding: 10px;\">Total Usage</th>
            <th style=\"border: 1px solid #ddd; padding: 10px;\">Status</th>
            <th style=\"border: 1px solid #ddd; padding: 10px;\">Date</th>
        </tr>";
        
        foreach ($data as $row) {
            echo "<tr>
                <td style=\"border: 1px solid #ddd; padding: 8px;\">" . htmlspecialchars($row->username) . "</td>
                <td style=\"border: 1px solid #ddd; padding: 8px;\">" . data_usage_admin_convert_bytes($row->acctinputoctets) . "</td>
                <td style=\"border: 1px solid #ddd; padding: 8px;\">" . data_usage_admin_convert_bytes($row->acctoutputoctets) . "</td>
                <td style=\"border: 1px solid #ddd; padding: 8px;\">" . data_usage_admin_convert_bytes($row->acctinputoctets + $row->acctoutputoctets) . "</td>
                <td style=\"border: 1px solid #ddd; padding: 8px;\">" . (empty($row->acctstoptime) ? '<span style=\"color: green;\">Connected</span>' : '<span style=\"color: red;\">Disconnected</span>') . "</td>
                <td style=\"border: 1px solid #ddd; padding: 8px;\">" . ($row->acctstarttime ?? 'N/A') . "</td>
            </tr>";
        }
        echo "</table>";
    }
    echo "</div>";
}

function isRadiusTableExist($table_name)
{
    try {
        // Use the radius database connection to check if table exists
        $test = ORM::for_table($table_name, 'radius')->limit(1)->find_many();
        return true;
    } catch (Exception $e) {
        return false;
    }
}

function data_usage_admin_fetch_user_data($search = '', $page = 1, $perPage = 50)
{
    try {
        $query = ORM::for_table('radacct', 'radius')->where_gt('acctoutputoctets', 0);
        
        if ($search) {
            $query->where_like('username', '%' . $search . '%');
        }
        
        $query->limit($perPage)->offset(($page - 1) * $perPage);
        $query->order_by_desc('acctstarttime');
        
        return $query->find_many();
    } catch (Exception $e) {
        return [];
    }
}

function data_usage_admin_count_user_data($search = '')
{
    try {
        $query = ORM::for_table('radacct', 'radius')->where_gt('acctoutputoctets', 0);
        
        if ($search) {
            $query->where_like('username', '%' . $search . '%');
        }
        
        return $query->count();
    } catch (Exception $e) {
        return 0;
    }
}

function data_usage_admin_convert_bytes($bytes)
{
    $bytes = floatval($bytes);
    if ($bytes >= 1073741824) {
        return number_format($bytes / 1073741824, 2) . ' GB';
    } elseif ($bytes >= 1048576) {
        return number_format($bytes / 1048576, 2) . ' MB';
    } elseif ($bytes >= 1024) {
        return number_format($bytes / 1024, 2) . ' KB';
    } else {
        return $bytes . ' bytes';
    }
}