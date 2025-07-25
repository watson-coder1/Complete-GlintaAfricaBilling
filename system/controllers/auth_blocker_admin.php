<?php
/**
 * Enhanced Authentication Blocker Admin Interface
 * Manage blocked MAC addresses and authentication controls
 * 
 * @author Glinta Africa Development Team
 * @version 1.0
 */

// Load the authentication blocker
require_once dirname(__DIR__, 2) . '/enhanced_authentication_blocker.php';

if (!Admin::getID()) {
    r2(U . "admin", 's', Lang::T("Admin authorization required"));
}

$admin = ORM::for_table('tbl_users')->find_one($_SESSION['uid']);
if (!$admin) {
    r2(U . "admin", 'e', 'Invalid admin session');
}

$ui->assign('_admin', $admin);
$ui->assign('_title', 'Authentication Blocker Management');
$ui->assign('_system_name', $config['CompanyName'] ?? 'Glinta Africa');

// Get action
$action = $routes['1'] ?? 'list';

switch ($action) {
    case 'list':
        // List all blocked MAC addresses
        $blocked_macs = ORM::for_table('tbl_blocked_mac_addresses')
            ->order_by_desc('blocked_at')
            ->find_many();
        
        // Get statistics
        $stats = EnhancedAuthenticationBlocker::getBlockingStatistics();
        
        // Get recent auth attempts
        $recent_attempts = ORM::for_table('tbl_auth_attempts')
            ->order_by_desc('attempt_time')
            ->limit(50)
            ->find_many();
        
        $ui->assign('blocked_macs', $blocked_macs);
        $ui->assign('stats', $stats);
        $ui->assign('recent_attempts', $recent_attempts);
        $ui->display('auth_blocker_admin.tpl');
        break;
        
    case 'block':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $mac_address = $_POST['mac_address'] ?? '';
            $username = $_POST['username'] ?? '';
            $reason = $_POST['reason'] ?? 'manual_block';
            $notes = $_POST['notes'] ?? '';
            $duration_hours = !empty($_POST['duration_hours']) ? intval($_POST['duration_hours']) : null;
            
            if (empty($mac_address)) {
                r2(U . 'auth_blocker_admin', 'e', 'MAC address is required');
                return;
            }
            
            $result = EnhancedAuthenticationBlocker::blockMacAddress(
                $mac_address, 
                $username ?: $mac_address, 
                $reason, 
                $notes,
                $duration_hours
            );
            
            if ($result['success']) {
                _log("Admin {$admin->username} blocked MAC {$mac_address} - Reason: {$reason}", 'Admin', $admin->id);
                r2(U . 'auth_blocker_admin', 's', "MAC address {$mac_address} has been blocked successfully");
            } else {
                r2(U . 'auth_blocker_admin', 'e', 'Failed to block MAC address: ' . ($result['error'] ?? 'Unknown error'));
            }
        } else {
            $ui->assign('_title', 'Block MAC Address');
            $ui->display('auth_blocker_block.tpl');
        }
        break;
        
    case 'unblock':
        $block_id = $routes['2'] ?? '';
        $mac_address = $_GET['mac'] ?? '';
        
        if (!empty($block_id)) {
            // Unblock by block ID
            $block = ORM::for_table('tbl_blocked_mac_addresses')->find_one($block_id);
            if (!$block) {
                r2(U . 'auth_blocker_admin', 'e', 'Block record not found');
                return;
            }
            
            $result = EnhancedAuthenticationBlocker::unblockMacAddress($block->mac_address, 'admin_unblock');
            $mac_address = $block->mac_address;
            
        } elseif (!empty($mac_address)) {
            // Unblock by MAC address
            $result = EnhancedAuthenticationBlocker::unblockMacAddress($mac_address, 'admin_unblock');
            
        } else {
            r2(U . 'auth_blocker_admin', 'e', 'Block ID or MAC address required');
            return;
        }
        
        if ($result['success']) {
            _log("Admin {$admin->username} unblocked MAC {$mac_address}", 'Admin', $admin->id);
            r2(U . 'auth_blocker_admin', 's', "MAC address {$mac_address} has been unblocked successfully");
        } else {
            r2(U . 'auth_blocker_admin', 'e', 'Failed to unblock MAC address: ' . ($result['error'] ?? 'Unknown error'));
        }
        break;
        
    case 'view':
        $block_id = $routes['2'] ?? '';
        if (empty($block_id)) {
            r2(U . 'auth_blocker_admin', 'e', 'Block ID required');
            return;
        }
        
        $block = ORM::for_table('tbl_blocked_mac_addresses')->find_one($block_id);
        if (!$block) {
            r2(U . 'auth_blocker_admin', 'e', 'Block record not found');
            return;
        }
        
        // Get auth attempts for this MAC
        $auth_attempts = ORM::for_table('tbl_auth_attempts')
            ->where('mac_address', $block->mac_address)
            ->order_by_desc('attempt_time')
            ->limit(100)
            ->find_many();
        
        // Get user recharge history
        $recharge_history = ORM::for_table('tbl_user_recharges')
            ->where('username', $block->mac_address)
            ->order_by_desc('recharged_on')
            ->order_by_desc('recharged_time')
            ->limit(20)
            ->find_many();
        
        // Get payment history
        $payment_history = ORM::for_table('tbl_payment_gateway')
            ->where('username', $block->mac_address)
            ->order_by_desc('created_date')
            ->limit(20)
            ->find_many();
        
        $ui->assign('block', $block);
        $ui->assign('auth_attempts', $auth_attempts);
        $ui->assign('recharge_history', $recharge_history);
        $ui->assign('payment_history', $payment_history);
        $ui->assign('_title', 'Block Details - ' . $block->mac_address);
        $ui->display('auth_blocker_view.tpl');
        break;
        
    case 'process_expired':
        // Process expired users and block them
        $result = EnhancedAuthenticationBlocker::processExpiredUsersForBlocking();
        
        _log("Admin {$admin->username} triggered expired user blocking process", 'Admin', $admin->id);
        
        if ($result['success']) {
            r2(U . 'auth_blocker_admin', 's', "Processed {$result['processed']} expired users for blocking");
        } else {
            r2(U . 'auth_blocker_admin', 'e', 'Failed to process expired users: ' . ($result['error'] ?? 'Unknown error'));
        }
        break;
        
    case 'cleanup':
        // Clean up old records
        $result = EnhancedAuthenticationBlocker::cleanupOldRecords();
        
        _log("Admin {$admin->username} triggered authentication blocker cleanup", 'Admin', $admin->id);
        
        if ($result['success']) {
            r2(U . 'auth_blocker_admin', 's', "Cleanup completed: {$result['expired_blocks']} blocks expired, {$result['deleted_attempts']} old attempts deleted");
        } else {
            r2(U . 'auth_blocker_admin', 'e', 'Cleanup failed: ' . ($result['error'] ?? 'Unknown error'));
        }
        break;
        
    case 'check_mac':
        // AJAX endpoint to check MAC status
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            header('Content-Type: application/json');
            
            $mac_address = $_POST['mac_address'] ?? '';
            if (empty($mac_address)) {
                echo json_encode(['error' => 'MAC address required']);
                exit;
            }
            
            $check_result = EnhancedAuthenticationBlocker::isAuthenticationBlocked($mac_address, 'admin_check');
            echo json_encode($check_result);
            exit;
        }
        break;
        
    case 'bulk_unblock':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $block_ids = $_POST['block_ids'] ?? [];
            if (empty($block_ids)) {
                r2(U . 'auth_blocker_admin', 'e', 'No blocks selected');
                return;
            }
            
            $unblocked_count = 0;
            $errors = 0;
            
            foreach ($block_ids as $block_id) {
                $block = ORM::for_table('tbl_blocked_mac_addresses')->find_one($block_id);
                if ($block && $block->status === 'active') {
                    $result = EnhancedAuthenticationBlocker::unblockMacAddress($block->mac_address, 'admin_bulk_unblock');
                    if ($result['success']) {
                        $unblocked_count++;
                    } else {
                        $errors++;
                    }
                }
            }
            
            _log("Admin {$admin->username} performed bulk unblock: {$unblocked_count} unblocked, {$errors} errors", 'Admin', $admin->id);
            
            if ($unblocked_count > 0) {
                r2(U . 'auth_blocker_admin', 's', "Bulk unblock completed: {$unblocked_count} MAC addresses unblocked" . ($errors > 0 ? ", {$errors} errors" : ""));
            } else {
                r2(U . 'auth_blocker_admin', 'e', 'No MAC addresses were unblocked');
            }
        }
        break;
        
    case 'export':
        // Export blocked MACs to CSV
        $blocked_macs = ORM::for_table('tbl_blocked_mac_addresses')
            ->order_by_desc('blocked_at')
            ->find_many();
        
        header('Content-Type: text/csv');
        header('Content-Disposition: attachment; filename="blocked_macs_' . date('Y-m-d') . '.csv"');
        
        $output = fopen('php://output', 'w');
        
        // CSV header
        fputcsv($output, [
            'MAC Address',
            'Username', 
            'Reason',
            'Status',
            'Blocked At',
            'Expires At',
            'Last Attempt',
            'Attempt Count',
            'Notes'
        ]);
        
        // CSV data
        foreach ($blocked_macs as $block) {
            fputcsv($output, [
                $block->mac_address,
                $block->username,
                $block->reason,
                $block->status,
                $block->blocked_at,
                $block->expires_at,
                $block->last_attempt,
                $block->attempt_count,
                $block->notes
            ]);
        }
        
        fclose($output);
        exit;
        
    default:
        r2(U . 'auth_blocker_admin', 'e', 'Invalid action');
}
?>