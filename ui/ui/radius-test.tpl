{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="box box-success">
            <div class="box-header with-border">
                <h3 class="box-title"><i class="fa fa-plus"></i> Create Test User</h3>
            </div>
            <div class="box-body">
                {if isset($success)}
                    <div class="alert alert-success">
                        <h4><i class="fa fa-check-circle"></i> Test User Created Successfully!</h4>
                        <p>{$success}</p>
                        
                        <div class="well well-sm">
                            <h5><strong>Test User Credentials:</strong></h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <strong>Username:</strong>
                                    <div class="input-group">
                                        <input type="text" class="form-control" value="{$test_username}" readonly>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="copyToClipboard('{$test_username}')">
                                                <i class="fa fa-copy"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <strong>Password:</strong>
                                    <div class="input-group">
                                        <input type="text" class="form-control" value="{$test_password}" readonly>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="copyToClipboard('{$test_password}')">
                                                <i class="fa fa-copy"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="alert alert-info">
                                <i class="fa fa-info-circle"></i>
                                <strong>Note:</strong> This test user is valid for 1 hour and will be automatically removed when expired.
                            </div>
                        </div>
                    </div>
                {/if}
                
                {if isset($error)}
                    <div class="alert alert-danger">
                        <h4><i class="fa fa-exclamation-triangle"></i> Error</h4>
                        <p>{$error}</p>
                    </div>
                {/if}
                
                <form method="POST" action="{$_url}radius_manager/test_user">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">Test User Configuration</h4>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Username Format:</label>
                                        <p class="form-control-static">
                                            <code>test_{literal}timestamp{/literal}</code>
                                            <br><small class="text-muted">Automatically generated unique username</small>
                                        </p>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label>Password:</label>
                                        <p class="form-control-static">
                                            <code>Random 6-character password</code>
                                            <br><small class="text-muted">Automatically generated secure password</small>
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Session Duration:</label>
                                        <p class="form-control-static">
                                            <strong>1 Hour</strong>
                                            <br><small class="text-muted">User will be automatically disconnected after 1 hour</small>
                                        </p>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label>Bandwidth Limit:</label>
                                        <p class="form-control-static">
                                            <strong>Default Plan Limits</strong>
                                            <br><small class="text-muted">Uses bandwidth profile from plan ID 1</small>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <h4 class="panel-title">Testing Instructions</h4>
                        </div>
                        <div class="panel-body">
                            <ol>
                                <li><strong>Create Test User:</strong> Click the button below to create a test user</li>
                                <li><strong>Connect to Hotspot:</strong> Connect a device to your WiFi hotspot</li>
                                <li><strong>Login:</strong> Use the generated credentials to authenticate</li>
                                <li><strong>Test Internet:</strong> Verify internet access is working</li>
                                <li><strong>Monitor Session:</strong> Check active sessions in RADIUS management</li>
                                <li><strong>Auto Cleanup:</strong> User will be automatically removed after expiration</li>
                            </ol>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" name="create_test" value="1" class="btn btn-success btn-lg">
                            <i class="fa fa-plus"></i> Create Test User
                        </button>
                        <a href="{$_url}radius_manager" class="btn btn-default">
                            <i class="fa fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="box box-default">
            <div class="box-header with-border">
                <h3 class="box-title">Testing Checklist</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-6">
                        <h4>Prerequisites</h4>
                        <div class="checkbox">
                            <label><input type="checkbox"> Mikrotik router configured with RADIUS</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> RADIUS server running and accessible</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Hotspot profile configured to use RADIUS</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Network connectivity between router and RADIUS server</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h4>Test Steps</h4>
                        <div class="checkbox">
                            <label><input type="checkbox"> Test user created successfully</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Device connected to hotspot network</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Login page appears correctly</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Authentication successful with test credentials</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Internet access working</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox"> Session appears in RADIUS active sessions</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Troubleshooting Guide</h3>
            </div>
            <div class="box-body">
                <div class="panel-group" id="troubleshooting">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#troubleshooting" href="#issue1">
                                    Authentication Failed
                                </a>
                            </h4>
                        </div>
                        <div id="issue1" class="panel-collapse collapse">
                            <div class="panel-body">
                                <ul>
                                    <li>Check RADIUS secret matches between Mikrotik and server</li>
                                    <li>Verify RADIUS server IP address in Mikrotik configuration</li>
                                    <li>Check firewall rules allow RADIUS traffic (ports 1812/1813)</li>
                                    <li>Review RADIUS server logs for authentication errors</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#troubleshooting" href="#issue2">
                                    No Internet Access After Login
                                </a>
                            </h4>
                        </div>
                        <div id="issue2" class="panel-collapse collapse">
                            <div class="panel-body">
                                <ul>
                                    <li>Check NAT rules for hotspot users</li>
                                    <li>Verify DNS server configuration</li>
                                    <li>Test with simple HTTP sites (not HTTPS initially)</li>
                                    <li>Check routing table and gateway configuration</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#troubleshooting" href="#issue3">
                                    Session Not Appearing in Statistics
                                </a>
                            </h4>
                        </div>
                        <div id="issue3" class="panel-collapse collapse">
                            <div class="panel-body">
                                <ul>
                                    <li>Check RADIUS accounting is enabled in hotspot profile</li>
                                    <li>Verify accounting packets are being sent (interim updates)</li>
                                    <li>Check database connectivity and table structure</li>
                                    <li>Review interim update interval settings</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function copyToClipboard(text) {
    // Create temporary textarea
    var textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    
    // Show feedback
    alert('Copied to clipboard: ' + text);
}
</script>

{include file="sections/footer.tpl"}