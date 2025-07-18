{include file="sections/header.tpl"}

<link rel="stylesheet" href="{$_url}ui/ui/css/daraja-fix.css">
<style>
/* Force enable URL input fields */
#callback_url, #timeout_url {
    background-color: #ffffff !important;
    cursor: text !important;
    pointer-events: auto !important;
}
</style>

<div class="row">
    <div class="col-md-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">M-Pesa Daraja Gateway Configuration</h3>
                <div class="box-tools pull-right">
                    <a href="{$_url}paymentgateway" class="btn btn-default btn-sm">
                        <i class="fa fa-arrow-left"></i> Back to Payment Gateways
                    </a>
                </div>
            </div>
            <div class="box-body">
                {if isset($notify)}
                    <div class="alert alert-{if $notify_t == 's'}success{else}danger{/if}">
                        {$notify}
                    </div>
                {/if}
                
                <form method="post" action="{$_url}paymentgateway/Daraja">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Basic Configuration</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label for="consumer_key">Consumer Key</label>
                                        <input type="text" class="form-control" id="consumer_key" 
                                               name="consumer_key" value="{$daraja_consumer_key}" required>
                                        <small class="help-block">Your M-Pesa Daraja Consumer Key from Safaricom</small>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="consumer_secret">Consumer Secret</label>
                                        <input type="password" class="form-control" id="consumer_secret" 
                                               name="consumer_secret" value="{$daraja_consumer_secret}" required>
                                        <small class="help-block">Your M-Pesa Daraja Consumer Secret</small>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="shortcode">Business Short Code</label>
                                        <input type="text" class="form-control" id="shortcode" 
                                               name="shortcode" value="{$daraja_business_shortcode}" required>
                                        <small class="help-block">Your M-Pesa Business Short Code (Paybill/Till Number)</small>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="passkey">Passkey</label>
                                        <input type="password" class="form-control" id="passkey" 
                                               name="passkey" value="{$daraja_passkey}" required>
                                        <small class="help-block">Your M-Pesa Online Passkey for STK Push</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="panel panel-warning">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Environment & URLs</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label for="environment">Environment</label>
                                        <select class="form-control" id="environment" name="environment" required>
                                            <option value="sandbox" {if $daraja_environment == 'sandbox'}selected{/if}>Sandbox (Testing)</option>
                                            <option value="production" {if $daraja_environment == 'production'}selected{/if}>Production (Live)</option>
                                        </select>
                                        <small class="help-block">Use Sandbox for testing, Production for live payments</small>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="callback_url">Callback URL</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="callback_url" 
                                                   name="callback_url" value="{$daraja_callback_url}">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="copyToClipboard('{$daraja_callback_url}')">
                                                    <i class="fa fa-copy"></i>
                                                </button>
                                            </span>
                                        </div>
                                        <small class="help-block">Configure this URL in your Daraja App settings</small>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="timeout_url">Timeout URL</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="timeout_url" 
                                                   name="timeout_url" value="{$daraja_timeout_url}">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="copyToClipboard('{$daraja_timeout_url}')">
                                                    <i class="fa fa-copy"></i>
                                                </button>
                                            </span>
                                        </div>
                                        <small class="help-block">Timeout callback URL for failed transactions</small>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="enabled" value="1" 
                                                       {if $daraja_status == 'Active'}checked{/if}>
                                                Enable M-Pesa Daraja Gateway
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="daraja_sandbox_mode" value="1" 
                                                       {if $daraja_sandbox_mode}checked{/if}>
                                                Enable Sandbox Mode (for testing)
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Status & Testing</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="info-box bg-{if $daraja_status == 'Active'}green{else}red{/if}">
                                                <span class="info-box-icon">
                                                    <i class="fa fa-{if $daraja_status == 'Active'}check-circle{else}times-circle{/if}"></i>
                                                </span>
                                                <div class="info-box-content">
                                                    <span class="info-box-text">Gateway Status</span>
                                                    <span class="info-box-number">{$daraja_status|default:'Inactive'}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="info-box bg-blue">
                                                <span class="info-box-icon"><i class="fa fa-globe"></i></span>
                                                <div class="info-box-content">
                                                    <span class="info-box-text">Environment</span>
                                                    <span class="info-box-number">{$daraja_environment|default:'Not Set'}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="info-box bg-yellow">
                                                <span class="info-box-icon"><i class="fa fa-mobile"></i></span>
                                                <div class="info-box-content">
                                                    <span class="info-box-text">Payment Portal</span>
                                                    <span class="info-box-number">
                                                        <a href="{$_url}mpesa_payment.php" target="_blank" class="text-yellow">
                                                            View <i class="fa fa-external-link"></i>
                                                        </a>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h5><i class="fa fa-cog"></i> Configuration Checklist</h5>
                                            <ul class="list-unstyled">
                                                <li>
                                                    <i class="fa fa-{if $daraja_consumer_key}check text-success{else}times text-danger{/if}"></i>
                                                    Consumer Key configured
                                                </li>
                                                <li>
                                                    <i class="fa fa-{if $daraja_consumer_secret}check text-success{else}times text-danger{/if}"></i>
                                                    Consumer Secret configured
                                                </li>
                                                <li>
                                                    <i class="fa fa-{if $daraja_business_shortcode}check text-success{else}times text-danger{/if}"></i>
                                                    Business Short Code configured
                                                </li>
                                                <li>
                                                    <i class="fa fa-{if $daraja_passkey}check text-success{else}times text-danger{/if}"></i>
                                                    Passkey configured
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-6">
                                            <h5><i class="fa fa-link"></i> Integration URLs</h5>
                                            <p><strong>Payment Portal:</strong><br>
                                            <code>{$_url}mpesa_payment.php</code></p>
                                            
                                            <p><strong>Callback URL:</strong><br>
                                            <code>{$daraja_callback_url}</code></p>
                                            
                                            <p><strong>API Test:</strong><br>
                                            <a href="{$_url}test_daraja.php" target="_blank" class="btn btn-sm btn-info">
                                                <i class="fa fa-flask"></i> Test API Connection
                                            </a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" name="save" class="btn btn-primary">
                            <i class="fa fa-save"></i> Save Configuration
                        </button>
                        <button type="submit" name="test_connection" class="btn btn-info">
                            <i class="fa fa-flask"></i> Test Connection
                        </button>
                        <a href="{$_url}paymentgateway" class="btn btn-default">
                            <i class="fa fa-arrow-left"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="box box-default collapsed-box">
            <div class="box-header with-border">
                <h3 class="box-title">Setup Instructions</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                        <i class="fa fa-plus"></i>
                    </button>
                </div>
            </div>
            <div class="box-body" style="display: none;">
                <div class="row">
                    <div class="col-md-6">
                        <h4>1. Get Daraja API Credentials</h4>
                        <ol>
                            <li>Visit <a href="https://developer.safaricom.co.ke" target="_blank">Safaricom Developer Portal</a></li>
                            <li>Create an account and login</li>
                            <li>Create a new app for M-Pesa Express (STK Push)</li>
                            <li>Get your Consumer Key and Consumer Secret</li>
                            <li>Note your Business Short Code and Passkey</li>
                        </ol>
                        
                        <h4>3. Configure Webhook URLs</h4>
                        <p>In your Daraja app settings, configure:</p>
                        <ul>
                            <li><strong>Callback URL:</strong> <code>{$daraja_callback_url}</code></li>
                            <li><strong>Timeout URL:</strong> <code>{$daraja_timeout_url}</code></li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h4>2. Test Configuration</h4>
                        <p>Use sandbox credentials first:</p>
                        <ul>
                            <li><strong>Business Short Code:</strong> 174379</li>
                            <li><strong>Passkey:</strong> Use the sandbox passkey provided</li>
                            <li><strong>Test Phone:</strong> 254708374149</li>
                        </ul>
                        
                        <h4>4. Go Live</h4>
                        <ol>
                            <li>Switch environment to "Production"</li>
                            <li>Update credentials with live values</li>
                            <li>Test with real M-Pesa account</li>
                            <li>Configure Mikrotik hotspot to redirect to payment portal</li>
                        </ol>
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

// Force remove readonly attributes when page loads
document.addEventListener('DOMContentLoaded', function() {
    // Get callback URL field
    var callbackField = document.getElementById('callback_url');
    var timeoutField = document.getElementById('timeout_url');
    
    if (callbackField) {
        callbackField.removeAttribute('readonly');
        callbackField.removeAttribute('disabled');
        callbackField.readOnly = false;
        callbackField.disabled = false;
        console.log('Callback URL field enabled');
    }
    
    if (timeoutField) {
        timeoutField.removeAttribute('readonly');
        timeoutField.removeAttribute('disabled');
        timeoutField.readOnly = false;
        timeoutField.disabled = false;
        console.log('Timeout URL field enabled');
    }
    
    // Double-check after a short delay
    setTimeout(function() {
        if (callbackField) {
            callbackField.removeAttribute('readonly');
            callbackField.readOnly = false;
        }
        if (timeoutField) {
            timeoutField.removeAttribute('readonly');
            timeoutField.readOnly = false;
        }
    }, 500);
});
</script>

{include file="sections/footer.tpl"}