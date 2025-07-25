{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-hovered mb20 panel-primary">
            <div class="panel-heading">
                <div class="btn-group pull-right">
                    <a class="btn btn-primary btn-sm" href="{$_url}auth_blocker_admin/block">
                        <i class="fa fa-ban"></i> Block MAC Address
                    </a>
                    <div class="btn-group">
                        <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-cogs"></i> Actions <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="{$_url}auth_blocker_admin/process_expired">
                                <i class="fa fa-clock-o"></i> Process Expired Users
                            </a></li>
                            <li><a href="{$_url}auth_blocker_admin/cleanup">
                                <i class="fa fa-trash"></i> Cleanup Old Records
                            </a></li>
                            <li class="divider"></li>
                            <li><a href="{$_url}auth_blocker_admin/export">
                                <i class="fa fa-download"></i> Export to CSV
                            </a></li>
                        </ul>
                    </div>
                </div>
                Authentication Blocker Management
            </div>
            <div class="panel-body">
                
                <!-- Statistics Row -->
                <div class="row mb20">
                    <div class="col-md-3">
                        <div class="panel panel-info">
                            <div class="panel-body text-center">
                                <h3 class="mb5">{$stats.active_blocks}</h3>
                                <small>Active Blocks</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-warning">
                            <div class="panel-body text-center">
                                <h3 class="mb5">{$stats.recent_attempts}</h3>
                                <small>Recent Attempts (24h)</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-danger">
                            <div class="panel-body text-center">
                                <h3 class="mb5">{$stats.recent_blocked_attempts}</h3>
                                <small>Blocked Attempts (24h)</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-success">
                            <div class="panel-body text-center">
                                <h3 class="mb5">{if $stats.blocks_by_reason.expired_session_retry}{$stats.blocks_by_reason.expired_session_retry}{else}0{/if}</h3>
                                <small>Expired Session Blocks</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick MAC Check -->
                <div class="row mb20">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">Quick MAC Check</h4>
                            </div>
                            <div class="panel-body">
                                <form class="form-inline" onsubmit="checkMacStatus(event)">
                                    <div class="form-group">
                                        <label for="check_mac">MAC Address:</label>
                                        <input type="text" class="form-control" id="check_mac" placeholder="aa:bb:cc:dd:ee:ff or device-hash">
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-search"></i> Check Status
                                    </button>
                                </form>
                                <div id="mac_check_result" class="mt10"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Blocked MAC Addresses Table -->
                <div class="table-responsive">
                    <form id="bulk_form" method="post" action="{$_url}auth_blocker_admin/bulk_unblock">
                        <div class="table-actions mb10">
                            <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Unblock selected MAC addresses?')">
                                <i class="fa fa-unlock"></i> Bulk Unblock
                            </button>
                        </div>
                        
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="30">
                                        <input type="checkbox" id="select_all" onchange="toggleSelectAll()">
                                    </th>
                                    <th>MAC Address</th>
                                    <th>Username</th>
                                    <th>Reason</th>
                                    <th>Status</th>
                                    <th>Blocked At</th>
                                    <th>Expires At</th>
                                    <th>Attempts</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $blocked_macs as $block}
                                <tr class="{if $block->status == 'active'}danger{elseif $block->status == 'lifted'}success{else}warning{/if}">
                                    <td>
                                        {if $block->status == 'active'}
                                        <input type="checkbox" name="block_ids[]" value="{$block->id}">
                                        {/if}
                                    </td>
                                    <td>
                                        <code>{$block->mac_address}</code>
                                        <br><small class="text-muted">{$block->username}</small>
                                    </td>
                                    <td>{$block->username}</td>
                                    <td>
                                        <span class="label 
                                            {if $block->reason == 'expired_session_retry'}label-danger
                                            {elseif $block->reason == 'suspicious_activity'}label-warning
                                            {elseif $block->reason == 'session_expired'}label-info
                                            {else}label-default{/if}">
                                            {$block->reason}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="label 
                                            {if $block->status == 'active'}label-danger
                                            {elseif $block->status == 'lifted'}label-success
                                            {else}label-warning{/if}">
                                            {$block->status}
                                        </span>
                                    </td>
                                    <td>
                                        {date('Y-m-d H:i:s', strtotime($block->blocked_at))}
                                        <br><small class="text-muted">{timeAgo($block->blocked_at)}</small>
                                    </td>
                                    <td>
                                        {if $block->expires_at}
                                            {date('Y-m-d H:i:s', strtotime($block->expires_at))}
                                        {else}
                                            <span class="text-muted">Never</span>
                                        {/if}
                                    </td>
                                    <td>
                                        <span class="badge">{$block->attempt_count}</span>
                                        {if $block->last_attempt}
                                        <br><small class="text-muted">Last: {timeAgo($block->last_attempt)}</small>
                                        {/if}
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-xs">
                                            <a href="{$_url}auth_blocker_admin/view/{$block->id}" class="btn btn-info" title="View Details">
                                                <i class="fa fa-eye"></i>
                                            </a>
                                            {if $block->status == 'active'}
                                            <a href="{$_url}auth_blocker_admin/unblock/{$block->id}" 
                                               class="btn btn-success" 
                                               title="Unblock"
                                               onclick="return confirm('Unblock this MAC address?')">
                                                <i class="fa fa-unlock"></i>
                                            </a>
                                            {/if}
                                        </div>
                                    </td>
                                </tr>
                                {foreachelse}
                                <tr>
                                    <td colspan="9" class="text-center text-muted">No blocked MAC addresses found</td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </form>
                </div>
                
                <!-- Recent Authentication Attempts -->
                <div class="panel panel-default mt20">
                    <div class="panel-heading">
                        <h4 class="panel-title">Recent Authentication Attempts</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-condensed">
                                <thead>
                                    <tr>
                                        <th>Time</th>
                                        <th>MAC Address</th>
                                        <th>IP Address</th>
                                        <th>Type</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $recent_attempts as $attempt}
                                    <tr class="{if $attempt->blocked}danger{/if}">
                                        <td>
                                            {date('Y-m-d H:i:s', strtotime($attempt->attempt_time))}
                                            <br><small class="text-muted">{timeAgo($attempt->attempt_time)}</small>
                                        </td>
                                        <td><code>{$attempt->mac_address}</code></td>
                                        <td>{$attempt->ip_address}</td>
                                        <td>
                                            <span class="label 
                                                {if $attempt->attempt_type == 'captive_portal'}label-primary
                                                {elseif $attempt->attempt_type == 'radius'}label-info
                                                {elseif $attempt->attempt_type == 'voucher'}label-success
                                                {else}label-default{/if}">
                                                {$attempt->attempt_type}
                                            </span>
                                        </td>
                                        <td>
                                            {if $attempt->blocked}
                                                <span class="label label-danger">Blocked</span>
                                                {if $attempt->reason}
                                                <br><small class="text-muted">{$attempt->reason}</small>
                                                {/if}
                                            {else}
                                                <span class="label label-success">Allowed</span>
                                            {/if}
                                        </td>
                                    </tr>
                                    {foreachelse}
                                    <tr>
                                        <td colspan="5" class="text-center text-muted">No recent attempts found</td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function toggleSelectAll() {
    var selectAll = document.getElementById('select_all');
    var checkboxes = document.querySelectorAll('input[name="block_ids[]"]');
    
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = selectAll.checked;
    });
}

function checkMacStatus(event) {
    event.preventDefault();
    
    var mac = document.getElementById('check_mac').value.trim();
    var resultDiv = document.getElementById('mac_check_result');
    
    if (!mac) {
        resultDiv.innerHTML = '<div class="alert alert-warning">Please enter a MAC address</div>';
        return;
    }
    
    resultDiv.innerHTML = '<div class="alert alert-info"><i class="fa fa-spinner fa-spin"></i> Checking...</div>';
    
    // AJAX request to check MAC status
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '{$_url}auth_blocker_admin/check_mac', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                try {
                    var response = JSON.parse(xhr.responseText);
                    var html = '';
                    
                    if (response.blocked) {
                        html = '<div class="alert alert-danger">' +
                               '<strong><i class="fa fa-ban"></i> BLOCKED</strong><br>' +
                               'Reason: ' + response.reason + '<br>' +
                               (response.blocked_since ? 'Blocked Since: ' + response.blocked_since + '<br>' : '') +
                               (response.message ? 'Message: ' + response.message : '') +
                               '</div>';
                    } else {
                        html = '<div class="alert alert-success">' +
                               '<strong><i class="fa fa-check"></i> ALLOWED</strong><br>' +
                               'This MAC address is not blocked from authentication.' +
                               (response.has_active_session ? '<br><strong>Has Active Session:</strong> ' + response.active_session.plan : '') +
                               '</div>';
                    }
                    
                    resultDiv.innerHTML = html;
                } catch (e) {
                    resultDiv.innerHTML = '<div class="alert alert-danger">Error parsing response</div>';
                }
            } else {
                resultDiv.innerHTML = '<div class="alert alert-danger">Error checking MAC status</div>';
            }
        }
    };
    
    xhr.send('mac_address=' + encodeURIComponent(mac));
}

// Auto-refresh statistics every 30 seconds
setInterval(function() {
    location.reload();
}, 30000);
</script>

{include file="sections/footer.tpl"}