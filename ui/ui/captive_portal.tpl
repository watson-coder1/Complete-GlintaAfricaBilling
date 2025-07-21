<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="theme-color" content="#000000">
    <title>Glinta Africa - Premium WiFi Access</title>
    <meta name="description" content="Get instant WiFi access with M-Pesa or voucher code">
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
            --glinta-blue: #1e3a8a;
            --glinta-gray: #f8fafc;
            --glinta-border: #e2e8f0;
            --success-green: #10b981;
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
            overflow-x: hidden;
            position: relative;
            /* Prevent pull-to-refresh deformation */
            overscroll-behavior: none;
            -webkit-overflow-scrolling: touch;
        }
        
        /* Animated background particles */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            pointer-events: none;
        }
        
        .particle {
            position: absolute;
            background: radial-gradient(circle, rgba(255, 215, 0, 0.6) 0%, rgba(255, 215, 0, 0) 70%);
            border-radius: 50%;
            animation: float-up 15s infinite linear;
        }
        
        .particle:nth-child(1) { width: 80px; height: 80px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 120px; height: 120px; left: 70%; animation-delay: 3s; }
        .particle:nth-child(3) { width: 60px; height: 60px; left: 40%; animation-delay: 6s; }
        .particle:nth-child(4) { width: 100px; height: 100px; left: 85%; animation-delay: 9s; }
        .particle:nth-child(5) { width: 70px; height: 70px; left: 25%; animation-delay: 12s; }
        
        @keyframes float-up {
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
        
        /* Loading screen */
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--kenya-black) 0%, var(--kenya-green) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease-out, visibility 0.5s ease-out;
        }
        
        .loading-screen.hidden {
            opacity: 0;
            visibility: hidden;
        }
        
        .loading-logo {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--glinta-gold), #ffa500);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Lobster', cursive;
            font-size: 60px;
            color: var(--kenya-black);
            margin-bottom: 30px;
            box-shadow: 0 0 50px rgba(255, 215, 0, 0.7);
            animation: logo-pulse 2s infinite;
        }
        
        @keyframes logo-pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }
        
        .loading-text {
            color: var(--glinta-gold);
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .loading-subtitle {
            color: var(--kenya-white);
            font-size: 16px;
            opacity: 0.8;
        }
        
        /* Main container */
        .main-container {
            position: relative;
            z-index: 10;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            opacity: 0;
            animation: fade-in 1s ease-out 0.5s forwards;
        }
        
        @keyframes fade-in {
            to { opacity: 1; }
        }
        
        /* Header */
        .header {
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
            padding: 20px 0;
            border-bottom: 1px solid rgba(255, 215, 0, 0.2);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .brand {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .brand-logo {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--glinta-gold), #ffa500);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Lobster', cursive;
            font-size: 24px;
            color: var(--kenya-black);
            font-weight: bold;
        }
        
        .brand-text h1 {
            font-family: 'Lobster', cursive;
            font-size: 28px;
            color: var(--glinta-gold);
            margin: 0;
        }
        
        .brand-text p {
            color: var(--kenya-white);
            font-size: 14px;
            margin: 0;
            opacity: 0.8;
        }
        
        .connection-info {
            text-align: right;
            color: var(--kenya-white);
            font-size: 12px;
            opacity: 0.7;
        }
        
        /* Welcome section */
        .welcome-section {
            background: linear-gradient(135deg, rgba(30, 58, 138, 0.9), rgba(59, 130, 246, 0.9));
            color: var(--kenya-white);
            padding: 40px 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)" /></svg>');
            opacity: 0.3;
        }
        
        .welcome-content {
            position: relative;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .welcome-title {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--glinta-gold);
            animation: slide-in-up 0.8s ease-out 1s both;
        }
        
        .welcome-subtitle {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.9;
            animation: slide-in-up 0.8s ease-out 1.2s both;
        }
        
        .steps-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            animation: slide-in-up 0.8s ease-out 1.4s both;
        }
        
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 150px;
        }
        
        .step-number {
            width: 50px;
            height: 50px;
            background: var(--glinta-gold);
            color: var(--kenya-black);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .step-text {
            font-size: 14px;
            text-align: center;
            line-height: 1.4;
        }
        
        @keyframes slide-in-up {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Content area */
        .content-area {
            flex: 1;
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
        
        .portal-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .portal-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 215, 0, 0.2);
            transition: all 0.3s ease;
            animation: card-slide-in 0.8s ease-out both;
        }
        
        .portal-card:nth-child(1) { animation-delay: 1.6s; }
        .portal-card:nth-child(2) { animation-delay: 1.8s; }
        
        @keyframes card-slide-in {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .portal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border-color: var(--glinta-gold);
        }
        
        .card-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .card-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--kenya-green), var(--success-green));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: var(--kenya-white);
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(0, 107, 63, 0.3);
        }
        
        .card-title {
            font-size: 24px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 10px;
        }
        
        .card-subtitle {
            color: #64748b;
            font-size: 15px;
            line-height: 1.5;
        }
        
        /* Package selection */
        .packages-grid {
            display: grid;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .package-item {
            border: 2px solid var(--glinta-border);
            border-radius: 15px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            position: relative;
            overflow: hidden;
        }
        
        .package-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            transition: left 0.5s ease;
        }
        
        .package-item:hover::before {
            left: 100%;
        }
        
        .package-item:hover {
            border-color: var(--kenya-green);
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 107, 63, 0.15);
        }
        
        .package-item.selected {
            border-color: var(--kenya-green);
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            box-shadow: 0 0 0 3px rgba(0, 107, 63, 0.1);
        }
        
        .package-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .package-name {
            font-weight: 600;
            color: var(--kenya-black);
            font-size: 16px;
        }
        
        .package-price {
            font-weight: 700;
            color: var(--kenya-green);
            font-size: 18px;
        }
        
        .package-details {
            font-size: 13px;
            color: #64748b;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .package-detail {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        /* Form styling */
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: var(--kenya-black);
            font-size: 15px;
        }
        
        .form-input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid var(--glinta-border);
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #ffffff, #fafafa);
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--kenya-green);
            box-shadow: 0 0 0 3px rgba(0, 107, 63, 0.1);
            background: #ffffff;
        }
        
        .form-help {
            font-size: 12px;
            color: #64748b;
            margin-top: 8px;
        }
        
        /* Buttons */
        .btn {
            width: 100%;
            padding: 18px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .btn:hover::before {
            left: 100%;
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
            background: linear-gradient(135deg, var(--glinta-blue), #3b82f6);
            color: var(--kenya-white);
            box-shadow: 0 4px 15px rgba(30, 58, 138, 0.3);
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #1e40af, var(--glinta-blue));
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(30, 58, 138, 0.4);
        }
        
        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
        }
        
        /* Voucher section */
        .voucher-input-group {
            display: flex;
            gap: 12px;
            margin-bottom: 25px;
        }
        
        .voucher-input {
            flex: 1;
            text-transform: uppercase;
        }
        
        .voucher-btn {
            padding: 15px 25px;
            background: linear-gradient(135deg, var(--glinta-gold), #ffa500);
            color: var(--kenya-black);
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .voucher-btn:hover {
            background: linear-gradient(135deg, #fbbf24, var(--glinta-gold));
            transform: translateY(-2px);
        }
        
        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }
        
        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--glinta-border), transparent);
        }
        
        .divider-text {
            background: linear-gradient(135deg, #ffffff, #fafafa);
            padding: 0 20px;
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
        }
        
        /* Loading states */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 10px;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        /* Help section */
        .help-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            border-left: 5px solid var(--glinta-gold);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            animation: card-slide-in 0.8s ease-out 2s both;
        }
        
        .help-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .help-content {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .faq-item {
            margin-bottom: 15px;
        }
        
        .faq-question {
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 5px;
        }
        
        .faq-answer {
            color: #64748b;
            font-size: 14px;
        }
        
        .contact-section {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
        }
        
        .contact-title {
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 10px;
        }
        
        .contact-info {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .contact-item {
            font-size: 14px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .portal-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            
            .steps-container {
                gap: 25px;
            }
            
            .portal-card {
                padding: 30px 25px;
            }
            
            .voucher-input-group {
                flex-direction: column;
            }
            
            .header-content {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .welcome-title {
                font-size: 28px;
            }
            
            .contact-info {
                flex-direction: column;
                gap: 10px;
            }
        }
        
        @media (max-width: 480px) {
            .content-area {
                padding: 30px 15px;
            }
            
            .welcome-section {
                padding: 30px 15px;
            }
            
            .steps-container {
                flex-direction: column;
                align-items: center;
                gap: 20px;
            }
        }
        
        /* Success/Error messages */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            border-left: 4px solid;
            animation: alert-slide-in 0.5s ease-out;
        }
        
        @keyframes alert-slide-in {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        .alert-success {
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            border-left-color: var(--success-green);
            color: #065f46;
        }
        
        .alert-error {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            border-left-color: var(--error-red);
            color: #991b1b;
        }
    </style>
</head>
<body>
    <!-- Loading Screen -->
    <div class="loading-screen" id="loadingScreen">
        <div class="loading-logo">G</div>
        <div class="loading-text">Glinta Africa</div>
        <div class="loading-subtitle">Connecting Kenya to the World</div>
    </div>

    <!-- Background Animation -->
    <div class="bg-animation">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <!-- Main Container -->
    <div class="main-container" id="mainContainer">
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <div class="brand">
                    <div class="brand-logo">G</div>
                    <div class="brand-text">
                        <h1>Glinta Africa</h1>
                        <p>Premium WiFi Solutions</p>
                    </div>
                </div>
                <div class="connection-info">
                    <div>Device: {$mac|truncate:12:"..."}</div>
                    <div>IP: {$ip}</div>
                </div>
            </div>
        </header>

        <!-- Welcome Section -->
        <section class="welcome-section">
            <div class="welcome-content">
                <h2 class="welcome-title">🚀 Welcome to Premium WiFi</h2>
                <p class="welcome-subtitle">Get instant high-speed internet access in 3 simple steps</p>
                
                <div class="steps-container">
                    <div class="step">
                        <div class="step-number">1</div>
                        <div class="step-text">Choose your WiFi package or enter voucher</div>
                    </div>
                    <div class="step">
                        <div class="step-number">2</div>
                        <div class="step-text">Pay securely with M-Pesa STK Push</div>
                    </div>
                    <div class="step">
                        <div class="step-number">3</div>
                        <div class="step-text">Enjoy unlimited internet access</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Content Area -->
        <main class="content-area">
            <!-- Alert Messages -->
            {if isset($smarty.get.status)}
                {if $smarty.get.status == 's'}
                    <div class="alert alert-success">
                        ✅ {$smarty.get.message|default:"Success!"}
                    </div>
                {else}
                    <div class="alert alert-error">
                        ❌ {$smarty.get.message|default:"An error occurred"}
                    </div>
                {/if}
            {/if}

            <div class="portal-grid">
                <!-- WiFi Packages -->
                <div class="portal-card">
                    <div class="card-header">
                        <div class="card-icon">📱</div>
                        <h3 class="card-title">Purchase WiFi Package</h3>
                        <p class="card-subtitle">Choose from our affordable packages and pay instantly with M-Pesa</p>
                    </div>

                    <form id="packageForm" action="{$_url}captive_portal/select" method="POST">
                        <input type="hidden" name="session_id" value="{$session_id}">
                        
                        <div class="form-group">
                            <label class="form-label">📦 Select Package</label>
                            <div class="packages-grid">
                                {foreach $packages as $package}
                                <div class="package-item" data-plan="{$package->id}" data-price="{$package->price}">
                                    <div class="package-header">
                                        <span class="package-name">{$package->name_plan}</span>
                                        <span class="package-price">KES {$package->price}</span>
                                    </div>
                                    <div class="package-details">
                                        <div class="package-detail">
                                            <span>⏱️</span>
                                            <span>{$package->validity} {$package->validity_unit}</span>
                                        </div>
                                        {if $package->data_limit}
                                        <div class="package-detail">
                                            <span>📊</span>
                                            <span>{$package->data_limit}</span>
                                        </div>
                                        {/if}
                                        <div class="package-detail">
                                            <span>🚀</span>
                                            <span>High Speed</span>
                                        </div>
                                    </div>
                                </div>
                                {/foreach}
                            </div>
                            <input type="hidden" name="plan_id" id="selectedPlan" required>
                        </div>

                        <div class="form-group">
                            <label for="phoneNumber" class="form-label">📞 M-Pesa Phone Number</label>
                            <input type="tel" 
                                   name="phone_number" 
                                   id="phoneNumber" 
                                   class="form-input" 
                                   placeholder="0712345678" 
                                   required 
                                   minlength="10" 
                                   maxlength="13"
                                   pattern="[0-9]+">
                            <div class="form-help">Enter your Safaricom number for M-Pesa payment</div>
                        </div>

                        <button type="submit" class="btn btn-primary" id="purchaseBtn" disabled>
                            <span id="purchaseBtnText">💳 Pay with M-Pesa</span>
                        </button>
                    </form>
                </div>

                <!-- Voucher Authentication -->
                <div class="portal-card">
                    <div class="card-header">
                        <div class="card-icon">🎫</div>
                        <h3 class="card-title">Voucher Code</h3>
                        <p class="card-subtitle">Already have a voucher code? Enter it here for instant access</p>
                    </div>

                    <form id="voucherForm" action="{$_url}captive_portal/voucher" method="POST">
                        <input type="hidden" name="session_id" value="{$session_id}">
                        
                        <div class="form-group">
                            <label for="voucherCode" class="form-label">🎫 Voucher Code</label>
                            <div class="voucher-input-group">
                                <input type="text" 
                                       name="voucher_code" 
                                       id="voucherCode" 
                                       class="form-input voucher-input" 
                                       placeholder="Enter voucher code"
                                       style="text-transform: uppercase;">
                                <button type="submit" class="voucher-btn">Activate</button>
                            </div>
                            <div class="form-help">Voucher codes are case-insensitive</div>
                        </div>

                        <div class="divider">
                            <span class="divider-text">Need Help?</span>
                        </div>

                        <button type="button" class="btn btn-secondary" onclick="window.location.reload()">
                            🔄 Refresh Page
                        </button>
                    </form>
                </div>
            </div>

            <!-- Help Section -->
            <section class="help-section">
                <h4 class="help-title">
                    <span>💡</span>
                    Frequently Asked Questions
                </h4>
                <div class="help-content">
                    <div class="faq-item">
                        <div class="faq-question">Q: What happens after I pay with M-Pesa?</div>
                        <div class="faq-answer">A: You'll receive an STK push notification on your phone. After successful payment, internet access is activated automatically within 30 seconds.</div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">Q: How long does my package last?</div>
                        <div class="faq-answer">A: Each package has a specific duration shown in the package details. Your access expires automatically when the time is up.</div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">Q: Can I use voucher codes?</div>
                        <div class="faq-answer">A: Yes! If you have a voucher code, enter it in the "Voucher Code" section for instant access without payment.</div>
                    </div>
                </div>
                
                <div class="contact-section">
                    <div class="contact-title">🚨 Need Immediate Help?</div>
                    <div class="contact-info">
                        <div class="contact-item">📧 support@glintaafrica.com</div>
                        <div class="contact-item">📞 0711311897</div>
                        <div class="contact-item">💬 WhatsApp Support</div>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <script>
        // Hide loading screen and show main content
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('loadingScreen').classList.add('hidden');
            }, 1500);
        });

        // Package selection with smooth transitions
        document.querySelectorAll('.package-item').forEach(item => {
            item.addEventListener('click', function() {
                // Remove previous selection
                document.querySelectorAll('.package-item').forEach(pkg => {
                    pkg.classList.remove('selected');
                });
                
                // Add selection to clicked item
                this.classList.add('selected');
                
                // Update hidden input and enable button
                const planId = this.dataset.plan;
                const price = this.dataset.price;
                document.getElementById('selectedPlan').value = planId;
                
                // Update button text with price
                const btn = document.getElementById('purchaseBtn');
                const btnText = document.getElementById('purchaseBtnText');
                btn.disabled = false;
                btnText.textContent = '💳 Pay KES ' + price + ' with M-Pesa';
                
                // Add animation
                btn.style.animation = 'none';
                btn.offsetHeight; // Trigger reflow
                btn.style.animation = 'card-slide-in 0.3s ease-out';
            });
        });

        // Phone number formatting and validation
        document.getElementById('phoneNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, ''); // Remove non-digits
            e.target.value = value;
            
            // Enable/disable purchase button based on selection and phone
            const planSelected = document.getElementById('selectedPlan').value;
            const phoneValid = value.length >= 10;
            document.getElementById('purchaseBtn').disabled = !(planSelected && phoneValid);
        });

        // Enhanced form submission with better UX
        document.getElementById('packageForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const planId = document.getElementById('selectedPlan').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            
            if (!planId) {
                showAlert('Please select a WiFi package first', 'error');
                return;
            }
            
            if (phoneNumber.length < 10) {
                showAlert('Please enter a valid phone number (minimum 10 digits)', 'error');
                return;
            }
            
            // Show loading state with animation
            const btn = document.getElementById('purchaseBtn');
            const btnText = document.getElementById('purchaseBtnText');
            btn.classList.add('loading');
            btnText.innerHTML = '<span class="spinner"></span>Sending M-Pesa request...';
            
            // Show M-Pesa instruction
            showMpesaInstruction(() => {
                // Submit form after user acknowledges
                this.submit();
            });
        });

        // Voucher form handling
        document.getElementById('voucherForm').addEventListener('submit', function(e) {
            const voucherCode = document.getElementById('voucherCode').value.trim();
            
            if (!voucherCode) {
                e.preventDefault();
                showAlert('Please enter a voucher code', 'error');
                return;
            }
            
            // Show loading state
            const submitBtn = e.target.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<span class="spinner"></span>Activating...';
            submitBtn.disabled = true;
        });

        // Voucher code auto-formatting
        document.getElementById('voucherCode').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });

        // Helper functions
        function showAlert(message, type) {
            // Remove existing alerts
            document.querySelectorAll('.alert').forEach(alert => alert.remove());
            
            // Create new alert
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-' + type;
            alertDiv.innerHTML = (type === 'error' ? '❌' : '✅') + ' ' + message;
            
            // Insert at top of content area
            const contentArea = document.querySelector('.content-area');
            contentArea.insertBefore(alertDiv, contentArea.firstChild);
            
            // Auto-remove after 5 seconds
            setTimeout(() => {
                alertDiv.style.animation = 'alert-slide-out 0.5s ease-out forwards';
                setTimeout(() => alertDiv.remove(), 500);
            }, 5000);
        }

        function showMpesaInstruction(callback) {
            // Create modal-like overlay
            const overlay = document.createElement('div');
            overlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.8);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 10000;
                animation: fade-in 0.3s ease-out;
            `;
            
            const modal = document.createElement('div');
            modal.style.cssText = `
                background: white;
                border-radius: 20px;
                padding: 40px;
                max-width: 400px;
                width: 90%;
                text-align: center;
                animation: slide-in-up 0.3s ease-out;
            `;
            
            modal.innerHTML = `
                <div style="font-size: 48px; margin-bottom: 20px;">📱</div>
                <h3 style="color: var(--kenya-black); margin-bottom: 15px;">M-Pesa Payment Request Sent!</h3>
                <p style="color: #64748b; margin-bottom: 25px; line-height: 1.5;">
                    <strong>Check your phone now!</strong><br>
                    You will receive an M-Pesa STK push notification.<br>
                    Enter your M-Pesa PIN to complete the payment.
                </p>
                <button onclick="this.parentElement.parentElement.remove(); arguments[0]()" 
                        style="background: var(--kenya-green); color: white; border: none; padding: 15px 30px; border-radius: 10px; font-weight: 600; cursor: pointer;">
                    OK, I Understand
                </button>
            `;
            
            overlay.appendChild(modal);
            document.body.appendChild(overlay);
            
            // Handle click outside to close
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) {
                    overlay.remove();
                    callback();
                }
            });
            
            // Pass callback to button
            modal.querySelector('button').onclick = function() {
                overlay.remove();
                callback();
            };
        }

        // Add CSS animations dynamically
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fade-in {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            @keyframes alert-slide-out {
                to {
                    opacity: 0;
                    transform: translateX(-20px);
                }
            }
        `;
        document.head.appendChild(style);

        // Clean URL parameters after showing alerts
        if (window.location.search) {
            const url = new URL(window.location);
            url.search = '';
            window.history.replaceState({}, document.title, url.pathname);
        }
    </script>
</body>
</html>