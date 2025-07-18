{include file="sections/header.tpl"}

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
                View Sessions <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
    
    <div class="col-md-3 col-sm-6">
        <div class="small-box bg-blue">
            <div class="inner">
                <h3>{$total_users}</h3>
                <p>RADIUS Users</p>
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
        <div class="small-box {if $cron_status eq 'running'}bg-green{else}bg-red{/if}">
            <div class="inner">
                <h3>{if $cron_status eq 'running'}Running{else}Stopped{/if}</h3>
                <p>Auto Expiry</p>
            </div>
            <div class="icon">
                <i class="fa fa-clock-o"></i>
            </div>
            <div class="small-box-footer">
                {if $cron_last_run > 0}
                    Last run: {date('M j, H:i', $cron_last_run)}
                {else}
                    Never run
                {/if}
            </div>
        </div>
    </div>
    
    <div class="col-md-3 col-sm-6">
        <div class="small-box bg-yellow">
            <div class="inner">
                <h3><i class="fa fa-cogs"></i></h3>
                <p>Statistics</p>
            </div>
            <div class="icon">
                <i class="fa fa-bar-chart"></i>
            </div>
            <a href="{$_url}radius_manager/statistics" class="small-box-footer">
                View Stats <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
</div>

{if isset($error)}
    <div class="alert alert-danger">
        <h4><i class="fa fa-exclamation-triangle"></i> RADIUS Connection Error</h4>
        <p>{$error}</p>
        <p><strong>Solutions:</strong></p>
        <ul>
            <li>Check if RADIUS database is configured in <code>config.php</code></li>
            <li>Verify RADIUS database credentials</li>
            <li>Ensure RADIUS tables exist in the database</li>
            <li>Check if <code>radius_enable</code> is set to <code>true</code></li>
        </ul>
    </div>
{else}
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Recent Sessions</h3>
                    <div class="box-tools pull-right">
                        <a href="{$_url}radius_manager/sessions" class="btn btn-primary btn-sm">
                            <i class="fa fa-eye"></i> View All
                        </a>
                    </div>
                </div>
                <div class="box-body">
                    {if $recent_sessions}
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Start Time</th>
                                        <th>NAS IP</th>
                                        <th>Status</th>
                                        <th>Session Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $recent_sessions as $session}
                                        <tr>
                                            <td><strong>{$session->username}</strong></td>
                                            <td>{date('M j, H:i', strtotime($session->acctstarttime))}</td>
                                            <td><code>{$session->nasipaddress}</code></td>
                                            <td>
                                                {if $session->acctstoptime}
                                                    <span class="label label-default">Stopped</span>
                                                {else}
                                                    <span class="label label-success">Active</span>
                                                {/if}
                                            </td>
                                            <td>
                                                {if $session->acctsessiontime}
                                                    {$session->acctsessiontime|seconds_to_time}
                                                {else}
                                                    {if !$session->acctstoptime}
                                                        {(time() - strtotime($session->acctstarttime))|seconds_to_time}
                                                    {else}
                                                        -
                                                    {/if}
                                                {/if}
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    {else}
                        <p class="text-muted">No recent sessions found.</p>
                    {/if}
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="box box-success">
                <div class="box-header with-border">
                    <h3 class="box-title">Quick Actions</h3>
                </div>
                <div class="box-body">
                    <a href="{$_url}radius_manager/test_user" class="btn btn-success btn-block">
                        <i class="fa fa-plus"></i> Create Test User
                    </a>
                    <a href="{$_url}mikrotik_config_generator.php" class="btn btn-info btn-block" target="_blank">
                        <i class="fa fa-router"></i> Mikrotik Config
                    </a>
                    <a href="{$_url}radius_manager/cleanup" class="btn btn-warning btn-block">
                        <i class="fa fa-trash"></i> Cleanup Old Records
                    </a>
                    <a href="{$_url}mpesa_payment.php" class="btn btn-primary btn-block" target="_blank">
                        <i class="fa fa-mobile"></i> Test Payment Portal
                    </a>
                </div>
            </div>
            
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">System Status</h3>
                </div>
                <div class="box-body">
                    <div class="info-box-content">
                        <span class="info-box-text">RADIUS Database</span>
                        <span class="info-box-number text-success">
                            <i class="fa fa-check-circle"></i> Connected
                        </span>
                    </div>
                    <hr>
                    <div class="info-box-content">
                        <span class="info-box-text">Auto Expiry System</span>
                        <span class="info-box-number {if $cron_status eq 'running'}text-success{else}text-danger{/if}">
                            <i class="fa fa-{if $cron_status eq 'running'}check-circle{else}exclamation-triangle{/if}"></i> 
                            {if $cron_status eq 'running'}Working{else}Not Running{/if}
                        </span>
                    </div>
                    {if $cron_status neq 'running'}
                        <div class="alert alert-warning alert-sm">
                            <small>
                                <strong>Setup Required:</strong><br>
                                Add this to your crontab:<br>
                                <code>*/5 * * * * php {$_path}/radius_cron.php</code>
                            </small>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="box box-warning">
                <div class="box-header with-border">
                    <h3 class="box-title">Integration Flow</h3>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-2 text-center">
                            <i class="fa fa-mobile fa-3x text-primary"></i>
                            <h5>Customer Payment</h5>
                            <small>M-Pesa STK Push</small>
                        </div>
                        <div class="col-md-1 text-center">
                            <i class="fa fa-arrow-right fa-2x text-muted"></i>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="fa fa-database fa-3x text-success"></i>
                            <h5>RADIUS User</h5>
                            <small>Auto Created</small>
                        </div>
                        <div class="col-md-1 text-center">
                            <i class="fa fa-arrow-right fa-2x text-muted"></i>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="fa fa-router fa-3x text-info"></i>
                            <h5>Mikrotik Auth</h5>
                            <small>RADIUS Login</small>
                        </div>
                        <div class="col-md-1 text-center">
                            <i class="fa fa-arrow-right fa-2x text-muted"></i>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="fa fa-wifi fa-3x text-warning"></i>
                            <h5>Internet Access</h5>
                            <small>Activated</small>
                        </div>
                        <div class="col-md-1 text-center">
                            <i class="fa fa-clock-o fa-2x text-danger"></i>
                            <h5>Auto Expiry</h5>
                            <small>Cron Job</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}

{include file="sections/footer.tpl"}