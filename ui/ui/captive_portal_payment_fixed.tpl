<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="theme-color" content="#006B3F">
    <title>{$_title}</title>
    <link rel="shortcut icon" href="{$_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <style>
        :root {
            --kenya-black: #000000;
            --kenya-red: #CE1126;
            --kenya-green: #006B3F;
            --kenya-white: #FFFFFF;
            --glinta-gold: #FFD700;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, var(--kenya-black), var(--kenya-green), var(--glinta-gold));
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Loading animation */
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(0.95); opacity: 0.7; }
        }
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        /* Container */
        .payment-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            position: relative;
            z-index: 10;
        }
        
        /* Brand section */
        .brand-section {
            margin-bottom: 30px;
        }
        
        .logo {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: var(--glinta-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            color: var(--kenya-black);
            box-shadow: 0 4px 20px rgba(255, 215, 0, 0.4);
        }
        
        .brand-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--kenya-black);
            margin-bottom: 5px;
        }
        
        .brand-subtitle {
            font-size: 16px;
            color: #666;
        }
        
        /* Payment Status */
        .payment-status {
            margin: 40px 0;
        }
        
        .payment-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 20px;
            font-size: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            position: relative;
        }
        
        .payment-icon.processing {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
            animation: pulse 2s infinite;
        }
        
        .payment-icon.processing::after {
            content: '';
            position: absolute;
            top: -4px;
            left: -4px;
            right: -4px;
            bottom: -4px;
            background: linear-gradient(45deg, #3b82f6, #1d4ed8, #3b82f6);
            border-radius: 50%;
            z-index: -1;
            animation: rotate 2s linear infinite;
        }
        
        .payment-icon.success {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }
        
        .payment-icon.failed {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }
        
        .status-text {
            font-size: 24px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 10px;
        }
        
        .status-message {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
        }
        
        /* Package info */
        .package-info {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin: 30px 0;
            border-left: 4px solid var(--kenya-green);
        }
        
        .package-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
        }
        
        .package-details {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            font-size: 14px;
        }
        
        .package-details span:first-child {
            color: #666;
        }
        
        .package-details span:last-child {
            font-weight: 600;
            color: var(--kenya-black);
        }
        
        /* Actions */
        .actions {
            margin-top: 30px;
            display: none;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--kenya-green), #059669);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 107, 63, 0.4);
        }
        
        .btn-secondary {
            background: #e5e7eb;
            color: var(--kenya-black);
        }
        
        .btn-secondary:hover {
            background: #d1d5db;
        }
        
        /* Help section */
        .help-section {
            margin-top: 30px;
            padding: 20px;
            background: #fef3c7;
            border-radius: 15px;
            border: 1px solid #fcd34d;
        }
        
        .help-title {
            font-size: 16px;
            font-weight: 600;
            color: #92400e;
            margin-bottom: 10px;
        }
        
        .help-text {
            font-size: 14px;
            color: #92400e;
            line-height: 1.6;
        }
        
        /* Loading spinner */
        .spinner {
            width: 40px;
            height: 40px;
            border: 3px solid #e5e7eb;
            border-top: 3px solid var(--kenya-green);
            border-radius: 50%;
            animation: rotate 1s linear infinite;
            margin: 20px auto;
        }
        
        /* Mobile responsive */
        @media (max-width: 640px) {
            .payment-container {
                padding: 30px 20px;
            }
            
            .brand-title {
                font-size: 24px;
            }
            
            .status-text {
                font-size: 20px;
            }
            
            .payment-icon {
                width: 100px;
                height: 100px;
                font-size: 50px;
            }
        }
        
        /* Debug info - Remove in production */
        .debug-info {
            position: fixed;
            bottom: 10px;
            left: 10px;
            right: 10px;
            background: yellow;
            color: black;
            padding: 10px;
            border-radius: 5px;
            font-size: 11px;
            font-family: monospace;
            max-height: 200px;
            overflow-y: auto;
            z-index: 9999;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <!-- Brand Section -->
        <div class="brand-section">
            <div class="logo">G</div>
            <h1 class="brand-title">Glinta Africa</h1>
            <p class="brand-subtitle">Premium WiFi Services</p>
        </div>
        
        <!-- Payment Status -->
        <div class="payment-status">
            <div class="payment-icon processing" id="paymentIcon">📱</div>
            <h2 class="status-text" id="statusText">Processing M-Pesa Payment</h2>
            <p class="status-message" id="statusMessage">
                Check your phone for the M-Pesa prompt and enter your PIN to complete the payment.
            </p>
            <div class="spinner" id="spinner"></div>
        </div>
        
        <!-- Package Info -->
        {if $plan}
        <div class="package-info">
            <h3 class="package-title">Package Details</h3>
            <div class="package-details">
                <span>Package:</span>
                <span>{$plan->name_plan}</span>
            </div>
            <div class="package-details">
                <span>Amount:</span>
                <span>KES {$plan->price}</span>
            </div>
            <div class="package-details">
                <span>Duration:</span>
                <span>{$plan->validity} {$plan->validity_unit}</span>
            </div>
        </div>
        {/if}
        
        <!-- Actions (hidden by default) -->
        <div class="actions" id="actions">
            <button class="btn btn-primary" onclick="window.location.href='{$_url}captive_portal/success/{$session_id}'">
                Continue to Internet
            </button>
            <button class="btn btn-secondary" onclick="window.location.href='{$_url}captive_portal'">
                Back to Portal
            </button>
        </div>
        
        <!-- Help Section -->
        <div class="help-section">
            <h4 class="help-title">Need Help?</h4>
            <p class="help-text">
                If you don't receive the M-Pesa prompt, ensure you have sufficient balance and try again. 
                For support, call <strong>0711311897</strong> or email <strong>support@glintaafrica.com</strong>
            </p>
        </div>
    </div>
    
    <!-- Debug Info - Remove in production -->
    <div class="debug-info" id="debugInfo">
        <strong>DEBUG INFO:</strong><br>
        Session ID: {$session_id}<br>
        URL: {$_url}<br>
        <div id="debugLog"></div>
    </div>
    
    <!-- Hidden inputs for JavaScript -->
    <input type="hidden" id="sessionId" value="{$session_id}">
    <input type="hidden" id="baseUrl" value="{$_url}">
    <input type="hidden" id="paymentId" value="{if $payment}{$payment->id}{else}0{/if}">
    
    <script>
        // Configuration
        const CHECK_INTERVAL = 3000; // 3 seconds
        const MAX_CHECKS = 40; // 2 minutes total
        let checkCount = 0;
        
        // Get values from hidden inputs
        const sessionId = document.getElementById('sessionId').value;
        const baseUrl = document.getElementById('baseUrl').value;
        const paymentId = document.getElementById('paymentId').value;
        
        // Debug logging
        function log(message) {
            console.log(message);
            const debugLog = document.getElementById('debugLog');
            const time = new Date().toLocaleTimeString();
            debugLog.innerHTML += time + ' - ' + message + '<br>';
        }
        
        // Initialize
        log('Payment monitoring started');
        log('Session ID: ' + sessionId);
        log('Base URL: ' + baseUrl);
        
        // Validate session ID
        if (!sessionId || sessionId === '' || sessionId.indexOf('{') !== -1 || sessionId.indexOf('$') !== -1) {
            log('ERROR: Invalid session ID');
            updateStatus('failed', 'Session Error', 'Invalid session. Please try again.');
            document.getElementById('spinner').style.display = 'none';
            document.getElementById('actions').style.display = 'block';
            return;
        }
        
        // Update UI
        function updateStatus(type, title, message) {
            const icon = document.getElementById('paymentIcon');
            const text = document.getElementById('statusText');
            const msg = document.getElementById('statusMessage');
            
            text.textContent = title;
            msg.textContent = message;
            
            if (type === 'success') {
                icon.className = 'payment-icon success';
                icon.textContent = '✅';
            } else if (type === 'failed') {
                icon.className = 'payment-icon failed';
                icon.textContent = '❌';
            }
        }
        
        // Check payment status
        function checkPaymentStatus() {
            checkCount++;
            log('Checking payment status... (attempt ' + checkCount + ')');
            
            if (checkCount > MAX_CHECKS) {
                log('Max checks reached. Timeout.');
                updateStatus('failed', 'Timeout', 'Payment check timed out. If you completed the payment, please refresh this page.');
                document.getElementById('spinner').style.display = 'none';
                document.getElementById('actions').style.display = 'block';
                return;
            }
            
            const url = baseUrl + 'captive_portal/status/' + sessionId;
            log('Fetching: ' + url);
            
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify({ check: true })
            })
            .then(response => {
                log('Response status: ' + response.status);
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                log('Response data: ' + JSON.stringify(data));
                
                if (data.status === 'completed') {
                    log('Payment completed! Redirecting...');
                    updateStatus('success', 'Payment Successful!', 'Your payment has been processed. Redirecting...');
                    document.getElementById('spinner').style.display = 'none';
                    
                    setTimeout(() => {
                        window.location.href = data.redirect || baseUrl + 'captive_portal/success/' + sessionId;
                    }, 2000);
                } else if (data.status === 'failed') {
                    log('Payment failed');
                    updateStatus('failed', 'Payment Failed', data.message || 'Payment was not successful. Please try again.');
                    document.getElementById('spinner').style.display = 'none';
                    document.getElementById('actions').style.display = 'block';
                } else {
                    // Still pending, check again
                    setTimeout(checkPaymentStatus, CHECK_INTERVAL);
                }
            })
            .catch(error => {
                log('Fetch error: ' + error.message);
                // Continue checking despite errors
                setTimeout(checkPaymentStatus, CHECK_INTERVAL);
            });
        }
        
        // Start checking after a short delay
        setTimeout(checkPaymentStatus, 2000);
        
        // Quick status check on load
        fetch(baseUrl + 'captive_portal/status/' + sessionId + '?quick=1')
            .then(response => response.json())
            .then(data => {
                if (data.status === 'completed') {
                    log('Already completed on load');
                    updateStatus('success', 'Payment Successful!', 'Your payment has been processed. Redirecting...');
                    document.getElementById('spinner').style.display = 'none';
                    setTimeout(() => {
                        window.location.href = data.redirect || baseUrl + 'captive_portal/success/' + sessionId;
                    }, 2000);
                }
            })
            .catch(error => {
                log('Quick check error: ' + error.message);
            });
    </script>
</body>
</html>