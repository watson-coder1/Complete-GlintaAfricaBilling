<?php

/**
 * RADIUS Management System
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * Handles automatic RADIUS user management, session expiry, and Mikrotik integration
 */

class RadiusManager
{
    /**
     * Create RADIUS user for hotspot service
     */
    public static function createHotspotUser($username, $password, $plan, $expiration_time = null)
    {
        global $config;
        
        if (defined('CAPTIVE_PORTAL_DEBUG_MODE') && CAPTIVE_PORTAL_DEBUG_MODE) {
            $UPLOAD_PATH = dirname(__DIR__, 2) . '/logs';
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " DEBUG: RADIUS_MANAGER: Attempting to CREATE user " . $username . " with expiration " . ($expiration_time ?? 'none') . "\n", FILE_APPEND);
        }
        
        if (!$config['radius_enable']) {
            return ['success' => false, 'message' => 'RADIUS is not enabled'];
        }
        
        try {
            // Remove existing entries for this user
            self::removeRadiusUser($username);
            
            // Create password entry for both CHAP and PAP authentication
            $radcheck = ORM::for_table('radcheck', 'radius')->create();
            $radcheck->username = $username;
            $radcheck->attribute = 'Cleartext-Password';
            $radcheck->op = ':=';
            $radcheck->value = $password;
            $radcheck->save();
            
            // For MAC-based authentication, we still need Auth-Type Accept
            // but only for users who have paid (this is created per paid user)
            $authtype = ORM::for_table('radcheck', 'radius')->create();
            $authtype->username = $username;
            $authtype->attribute = 'Auth-Type';
            $authtype->op = ':=';
            $authtype->value = 'Accept';
            $authtype->save();
            
            // Add simultaneous use limit
            $simultaneous = ORM::for_table('radcheck', 'radius')->create();
            $simultaneous->username = $username;
            $simultaneous->attribute = 'Simultaneous-Use';
            $simultaneous->op = ':=';
            $simultaneous->value = '1';
            $simultaneous->save();
            
            // Add session timeout if plan has time limit
            if ($plan && $plan->typebp == 'Limited' && $plan->limit_type == 'Time_Limit') {
                $timeout_seconds = $plan->time_limit * ($plan->time_unit == 'Hrs' ? 3600 : 60);
                
                $session_timeout = ORM::for_table('radcheck', 'radius')->create();
                $session_timeout->username = $username;
                $session_timeout->attribute = 'Session-Timeout';
                $session_timeout->op = ':=';
                $session_timeout->value = $timeout_seconds;
                $session_timeout->save();
            }
            
            // Add data limit if applicable
            if ($plan && $plan->typebp == 'Limited' && $plan->limit_type == 'Data_Limit') {
                $data_limit = $plan->data_limit * 1048576; // Convert MB to bytes
                
                $data_check = ORM::for_table('radcheck', 'radius')->create();
                $data_check->username = $username;
                $data_check->attribute = 'Max-Octets';
                $data_check->op = ':=';
                $data_check->value = $data_limit;
                $data_check->save();
            }
            
            // Add bandwidth limits (radreply)
            if ($plan) {
                $bandwidth = ORM::for_table('tbl_bandwidth')->find_one($plan->id_bw);
                if ($bandwidth) {
                    self::addBandwidthLimits($username, $bandwidth);
                }
            }
            
            // Add expiration time
            if ($expiration_time) {
                $expiry = ORM::for_table('radcheck', 'radius')->create();
                $expiry->username = $username;
                $expiry->attribute = 'Expiration';
                $expiry->op = ':=';
                $expiry->value = date('M j Y H:i:s', strtotime($expiration_time));
                $expiry->save();
            }
            
            _log("RADIUS hotspot user created: {$username}", 'RADIUS', 0);
            
            if (defined('CAPTIVE_PORTAL_DEBUG_MODE') && CAPTIVE_PORTAL_DEBUG_MODE) {
                $UPLOAD_PATH = dirname(__DIR__, 2) . '/logs';
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " DEBUG: RADIUS_MANAGER: User " . $username . " CREATION completed successfully\n", FILE_APPEND);
            }
            
            return ['success' => true, 'message' => 'RADIUS user created successfully'];
            
        } catch (Exception $e) {
            _log("RADIUS user creation failed: " . $e->getMessage(), 'RADIUS', 0);
            return ['success' => false, 'message' => 'Failed to create RADIUS user: ' . $e->getMessage()];
        }
    }
    
    /**
     * Add bandwidth limits to RADIUS user
     */
    public static function addBandwidthLimits($username, $bandwidth)
    {
        try {
            // Download speed limit
            $download_speed = $bandwidth->rate_down;
            if ($bandwidth->rate_down_unit == 'Mbps') {
                $download_speed *= 1000000;
            } else {
                $download_speed *= 1000;
            }
            
            $dl_reply = ORM::for_table('radreply', 'radius')->create();
            $dl_reply->username = $username;
            $dl_reply->attribute = 'WISPr-Bandwidth-Max-Down';
            $dl_reply->op = ':=';
            $dl_reply->value = $download_speed;
            $dl_reply->save();
            
            // Upload speed limit
            $upload_speed = $bandwidth->rate_up;
            if ($bandwidth->rate_up_unit == 'Mbps') {
                $upload_speed *= 1000000;
            } else {
                $upload_speed *= 1000;
            }
            
            $ul_reply = ORM::for_table('radreply', 'radius')->create();
            $ul_reply->username = $username;
            $ul_reply->attribute = 'WISPr-Bandwidth-Max-Up';
            $ul_reply->op = ':=';
            $ul_reply->value = $upload_speed;
            $ul_reply->save();
            
            return true;
            
        } catch (Exception $e) {
            _log("Failed to add bandwidth limits: " . $e->getMessage(), 'RADIUS', 0);
            return false;
        }
    }
    
    /**
     * Remove RADIUS user completely
     */
    public static function removeRadiusUser($username)
    {
        if (defined('CAPTIVE_PORTAL_DEBUG_MODE') && CAPTIVE_PORTAL_DEBUG_MODE) {
            $UPLOAD_PATH = dirname(__DIR__, 2) . '/logs';
            
            // Get stack trace to see what called this function
            $backtrace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 3);
            $caller = isset($backtrace[1]) ? $backtrace[1]['file'] . ':' . $backtrace[1]['line'] : 'unknown';
            $function = isset($backtrace[1]) ? ($backtrace[1]['function'] ?? 'unknown') : 'unknown';
            
            file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                date('Y-m-d H:i:s') . " DEBUG: RADIUS_MANAGER: Attempting to REMOVE user " . $username . " - CALLED FROM: " . $caller . " in function: " . $function . "\n", FILE_APPEND);
        }
        
        try {
            // Remove from radcheck
            ORM::for_table('radcheck', 'radius')
                ->where('username', $username)
                ->delete_many();
            
            // Remove from radreply
            ORM::for_table('radreply', 'radius')
                ->where('username', $username)
                ->delete_many();
            
            // Remove from radgroupcheck
            ORM::for_table('radgroupcheck', 'radius')
                ->where('groupname', $username)
                ->delete_many();
            
            // Remove from radgroupreply
            ORM::for_table('radgroupreply', 'radius')
                ->where('groupname', $username)
                ->delete_many();
            
            // Remove from radusergroup
            ORM::for_table('radusergroup', 'radius')
                ->where('username', $username)
                ->delete_many();
            
            _log("RADIUS user removed: {$username}", 'RADIUS', 0);
            
            if (defined('CAPTIVE_PORTAL_DEBUG_MODE') && CAPTIVE_PORTAL_DEBUG_MODE) {
                $UPLOAD_PATH = dirname(__DIR__, 2) . '/logs';
                file_put_contents($UPLOAD_PATH . '/captive_portal_debug.log', 
                    date('Y-m-d H:i:s') . " DEBUG: RADIUS_MANAGER: User " . $username . " REMOVAL completed\n", FILE_APPEND);
            }
            
            return true;
            
        } catch (Exception $e) {
            _log("Failed to remove RADIUS user: " . $e->getMessage(), 'RADIUS', 0);
            return false;
        }
    }
    
    /**
     * Check if RADIUS user exists and is active
     */
    public static function isRadiusUserActive($username)
    {
        try {
            $user = ORM::for_table('radcheck', 'radius')
                ->where('username', $username)
                ->where('attribute', 'Cleartext-Password')
                ->find_one();
            
            if (!$user) {
                return false;
            }
            
            // Check if user has active session
            $session = ORM::for_table('radacct', 'radius')
                ->where('username', $username)
                ->where_null('acctstoptime')
                ->find_one();
            
            return $session ? true : false;
            
        } catch (Exception $e) {
            return false;
        }
    }
    
    /**
     * Get active RADIUS sessions
     */
    public static function getActiveSessions($limit = 100)
    {
        try {
            $sessions = ORM::for_table('radacct', 'radius')
                ->where_null('acctstoptime')
                ->order_by_desc('acctstarttime')
                ->limit($limit)
                ->find_many();
            
            return $sessions;
            
        } catch (Exception $e) {
            return [];
        }
    }
    
    /**
     * Disconnect user session (send COA)
     */
    public static function disconnectUser($username, $nasipaddress = null)
    {
        try {
            // Find active session
            $session = ORM::for_table('radacct', 'radius')
                ->where('username', $username)
                ->where_null('acctstoptime')
                ->find_one();
            
            if (!$session) {
                return ['success' => false, 'message' => 'No active session found'];
            }
            
            // Mark session as stopped in database
            $session->acctstoptime = date('Y-m-d H:i:s');
            $session->acctterminatecause = 'Admin-Reset';
            $session->save();
            
            // TODO: Send actual COA packet to NAS if needed
            // For now, we rely on session timeout or manual disconnect
            
            _log("User session disconnected: {$username}", 'RADIUS', 0);
            
            return ['success' => true, 'message' => 'User disconnected successfully'];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => 'Failed to disconnect user: ' . $e->getMessage()];
        }
    }
    
    /**
     * Process expired users automatically
     */
    public static function processExpiredUsers()
    {
        try {
            // Get expired user recharges (include time, not just date)
            $expired_recharges = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where_lt('expiration', date('Y-m-d H:i:s'))
                ->find_many();
            
            $processed = 0;
            
            foreach ($expired_recharges as $recharge) {
                // Mark as expired
                $recharge->status = 'off';
                $recharge->save();
                
                // Remove from RADIUS if hotspot
                if ($recharge->type == 'Hotspot') {
                    self::removeRadiusUser($recharge->username);
                    
                    // Disconnect active session
                    self::disconnectUser($recharge->username);
                }
                
                // Update customer status if PPPoE
                if ($recharge->type == 'PPPOE') {
                    $customer = ORM::for_table('tbl_customers')
                        ->where('username', $recharge->username)
                        ->find_one();
                    
                    if ($customer) {
                        $customer->status = 'Expired';
                        $customer->save();
                    }
                }
                
                $processed++;
                
                _log("Expired user processed: {$recharge->username}", 'RADIUS', 0);
            }
            
            return ['success' => true, 'processed' => $processed];
            
        } catch (Exception $e) {
            _log("Error processing expired users: " . $e->getMessage(), 'RADIUS', 0);
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Generate secure random password
     */
    public static function generatePassword($length = 8)
    {
        $charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $password = '';
        
        for ($i = 0; $i < $length; $i++) {
            $password .= $charset[random_int(0, strlen($charset) - 1)];
        }
        
        return $password;
    }
    
    /**
     * Get user session statistics
     */
    public static function getUserStats($username, $days = 30)
    {
        try {
            $stats = ORM::for_table('radacct', 'radius')
                ->where('username', $username)
                ->where_gte('acctstarttime', date('Y-m-d H:i:s', strtotime("-{$days} days")))
                ->find_many();
            
            $total_sessions = count($stats);
            $total_time = 0;
            $total_download = 0;
            $total_upload = 0;
            
            foreach ($stats as $session) {
                $total_time += $session->acctsessiontime ?? 0;
                $total_download += $session->acctinputoctets ?? 0;
                $total_upload += $session->acctoutputoctets ?? 0;
            }
            
            return [
                'username' => $username,
                'total_sessions' => $total_sessions,
                'total_time' => $total_time,
                'total_download' => $total_download,
                'total_upload' => $total_upload,
                'total_data' => $total_download + $total_upload
            ];
            
        } catch (Exception $e) {
            return null;
        }
    }
    
    /**
     * Clean old accounting records
     */
    public static function cleanOldRecords($days = 90)
    {
        try {
            $cutoff_date = date('Y-m-d H:i:s', strtotime("-{$days} days"));
            
            $deleted = ORM::for_table('radacct', 'radius')
                ->where_not_null('acctstoptime')
                ->where_lt('acctstoptime', $cutoff_date)
                ->delete_many();
            
            _log("Cleaned {$deleted} old RADIUS accounting records", 'RADIUS', 0);
            
            return ['success' => true, 'deleted' => $deleted];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
}