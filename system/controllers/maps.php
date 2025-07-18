<?php

/**
 * Maps Controller - Kenya Interactive Map for Admin Dashboard
 * Shows hotspot locations, user statistics, and revenue analytics
 */

if (!_admin()) {
    r2(U . 'admin', 'e', Lang::T('Access_Denied'));
}

$action = $routes['1'];

switch ($action) {
    case 'kenya':
    default:
        // Kenya map with real-time statistics
        
        // Get real statistics from database
        $totalHotspots = ORM::for_table('tbl_routers')->where('enabled', 1)->count();
        
        // Get active users by service type
        $hotspotUsers = ORM::for_table('tbl_user_recharges')
            ->where('status', 'on')
            ->where('type', 'Hotspot')
            ->where_gt('expiration', date('Y-m-d H:i:s'))
            ->count();
            
        $pppoeUsers = ORM::for_table('tbl_user_recharges')
            ->where('status', 'on')
            ->where('type', 'PPPoE')
            ->where_gt('expiration', date('Y-m-d H:i:s'))
            ->count();
            
        $totalUsers = $hotspotUsers + $pppoeUsers;
        
        // Get today's revenue from M-Pesa payments
        $todayRevenue = ORM::for_table('tbl_payment_gateway')
            ->where('status', 2) // Paid
            ->where_gte('paid_date', date('Y-m-d 00:00:00'))
            ->where_lte('paid_date', date('Y-m-d 23:59:59'))
            ->sum('price');
            
        // Get this month's revenue
        $monthlyRevenue = ORM::for_table('tbl_payment_gateway')
            ->where('status', 2)
            ->where_gte('paid_date', date('Y-m-01 00:00:00'))
            ->where_lte('paid_date', date('Y-m-t 23:59:59'))
            ->sum('price');
            
        // Get regional statistics (mock data for demo - replace with real location-based queries)
        $regionalStats = [
            'nairobi' => [
                'users' => floor($totalUsers * 0.45), // 45% in Nairobi region
                'revenue' => floor($todayRevenue * 0.50), // 50% revenue from Nairobi
                'hotspots' => floor($totalHotspots * 0.40),
                'growth' => 5.2
            ],
            'mombasa' => [
                'users' => floor($totalUsers * 0.25), // 25% in Coastal region
                'revenue' => floor($todayRevenue * 0.25),
                'hotspots' => floor($totalHotspots * 0.25),
                'growth' => 3.8
            ],
            'western' => [
                'users' => floor($totalUsers * 0.20), // 20% in Western region
                'revenue' => floor($todayRevenue * 0.15),
                'hotspots' => floor($totalHotspots * 0.20),
                'growth' => 4.1
            ],
            'other' => [
                'users' => floor($totalUsers * 0.10), // 10% in other regions
                'revenue' => floor($todayRevenue * 0.10),
                'hotspots' => floor($totalHotspots * 0.15),
                'growth' => 2.9
            ]
        ];
        
        // Get top locations with actual data
        $topLocations = ORM::for_table('tbl_routers')
            ->select('name')
            ->select('description')
            ->select('ip_address')
            ->where('enabled', 1)
            ->order_by_desc('id')
            ->limit(10)
            ->find_many();
            
        // Calculate system uptime (mock - replace with actual monitoring)
        $systemUptime = 99.8;
        
        // Get recent activities
        $recentActivities = ORM::for_table('tbl_logs')
            ->where_gte('date', date('Y-m-d 00:00:00'))
            ->order_by_desc('date')
            ->limit(20)
            ->find_many();
            
        // Get hourly user distribution for today
        $hourlyStats = [];
        for ($hour = 0; $hour < 24; $hour++) {
            $hourStart = date('Y-m-d') . ' ' . sprintf('%02d:00:00', $hour);
            $hourEnd = date('Y-m-d') . ' ' . sprintf('%02d:59:59', $hour);
            
            $hourlyUsers = ORM::for_table('tbl_user_recharges')
                ->where('status', 'on')
                ->where_gte('recharged_on', date('Y-m-d'))
                ->where_gte('recharged_time', sprintf('%02d:00:00', $hour))
                ->where_lte('recharged_time', sprintf('%02d:59:59', $hour))
                ->count();
                
            $hourlyStats[$hour] = $hourlyUsers;
        }
        
        // Peak hour calculation
        $peakHour = array_search(max($hourlyStats), $hourlyStats);
        $peakHourFormatted = sprintf('%02d:00 - %02d:00', $peakHour, ($peakHour + 1) % 24);
        
        // Assign data to template
        $ui->assign('totalHotspots', $totalHotspots);
        $ui->assign('totalUsers', $totalUsers);
        $ui->assign('hotspotUsers', $hotspotUsers);
        $ui->assign('pppoeUsers', $pppoeUsers);
        $ui->assign('todayRevenue', $todayRevenue);
        $ui->assign('monthlyRevenue', $monthlyRevenue);
        $ui->assign('regionalStats', $regionalStats);
        $ui->assign('topLocations', $topLocations);
        $ui->assign('systemUptime', $systemUptime);
        $ui->assign('recentActivities', $recentActivities);
        $ui->assign('hourlyStats', $hourlyStats);
        $ui->assign('peakHour', $peakHourFormatted);
        
        $ui->assign('_title', 'Kenya Coverage Map - Glinta Africa');
        $ui->assign('_system_menu', 'maps');
        $ui->display('admin/maps/kenya.tpl');
        break;
        
    case 'api':
        // API endpoint for real-time data updates
        header('Content-Type: application/json');
        
        $timePeriod = $_GET['period'] ?? 'today';
        $serviceType = $_GET['service'] ?? 'all';
        
        // Build query based on filters
        $query = ORM::for_table('tbl_user_recharges')
            ->where('status', 'on')
            ->where_gt('expiration', date('Y-m-d H:i:s'));
            
        if ($serviceType !== 'all') {
            $query->where('type', $serviceType);
        }
        
        // Time period filter
        switch ($timePeriod) {
            case 'today':
                $query->where_gte('recharged_on', date('Y-m-d'));
                break;
            case 'week':
                $query->where_gte('recharged_on', date('Y-m-d', strtotime('-7 days')));
                break;
            case 'month':
                $query->where_gte('recharged_on', date('Y-m-01'));
                break;
            case 'year':
                $query->where_gte('recharged_on', date('Y-01-01'));
                break;
        }
        
        $activeUsers = $query->count();
        
        // Get revenue for the same period
        $revenueQuery = ORM::for_table('tbl_payment_gateway')
            ->where('status', 2);
            
        switch ($timePeriod) {
            case 'today':
                $revenueQuery->where_gte('paid_date', date('Y-m-d 00:00:00'))
                           ->where_lte('paid_date', date('Y-m-d 23:59:59'));
                break;
            case 'week':
                $revenueQuery->where_gte('paid_date', date('Y-m-d 00:00:00', strtotime('-7 days')));
                break;
            case 'month':
                $revenueQuery->where_gte('paid_date', date('Y-m-01 00:00:00'))
                           ->where_lte('paid_date', date('Y-m-t 23:59:59'));
                break;
            case 'year':
                $revenueQuery->where_gte('paid_date', date('Y-01-01 00:00:00'))
                           ->where_lte('paid_date', date('Y-12-31 23:59:59'));
                break;
        }
        
        $revenue = $revenueQuery->sum('price') ?: 0;
        
        // Get hotspot count
        $hotspotCount = ORM::for_table('tbl_routers')->where('enabled', 1)->count();
        
        // Calculate uptime (mock for now)
        $uptime = 99.8 + (rand(-5, 5) / 100); // ±0.05% variation
        $uptime = max(99.0, min(100.0, $uptime));
        
        echo json_encode([
            'success' => true,
            'data' => [
                'users' => $activeUsers,
                'revenue' => $revenue,
                'hotspots' => $hotspotCount,
                'uptime' => round($uptime, 1),
                'period' => $timePeriod,
                'service' => $serviceType,
                'timestamp' => time()
            ]
        ]);
        exit;
        
    case 'location':
        // Get detailed location information
        header('Content-Type: application/json');
        
        $locationName = $_GET['name'] ?? '';
        $routerId = $_GET['router_id'] ?? 0;
        
        if ($locationName || $routerId) {
            $router = null;
            
            if ($routerId) {
                $router = ORM::for_table('tbl_routers')->find_one($routerId);
            } else {
                $router = ORM::for_table('tbl_routers')
                    ->where_like('name', '%' . $locationName . '%')
                    ->find_one();
            }
            
            if ($router) {
                // Get users for this router
                $users = ORM::for_table('tbl_user_recharges')
                    ->where('status', 'on')
                    ->where('routers', $router->id)
                    ->where_gt('expiration', date('Y-m-d H:i:s'))
                    ->count();
                    
                // Get revenue for this router today
                $revenue = ORM::for_table('tbl_payment_gateway')
                    ->join('tbl_user_recharges', 'tbl_payment_gateway.username = tbl_user_recharges.username')
                    ->where('tbl_payment_gateway.status', 2)
                    ->where('tbl_user_recharges.routers', $router->id)
                    ->where_gte('tbl_payment_gateway.paid_date', date('Y-m-d 00:00:00'))
                    ->sum('tbl_payment_gateway.price');
                    
                echo json_encode([
                    'success' => true,
                    'location' => [
                        'id' => $router->id,
                        'name' => $router->name,
                        'description' => $router->description,
                        'ip_address' => $router->ip_address,
                        'users' => $users,
                        'revenue' => $revenue ?: 0,
                        'status' => $router->enabled ? 'Online' : 'Offline',
                        'last_seen' => date('Y-m-d H:i:s')
                    ]
                ]);
            } else {
                echo json_encode([
                    'success' => false,
                    'message' => 'Location not found'
                ]);
            }
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Location name or router ID required'
            ]);
        }
        exit;
}

?>