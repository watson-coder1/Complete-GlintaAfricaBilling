<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Payment Status - Glinta Africa WiFi</title>
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
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--kenya-black) 0%, #1a1a1a 25%, var(--kenya-green) 75%, var(--glinta-gold) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .status-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .logo {
            font-family: 'Lobster', cursive;
            font-size: 2.5rem;
            color: var(--kenya-green);
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .status-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            animation: pulse 2s infinite;
        }
        
        .status-icon.pending {
            background: linear-gradient(135deg, var(--warning-orange), #fbbf24);
            color: white;
        }
        
        .status-icon.success {
            background: linear-gradient(135deg, var(--success-green), #34d399);
            color: white;
        }
        
        .status-icon.error {
            background: linear-gradient(135deg, var(--error-red), #f87171);
            color: white;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .status-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--kenya-black);
            margin-bottom: 15px;
        }
        
        .status-message {
            font-size: 1rem;
            color: #6b7280;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 20px;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--kenya-green), var(--glinta-gold));
            border-radius: 4px;
            animation: loading 2s ease-in-out infinite;
        }
        
        @keyframes loading {
            0% { width: 30%; }
            50% { width: 70%; }
            100% { width: 30%; }
        }
        
        .plan-info {
            background: #f9fafb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
        }
        
        .plan-info h3 {
            color: var(--kenya-green);
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .plan-detail {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }
        
        .plan-detail span:first-child {
            color: #6b7280;
        }
        
        .plan-detail span:last-child {
            color: var(--kenya-black);
            font-weight: 500;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
            font-size: 0.9rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--kenya-green), #047857);
            color: white;
        }
        
        .btn-secondary {
            background: #f3f4f6;
            color: var(--kenya-black);
            border: 1px solid #d1d5db;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .timer {
            background: #fef3c7;
            border: 1px solid #fbbf24;
            border-radius: 8px;
            padding: 15px;
            margin-top: 20px;
        }
        
        .timer-text {
            color: #92400e;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        /* Mobile responsiveness */
        @media (max-width: 480px) {
            .status-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .logo {
                font-size: 2rem;
            }
            
            .status-icon {
                width: 60px;
                height: 60px;
                font-size: 2rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
        
        /* Status-specific styles */
        .status-pending .status-icon {
            animation: spin 2s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        .auto-refresh-notice {
            background: #e0f2fe;
            border: 1px solid #0891b2;
            border-radius: 8px;
            padding: 12px;
            margin-top: 15px;
        }
        
        .auto-refresh-notice p {
            color: #0c4a6e;
            font-size: 0.85rem;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="status-container">
        <div class="logo">Glinta Africa</div>
        
        <div class="status-icon pending" id="statusIcon">
            ⏳
        </div>
        
        <h1 class="status-title" id="statusTitle">Checking Payment Status</h1>
        <p class="status-message" id="statusMessage">Please wait while we verify your M-Pesa payment...</p>
        
        <div class="progress-bar">
            <div class="progress-fill" id="progressFill"></div>
        </div>
        
        {if $plan}
        <div class="plan-info">
            <h3>Selected Package</h3>
            <div class="plan-detail">
                <span>Package:</span>
                <span>{$plan.name_plan}</span>
            </div>
            <div class="plan-detail">
                <span>Duration:</span>
                <span>{$plan.validity} {$plan.validity_unit}</span>
            </div>
            <div class="plan-detail">
                <span>Price:</span>
                <span>KES {$plan.price}</span>
            </div>
            {if $session.phone_number}
            <div class="plan-detail">
                <span>Phone:</span>
                <span>{$session.phone_number}</span>
            </div>
            {/if}
        </div>
        {/if}
        
        <div class="action-buttons">
            <button class="btn btn-primary" onclick="checkStatus()" id="checkBtn">
                Check Again
            </button>
            <a href="{$_url}captive_portal" class="btn btn-secondary">
                Start Over
            </a>
        </div>
        
        <div class="auto-refresh-notice">
            <p>
                <strong>Auto-checking every 5 seconds</strong><br>
                This page will automatically refresh when payment is confirmed.
            </p>
        </div>
        
        <div class="timer" id="timer" style="display: none;">
            <div class="timer-text">
                Timeout in: <span id="countdown">120</span> seconds
            </div>
        </div>
    </div>

    <script>
        let checkInterval;
        let timeoutCounter = 120; // 2 minutes timeout
        let countdownInterval;
        
        function checkStatus() {
            const sessionId = '{$session.session_id}';
            const checkBtn = document.getElementById('checkBtn');
            const statusIcon = document.getElementById('statusIcon');
            const statusTitle = document.getElementById('statusTitle');
            const statusMessage = document.getElementById('statusMessage');
            
            checkBtn.disabled = true;
            checkBtn.textContent = 'Checking...';
            
            fetch('{$_url}captive_portal/status/' + sessionId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'completed') {
                    // Payment successful
                    statusIcon.className = 'status-icon success';
                    statusIcon.textContent = '✅';
                    statusTitle.textContent = 'Payment Successful!';
                    statusMessage.textContent = data.message;
                    
                    clearInterval(checkInterval);
                    clearInterval(countdownInterval);
                    
                    // Redirect after a moment
                    setTimeout(() => {
                        window.location.href = data.redirect;
                    }, 2000);
                } else if (data.status === 'error') {
                    // Payment failed
                    statusIcon.className = 'status-icon error';
                    statusIcon.textContent = '❌';
                    statusTitle.textContent = 'Payment Failed';
                    statusMessage.textContent = data.message;
                    
                    clearInterval(checkInterval);
                    clearInterval(countdownInterval);
                } else {
                    // Still pending
                    statusMessage.textContent = data.message || 'Waiting for payment confirmation...';
                }
                
                checkBtn.disabled = false;
                checkBtn.textContent = 'Check Again';
            })
            .catch(error => {
                console.error('Status check error:', error);
                checkBtn.disabled = false;
                checkBtn.textContent = 'Check Again';
                statusMessage.textContent = 'Error checking status. Please try again.';
            });
        }
        
        function startCountdown() {
            const timerElement = document.getElementById('timer');
            const countdownElement = document.getElementById('countdown');
            
            timerElement.style.display = 'block';
            
            countdownInterval = setInterval(() => {
                timeoutCounter--;
                countdownElement.textContent = timeoutCounter;
                
                if (timeoutCounter <= 0) {
                    clearInterval(countdownInterval);
                    clearInterval(checkInterval);
                    
                    document.getElementById('statusIcon').className = 'status-icon error';
                    document.getElementById('statusIcon').textContent = '⏰';
                    document.getElementById('statusTitle').textContent = 'Payment Timeout';
                    document.getElementById('statusMessage').textContent = 'Payment verification timed out. If you completed the payment, please contact support.';
                }
            }, 1000);
        }
        
        // Auto-check every 5 seconds
        checkInterval = setInterval(checkStatus, 5000);
        
        // Start countdown timer
        startCountdown();
        
        // Initial check
        checkStatus();
        
        // Cleanup on page unload
        window.addEventListener('beforeunload', () => {
            clearInterval(checkInterval);
            clearInterval(countdownInterval);
        });
    </script>
</body>
</html>