{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12 col-md-8 col-md-offset-2">
        <div class="panel panel-hovered mb20 panel-primary">
            <div class="panel-heading">
                <div class="btn-group pull-right">
                    <a class="btn btn-default btn-sm" href="{$_url}auth_blocker_admin">
                        <i class="fa fa-arrow-left"></i> Back to List
                    </a>
                </div>
                Block MAC Address
            </div>
            <div class="panel-body">
                <form method="post" action="{$_url}auth_blocker_admin/block">
                    <div class="form-group">
                        <label for="mac_address">MAC Address <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="mac_address" name="mac_address" 
                               placeholder="aa:bb:cc:dd:ee:ff or device-hash" required>
                        <div class="help-block">
                            Enter the MAC address to block. Can be a standard MAC format (aa:bb:cc:dd:ee:ff) 
                            or device fingerprint (device-xxxxx, auto-xxxxx).
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="username">Username (Optional)</label>
                        <input type="text" class="form-control" id="username" name="username" 
                               placeholder="Leave empty to use MAC as username">
                        <div class="help-block">
                            Associated username. If left empty, MAC address will be used as username.
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="reason">Block Reason <span class="text-danger">*</span></label>
                        <select class="form-control" id="reason" name="reason" required onchange="updateReasonHelp()">
                            <option value="manual_block">Manual Block</option>
                            <option value="suspicious_activity">Suspicious Activity</option>
                            <option value="expired_session_retry">Expired Session Retry</option>
                            <option value="policy_violation">Policy Violation</option>
                            <option value="security_threat">Security Threat</option>
                            <option value="maintenance">Maintenance</option>
                            <option value="other">Other</option>
                        </select>
                        <div class="help-block" id="reason_help">
                            Manual administrative block of MAC address.
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="duration_hours">Block Duration (Hours)</label>
                        <select class="form-control" id="duration_hours" name="duration_hours">
                            <option value="">Permanent (No expiry)</option>
                            <option value="1">1 Hour</option>
                            <option value="6">6 Hours</option>
                            <option value="24">24 Hours</option>
                            <option value="72">3 Days</option>
                            <option value="168">1 Week</option>
                        </select>
                        <div class="help-block">
                            How long should this block remain active? Leave empty for permanent block.
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="notes">Additional Notes</label>
                        <textarea class="form-control" id="notes" name="notes" rows="3" 
                                  placeholder="Optional notes about this block..."></textarea>
                        <div class="help-block">
                            Additional information about why this MAC is being blocked.
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-danger">
                            <i class="fa fa-ban"></i> Block MAC Address
                        </button>
                        <a href="{$_url}auth_blocker_admin" class="btn btn-default">
                            <i class="fa fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function updateReasonHelp() {
    var reason = document.getElementById('reason').value;
    var helpDiv = document.getElementById('reason_help');
    
    var helpTexts = {
        'manual_block': 'Manual administrative block of MAC address.',
        'suspicious_activity': 'Block due to suspicious authentication patterns or rapid attempts.',
        'expired_session_retry': 'User attempting to reconnect after session expired without new payment.',
        'policy_violation': 'User violated network usage policies or terms of service.',
        'security_threat': 'MAC address identified as potential security threat.',
        'maintenance': 'Temporary block during system maintenance.',
        'other': 'Custom reason - please specify in notes.'
    };
    
    helpDiv.textContent = helpTexts[reason] || 'Please select a block reason.';
}

// Format MAC address as user types
document.getElementById('mac_address').addEventListener('input', function(e) {
    var value = e.target.value.replace(/[^a-fA-F0-9]/g, '');
    
    // Only format if it looks like a MAC address (not device fingerprint)
    if (value.length <= 12 && !e.target.value.startsWith('device-') && !e.target.value.startsWith('auto-')) {
        var formatted = value.match(/.{1,2}/g)?.join(':') || value;
        if (formatted !== e.target.value) {
            e.target.value = formatted;
        }
    }
});
</script>

{include file="sections/footer.tpl"}