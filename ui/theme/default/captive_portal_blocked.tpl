<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$_title}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .blocked-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .blocked-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            width: 100%;
        }
        .blocked-header {
            background: linear-gradient(135deg, #ff6b6b, #ee5a5a);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .blocked-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.9;
        }
        .blocked-body {
            padding: 40px 30px;
            text-align: center;
        }
        .blocked-reason {
            background: #f8f9fa;
            border-left: 4px solid #ff6b6b;
            padding: 15px;
            margin: 20px 0;
            text-align: left;
            border-radius: 0 8px 8px 0;
        }
        .mac-address {
            font-family: 'Courier New', monospace;
            background: #e9ecef;
            padding: 8px 12px;
            border-radius: 6px;
            display: inline-block;
            margin: 10px 0;
        }
        .blocked-actions {
            margin-top: 30px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .contact-info {
            background: #e3f2fd;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
        .contact-info h6 {
            color: #1976d2;
            margin-bottom: 10px;
        }
        .countdown {
            font-size: 1.2rem;
            font-weight: bold;
            color: #ff6b6b;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <div class="blocked-container">
        <div class="blocked-card">
            <div class="blocked-header">
                <div class="blocked-icon">
                    <i class="fas fa-ban"></i>
                </div>
                <h2>Access Blocked</h2>
                <p class="mb-0">{$_system_name} WiFi Portal</p>
            </div>
            
            <div class="blocked-body">
                <div class="alert alert-danger">
                    <strong><i class="fas fa-exclamation-triangle"></i> Authentication Blocked</strong>
                    <p class="mt-2 mb-0">{$blocked_message}</p>
                </div>
                
                <div class="blocked-reason">
                    <h6><i class="fas fa-info-circle"></i> Block Details</h6>
                    <p class="mb-1"><strong>Reason:</strong> 
                        {if $blocked_reason == 'expired_session_retry'}
                            Previous session expired - New payment required
                        {elseif $blocked_reason == 'suspicious_activity'}
                            Too many authentication attempts
                        {elseif $blocked_reason == 'session_expired'}
                            Session has expired
                        {else}
                            {$blocked_reason}
                        {/if}
                    </p>
                    
                    {if $blocked_since}
                    <p class="mb-1"><strong>Blocked Since:</strong> {$blocked_since}</p>
                    {/if}
                    
                    <p class="mb-0"><strong>Device:</strong> <span class="mac-address">{$mac_address}</span></p>
                </div>
                
                {if $blocked_reason == 'expired_session_retry'}
                <div class="alert alert-info">
                    <h6><i class="fas fa-credit-card"></i> How to Regain Access</h6>
                    <p class="mb-0">Your previous internet session has expired. To regain access, you need to:</p>
                    <ol class="text-left mt-2 mb-0">
                        <li>Make a new payment for an internet package</li>
                        <li>Your device will be automatically unblocked after successful payment</li>
                        <li>You'll then be able to browse the internet again</li>
                    </ol>
                </div>
                {elseif $blocked_reason == 'suspicious_activity'}
                <div class="alert alert-warning">
                    <h6><i class="fas fa-clock"></i> Temporary Block</h6>
                    <p class="mb-0">This is a temporary security measure. Please wait 5 minutes before trying again.</p>
                    <div class="countdown" id="countdown">
                        <i class="fas fa-hourglass-half"></i> Please wait...
                    </div>
                </div>
                {/if}
                
                <div class="blocked-actions">
                    {if $blocked_reason == 'expired_session_retry'}
                    <a href="{$_url}captive_portal" class="btn btn-primary btn-lg">
                        <i class="fas fa-credit-card"></i> Purchase New Package
                    </a>
                    {else}
                    <button class="btn btn-secondary" onclick="history.back()">
                        <i class="fas fa-arrow-left"></i> Go Back
                    </button>
                    {/if}
                </div>
                
                <div class="contact-info">
                    <h6><i class="fas fa-headset"></i> Need Help?</h6>
                    <p class="mb-1">If you believe this is an error, please contact our support team:</p>
                    <p class="mb-0">
                        <i class="fas fa-phone"></i> Call: +254 XXX XXX XXX<br>
                        <i class="fas fa-envelope"></i> Email: support@glintaafrica.com
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.bundle.min.js"></script>
    
    {if $blocked_reason == 'suspicious_activity'}
    <script>
    // Countdown timer for suspicious activity blocks
    $(document).ready(function() {
        var countdownMinutes = 5;
        var countdownSeconds = countdownMinutes * 60;
        
        function updateCountdown() {
            var minutes = Math.floor(countdownSeconds / 60);
            var seconds = countdownSeconds % 60;
            
            $('#countdown').html('<i class="fas fa-hourglass-half"></i> ' + minutes + ':' + (seconds < 10 ? '0' : '') + seconds + ' remaining');
            
            if (countdownSeconds <= 0) {
                $('#countdown').html('<i class="fas fa-check-circle"></i> You may try again now');
                $('.btn-secondary').prop('disabled', false).removeClass('btn-secondary').addClass('btn-primary').html('<i class="fas fa-redo"></i> Try Again');
                return;
            }
            
            countdownSeconds--;
            setTimeout(updateCountdown, 1000);
        }
        
        updateCountdown();
    });
    </script>
    {/if}
</body>
</html>