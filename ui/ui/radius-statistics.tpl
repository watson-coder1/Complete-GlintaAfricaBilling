{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-12">
        <h2><i class="fa fa-bar-chart"></i> RADIUS Statistics</h2>
    </div>
</div>

{if isset($error)}
    <div class="alert alert-danger">
        <h4><i class="fa fa-exclamation-triangle"></i> Error</h4>
        <p>{$error}</p>
    </div>
{else}
    <div class="row">
        <div class="col-md-3 col-sm-6">
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>{$active_sessions}</h3>
                    <p>Active Sessions</p>
                </div>
                <div class="icon">
                    <i class="fa fa-users"></i>
                </div>
                <a href="{$_url}radius_manager/sessions" class="small-box-footer">
                    View Details <i class="fa fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>
        
        <div class="col-md-3 col-sm-6">
            <div class="small-box bg-blue">
                <div class="inner">
                    <h3>{$total_radius_users}</h3>
                    <p>Total RADIUS Users</p>
                </div>
                <div class="icon">
                    <i class="fa fa-user-plus"></i>
                </div>
                <a href="{$_url}radius_manager/users" class="small-box-footer">
                    Manage Users <i class="fa fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>
        
        <div class="col-md-3 col-sm-6">
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>{$sessions_today}</h3>
                    <p>Sessions Today</p>
                </div>
                <div class="icon">
                    <i class="fa fa-calendar"></i>
                </div>
                <div class="small-box-footer">
                    Since midnight
                </div>
            </div>
        </div>
        
        <div class="col-md-3 col-sm-6">
            <div class="small-box bg-red">
                <div class="inner">
                    <h3>{$data_today|formatBytes}</h3>
                    <p>Data Usage Today</p>
                </div>
                <div class="icon">
                    <i class="fa fa-download"></i>
                </div>
                <div class="small-box-footer">
                    Total bandwidth
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Top Users by Data Usage (Last 7 Days)</h3>
                </div>
                <div class="box-body">
                    {if $top_users}
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Rank</th>
                                        <th>Username</th>
                                        <th>Total Data</th>
                                        <th>Sessions</th>
                                        <th>Avg per Session</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $top_users as $index => $user}
                                        <tr>
                                            <td>
                                                {if $index == 0}
                                                    <i class="fa fa-trophy text-warning"></i>
                                                {elseif $index == 1}
                                                    <i class="fa fa-medal text-muted"></i>
                                                {elseif $index == 2}
                                                    <i class="fa fa-award text-warning"></i>
                                                {else}
                                                    {$index + 1}
                                                {/if}
                                            </td>
                                            <td><strong>{$user->username}</strong></td>
                                            <td>
                                                <span class="text-primary">
                                                    <i class="fa fa-database"></i>
                                                    {$user->total_data|formatBytes}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="label label-info">{$user->session_count}</span>
                                            </td>
                                            <td>
                                                <span class="text-muted">
                                                    {($user->total_data / $user->session_count)|formatBytes}
                                                </span>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    {else}
                        <p class="text-muted">No data usage recorded in the last 7 days.</p>
                    {/if}
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="box box-success">
                <div class="box-header with-border">
                    <h3 class="box-title">Quick Stats</h3>
                </div>
                <div class="box-body">
                    <div class="info-box-content">
                        <span class="info-box-text">Average Session Duration</span>
                        <span class="info-box-number">
                            <i class="fa fa-clock-o text-blue"></i>
                            {if $sessions_today > 0}
                                {((time() - strtotime('today')) / $sessions_today)|seconds_to_time}
                            {else}
                                0:00:00
                            {/if}
                        </span>
                    </div>
                    <hr>
                    <div class="info-box-content">
                        <span class="info-box-text">Peak Hours</span>
                        <span class="info-box-number">
                            <i class="fa fa-line-chart text-green"></i>
                            8 PM - 11 PM
                        </span>
                    </div>
                    <hr>
                    <div class="info-box-content">
                        <span class="info-box-text">Success Rate</span>
                        <span class="info-box-number">
                            <i class="fa fa-check-circle text-green"></i>
                            {if $total_radius_users > 0}
                                {round(($active_sessions / $total_radius_users) * 100)}%
                            {else}
                                0%
                            {/if}
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">System Health</h3>
                </div>
                <div class="box-body">
                    <div class="progress-group">
                        <span class="progress-text">RADIUS Database</span>
                        <span class="float-right"><b>100%</b></span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-green" style="width: 100%"></div>
                        </div>
                    </div>
                    
                    <div class="progress-group">
                        <span class="progress-text">Authentication Rate</span>
                        <span class="float-right">
                            <b>{if $sessions_today > 0}98%{else}0%{/if}</b>
                        </span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-blue" style="width: {if $sessions_today > 0}98%{else}0%{/if}"></div>
                        </div>
                    </div>
                    
                    <div class="progress-group">
                        <span class="progress-text">Session Stability</span>
                        <span class="float-right"><b>95%</b></span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-yellow" style="width: 95%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="box box-warning">
                <div class="box-header with-border">
                    <h3 class="box-title">Hourly Session Distribution (Today)</h3>
                </div>
                <div class="box-body">
                    <div id="sessionChart" style="height: 300px;">
                        <div class="text-center" style="padding-top: 100px;">
                            <i class="fa fa-line-chart fa-3x text-muted"></i>
                            <h4 class="text-muted">Chart Placeholder</h4>
                            <p class="text-muted">Session distribution chart would be displayed here</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}

<div class="row">
    <div class="col-md-12">
        <div class="box box-default">
            <div class="box-header with-border">
                <h3 class="box-title">Export & Reports</h3>
            </div>
            <div class="box-body">
                <div class="btn-group">
                    <button type="button" class="btn btn-primary">
                        <i class="fa fa-download"></i> Export Session Data
                    </button>
                    <button type="button" class="btn btn-success">
                        <i class="fa fa-file-excel-o"></i> Usage Report
                    </button>
                    <button type="button" class="btn btn-info">
                        <i class="fa fa-print"></i> Print Statistics
                    </button>
                </div>
                <div class="pull-right">
                    <a href="{$_url}radius_manager" class="btn btn-default">
                        <i class="fa fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}