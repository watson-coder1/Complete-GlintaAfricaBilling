{include file="sections/header.tpl"}

<style>
/* Dashboard Box Enhancements */
.small-box {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
    transition: transform 0.2s ease !important;
}

.small-box:hover {
    transform: translateY(-2px) !important;
    box-shadow: 0 6px 12px rgba(0,0,0,0.15) !important;
}

.small-box .inner h3 {
    text-shadow: 1px 1px 2px rgba(0,0,0,0.3) !important;
}

.small-box .inner p {
    text-shadow: 1px 1px 2px rgba(0,0,0,0.3) !important;
}

.small-box .icon {
    transition: transform 0.2s ease !important;
}

.small-box:hover .icon {
    transform: scale(1.1) !important;
}

/* Force color overrides */
.bg-aqua { background-color: #00c0ef !important; }
.bg-green { background-color: #00a65a !important; }
.bg-yellow { background-color: #f39c12 !important; }
.bg-red { background-color: #dd4b39 !important; }
.bg-blue { background-color: #3c8dbc !important; }
.bg-purple { background-color: #9b59b6 !important; }
</style>

<div class="row">
    {if in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-aqua" style="background-color: #00c0ef !important; min-height: 120px; padding: 20px;">
                <div class="inner">
                    <h3 class="text-bold" style="font-size: 38px; font-weight: 800; color: #fff !important; margin-bottom: 10px;"><sup style="font-size: 20px;">{$_c['currency_code']}</sup>
                        {number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</h3>
                </div>
                <div class="icon" style="font-size: 70px; opacity: 0.8;">
                    <i class="ion ion-clock"></i>
                </div>
                <a href="{$_url}reports/by-date" class="small-box-footer" style="font-size: 16px; font-weight: 600; color: #fff !important; background-color: rgba(0,0,0,0.2);">{Lang::T('Income Today')}</a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-green" style="background-color: #00a65a !important; min-height: 120px; padding: 20px;">
                <div class="inner">
                    <h3 class="text-bold" style="font-size: 38px; font-weight: 800; color: #fff !important; margin-bottom: 10px;"><sup style="font-size: 20px;">{$_c['currency_code']}</sup>
                        {number_format($imonth,0,$_c['dec_point'],$_c['thousands_sep'])}</h3>
                </div>
                <div class="icon" style="font-size: 70px; opacity: 0.8;">
                    <i class="ion ion-android-calendar"></i>
                </div>
                <a href="{$_url}reports/by-period" class="small-box-footer" style="font-size: 16px; font-weight: 600; color: #fff !important; background-color: rgba(0,0,0,0.2);">{Lang::T('Income This Month')}</a>
            </div>
        </div>
    {/if}
    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-yellow" style="background-color: #f39c12 !important; min-height: 120px; padding: 20px;">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 38px; font-weight: 800; color: #fff !important; margin-bottom: 10px;">{$u_act}/{$u_expired}</h3>
            </div>
            <div class="icon" style="font-size: 70px; opacity: 0.8;">
                <i class="ion ion-person"></i>
            </div>
            <a href="{$_url}plan/list" class="small-box-footer" style="font-size: 16px; font-weight: 600; color: #fff !important; background-color: rgba(0,0,0,0.2);">{Lang::T('Active')}/{Lang::T('Expired')}</a>
        </div>
    </div>
    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-red" style="background-color: #dd4b39 !important; min-height: 120px; padding: 20px;">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 38px; font-weight: 800; color: #fff !important; margin-bottom: 10px;">{$c_all}</h3>
            </div>
            <div class="icon" style="font-size: 70px; opacity: 0.8;">
                <i class="ion ion-android-people"></i>
            </div>
            <a href="{$_url}customers/list" class="small-box-footer" style="font-size: 16px; font-weight: 600; color: #fff !important; background-color: rgba(0,0,0,0.2);">{Lang::T('Customers')}</a>
        </div>
    </div>
</div>

<!-- Service Analytics Section - Compact Layout -->
<div class="row">
    <div class="col-md-12">
        <div class="box box-success">
            <div class="box-header with-border">
                <h3 class="box-title" style="font-size: 20px; font-weight: 600;">Service Analytics - Real Data</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-success btn-sm" data-widget="collapse">
                        <i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <!-- Service Stats Row -->
                    <div class="col-md-3">
                        <div class="small-box bg-green" onclick="window.location.href='{$_url}reports/by-date'" style="cursor: pointer; background-color: #00a65a !important; min-height: 110px; padding: 15px;">
                            <div class="inner">
                                <h3 style="font-size: 32px; font-weight: 800; color: #fff !important; margin-bottom: 8px;">{$_c['currency_code']}. {number_format($hotspot_income_today,0,$_c['dec_point'],$_c['thousands_sep'])}</h3>
                                <p style="font-size: 18px; font-weight: 600; color: #fff !important; margin: 0;">Hotspot Income</p>
                            </div>
                            <div class="icon" style="font-size: 60px; opacity: 0.8;">
                                <i class="fa fa-wifi"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="small-box bg-blue" onclick="window.location.href='{$_url}reports/by-date'" style="cursor: pointer; background-color: #3c8dbc !important; min-height: 110px; padding: 15px;">
                            <div class="inner">
                                <h3 style="font-size: 32px; font-weight: 800; color: #fff !important; margin-bottom: 8px;">{$_c['currency_code']}. {number_format($pppoe_income_today,0,$_c['dec_point'],$_c['thousands_sep'])}</h3>
                                <p style="font-size: 18px; font-weight: 600; color: #fff !important; margin: 0;">PPPoE Income</p>
                            </div>
                            <div class="icon" style="font-size: 60px; opacity: 0.8;">
                                <i class="fa fa-globe"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="small-box bg-yellow" onclick="window.location.href='{$_url}plan/list'" style="cursor: pointer; background-color: #f39c12 !important; min-height: 110px; padding: 15px;">
                            <div class="inner">
                                <h3 style="font-size: 32px; font-weight: 800; color: #fff !important; margin-bottom: 8px;">{$radius_online_hotspot}</h3>
                                <p style="font-size: 18px; font-weight: 600; color: #fff !important; margin: 0;">Hotspot Online</p>
                            </div>
                            <div class="icon" style="font-size: 60px; opacity: 0.8;">
                                <i class="fa fa-users"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="small-box bg-purple" onclick="window.location.href='{$_url}plan/list'" style="cursor: pointer; background-color: #9b59b6 !important; min-height: 110px; padding: 15px;">
                            <div class="inner">
                                <h3 style="font-size: 32px; font-weight: 800; color: #fff !important; margin-bottom: 8px;">{$pppoe_active}</h3>
                                <p style="font-size: 18px; font-weight: 600; color: #fff !important; margin: 0;">PPPoE Active</p>
                            </div>
                            <div class="icon" style="font-size: 60px; opacity: 0.8;">
                                <i class="fa fa-user"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<ol class="breadcrumb">
    <li>{Lang::dateFormat($start_date)}</li>
    <li>{Lang::dateFormat($current_date)}</li>
    {if $_c['enable_balance'] == 'yes' && in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <li onclick="window.location.href = '{$_url}customers/list?search=&order=balance&filter=Active&orderby=desc'" style="cursor: pointer; font-size: 16px; font-weight: 500;">
            {Lang::T('Customer Balance')} <sup style="font-size: 14px;">{$_c['currency_code']}</sup>
            <b style="font-size: 18px;">{number_format($cb,0,$_c['dec_point'],$_c['thousands_sep'])}</b>
        </li>
    {/if}
</ol>
<div class="row">
    <div class="col-md-7">

        <!-- solid sales graph -->
        {if $_c['hide_mrc'] != 'yes'}
            <div class="box box-solid ">
                <div class="box-header">
                    <i class="fa fa-th"></i>

                    <h3 class="box-title" style="font-size: 20px; font-weight: 600;">{Lang::T('Monthly Registered Customers')}</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn bg-teal btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <a href="{$_url}dashboard&refresh" class="btn bg-teal btn-sm"><i class="fa fa-refresh"></i>
                        </a>
                    </div>
                </div>
                <div class="box-body border-radius-none">
                    <canvas class="chart" id="chart" style="height: 250px;"></canvas>
                </div>
            </div>
        {/if}

        <!-- solid sales graph -->
        {if $_c['hide_tms'] != 'yes'}
            <div class="box box-solid ">
                <div class="box-header">
                    <i class="fa fa-inbox"></i>

                    <h3 class="box-title" style="font-size: 20px; font-weight: 600;">{Lang::T('Total Monthly Sales')}</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn bg-teal btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <a href="{$_url}dashboard&refresh" class="btn bg-teal btn-sm"><i class="fa fa-refresh"></i>
                        </a>
                    </div>
                </div>
                <div class="box-body border-radius-none">
                    <canvas class="chart" id="salesChart" style="height: 250px;"></canvas>
                </div>
            </div>
        {/if}
        {if $_c['disable_voucher'] != 'yes' && $stocks['unused']>0 || $stocks['used']>0}
            {if $_c['hide_vs'] != 'yes'}
                <div class="panel panel-primary mb20 panel-hovered project-stats table-responsive">
                    <div class="panel-heading">Vouchers Stock</div>
                    <div class="table-responsive">
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th>{Lang::T('Package Name')}</th>
                                    <th>unused</th>
                                    <th>used</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $plans as $stok}
                                    <tr>
                                        <td>{$stok['name_plan']}</td>
                                        <td>{$stok['unused']}</td>
                                        <td>{$stok['used']}</td>
                                    </tr>
                                </tbody>
                            {/foreach}
                            <tr>
                                <td>Total</td>
                                <td>{$stocks['unused']}</td>
                                <td>{$stocks['used']}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            {/if}
        {/if}
        {if $_c['hide_uet'] != 'yes'}
            <div class="panel panel-warning mb20 panel-hovered project-stats table-responsive">
                <div class="panel-heading">{Lang::T('User Expired, Today')}</div>
                <div class="table-responsive">
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <th>{Lang::T('Username')}</th>
                                <th>{Lang::T('Created / Expired')}</th>
                                <th>{Lang::T('Internet Package')}</th>
                                <th>{Lang::T('Location')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $expire as $expired}
                                {assign var="rem_exp" value="{$expired['expiration']} {$expired['time']}"}
                                {assign var="rem_started" value="{$expired['recharged_on']} {$expired['recharged_time']}"}
                                <tr>
                                    <td><a href="{$_url}customers/viewu/{$expired['username']}">{$expired['username']}</a></td>
                                    <td><small data-toggle="tooltip" data-placement="top"
                                            title="{Lang::dateAndTimeFormat($expired['recharged_on'],$expired['recharged_time'])}">{Lang::timeElapsed($rem_started)}</small>
                                        /
                                        <span data-toggle="tooltip" data-placement="top"
                                            title="{Lang::dateAndTimeFormat($expired['expiration'],$expired['time'])}">{Lang::timeElapsed($rem_exp)}</span>
                                    </td>
                                    <td>{$expired['namebp']}</td>
                                    <td>{$expired['routers']}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                &nbsp; {include file="pagination.tpl"}
            </div>
        {/if}
    </div>


    <div class="col-md-5">
        {if $_c['router_check'] && count($routeroffs)> 0}
            <div class="panel panel-danger">
                <div class="panel-heading text-bold">{Lang::T('Routers Offline')}</div>
                <div class="table-responsive">
                    <table class="table table-condensed">
                        <tbody>
                            {foreach $routeroffs as $ros}
                                <tr>
                                    <td><a href="{$_url}routers/edit/{$ros['id']}" class="text-bold text-red">{$ros['name']}</a></td>
                                    <td data-toggle="tooltip" data-placement="top" class="text-red"
                                            title="{Lang::dateTimeFormat($ros['last_seen'])}">{Lang::timeElapsed($ros['last_seen'])}
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        {/if}
        {if $run_date}
        {assign var="current_time" value=$smarty.now}
        {assign var="run_time" value=strtotime($run_date)}
        {if $current_time - $run_time > 3600}
        <div class="panel panel-cron-warning panel-hovered mb20 activities">
            <div class="panel-heading"><i class="fa fa-clock-o"></i> &nbsp; {Lang::T('Cron has not run for over 1 hour. Please
                check your setup.')}</div>
        </div>
        {else}
        <div class="panel panel-cron-success panel-hovered mb20 activities">
            <div class="panel-heading">{Lang::T('Cron Job last ran on')}: {$run_date}</div>
        </div>
        {/if}
        {else}
        <div class="panel panel-cron-danger panel-hovered mb20 activities">
            <div class="panel-heading"><i class="fa fa-warning"></i> &nbsp; {Lang::T('Cron appear not been setup, please check
                your cron setup.')}</div>
        </div>
        {/if}
        {if $_c['hide_pg'] != 'yes'}
            <div class="panel panel-success panel-hovered mb20 activities">
                <div class="panel-heading">{Lang::T('Payment Gateway')}: {str_replace(',',', ',$_c['payment_gateway'])}
                </div>
            </div>
        {/if}
        {if $_c['hide_aui'] != 'yes'}
            <div class="panel panel-info panel-hovered mb20 activities">
                <div class="panel-heading">{Lang::T('All Users Insights')}</div>
                <div class="panel-body">
                    <canvas id="userRechargesChart"></canvas>
                </div>
            </div>
        {/if}
        {if $_c['hide_al'] != 'yes'}
            <div class="panel panel-info panel-hovered mb20 activities">
                <div class="panel-heading"><a href="{$_url}logs">{Lang::T('Activity Log')}</a></div>
                <div class="panel-body">
                    <ul class="list-unstyled">
                        {foreach $dlog as $dlogs}
                            <li class="primary">
                                <span class="point"></span>
                                <span class="time small text-muted">{Lang::timeElapsed($dlogs['date'],true)}</span>
                                <p>{$dlogs['description']}</p>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {/if}
    </div>


</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>

<script type="text/javascript">
    {if $_c['hide_mrc'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                var monthlyRegisteredByService = JSON.parse('{/literal}{$monthlyRegisteredByService|json_encode}{literal}');

                var monthNames = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];

                var labels = monthNames;
                var hotspotData = [];
                var pppoeData = [];

                // Extract data for each service type
                for (var i = 0; i < 12; i++) {
                    hotspotData.push(monthlyRegisteredByService.hotspot[i] ? monthlyRegisteredByService.hotspot[i].count : 0);
                    pppoeData.push(monthlyRegisteredByService.pppoe[i] ? monthlyRegisteredByService.pppoe[i].count : 0);
                }

                var ctx = document.getElementById('chart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Hotspot Customers',
                            data: hotspotData,
                            backgroundColor: 'rgba(0, 123, 255, 0.6)',
                            borderColor: 'rgba(0, 123, 255, 1)',
                            borderWidth: 1
                        }, {
                            label: 'PPPoE Customers',
                            data: pppoeData,
                            backgroundColor: 'rgba(40, 167, 69, 0.6)',
                            borderColor: 'rgba(40, 167, 69, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                grid: {
                                    display: false
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.1)'
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top'
                            }
                        }
                    }
                });
            });
        {/literal}
    {/if}
    {if $_c['hide_tmc'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                var monthlySalesByService = JSON.parse('{/literal}{$monthlySalesByService|json_encode}{literal}');

                var monthNames = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];

                var labels = monthNames;
                var hotspotSalesData = [];
                var pppoeSalesData = [];

                // Extract data for each service type
                for (var i = 0; i < 12; i++) {
                    hotspotSalesData.push(monthlySalesByService.hotspot[i] ? monthlySalesByService.hotspot[i].totalSales : 0);
                    pppoeSalesData.push(monthlySalesByService.pppoe[i] ? monthlySalesByService.pppoe[i].totalSales : 0);
                }

                var ctx = document.getElementById('salesChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Hotspot Sales',
                            data: hotspotSalesData,
                            backgroundColor: 'rgba(255, 193, 7, 0.6)', // Yellow for Hotspot
                            borderColor: 'rgba(255, 193, 7, 1)',
                            borderWidth: 1
                        }, {
                            label: 'PPPoE Sales',
                            data: pppoeSalesData,
                            backgroundColor: 'rgba(220, 53, 69, 0.6)', // Red for PPPoE
                            borderColor: 'rgba(220, 53, 69, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                grid: {
                                    display: false
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.1)'
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top'
                            }
                        }
                    }
                });
            });
        {/literal}
    {/if}
    {if $_c['hide_aui'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                // Get the data from PHP and assign it to JavaScript variables
                var u_act = '{/literal}{$u_act}{literal}';
                var c_all = '{/literal}{$c_all}{literal}';
                var u_all = '{/literal}{$u_all}{literal}';
                //lets calculate the inactive users as reported
                var expired = u_all - u_act;
                var inactive = c_all - u_all;
                if (inactive < 0) {
                    inactive = 0;
                }
                // Create the chart data
                var data = {
                    labels: ['Active Users', 'Expired Users', 'Inactive Users'],
                    datasets: [{
                        label: 'User Recharges',
                        data: [parseInt(u_act), parseInt(expired), parseInt(inactive)],
                        backgroundColor: ['rgba(4, 191, 13)', 'rgba(191, 35, 4)', 'rgba(0, 0, 255, 0.5'],
                        borderColor: ['rgba(0, 255, 0, 1)', 'rgba(255, 99, 132, 1)', 'rgba(0, 0, 255, 0.7'],
                        borderWidth: 1
                    }]
                };

                // Create chart options
                var options = {
                    responsive: true,
                    aspectRatio: 1,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                boxWidth: 15
                            }
                        }
                    }
                };

                // Get the canvas element and create the chart
                var ctx = document.getElementById('userRechargesChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'pie',
                    data: data,
                    options: options
                });
            });
        {/literal}
    {/if}
    
</script>

{if $_c['new_version_notify'] != 'disable'}
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            $.getJSON("./version.json?" + Math.random(), function(data) {
                var localVersion = data.version;
                $('#version').html('Version: ' + localVersion);
                $.getJSON(
                    "https://raw.githubusercontent.com/hotspotbilling/phpnuxbill/master/version.json?" +
                    Math
                    .random(),
                    function(data) {
                        var latestVersion = data.version;
                        if (localVersion !== latestVersion) {
                            $('#version').html('Latest Version: ' + latestVersion);
                            if (getCookie(latestVersion) != 'done') {
                                Swal.fire({
                                    icon: 'info',
                                    title: "New Version Available\nVersion: " + latestVersion,
                                    toast: true,
                                    position: 'bottom-right',
                                    showConfirmButton: true,
                                    showCloseButton: true,
                                    timer: 30000,
                                    confirmButtonText: '<a href="{$_url}community#latestVersion" style="color: white;">Update Now</a>',
                                    timerProgressBar: true,
                                    didOpen: (toast) => {
                                        toast.addEventListener('mouseenter', Swal.stopTimer)
                                        toast.addEventListener('mouseleave', Swal
                                            .resumeTimer)
                                    }
                                });
                                setCookie(latestVersion, 'done', 7);
                            }
                        }
                    });
            });

        });
    </script>
{/if}

{include file="sections/footer.tpl"}
