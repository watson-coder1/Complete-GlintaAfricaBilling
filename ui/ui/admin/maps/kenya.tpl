{include file="admin/header.tpl"}

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary panel-hovered">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <i class="fa fa-map-marker"></i> Kenya Hotspot Coverage Map
                </h4>
            </div>
            <div class="panel-body">
                <!-- Map Controls -->
                <div class="row mb-3">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>View Mode:</label>
                            <select id="mapMode" class="form-control">
                                <option value="hotspots">Hotspot Locations</option>
                                <option value="users">Active Users</option>
                                <option value="revenue">Revenue by Region</option>
                                <option value="coverage">Coverage Areas</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Time Period:</label>
                            <select id="timePeriod" class="form-control">
                                <option value="today">Today</option>
                                <option value="week">This Week</option>
                                <option value="month" selected>This Month</option>
                                <option value="year">This Year</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Service Type:</label>
                            <select id="serviceType" class="form-control">
                                <option value="all">All Services</option>
                                <option value="Hotspot">Hotspot Only</option>
                                <option value="PPPoE">PPPoE Only</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>&nbsp;</label>
                            <button id="refreshMap" class="btn btn-success btn-block">
                                <i class="fa fa-refresh"></i> Refresh Data
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Kenya Map Container -->
                <div class="map-container" style="position: relative; height: 600px; background: #f8f9fa; border-radius: 10px; overflow: hidden;">
                    <div id="kenyaMap" style="width: 100%; height: 100%; position: relative;">
                        <!-- Kenya SVG Map -->
                        <svg viewBox="0 0 800 600" style="width: 100%; height: 100%;">
                            <!-- Kenya Border Path -->
                            <path id="kenyaBorder" d="M300 100 L500 120 L520 140 L540 180 L560 220 L550 280 L520 320 L480 350 L420 380 L380 400 L340 420 L300 430 L260 420 L220 400 L180 380 L160 350 L150 320 L140 280 L160 240 L180 200 L200 160 L220 120 L260 100 Z" 
                                  fill="#e8f5e8" 
                                  stroke="#28a745" 
                                  stroke-width="2"/>
                            
                            <!-- Major Cities -->
                            <g id="cities">
                                <!-- Nairobi -->
                                <circle cx="380" cy="320" r="8" fill="#dc3545" class="city-marker" data-city="Nairobi" data-users="45000" data-revenue="1250000"/>
                                <text x="390" y="315" fill="#333" font-size="12" font-weight="bold">Nairobi</text>
                                
                                <!-- Mombasa -->
                                <circle cx="480" cy="360" r="6" fill="#007bff" class="city-marker" data-city="Mombasa" data-users="18000" data-revenue="450000"/>
                                <text x="490" y="355" fill="#333" font-size="11">Mombasa</text>
                                
                                <!-- Kisumu -->
                                <circle cx="280" cy="300" r="5" fill="#ffc107" class="city-marker" data-city="Kisumu" data-users="8500" data-revenue="180000"/>
                                <text x="290" y="295" fill="#333" font-size="10">Kisumu</text>
                                
                                <!-- Nakuru -->
                                <circle cx="340" cy="280" r="4" fill="#6f42c1" class="city-marker" data-city="Nakuru" data-users="6200" data-revenue="125000"/>
                                <text x="350" y="275" fill="#333" font-size="10">Nakuru</text>
                                
                                <!-- Eldoret -->
                                <circle cx="320" cy="240" r="4" fill="#20c997" class="city-marker" data-city="Eldoret" data-users="5800" data-revenue="110000"/>
                                <text x="330" y="235" fill="#333" font-size="10">Eldoret</text>
                                
                                <!-- Thika -->
                                <circle cx="390" cy="300" r="3" fill="#fd7e14" class="city-marker" data-city="Thika" data-users="3200" data-revenue="75000"/>
                                <text x="400" y="295" fill="#333" font-size="9">Thika</text>
                                
                                <!-- Machakos -->
                                <circle cx="400" cy="340" r="3" fill="#e83e8c" class="city-marker" data-city="Machakos" data-users="2800" data-revenue="60000"/>
                                <text x="410" y="335" fill="#333" font-size="9">Machakos</text>
                            </g>
                            
                            <!-- Coverage Areas (circles showing range) -->
                            <g id="coverageAreas" style="display: none;">
                                <circle cx="380" cy="320" r="40" fill="rgba(40, 167, 69, 0.3)" stroke="#28a745" stroke-width="1" stroke-dasharray="5,5"/>
                                <circle cx="480" cy="360" r="25" fill="rgba(0, 123, 255, 0.3)" stroke="#007bff" stroke-width="1" stroke-dasharray="5,5"/>
                                <circle cx="280" cy="300" r="20" fill="rgba(255, 193, 7, 0.3)" stroke="#ffc107" stroke-width="1" stroke-dasharray="5,5"/>
                                <circle cx="340" cy="280" r="15" fill="rgba(111, 66, 193, 0.3)" stroke="#6f42c1" stroke-width="1" stroke-dasharray="5,5"/>
                                <circle cx="320" cy="240" r="15" fill="rgba(32, 201, 151, 0.3)" stroke="#20c997" stroke-width="1" stroke-dasharray="5,5"/>
                            </g>
                            
                            <!-- Hotspot Indicators -->
                            <g id="hotspotIndicators">
                                <!-- Animated pulse for active hotspots -->
                                <circle cx="380" cy="320" r="12" fill="none" stroke="#dc3545" stroke-width="2" opacity="0.8">
                                    <animate attributeName="r" values="8;16;8" dur="2s" repeatCount="indefinite"/>
                                    <animate attributeName="opacity" values="0.8;0.3;0.8" dur="2s" repeatCount="indefinite"/>
                                </circle>
                                <circle cx="480" cy="360" r="10" fill="none" stroke="#007bff" stroke-width="2" opacity="0.8">
                                    <animate attributeName="r" values="6;12;6" dur="2s" repeatCount="indefinite"/>
                                    <animate attributeName="opacity" values="0.8;0.3;0.8" dur="2s" repeatCount="indefinite"/>
                                </circle>
                            </g>
                        </svg>
                        
                        <!-- Map Overlay Info -->
                        <div id="mapInfo" style="position: absolute; top: 20px; left: 20px; background: rgba(255,255,255,0.95); padding: 15px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); min-width: 200px;">
                            <h5 style="margin: 0 0 10px 0; color: #2c3e50;">
                                <i class="fa fa-map-marker text-primary"></i> Map Overview
                            </h5>
                            <div class="row">
                                <div class="col-6">
                                    <small class="text-muted">Total Hotspots</small>
                                    <div class="h4 mb-1 text-primary" id="totalHotspots">247</div>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted">Active Users</small>
                                    <div class="h4 mb-1 text-success" id="totalUsers">89,500</div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <small class="text-muted">Revenue Today</small>
                                    <div class="h4 mb-1 text-warning" id="totalRevenue">KES 2.2M</div>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted">Uptime</small>
                                    <div class="h4 mb-1 text-info" id="systemUptime">99.8%</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Legend -->
                        <div id="mapLegend" style="position: absolute; bottom: 20px; right: 20px; background: rgba(255,255,255,0.95); padding: 15px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                            <h6 style="margin: 0 0 10px 0; color: #2c3e50;">
                                <i class="fa fa-info-circle"></i> Legend
                            </h6>
                            <div class="legend-item" style="margin-bottom: 8px;">
                                <span style="display: inline-block; width: 12px; height: 12px; background: #dc3545; border-radius: 50%; margin-right: 8px;"></span>
                                <small>Major City (10K+ Users)</small>
                            </div>
                            <div class="legend-item" style="margin-bottom: 8px;">
                                <span style="display: inline-block; width: 10px; height: 10px; background: #007bff; border-radius: 50%; margin-right: 8px;"></span>
                                <small>City (5K+ Users)</small>
                            </div>
                            <div class="legend-item" style="margin-bottom: 8px;">
                                <span style="display: inline-block; width: 8px; height: 8px; background: #ffc107; border-radius: 50%; margin-right: 8px;"></span>
                                <small>Town (1K+ Users)</small>
                            </div>
                            <div class="legend-item">
                                <span style="display: inline-block; width: 6px; height: 6px; background: #28a745; border-radius: 50%; margin-right: 8px; animation: pulse 2s infinite;"></span>
                                <small>Active Hotspot</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Regional Statistics Cards -->
<div class="row">
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3">
                        <i class="fa fa-building fa-3x text-primary"></i>
                    </div>
                    <div class="col-xs-9 text-right">
                        <div class="h2" id="nairobiUsers">45,230</div>
                        <div>Nairobi Region</div>
                        <small class="text-muted">Central Kenya</small>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <span class="pull-left">Daily Growth: +5.2%</span>
                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-info">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3">
                        <i class="fa fa-ship fa-3x text-info"></i>
                    </div>
                    <div class="col-xs-9 text-right">
                        <div class="h2" id="mombasaUsers">18,450</div>
                        <div>Coastal Region</div>
                        <small class="text-muted">Mombasa & Surroundings</small>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <span class="pull-left">Daily Growth: +3.8%</span>
                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-warning">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3">
                        <i class="fa fa-tree fa-3x text-warning"></i>
                    </div>
                    <div class="col-xs-9 text-right">
                        <div class="h2" id="westernUsers">14,780</div>
                        <div>Western Region</div>
                        <small class="text-muted">Kisumu, Eldoret & Towns</small>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <span class="pull-left">Daily Growth: +4.1%</span>
                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-success">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3">
                        <i class="fa fa-mountain fa-3x text-success"></i>
                    </div>
                    <div class="col-xs-9 text-right">
                        <div class="h2" id="otherUsers">11,040</div>
                        <div>Other Regions</div>
                        <small class="text-muted">Mt. Kenya, Northern & Eastern</small>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <span class="pull-left">Daily Growth: +2.9%</span>
                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<!-- Detailed Location Table -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <i class="fa fa-list"></i> Hotspot Locations Details
                </h4>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="locationsTable">
                        <thead>
                            <tr>
                                <th>Location</th>
                                <th>County</th>
                                <th>Active Hotspots</th>
                                <th>Online Users</th>
                                <th>Today's Revenue</th>
                                <th>Service Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="location-row" data-lat="-1.2921" data-lng="36.8219">
                                <td><strong>Nairobi CBD</strong></td>
                                <td>Nairobi</td>
                                <td><span class="badge badge-primary">45</span></td>
                                <td><span class="text-success"><strong>12,450</strong></span></td>
                                <td><span class="text-warning"><strong>KES 890,000</strong></span></td>
                                <td>
                                    <span class="label label-success">Hotspot</span>
                                    <span class="label label-info">PPPoE</span>
                                </td>
                                <td><span class="label label-success">Online</span></td>
                                <td>
                                    <button class="btn btn-xs btn-primary view-location" data-location="Nairobi CBD">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                    <button class="btn btn-xs btn-warning edit-location" data-location="Nairobi CBD">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="location-row" data-lat="-4.0435" data-lng="39.6682">
                                <td><strong>Mombasa Town</strong></td>
                                <td>Mombasa</td>
                                <td><span class="badge badge-info">28</span></td>
                                <td><span class="text-success"><strong>8,230</strong></span></td>
                                <td><span class="text-warning"><strong>KES 325,000</strong></span></td>
                                <td>
                                    <span class="label label-success">Hotspot</span>
                                </td>
                                <td><span class="label label-success">Online</span></td>
                                <td>
                                    <button class="btn btn-xs btn-primary view-location" data-location="Mombasa Town">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                    <button class="btn btn-xs btn-warning edit-location" data-location="Mombasa Town">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="location-row" data-lat="-0.0917" data-lng="34.7680">
                                <td><strong>Kisumu City</strong></td>
                                <td>Kisumu</td>
                                <td><span class="badge badge-warning">18</span></td>
                                <td><span class="text-success"><strong>5,670</strong></span></td>
                                <td><span class="text-warning"><strong>KES 180,000</strong></span></td>
                                <td>
                                    <span class="label label-success">Hotspot</span>
                                    <span class="label label-info">PPPoE</span>
                                </td>
                                <td><span class="label label-success">Online</span></td>
                                <td>
                                    <button class="btn btn-xs btn-primary view-location" data-location="Kisumu City">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                    <button class="btn btn-xs btn-warning edit-location" data-location="Kisumu City">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="location-row" data-lat="-0.3031" data-lng="36.0800">
                                <td><strong>Nakuru Town</strong></td>
                                <td>Nakuru</td>
                                <td><span class="badge badge-success">22</span></td>
                                <td><span class="text-success"><strong>4,890</strong></span></td>
                                <td><span class="text-warning"><strong>KES 145,000</strong></span></td>
                                <td>
                                    <span class="label label-success">Hotspot</span>
                                </td>
                                <td><span class="label label-success">Online</span></td>
                                <td>
                                    <button class="btn btn-xs btn-primary view-location" data-location="Nakuru Town">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                    <button class="btn btn-xs btn-warning edit-location" data-location="Nakuru Town">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Location Detail Modal -->
<div class="modal fade" id="locationModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="locationModalTitle">
                    <i class="fa fa-map-marker"></i> Location Details
                </h4>
            </div>
            <div class="modal-body" id="locationModalBody">
                <!-- Dynamic content will be loaded here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="manageLocation">Manage Location</button>
            </div>
        </div>
    </div>
</div>

<style>
@keyframes pulse {
    0% { transform: scale(1); opacity: 1; }
    50% { transform: scale(1.1); opacity: 0.7; }
    100% { transform: scale(1); opacity: 1; }
}

.city-marker {
    cursor: pointer;
    transition: all 0.3s ease;
}

.city-marker:hover {
    stroke: #333;
    stroke-width: 2;
    transform: scale(1.2);
}

.location-row {
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.location-row:hover {
    background-color: #f5f5f5 !important;
}

.panel {
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.map-container {
    border: 2px solid #e9ecef;
}

#mapInfo, #mapLegend {
    font-family: 'Arial', sans-serif;
}

.badge {
    font-size: 11px;
    padding: 4px 8px;
}
</style>

<script>
$(document).ready(function() {
    // Initialize DataTable for locations
    $('#locationsTable').DataTable({
        "pageLength": 10,
        "order": [[ 4, "desc" ]], // Sort by revenue
        "columnDefs": [
            { "orderable": false, "targets": 7 } // Disable sorting for actions column
        ]
    });
    
    // Map mode change handler
    $('#mapMode').change(function() {
        var mode = $(this).val();
        updateMapView(mode);
    });
    
    // Time period change handler
    $('#timePeriod, #serviceType').change(function() {
        refreshMapData();
    });
    
    // Refresh map data
    $('#refreshMap').click(function() {
        $(this).html('<i class="fa fa-spinner fa-spin"></i> Refreshing...');
        setTimeout(function() {
            refreshMapData();
            $('#refreshMap').html('<i class="fa fa-refresh"></i> Refresh Data');
        }, 1500);
    });
    
    // City marker click handler
    $('.city-marker').click(function() {
        var city = $(this).data('city');
        var users = $(this).data('users');
        var revenue = $(this).data('revenue');
        
        showLocationDetails(city, users, revenue);
    });
    
    // Location row click handler
    $('.location-row').click(function() {
        var location = $(this).find('td:first strong').text();
        highlightLocationOnMap(location);
    });
    
    // View location button
    $('.view-location').click(function(e) {
        e.stopPropagation();
        var location = $(this).data('location');
        showLocationModal(location);
    });
    
    // Edit location button
    $('.edit-location').click(function(e) {
        e.stopPropagation();
        var location = $(this).data('location');
        editLocation(location);
    });
    
    // Real-time updates every 30 seconds
    setInterval(function() {
        updateRealTimeStats();
    }, 30000);
    
    // Initialize with default view
    updateMapView('hotspots');
});

function updateMapView(mode) {
    // Hide all special overlays first
    $('#coverageAreas').hide();
    $('#hotspotIndicators').show();
    
    switch(mode) {
        case 'hotspots':
            // Show hotspot locations with pulsing animation
            $('.city-marker').attr('r', function() {
                return $(this).data('users') > 20000 ? 8 :
                       $(this).data('users') > 10000 ? 6 :
                       $(this).data('users') > 5000 ? 4 : 3;
            });
            break;
            
        case 'users':
            // Scale markers by user count
            $('.city-marker').attr('r', function() {
                var users = $(this).data('users');
                return Math.max(3, Math.min(12, users / 5000));
            });
            break;
            
        case 'revenue':
            // Color markers by revenue
            $('.city-marker').attr('fill', function() {
                var revenue = $(this).data('revenue');
                return revenue > 1000000 ? '#dc3545' :
                       revenue > 500000 ? '#fd7e14' :
                       revenue > 200000 ? '#ffc107' : '#28a745';
            });
            break;
            
        case 'coverage':
            // Show coverage areas
            $('#coverageAreas').show();
            $('.city-marker').attr('r', 4).attr('fill', '#6c757d');
            break;
    }
}

function refreshMapData() {
    var timePeriod = $('#timePeriod').val();
    var serviceType = $('#serviceType').val();
    
    // Simulate API call to refresh data
    console.log('Refreshing map data for:', timePeriod, serviceType);
    
    // Update stats with real data
    updateStatistics(timePeriod, serviceType);
}

function updateStatistics(period, service) {
    // Simulate real-time data updates
    var stats = getStatistics(period, service);
    
    $('#totalHotspots').text(stats.hotspots);
    $('#totalUsers').text(stats.users.toLocaleString());
    $('#totalRevenue').text('KES ' + (stats.revenue / 1000000).toFixed(1) + 'M');
    $('#systemUptime').text(stats.uptime + '%');
    
    // Update regional stats
    $('#nairobiUsers').text(stats.regional.nairobi.toLocaleString());
    $('#mombasaUsers').text(stats.regional.mombasa.toLocaleString());
    $('#westernUsers').text(stats.regional.western.toLocaleString());
    $('#otherUsers').text(stats.regional.other.toLocaleString());
}

function getStatistics(period, service) {
    // Mock data - in production, this would come from your database
    var baseStats = {
        hotspots: 247,
        users: 89500,
        revenue: 2200000,
        uptime: 99.8,
        regional: {
            nairobi: 45230,
            mombasa: 18450,
            western: 14780,
            other: 11040
        }
    };
    
    // Adjust based on filters
    if (service === 'Hotspot') {
        baseStats.users = Math.floor(baseStats.users * 0.7);
        baseStats.revenue = Math.floor(baseStats.revenue * 0.6);
    } else if (service === 'PPPoE') {
        baseStats.users = Math.floor(baseStats.users * 0.3);
        baseStats.revenue = Math.floor(baseStats.revenue * 0.4);
    }
    
    return baseStats;
}

function showLocationDetails(city, users, revenue) {
    $('#mapInfo').html(`
        <h5 style="margin: 0 0 10px 0; color: #2c3e50;">
            <i class="fa fa-map-marker text-primary"></i> ${city}
        </h5>
        <div class="row">
            <div class="col-6">
                <small class="text-muted">Active Users</small>
                <div class="h4 mb-1 text-success">${users.toLocaleString()}</div>
            </div>
            <div class="col-6">
                <small class="text-muted">Revenue Today</small>
                <div class="h4 mb-1 text-warning">KES ${(revenue/1000).toFixed(0)}K</div>
            </div>
        </div>
        <div class="mt-2">
            <button class="btn btn-sm btn-primary" onclick="showLocationModal('${city}')">
                View Details
            </button>
        </div>
    `);
}

function highlightLocationOnMap(location) {
    // Remove previous highlights
    $('.city-marker').attr('stroke-width', '0');
    
    // Find and highlight the selected location
    $('.city-marker').each(function() {
        if ($(this).data('city') && $(this).data('city').includes(location.split(' ')[0])) {
            $(this).attr('stroke', '#333').attr('stroke-width', '3');
        }
    });
}

function showLocationModal(location) {
    $('#locationModalTitle').html('<i class="fa fa-map-marker"></i> ' + location + ' - Detailed View');
    
    var modalContent = `
        <div class="row">
            <div class="col-md-6">
                <h5>Current Statistics</h5>
                <table class="table table-condensed">
                    <tr><td>Active Hotspots:</td><td><strong>25</strong></td></tr>
                    <tr><td>Online Users:</td><td><strong>8,450</strong></td></tr>
                    <tr><td>Today's Revenue:</td><td><strong>KES 325,000</strong></td></tr>
                    <tr><td>Average Session:</td><td><strong>2.5 hours</strong></td></tr>
                    <tr><td>Peak Hours:</td><td><strong>6-9 PM</strong></td></tr>
                </table>
            </div>
            <div class="col-md-6">
                <h5>Service Distribution</h5>
                <div class="progress mb-2">
                    <div class="progress-bar progress-bar-success" style="width: 70%">
                        Hotspot (70%)
                    </div>
                </div>
                <div class="progress mb-2">
                    <div class="progress-bar progress-bar-info" style="width: 30%">
                        PPPoE (30%)
                    </div>
                </div>
                
                <h5 class="mt-3">Recent Activity</h5>
                <ul class="list-unstyled">
                    <li><i class="fa fa-circle text-success"></i> 15 new connections (last hour)</li>
                    <li><i class="fa fa-circle text-info"></i> 3 payment confirmations</li>
                    <li><i class="fa fa-circle text-warning"></i> 1 bandwidth limit reached</li>
                </ul>
            </div>
        </div>
    `;
    
    $('#locationModalBody').html(modalContent);
    $('#locationModal').modal('show');
}

function editLocation(location) {
    // Redirect to location management page
    window.location.href = '{$_url}admin/routers/edit/' + encodeURIComponent(location);
}

function updateRealTimeStats() {
    // Simulate real-time updates
    var currentUsers = parseInt($('#totalUsers').text().replace(/,/g, ''));
    var variation = Math.floor(Math.random() * 200) - 100; // ±100 users
    var newUsers = Math.max(0, currentUsers + variation);
    
    $('#totalUsers').text(newUsers.toLocaleString());
    
    // Update uptime with small variations
    var currentUptime = parseFloat($('#systemUptime').text().replace('%', ''));
    var newUptime = Math.max(99.0, Math.min(100.0, currentUptime + (Math.random() * 0.2 - 0.1)));
    $('#systemUptime').text(newUptime.toFixed(1) + '%');
}
</script>

{include file="admin/footer.tpl"}