<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="theme-color" content="#000000">
    <title>Welcome to Glinta WiFi - Internet Access Active</title>
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
            align-items: flex-start;
            justify-content: center;
            padding: 15px;
            padding-top: 20px;
            position: relative;
            overflow-x: hidden;
            overflow-y: auto;
            /* Prevent pull-to-refresh deformation while allowing scroll */
            overscroll-behavior-y: contain;
            -webkit-overflow-scrolling: touch;
        }
        
        /* Celebration animation background */
        .celebration-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }
        
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: var(--glinta-gold);
            animation: confetti-fall 3s linear infinite;
        }
        
        .confetti:nth-child(1) { left: 10%; animation-delay: 0s; background: var(--glinta-gold); }
        .confetti:nth-child(2) { left: 20%; animation-delay: 0.3s; background: var(--kenya-green); }
        .confetti:nth-child(3) { left: 30%; animation-delay: 0.6s; background: var(--glinta-gold); }
        .confetti:nth-child(4) { left: 40%; animation-delay: 0.9s; background: var(--success-green); }
        .confetti:nth-child(5) { left: 50%; animation-delay: 1.2s; background: var(--glinta-gold); }
        .confetti:nth-child(6) { left: 60%; animation-delay: 1.5s; background: var(--kenya-green); }
        .confetti:nth-child(7) { left: 70%; animation-delay: 1.8s; background: var(--glinta-gold); }
        .confetti:nth-child(8) { left: 80%; animation-delay: 2.1s; background: var(--success-green); }
        .confetti:nth-child(9) { left: 90%; animation-delay: 2.4s; background: var(--glinta-gold); }
        
        @keyframes confetti-fall {
            0% {
                transform: translateY(-100vh) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
        
        /* Success container */
        .success-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3),
                        0 0 100px rgba(16, 185, 129, 0.3);
            padding: 50px 40px;
            max-width: 600px;
            width: 100%;
            text-align: center;
            position: relative;
            z-index: 10;
            border: 2px solid rgba(16, 185, 129, 0.3);
            animation: container-entrance 1s ease-out;
        }
        
        @keyframes container-entrance {
            0% {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            50% {
                opacity: 0.8;
                transform: translateY(-10px) scale(1.02);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        /* Success icon */
        .success-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--success-green), #34d399);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            color: var(--kenya-white);
            margin: 0 auto 30px;
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.4);
            animation: success-bounce 1s ease-out 0.5s both;
            position: relative;
        }
        
        .success-icon::before {
            content: '';
            position: absolute;
            top: -20px;
            left: -20px;
            right: -20px;
            bottom: -20px;
            background: linear-gradient(45deg, transparent, rgba(16, 185, 129, 0.2), transparent);
            border-radius: 50%;
            animation: rotate-glow 3s linear infinite;
        }
        
        @keyframes success-bounce {
            0% {
                transform: scale(0);
                opacity: 0;
            }
            50% {
                transform: scale(1.2);
                opacity: 0.8;
            }
            75% {
                transform: scale(0.9);
                opacity: 1;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        @keyframes rotate-glow {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        /* Brand section */
        .brand-section {
            margin-bottom: 35px;
            animation: slide-up 0.8s ease-out 1s both;
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
        
        .brand-title {
            font-family: 'Lobster', cursive;
            font-size: 36px;
            color: var(--glinta-gold);
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .brand-subtitle {
            font-size: 16px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        /* Success message */
        .success-message {
            margin-bottom: 35px;
            animation: slide-up 0.8s ease-out 1.2s both;
        }
        
        .success-title {
            font-size: 32px;
            font-weight: 700;
            color: var(--success-green);
            margin-bottom: 15px;
            animation: text-glow 2s ease-in-out infinite alternate;
        }
        
        @keyframes text-glow {
            from {
                text-shadow: 0 0 10px rgba(16, 185, 129, 0.5);
            }
            to {
                text-shadow: 0 0 20px rgba(16, 185, 129, 0.8), 0 0 30px rgba(16, 185, 129, 0.4);
            }
        }
        
        .success-subtitle {
            font-size: 18px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        
        .welcome-text {
            font-size: 20px;
            color: var(--kenya-black);
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        /* Session details */
        .session-details {
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 35px;
            border-left: 5px solid var(--success-green);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            animation: slide-up 0.8s ease-out 1.4s both;
        }
        
        .session-header {
            font-size: 20px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .session-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 20px;
        }
        
        .session-item {
            background: var(--kenya-white);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .session-item:hover {
            transform: translateY(-5px);
        }
        
        .session-value {
            font-size: 18px;
            font-weight: 700;
            color: var(--kenya-green);
            margin-bottom: 5px;
        }
        
        .session-label {
            font-size: 12px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }
        
        /* Connection status */
        .connection-status {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 35px;
            animation: slide-up 0.8s ease-out 1.6s both;
        }
        
        .status-header {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .status-indicators {
            display: flex;
            justify-content: space-around;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .status-indicator {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }
        
        .indicator-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--success-green), #34d399);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: var(--kenya-white);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            animation: indicator-pulse 2s infinite;
        }
        
        @keyframes indicator-pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            }
            50% {
                transform: scale(1.1);
                box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
            }
        }
        
        .indicator-text {
            font-size: 14px;
            color: var(--kenya-black);
            font-weight: 500;
            text-align: center;
        }
        
        /* Navigation section */
        .navigation-section {
            margin-bottom: 35px;
            animation: slide-up 0.8s ease-out 1.8s both;
        }
        
        .nav-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 20px;
        }
        
        .nav-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            max-width: 100%;
        }
        
        .nav-btn {
            padding: 18px 25px;
            border: none;
            border-radius: 15px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
        }
        
        .nav-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .nav-btn:hover::before {
            left: 100%;
        }
        
        .nav-btn.primary {
            background: linear-gradient(135deg, var(--success-green), #34d399);
            color: var(--kenya-white);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }
        
        .nav-btn.primary:hover {
            background: linear-gradient(135deg, #059669, var(--success-green));
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
        }
        
        .nav-btn.secondary {
            background: linear-gradient(135deg, var(--glinta-gold), #fbbf24);
            color: var(--kenya-black);
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
        }
        
        .nav-btn.secondary:hover {
            background: linear-gradient(135deg, #f59e0b, var(--glinta-gold));
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
        }
        
        /* Countdown */
        .countdown-section {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            border: 2px solid rgba(16, 185, 129, 0.2);
            animation: slide-up 0.8s ease-out 2s both;
        }
        
        .countdown-text {
            font-size: 16px;
            color: var(--kenya-black);
            margin-bottom: 10px;
        }
        
        .countdown-timer {
            font-size: 24px;
            font-weight: 700;
            color: var(--success-green);
            animation: countdown-pulse 1s infinite;
        }
        
        @keyframes countdown-pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(0.95); }
        }
        
        /* Usage tips */
        .usage-tips {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 20px;
            padding: 25px;
            text-align: left;
            animation: slide-up 0.8s ease-out 2.2s both;
        }
        
        .tips-title {
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
        
        .tips-list {
            list-style: none;
            padding: 0;
        }
        
        .tips-list li {
            padding: 10px 0;
            padding-left: 30px;
            position: relative;
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
        }
        
        .tips-list li::before {
            content: '✨';
            position: absolute;
            left: 0;
            font-size: 16px;
        }
        
        /* Support section */
        .support-section {
            background: var(--kenya-white);
            border-radius: 15px;
            padding: 20px;
            margin-top: 25px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            animation: slide-up 0.8s ease-out 2.4s both;
        }
        
        .support-title {
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
            font-size: 16px;
        }
        
        .support-contacts {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .support-contact {
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
                padding: 10px;
                align-items: flex-start;
                padding-top: 20px;
            }
            
            .success-container {
                padding: 30px 20px;
                margin: 0;
                max-width: 100%;
                border-radius: 20px;
            }
            
            .success-icon {
                width: 100px;
                height: 100px;
                font-size: 50px;
            }
            
            .brand-title {
                font-size: 28px;
            }
            
            .success-title {
                font-size: 26px;
            }
            
            .session-grid {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .status-indicators {
                flex-direction: column;
                align-items: center;
                gap: 15px;
            }
            
            .nav-buttons {
                grid-template-columns: 1fr;
            }
            
            .support-contacts {
                flex-direction: column;
                gap: 10px;
            }
        }
        
        @media (max-width: 480px) {
            .success-container {
                padding: 30px 20px;
            }
            
            .session-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    {literal}
    <script>
        alert("DEBUG: JavaScript IS RUNNING!"); // This should pop up!
    </script>
    {/literal}
    <!-- Celebration Background -->
    <div class="celebration-bg">
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
        <div class="confetti"></div>
    </div>

    <!-- Main Container -->
    <div class="success-container">
        <!-- Success Icon -->
        <div class="success-icon">✅</div>
        
        <!-- Brand Section -->
        <div class="brand-section">
            <h1 class="brand-title">Glinta Africa</h1>
            <p class="brand-subtitle">Premium WiFi Solutions</p>
        </div>
        
        <!-- Success Message -->
        <div class="success-message">
            <h2 class="success-title">🎉 Welcome to WiFi!</h2>
            <p class="success-subtitle">
                Your payment has been processed successfully and internet access is now active.
            </p>
            <p class="welcome-text">
                You can now browse the internet at high speed!
            </p>
        </div>
        
        <!-- Session Details -->
        {if $plan}
        <div class="session-details">
            <div class="session-header">
                <span>📊</span>
                <span>Your WiFi Session</span>
            </div>
            <div class="session-grid">
                <div class="session-item">
                    <div class="session-value">{$plan->name_plan}</div>
                    <div class="session-label">Package</div>
                </div>
                <div class="session-item">
                    <div class="session-value">KES {$plan->price}</div>
                    <div class="session-label">Amount Paid</div>
                </div>
                <div class="session-item">
                    <div class="session-value">{$plan->validity}</div>
                    <div class="session-label">{$plan->validity_unit}</div>
                </div>
                {if $user_recharge}
                <div class="session-item">
                    <div class="session-value">{$user_recharge->expiration|date_format:"%H:%M"}</div>
                    <div class="session-label">Expires At</div>
                </div>
                {/if}
            </div>
        </div>
        {/if}
        
        <!-- Connection Status -->
        <div class="connection-status">
            <div class="status-header">
                <span>🌐</span>
                <span>Connection Status</span>
            </div>
            <div class="status-indicators">
                <div class="status-indicator">
                    <div class="indicator-icon">📶</div>
                    <div class="indicator-text">Connected</div>
                </div>
                <div class="status-indicator">
                    <div class="indicator-icon">🚀</div>
                    <div class="indicator-text">High Speed</div>
                </div>
                <div class="status-indicator">
                    <div class="indicator-icon">🔒</div>
                    <div class="indicator-text">Secure</div>
                </div>
            </div>
        </div>
        
        <!-- Navigation Section -->
        <div class="navigation-section">
            <h3 class="nav-title">🌟 Choose Your Platform</h3>
            <div class="nav-buttons">
                <a href="https://google.com" class="nav-btn primary" target="_blank">
                    <img src="https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png" alt="Google" style="height: 20px;">
                    <span>Search</span>
                </a>
                <a href="https://youtube.com" class="nav-btn secondary" target="_blank">
                    <img src="https://www.youtube.com/s/desktop/f506bd45/img/favicon_32x32.png" alt="YouTube" style="height: 20px;">
                    <span>YouTube</span>
                </a>
                <a href="https://facebook.com" class="nav-btn" style="background: linear-gradient(135deg, #1877F2, #42A5F5); color: white;" target="_blank">
                    <span>📘</span>
                    <span>Facebook</span>
                </a>
                <a href="https://twitter.com" class="nav-btn" style="background: linear-gradient(135deg, #1DA1F2, #0D8BD9); color: white;" target="_blank">
                    <span>🐦</span>
                    <span>Twitter</span>
                </a>
                <a href="https://instagram.com" class="nav-btn" style="background: linear-gradient(135deg, #E4405F, #FFDC80); color: white;" target="_blank">
                    <span>📸</span>
                    <span>Instagram</span>
                </a>
                <a href="https://whatsapp.com" class="nav-btn" style="background: linear-gradient(135deg, #25D366, #128C7E); color: white;" target="_blank">
                    <span>💬</span>
                    <span>WhatsApp</span>
                </a>
                <a href="https://tiktok.com" class="nav-btn" style="background: linear-gradient(135deg, #000000, #FF0050); color: white;" target="_blank">
                    <span>🎵</span>
                    <span>TikTok</span>
                </a>
                <a href="https://netflix.com" class="nav-btn" style="background: linear-gradient(135deg, #E50914, #B81D24); color: white;" target="_blank">
                    <span>🎬</span>
                    <span>Netflix</span>
                </a>
            </div>
        </div>
        
        <!-- Countdown -->
        <div class="countdown-section">
            <div class="countdown-text">Auto-redirecting to Google in:</div>
            <div class="countdown-timer">
                <span id="countdown">10</span> seconds
            </div>
        </div>
        
        <!-- Usage Tips -->
        <div class="usage-tips">
            <div class="tips-title">
                <span>💡</span>
                <span>WiFi Usage Tips</span>
            </div>
            <ul class="tips-list">
                <li>Your session will automatically expire when the time limit is reached</li>
                <li>You can reconnect to the same WiFi network without entering password</li>
                <li>For the best experience, avoid downloading large files unnecessarily</li>
                <li>If you experience any issues, refresh your browser or reconnect to WiFi</li>
            </ul>
        </div>
        
        <!-- Support Section -->
        <div class="support-section">
            <div class="support-title">Need Help? We're Here for You!</div>
            <div class="support-contacts">
                <div class="support-contact">📧 support@glintaafrica.com</div>
                <div class="support-contact">📞 0711311897</div>
                <div class="support-contact">💬 WhatsApp Support</div>
            </div>
        </div>
    </div>
    
    <script>
        // Countdown timer
        let timeLeft = 10;
        const countdownEl = document.getElementById('countdown');
        
        function updateCountdown() {
            countdownEl.textContent = timeLeft;
            
            if (timeLeft <= 0) {
                window.location.href = 'https://google.com';
                return;
            }
            
            timeLeft--;
            setTimeout(updateCountdown, 1000);
        }
        
        // Start countdown
        updateCountdown();
        
        // Add click effects to buttons
        document.querySelectorAll('.nav-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
        
        // Add hover effects to session items
        document.querySelectorAll('.session-item').forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
                this.style.boxShadow = '0 8px 25px rgba(0, 0, 0, 0.15)';
            });
            
            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-5px) scale(1)';
                this.style.boxShadow = '0 4px 10px rgba(0, 0, 0, 0.1)';
            });
        });
        
        // Add celebration sound effect (optional)
        function playCelebrationSound() {
            // Create a simple beep sound using Web Audio API
            try {
                const audioContext = new (window.AudioContext || window.webkitAudioContext)();
                const oscillator = audioContext.createOscillator();
                const gainNode = audioContext.createGain();
                
                oscillator.connect(gainNode);
                gainNode.connect(audioContext.destination);
                
                oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
                oscillator.frequency.setValueAtTime(1000, audioContext.currentTime + 0.1);
                
                gainNode.gain.setValueAtTime(0, audioContext.currentTime);
                gainNode.gain.linearRampToValueAtTime(0.3, audioContext.currentTime + 0.1);
                gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.5);
                
                oscillator.start(audioContext.currentTime);
                oscillator.stop(audioContext.currentTime + 0.5);
            } catch (e) {
                // Silent fail if Web Audio API is not supported
            }
        }
        
        // Play celebration sound after 1 second
        setTimeout(playCelebrationSound, 1000);
        
        // Add dynamic background effects
        setInterval(() => {
            const container = document.querySelector('.success-container');
            if (container) {
                const randomOpacity = 0.2 + Math.random() * 0.2;
                container.style.boxShadow = 
                    '0 30px 60px rgba(0, 0, 0, 0.3), ' +
                    '0 0 100px rgba(16, 185, 129, ' + randomOpacity + ')';
            }
        }, 2000);
        
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                window.location.href = 'https://google.com';
            } else if (e.key === 'Escape') {
                timeLeft = 0; // Stop countdown
            }
        });
        
        // Handle page visibility change
        document.addEventListener('visibilitychange', function() {
            if (document.hidden) {
                // Pause countdown when tab is not visible
                timeLeft += 1;
            }
        });
        
        // Debug: Check current URL to understand captive portal structure
        console.log('Success page loaded. Current URL:', window.location.href);
        console.log('Protocol:', window.location.protocol);
        console.log('Hostname:', window.location.hostname);
        console.log('MAC Address from session:', '{$session->mac_address}');
        console.log('Session status:', '{$session->status}');
        console.log('User recharge exists:', '{if $user_recharge}YES{else}NO{/if}');
        {if $user_recharge}
        console.log('User recharge status:', '{$user_recharge->status}');
        console.log('User recharge expiration:', '{$user_recharge->expiration}');
        {/if}
        
        // IMMEDIATE DEBUG BOX - show before any other code
        const debugDiv = document.createElement('div');
        debugDiv.style.cssText = 'position:fixed;top:10px;left:10px;background:red;color:white;padding:10px;font-size:14px;z-index:9999;max-width:300px;';
        debugDiv.innerHTML = '<strong>DEBUG: Success page loaded!</strong><br>JavaScript is running...';
        document.body.appendChild(debugDiv);
        
        // Bulletproof MikroTik authentication with VISIBLE debugging
        setTimeout(function() {
            debugDiv.innerHTML += '<br>Timer started, checking variables...';
        
            // Use PHP-provided parameters with proper fallbacks
            const loginUrl = '{$mikrotik_login_url}' || 'http://192.168.88.1/login';
            const username = '{$mikrotik_username}';
            const password = '{$mikrotik_password}';
            const dst = '{$mikrotik_dst}' || 'https://google.com';
            
            debugDiv.innerHTML += '<br>LoginURL: ' + loginUrl + '<br>Username: ' + username + '<br>Password: ' + password;
            console.log('=== BULLETPROOF MikroTik Authentication Starting ===');
            
            console.log('Login URL:', loginUrl);
            console.log('Username (MAC):', username);
            console.log('Password (MAC):', password);
            console.log('Destination:', dst);
            
            // Add status element to existing debug div
            debugDiv.innerHTML += '<br><span id="debug-status">Preparing authentication...</span>';
            
            // Create form with ALL MikroTik parameters
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = loginUrl;
            form.id = 'mikrotik_auth_form';
            
            // Core fields
            const fields = {
                'username': username,
                'password': password,
                'dst': dst,
                'popup': 'true'
            };
            
            // Add MikroTik-specific fields if they exist
            {if $mikrotik_mac}
            fields['mac'] = '{$mikrotik_mac}';
            {/if}
            {if $mikrotik_ip}
            fields['ip'] = '{$mikrotik_ip}';
            {/if}
            {if $mikrotik_link_orig}
            fields['link-orig'] = '{$mikrotik_link_orig}';
            {/if}
            {if $mikrotik_link_login_only}
            fields['link-login-only'] = '{$mikrotik_link_login_only}';
            {/if}
            {if $mikrotik_chap_id}
            fields['chap-id'] = '{$mikrotik_chap_id}';
            {/if}
            {if $mikrotik_chap_challenge}
            fields['chap-challenge'] = '{$mikrotik_chap_challenge}';
            {/if}
            {if $mikrotik_hotspotaddress}
            fields['hotspotaddress'] = '{$mikrotik_hotspotaddress}';
            {/if}
            
            // Always include login-by=mac for MAC authentication
            fields['login-by'] = 'mac';
            
            // Create all form fields
            console.log('=== Form Fields ===');
            for (const [name, value] of Object.entries(fields)) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = value;
                form.appendChild(input);
                console.log(name + ':', value);
            }
            
            document.body.appendChild(form);
            
            console.log('=== Submitting MikroTik Authentication Form ===');
            console.log('Form HTML:', form.outerHTML);
            
            try {
                document.getElementById('debug-status').innerText = 'Submitting form to MikroTik...';
                form.submit();
                console.log('✅ Form submission initiated successfully');
                document.getElementById('debug-status').innerText = 'Form submitted, waiting for response...';
            } catch (error) {
                console.error('❌ Error submitting form:', error);
                document.getElementById('debug-status').innerText = 'Form submit failed, trying fallback...';
                // Fallback: try direct redirect with GET parameters
                const params = new URLSearchParams(fields);
                const fallbackUrl = loginUrl + '?' + params.toString();
                console.log('Attempting fallback redirect to:', fallbackUrl);
                document.getElementById('debug-status').innerText = 'Redirecting to: ' + fallbackUrl;
                setTimeout(() => {
                    window.location.href = fallbackUrl;
                }, 2000);
            }
            
        }, 3000); // Wait 3 seconds for user to see success page
    </script>
</body>
</html>