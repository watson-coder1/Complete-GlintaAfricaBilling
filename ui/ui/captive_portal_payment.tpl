<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="theme-color" content="#000000">
    <title>Processing Payment - Glinta Africa WiFi</title>
    <link rel="shortcut icon" href="{$_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --kenya-black: #000000;
            --kenya-red: #CE1126;
            --kenya-green: #006B3F;
            --kenya-white: #FFFFFF;
            --glinta-gold: #FFD700;
            --success-green: #10b981;
            --warning-orange: #f59e0b;
            --error-red: #ef4444;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html {
            height: 100%;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--kenya-black) 0%, #1a1a1a 25%, var(--kenya-green) 75%, var(--glinta-gold) 100%);
            min-height: 100vh;
            min-height: -webkit-fill-available; /* iOS Safari fix */
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding: 15px;
            padding-top: 20px;
            overflow-x: hidden;
            overflow-y: auto;
            /* Allow scrolling but prevent pull-to-refresh */
            overscroll-behavior-y: contain;
            -webkit-overflow-scrolling: touch;
            /* Ensure full width and proper centering */
            position: relative;
            width: 100%;
            box-sizing: border-box;
        }
        
        /* Fix for mobile viewport issues */
        html {
            height: 100%;
            height: -webkit-fill-available; /* iOS Safari */
        }
        
        /* Ensure consistent centering on mobile */
        @supports (-webkit-touch-callout: none) {
            body {
                height: -webkit-fill-available;
            }
        }
        
        /* Animated background */
        .bg-particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }
        
        .particle {
            position: absolute;
            background: radial-gradient(circle, rgba(255, 215, 0, 0.4) 0%, rgba(255, 215, 0, 0) 70%);
            border-radius: 50%;
            animation: float-particle 20s infinite linear;
        }
        
        .particle:nth-child(1) { width: 100px; height: 100px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 80px; height: 80px; left: 70%; animation-delay: 5s; }
        .particle:nth-child(3) { width: 120px; height: 120px; left: 40%; animation-delay: 10s; }
        .particle:nth-child(4) { width: 90px; height: 90px; left: 85%; animation-delay: 15s; }
        
        @keyframes float-particle {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10%, 90% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-100vh) rotate(360deg);
                opacity: 0;
            }
        }
        
        /* Main container */
        .payment-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3),
                        0 0 100px rgba(255, 215, 0, 0.2);
            padding: 50px 40px;
            max-width: 550px;
            width: 100%;
            text-align: center;
            position: relative;
            z-index: 10;
            border: 2px solid rgba(255, 215, 0, 0.3);
            animation: container-entrance 0.8s ease-out;
            /* Allow container to grow with content */
            min-width: 300px;
            margin: 20px auto;
            overflow-y: auto;
            max-height: none;
        }
        
        @keyframes container-entrance {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        /* Header */
        .brand-header {
            margin-bottom: 35px;
            animation: slide-down 0.8s ease-out 0.3s both;
        }
        
        @keyframes slide-down {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .brand-logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--glinta-gold), #ffa500);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Lobster', cursive;
            font-size: 40px;
            color: var(--kenya-black);
            margin: 0 auto 15px;
            box-shadow: 0 10px 30px rgba(255, 215, 0, 0.4);
            animation: logo-pulse 2s infinite;
        }
        
        @keyframes logo-pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 10px 30px rgba(255, 215, 0, 0.4);
            }
            50% {
                transform: scale(1.1);
                box-shadow: 0 15px 40px rgba(255, 215, 0, 0.6);
            }
        }
        
        .brand-title {
            font-family: 'Lobster', cursive;
            font-size: 32px;
            color: var(--glinta-gold);
            margin-bottom: 5px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .brand-subtitle {
            font-size: 14px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        /* Payment status */
        .payment-status {
            margin-bottom: 35px;
            animation: slide-up 0.8s ease-out 0.5s both;
        }
        
        @keyframes slide-up {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .payment-icon {
            font-size: 80px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        
        .payment-icon.processing {
            color: var(--warning-orange);
            animation: icon-pulse 2s infinite;
        }
        
        .payment-icon.success {
            color: var(--success-green);
            animation: icon-bounce 0.6s ease-out;
        }
        
        .payment-icon.error {
            color: var(--error-red);
            animation: icon-shake 0.5s ease-out;
        }
        
        @keyframes icon-pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.8;
            }
        }
        
        @keyframes icon-bounce {
            0%, 20%, 53%, 80%, 100% {
                transform: translate3d(0,0,0);
            }
            40%, 43% {
                transform: translate3d(0,-30px,0);
            }
            70% {
                transform: translate3d(0,-15px,0);
            }
            90% {
                transform: translate3d(0,-4px,0);
            }
        }
        
        @keyframes icon-shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
            20%, 40%, 60%, 80% { transform: translateX(10px); }
        }
        
        .payment-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--kenya-black);
            margin-bottom: 15px;
        }
        
        .payment-message {
            font-size: 16px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        /* Package summary */
        .package-summary {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 35px;
            border-left: 5px solid var(--kenya-green);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            animation: slide-up 0.8s ease-out 0.7s both;
        }
        
        .package-header {
            font-size: 20px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .package-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 20px;
        }
        
        .package-detail {
            background: var(--kenya-white);
            padding: 15px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .package-detail:hover {
            transform: translateY(-3px);
        }
        
        .detail-value {
            font-size: 20px;
            font-weight: 700;
            color: var(--kenya-green);
            margin-bottom: 5px;
        }
        
        .detail-label {
            font-size: 12px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }
        
        /* Payment steps */
        .payment-steps {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 35px;
            animation: slide-up 0.8s ease-out 0.9s both;
        }
        
        .steps-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .step {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(226, 232, 240, 0.5);
            transition: all 0.3s ease;
        }
        
        .step:last-child {
            border-bottom: none;
        }
        
        .step:hover {
            background: rgba(255, 255, 255, 0.5);
            border-radius: 10px;
            padding: 12px 15px;
        }
        
        .step-number {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, var(--kenya-green), var(--success-green));
            color: var(--kenya-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: bold;
            flex-shrink: 0;
            box-shadow: 0 4px 10px rgba(0, 107, 63, 0.3);
        }
        
        .step-text {
            font-size: 14px;
            color: #64748b;
            text-align: left;
            flex: 1;
        }
        
        /* Loading indicator */
        .loading-section {
            margin: 35px 0;
            animation: slide-up 0.8s ease-out 1.1s both;
        }
        
        .loading-spinner {
            width: 60px;
            height: 60px;
            margin: 0 auto 20px;
            position: relative;
        }
        
        .spinner-ring {
            position: absolute;
            width: 100%;
            height: 100%;
            border: 3px solid transparent;
            border-radius: 50%;
        }
        
        .spinner-ring:nth-child(1) {
            border-top-color: var(--kenya-green);
            animation: spin 1.5s linear infinite;
        }
        
        .spinner-ring:nth-child(2) {
            border-right-color: var(--glinta-gold);
            animation: spin 2s linear infinite reverse;
            width: 80%;
            height: 80%;
            top: 10%;
            left: 10%;
        }
        
        .spinner-ring:nth-child(3) {
            border-bottom-color: var(--kenya-green);
            animation: spin 2.5s linear infinite;
            width: 60%;
            height: 60%;
            top: 20%;
            left: 20%;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .loading-text {
            font-size: 18px;
            color: var(--kenya-green);
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .loading-subtitle {
            font-size: 14px;
            color: #64748b;
        }
        
        /* Status messages */
        .status-alert {
            padding: 20px;
            border-radius: 15px;
            margin: 25px 0;
            border-left: 4px solid;
            animation: alert-slide-in 0.5s ease-out;
            display: none;
        }
        
        @keyframes alert-slide-in {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .status-alert.success {
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            border-left-color: var(--success-green);
            color: #065f46;
        }
        
        .status-alert.error {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            border-left-color: var(--error-red);
            color: #991b1b;
        }
        
        .status-alert.warning {
            background: linear-gradient(135deg, #fffbeb, #fef3c7);
            border-left-color: var(--warning-orange);
            color: #92400e;
        }
        
        /* Countdown */
        .countdown {
            font-size: 20px;
            font-weight: 600;
            color: var(--kenya-green);
            margin: 25px 0;
            animation: countdown-pulse 1s infinite;
            display: none;
        }
        
        @keyframes countdown-pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        /* Help section */
        .help-section {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 20px;
            padding: 25px;
            text-align: left;
            animation: slide-up 0.8s ease-out 1.3s both;
        }
        
        .help-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .help-content {
            font-size: 14px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .help-list {
            list-style: none;
            padding: 0;
            margin: 15px 0;
        }
        
        .help-list li {
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
        }
        
        .help-list li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: var(--success-green);
            font-weight: bold;
        }
        
        .contact-info {
            background: var(--kenya-white);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }
        
        .contact-title {
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
            font-size: 16px;
        }
        
        .contact-details {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .contact-item {
            font-size: 13px;
            color: var(--kenya-green);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            body {
                padding: 8px;
                padding-top: 10px;
                padding-bottom: 10px;
            }
            
            .payment-container {
                padding: 20px 15px;
                margin: 10px auto;
                width: calc(100% - 16px);
                max-width: none;
                border-radius: 15px;
                min-height: auto;
                box-sizing: border-box;
            }
            
            .brand-logo {
                width: 60px;
                height: 60px;
                font-size: 30px;
            }
            
            .brand-title {
                font-size: 26px;
            }
            
            .payment-icon {
                font-size: 60px;
            }
            
            .payment-title {
                font-size: 24px;
            }
            
            .package-details {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .contact-details {
                flex-direction: column;
                gap: 10px;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 5px;
                padding-top: 8px;
            }
            
            .payment-container {
                padding: 15px 12px;
                border-radius: 12px;
                width: calc(100% - 10px);
                margin: 5px auto;
                box-sizing: border-box;
            }
            
            .package-details {
                grid-template-columns: 1fr;
            }
        }
        
        /* Button styles */
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--kenya-green), var(--success-green));
            color: var(--kenya-white);
            box-shadow: 0 4px 15px rgba(0, 107, 63, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #065f46, var(--kenya-green));
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 107, 63, 0.4);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #64748b, #475569);
            color: var(--kenya-white);
            box-shadow: 0 4px 15px rgba(100, 116, 139, 0.3);
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #475569, #64748b);
            transform: translateY(-2px);
        }
        
        .actions {
            margin-top: 30px;
            display: none;
        }
        
        .actions.show {
            display: block;
            animation: slide-up 0.5s ease-out;
        }
    </style>
</head>
<body>
    <!-- Background Animation -->
    <div class="bg-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <!-- Main Container -->
    <div class="payment-container">
        <!-- Brand Header -->
        <div class="brand-header">
            <div class="brand-logo">G</div>
            <h1 class="brand-title">Glinta Africa</h1>
            <p class="brand-subtitle">Premium WiFi Solutions</p>
        </div>
        
        <!-- Payment Status -->
        <div class="payment-status">
            <div class="payment-icon processing" id="paymentIcon">📱</div>
            <h2 class="payment-title" id="paymentTitle">Processing M-Pesa Payment</h2>
            <p class="payment-message" id="paymentMessage">
                Check your phone for the M-Pesa STK push notification and enter your PIN to complete the transaction.
            </p>
        </div>
        
        <!-- Package Summary -->
        {if $plan}
        <div class="package-summary">
            <div class="package-header">
                <span>📦</span>
                <span>Package: {$plan->name_plan}</span>
            </div>
            <div class="package-details">
                <div class="package-detail">
                    <div class="detail-value">KES {$plan->price}</div>
                    <div class="detail-label">Amount</div>
                </div>
                <div class="package-detail">
                    <div class="detail-value">{$plan->validity}</div>
                    <div class="detail-label">{$plan->validity_unit}</div>
                </div>
                <div class="package-detail">
                    <div class="detail-value">🚀</div>
                    <div class="detail-label">High Speed</div>
                </div>
                {if $plan->data_limit}
                <div class="package-detail">
                    <div class="detail-value">{$plan->data_limit}</div>
                    <div class="detail-label">Data Limit</div>
                </div>
                {/if}
            </div>
        </div>
        {/if}
        
        <!-- Payment Steps -->
        <div class="payment-steps">
            <div class="steps-title">
                <span>📋</span>
                <span>Payment Process</span>
            </div>
            <div class="step">
                <div class="step-number">1</div>
                <div class="step-text">Check your phone for M-Pesa STK push notification</div>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <div class="step-text">Enter your M-Pesa PIN to authorize the payment</div>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <div class="step-text">Wait for confirmation and automatic internet activation</div>
            </div>
        </div>
        
        <!-- Loading Section -->
        <div class="loading-section" id="loadingSection">
            <div class="loading-spinner">
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
            </div>
            <div class="loading-text" id="loadingText">Waiting for payment confirmation...</div>
            <div class="loading-subtitle">Please complete the M-Pesa payment on your phone</div>
        </div>
        
        <!-- Status Alert -->
        <div class="status-alert" id="statusAlert">
            <div id="statusText"></div>
        </div>
        
        <!-- Countdown -->
        <div class="countdown" id="countdown">
            Redirecting in <span id="countdownNumber">5</span> seconds...
        </div>
        
        <!-- Action Buttons -->
        <div class="actions" id="actions">
            <button class="btn btn-primary" onclick="window.location.href='{$_url}captive_portal/success/{$session->session_id}'">
                Continue to WiFi
            </button>
            <button class="btn btn-secondary" onclick="window.location.href='{$_url}captive_portal'">
                Back to Portal
            </button>
        </div>
        
        <!-- Help Section -->
        <div class="help-section">
            <div class="help-title">
                <span>❓</span>
                <span>Payment Help</span>
            </div>
            <div class="help-content">
                <p><strong>Payment not working?</strong></p>
                <ul class="help-list">
                    <li>Ensure you have sufficient M-Pesa balance</li>
                    <li>Check if your phone number is registered for M-Pesa</li>
                    <li>Try again after a few minutes if STK push fails</li>
                    <li>Contact support if the problem persists</li>
                </ul>
                
                <div class="contact-info">
                    <div class="contact-title">🚨 Need Immediate Help?</div>
                    <div class="contact-details">
                        <div class="contact-item">📧 support@glintaafrica.com</div>
                        <div class="contact-item">📞 0711311897</div>
                        <div class="contact-item">💬 WhatsApp Support</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // IMMEDIATE TEST: Force JavaScript execution detection
        setTimeout(function() {
            // Try to send a simple ping to prove JS is working
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '{$_url}captive_portal/debug_log');
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.send(JSON.stringify({message: 'BASIC JS TEST: JavaScript is executing'}));
        }, 100);
        
        // Session data from PHP  
        var sessionId = '{$session_id}';
        var paymentId = '{if $payment}{$payment->id}{else}null{/if}';
        
        // Test if variables are loading
        setTimeout(function() {
            var xhr2 = new XMLHttpRequest();
            xhr2.open('POST', '{$_url}captive_portal/debug_log');
            xhr2.setRequestHeader('Content-Type', 'application/json');
            xhr2.send(JSON.stringify({message: 'SESSION ID TEST: ' + sessionId}));
        }, 200);
        
        // Alert and simple polling if session ID exists
        if (sessionId && sessionId !== '' && sessionId !== '{$session_id}') {
            // Start simple polling every 3 seconds
            setTimeout(function() {
                var pollCount = 0;
                var interval = setInterval(function() {
                    pollCount++;
                    var xhr3 = new XMLHttpRequest();
                    xhr3.open('POST', '{$_url}captive_portal/status/' + sessionId);
                    xhr3.setRequestHeader('Content-Type', 'application/json');
                    xhr3.onload = function() {
                        if (xhr3.status === 200) {
                            var data = JSON.parse(xhr3.responseText);
                            if (data.status === 'completed') {
                                clearInterval(interval);
                                window.location.href = data.redirect || '{$_url}captive_portal/success/' + sessionId;
                            }
                        }
                    };
                    xhr3.send(JSON.stringify({check: true}));
                    
                    // Stop after 20 attempts (1 minute)
                    if (pollCount >= 20) {
                        clearInterval(interval);
                    }
                }, 3000);
            }, 2000);
        } else {
            alert('Session ID missing! Redirecting...');
            setTimeout(function() {
                window.location.href = '{$_url}captive_portal';
            }, 2000);
        }
        
        // Start simple polling after 2 seconds
        setTimeout(function() {
            var pollCount = 0;
            var maxPolls = 40;
            
            function pollStatus() {
                pollCount++;
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '{$_url}captive_portal/status/' + sessionId, true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        try {
                            var data = JSON.parse(xhr.responseText);
                            if (data.status === 'completed') {
                                window.location.href = data.redirect || '{$_url}captive_portal/success/' + sessionId;
                            } else if (pollCount < maxPolls) {
                                setTimeout(pollStatus, 3000);
                            }
                        } catch (e) {
                            if (pollCount < maxPolls) setTimeout(pollStatus, 3000);
                        }
                    } else if (pollCount < maxPolls) {
                        setTimeout(pollStatus, 3000);
                    }
                };
                
                xhr.send(JSON.stringify({check: true}));
            }
            
            pollStatus();
        }, 2000);
    </script>
</body>
</html>
