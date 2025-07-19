<?php
register_menu("Data Usage", true, "data_usage_admin", 'SERVICES', '');

function data_usage_admin()
{
    global $ui;
    _admin();
    $ui->assign('_title', 'Data Usage');
    $ui->assign('_system_menu', 'services');
    $admin = Admin::_info();
    $ui->assign('_admin', $admin);
    
    $search = $_POST['q'] ?? '';
    
    // Check if radius database tables exist
    if (!isRadiusTableExist('radacct')) {
        $ui->assign('has_data', false);
        $ui->assign('search', $search);
        $ui->assign('data', []);
        $ui->assign('total', 0);
        $ui->display('data_usage_admin.tpl');
        return;
    }
    
    $total = data_usage_admin_count_user_data($search);
    $data = data_usage_admin_fetch_user_data($search, 1, 50);
    
    // Process data for display
    $processed_data = [];
    foreach ($data as $row) {
        $processed_data[] = [
            'username' => $row->username,
            'downloaded' => data_usage_admin_convert_bytes($row->acctinputoctets),
            'uploaded' => data_usage_admin_convert_bytes($row->acctoutputoctets),
            'total' => data_usage_admin_convert_bytes($row->acctinputoctets + $row->acctoutputoctets),
            'status' => empty($row->acctstoptime) ? 'Connected' : 'Disconnected',
            'status_class' => empty($row->acctstoptime) ? 'success' : 'danger',
            'date' => $row->acctstarttime ?? 'N/A'
        ];
    }
    
    $ui->assign('has_data', $total > 0);
    $ui->assign('search', $search);
    $ui->assign('data', $processed_data);
    $ui->assign('total', $total);
    $ui->display('data_usage_admin.tpl');
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