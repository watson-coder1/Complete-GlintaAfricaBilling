{include file="sections/header.tpl"}

<div class="row">
    {if in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h4 class="text-bold" style="font-size: large;"><sup>{$_c['currency_code']}</sup>
                        {number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</h4>
                </div>
                <div class="icon">
                    <i class="ion ion-clock"></i>
                </div>
                <a href="{$_url}reports/by-date" class="small-box-footer">{Lang::T('Income Today')}</a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-green">
                <div class="inner">
                    <h4 class="text-bold" style="font-size: large;"><sup>{$_c['currency_code']}</sup>
                        {number_format($imonth,0,$_c['dec_point'],$_c['thousands_sep'])}</h4>
                </div>
                <div class="icon">
                    <i class="ion ion-android-calendar"></i>
                </div>
                <a href="{$_url}reports/by-period" class="small-box-footer">{Lang::T('Income This Month')}</a>
            </div>
        </div>
    {/if}
    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-yellow">
            <div class="inner">
                <h4 class="text-bold" style="font-size: large;">{$u_act}/{$u_all-$u_act}</h4>
            </div>
            <div class="icon">
                <i class="ion ion-person"></i>
            </div>
            <a href="{$_url}plan/list" class="small-box-footer">{Lang::T('Active')}/{Lang::T('Expired')}</a>
        </div>
    </div>
    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-red">
            <div class="inner">
                <h4 class="text-bold" style="font-size: large;">{$c_all}</h4>
            </div>
            <div class="icon">
                <i class="ion ion-android-people"></i>
            </div>
            <a href="{$_url}customers/list" class="small-box-footer">{Lang::T('Customers')}</a>
        </div>
    </div>
</div>
<ol class="breadcrumb">
    <li>{Lang::dateFormat($start_date)}</li>
    <li>{Lang::dateFormat($current_date)}</li>
    {if $_c['enable_balance'] == 'yes' && in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <li onclick="window.location.href = '{$_url}customers&search=&order=balance&filter=Active&orderby=desc'" style="cursor: pointer;">
            {Lang::T('Customer Balance')} <sup>{$_c['currency_code']}</sup>
            <b>{number_format($cb,0,$_c['dec_point'],$_c['thousands_sep'])}</b>
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

                    <h3 class="box-title">{Lang::T('Monthly Registered Customers')}</h3>

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

                    <h3 class="box-title">{Lang::T('Total Monthly Sales')}</h3>

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
                var counts = JSON.parse('{/literal}{$monthlyRegistered|json_encode}{literal}');

                var monthNames = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];

                var labels = [];
                var data = [];

                for (var i = 1; i <= 12; i++) {
                    var month = counts.find(count => count.date === i);
                    labels.push(month ? monthNames[i - 1] : monthNames[i - 1].substring(0, 3));
                    data.push(month ? month.count : 0);
                }

                var ctx = document.getElementById('chart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Registered Members',
                            data: data,
                            backgroundColor: 'rgba(0, 0, 255, 0.5)',
                            borderColor: 'rgba(0, 0, 255, 0.7)',
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
                        }
                    }
                });
            });
        {/literal}
    {/if}
    {if $_c['hide_tmc'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                var monthlySales = JSON.parse('{/literal}{$monthlySales|json_encode}{literal}');

                var monthNames = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];

                var labels = [];
                var data = [];

                for (var i = 1; i <= 12; i++) {
                    var month = findMonthData(monthlySales, i);
                    labels.push(month ? monthNames[i - 1] : monthNames[i - 1].substring(0, 3));
                    data.push(month ? month.totalSales : 0);
                }

                var ctx = document.getElementById('salesChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Monthly Sales',
                            data: data,
                            backgroundColor: 'rgba(2, 10, 242)', // Customize the background color
                            borderColor: 'rgba(255, 99, 132, 1)', // Customize the border color
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
                        }
                    }
                });
            });

            function findMonthData(monthlySales, month) {
                for (var i = 0; i < monthlySales.length; i++) {
                    if (monthlySales[i].month === month) {
                        return monthlySales[i];
                    }
                }
                return null;
            }
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
