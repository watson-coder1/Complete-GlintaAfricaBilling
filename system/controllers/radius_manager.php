<?php

/**
 * RADIUS Management Controller
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * Admin interface for RADIUS user management
 */

_admin();
$ui->assign('_title', 'RADIUS Management');
$ui->assign('_system_menu', 'radius');

$action = alphanumeric($routes[1]);
$ui->assign('_admin', $admin);

// Load RadiusManager
require_once 'system/autoload/RadiusManager.php';

switch ($action) {
    case 'sessions':
        // Active sessions
        $page = _get('page', 1);
        $limit = 50;
        $offset = ($page - 1) * $limit;
        
        try {
            $sessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->order_by_desc('acctstarttime')
                ->limit($limit)
                ->offset($offset)
                ->find_many();
            
            $total_sessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->count();
            
            $ui->assign('sessions', $sessions);
            $ui->assign('total_sessions', $total_sessions);
            $ui->assign('current_page', $page);
            $ui->assign('total_pages', ceil($total_sessions / $limit));
            
        } catch (Exception $e) {
            $sessions = [];
            $ui->assign('sessions', $sessions);
            $ui->assign('error', 'RADIUS database not accessible: ' . $e->getMessage());
        }
        
        $ui->assign('_title', 'Active RADIUS Sessions');
        $ui->display('radius-sessions.tpl');
        break;
        
    case 'disconnect':
        $username = alphanumeric($routes[2]);
        if ($username) {
            $result = RadiusManager::disconnectUser($username);
            if ($result['success']) {
                r2(U . 'radius_manager/sessions', 's', 'User disconnected successfully');
            } else {
                r2(U . 'radius_manager/sessions', 'e', $result['message']);
            }
        } else {
            r2(U . 'radius_manager/sessions', 'e', 'Invalid username');
        }
        break;
        
    case 'users':
        // RADIUS users management
        $search = _get('search', '');
        $query = ORM::for_table('radcheck', 'radius')
            ->where('attribute', 'Cleartext-Password')
            ->order_by_desc('id');
            
        if (!empty($search)) {
            $query->where_like('username', '%' . $search . '%');
        }
        
        try {
            $radius_users = $query->limit(50)->find_many();
            $ui->assign('radius_users', $radius_users);
            $ui->assign('search', $search);
        } catch (Exception $e) {
            $ui->assign('radius_users', []);
            $ui->assign('error', 'RADIUS database not accessible: ' . $e->getMessage());
        }
        
        $ui->assign('_title', 'RADIUS Users');
        $ui->display('radius-users.tpl');
        break;
        
    case 'delete_user':
        $username = alphanumeric($routes[2]);
        if ($username) {
            $result = RadiusManager::removeRadiusUser($username);
            if ($result) {
                r2(U . 'radius_manager/users', 's', 'RADIUS user deleted successfully');
            } else {
                r2(U . 'radius_manager/users', 'e', 'Failed to delete RADIUS user');
            }
        } else {
            r2(U . 'radius_manager/users', 'e', 'Invalid username');
        }
        break;
        
    case 'statistics':
        // RADIUS statistics
        try {
            // Active sessions count
            $active_sessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->count();
            
            // Total users in RADIUS
            $total_radius_users = ORM::for_table('radcheck', 'radius')
                ->where('attribute', 'Cleartext-Password')
                ->count();
            
            // Sessions today
            $sessions_today = ORM::for_table('radacct', 'radius')
                ->where_gte('acctstarttime', date('Y-m-d 00:00:00'))
                ->count();
            
            // Data usage today
            $data_today = ORM::for_table('radacct', 'radius')
                ->where_gte('acctstarttime', date('Y-m-d 00:00:00'))
                ->sum('acctinputoctets') + ORM::for_table('radacct', 'radius')
                ->where_gte('acctstarttime', date('Y-m-d 00:00:00'))
                ->sum('acctoutputoctets');
            
            // Top users by data usage (last 7 days)
            $top_users = ORM::for_table('radacct', 'radius')
                ->select('username')
                ->select_expr('SUM(acctinputoctets + acctoutputoctets)', 'total_data')
                ->select_expr('COUNT(*)', 'session_count')
                ->where_gte('acctstarttime', date('Y-m-d H:i:s', strtotime('-7 days')))
                ->group_by('username')
                ->order_by_desc('total_data')
                ->limit(10)
                ->find_many();
            
            $ui->assign('active_sessions', $active_sessions);
            $ui->assign('total_radius_users', $total_radius_users);
            $ui->assign('sessions_today', $sessions_today);
            $ui->assign('data_today', $data_today);
            $ui->assign('top_users', $top_users);
            
        } catch (Exception $e) {
            $ui->assign('error', 'RADIUS database not accessible: ' . $e->getMessage());
        }
        
        $ui->assign('_title', 'RADIUS Statistics');
        $ui->display('radius-statistics.tpl');
        break;
        
    case 'cleanup':
        if (_post('confirm') == 'yes') {
            $days = _post('days', 90);
            $result = RadiusManager::cleanOldRecords($days);
            
            if ($result['success']) {
                r2(U . 'radius_manager', 's', "Cleaned {$result['deleted']} old records");
            } else {
                r2(U . 'radius_manager', 'e', $result['message']);
            }
        } else {
            $ui->assign('_title', 'Cleanup Old Records');
            $ui->display('radius-cleanup.tpl');
        }
        break;
        
    case 'test_user':
        if (_post('create_test')) {
            $test_username = 'test_' . time();
            $test_password = RadiusManager::generatePassword(6);
            
            // Create simple test user (1 hour)
            $test_plan = (object)[
                'typebp' => 'Limited',
                'limit_type' => 'Time_Limit',
                'time_limit' => 1,
                'time_unit' => 'Hrs',
                'id_bw' => 1
            ];
            
            $expiration = date('Y-m-d H:i:s', strtotime('+1 hour'));
            
            $result = RadiusManager::createHotspotUser($test_username, $test_password, $test_plan, $expiration);
            
            if ($result['success']) {
                $ui->assign('test_username', $test_username);
                $ui->assign('test_password', $test_password);
                $ui->assign('success', 'Test user created successfully');
            } else {
                $ui->assign('error', 'Failed to create test user: ' . $result['message']);
            }
        }
        
        $ui->assign('_title', 'Create Test User');
        $ui->display('radius-test.tpl');
        break;
        
    default:
        // Dashboard
        try {
            // Quick stats
            $active_sessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->count();
            
            $total_users = ORM::for_table('radcheck', 'radius')
                ->where('attribute', 'Cleartext-Password')
                ->count();
            
            // Recent sessions
            $recent_sessions = ORM::for_table('radacct', 'radius')
                ->order_by_desc('acctstarttime')
                ->limit(10)
                ->find_many();
            
            // Check RADIUS cron status
            $cron_file = $UPLOAD_PATH . '/radius_cron_last_run.txt';
            $cron_last_run = file_exists($cron_file) ? file_get_contents($cron_file) : 0;
            $cron_status = (time() - $cron_last_run) < 600 ? 'running' : 'stopped'; // 10 minutes
            
            $ui->assign('active_sessions', $active_sessions);
            $ui->assign('total_users', $total_users);
            $ui->assign('recent_sessions', $recent_sessions);
            $ui->assign('cron_status', $cron_status);
            $ui->assign('cron_last_run', $cron_last_run);
            
        } catch (Exception $e) {
            $ui->assign('error', 'RADIUS database not accessible: ' . $e->getMessage());
        }
        
        $ui->assign('_title', 'RADIUS Management Dashboard');
        $ui->display('radius-dashboard.tpl');
        break;
}
?>