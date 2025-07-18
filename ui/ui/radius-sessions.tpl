{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Active RADIUS Sessions</h3>
                <div class="box-tools pull-right">
                    <a href="{$_url}radius_manager" class="btn btn-default btn-sm">
                        <i class="fa fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>
            <div class="box-body">
                {if isset($error)}
                    <div class="alert alert-danger">
                        <h4><i class="fa fa-exclamation-triangle"></i> Error</h4>
                        <p>{$error}</p>
                    </div>
                {else}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-box bg-green">
                                <span class="info-box-icon"><i class="fa fa-users"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Active Sessions</span>
                                    <span class="info-box-number">{$total_sessions}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-box bg-blue">
                                <span class="info-box-icon"><i class="fa fa-refresh"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Auto Refresh</span>
                                    <span class="info-box-number">30s</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    {if $sessions}
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Start Time</th>
                                        <th>Session Time</th>
                                        <th>NAS IP Address</th>
                                        <th>Framed IP</th>
                                        <th>Input Bytes</th>
                                        <th>Output Bytes</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $sessions as $session}
                                        <tr>
                                            <td>
                                                <strong>{$session->username}</strong>
                                                <br><small class="text-muted">{$session->acctuniqueid}</small>
                                            </td>
                                            <td>
                                                {date('M j, Y H:i:s', strtotime($session->acctstarttime))}
                                                <br><small class="text-muted">{$session->acctstarttime|time_elapsed_string}</small>
                                            </td>
                                            <td>
                                                <span class="label label-info">
                                                    {(time() - strtotime($session->acctstarttime))|seconds_to_time}
                                                </span>
                                            </td>
                                            <td><code>{$session->nasipaddress}</code></td>
                                            <td>
                                                {if $session->framedipaddress}
                                                    <code>{$session->framedipaddress}</code>
                                                {else}
                                                    <span class="text-muted">-</span>
                                                {/if}
                                            </td>
                                            <td>
                                                <span class="text-success">
                                                    <i class="fa fa-download"></i>
                                                    {if $session->acctinputoctets}
                                                        {$session->acctinputoctets|formatBytes}
                                                    {else}
                                                        0 B
                                                    {/if}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="text-info">
                                                    <i class="fa fa-upload"></i>
                                                    {if $session->acctoutputoctets}
                                                        {$session->acctoutputoctets|formatBytes}
                                                    {else}
                                                        0 B
                                                    {/if}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="{$_url}radius_manager/disconnect/{$session->username}" 
                                                   class="btn btn-danger btn-xs"
                                                   onclick="return confirm('Are you sure you want to disconnect this user?')">
                                                    <i class="fa fa-power-off"></i> Disconnect
                                                </a>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                        
                        {if $total_pages > 1}
                            <nav>
                                <ul class="pagination">
                                    {if $current_page > 1}
                                        <li><a href="{$_url}radius_manager/sessions?page={$current_page-1}">&laquo; Previous</a></li>
                                    {/if}
                                    
                                    {for $i=1 to $total_pages}
                                        <li {if $i == $current_page}class="active"{/if}>
                                            <a href="{$_url}radius_manager/sessions?page={$i}">{$i}</a>
                                        </li>
                                    {/for}
                                    
                                    {if $current_page < $total_pages}
                                        <li><a href="{$_url}radius_manager/sessions?page={$current_page+1}">Next &raquo;</a></li>
                                    {/if}
                                </ul>
                            </nav>
                        {/if}
                    {else}
                        <div class="text-center">
                            <i class="fa fa-users fa-3x text-muted"></i>
                            <h4 class="text-muted">No Active Sessions</h4>
                            <p class="text-muted">There are currently no active RADIUS sessions.</p>
                        </div>
                    {/if}
                {/if}
            </div>
        </div>
    </div>
</div>

<script>
// Auto refresh every 30 seconds
setTimeout(function() {
    window.location.reload();
}, 30000);
</script>

{include file="sections/footer.tpl"}