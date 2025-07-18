<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Enterprise-Grade Hotspot Billing System. Transform your WiFi business with Africa's most advanced billing platform.">
    <meta name="keywords" content="enterprise hotspot billing, wifi management, mikrotik billing, ISP solutions, hotspot management africa">
    <meta property="og:title" content="Glinta Africa - Enterprise Hotspot Billing System">
    <meta property="og:description" content="Africa's most advanced hotspot billing system trusted by enterprise networks.">
    <meta name="robots" content="index, follow">
    
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Use CDN for Bootstrap to avoid local dependency issues -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-gold: #FFD700;
            --dark-gold: #DAA520;
            --accent-gold: #F4D03F;
            --primary-black: #000000;
            --dark-gray: #1a1a1a;
            --medium-gray: #2c2c2c;
            --light-gray: #f8f9fa;
            --pure-white: #ffffff;
            --success: #28a745;
            --info: #007bff;
            --warning: #ffc107;
            --danger: #dc3545;
            --font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            --font-heading: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.15);
            --shadow-lg: 0 8px 24px rgba(0,0,0,0.2);
            --shadow-xl: 0 12px 32px rgba(0,0,0,0.25);
            --gradient-primary: linear-gradient(135deg, var(--primary-black) 0%, var(--dark-gray) 50%, var(--medium-gray) 100%);
            --gradient-gold: linear-gradient(135deg, var(--primary-gold) 0%, var(--dark-gold) 100%);
            --gradient-accent: linear-gradient(135deg, var(--accent-gold) 0%, var(--primary-gold) 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: var(--font-primary);
            line-height: 1.6;
            color: var(--medium-gray);
            overflow-x: hidden;
        }

        /* Enhanced Loading Screen */
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            opacity: 1;
            visibility: visible;
            transition: all 0.8s ease;
        }

        .loading-screen.fade-out {
            opacity: 0;
            visibility: hidden;
        }

        .loading-content {
            text-align: center;
            color: var(--pure-white);
        }

        .loading-logo {
            font-size: 3rem;
            font-weight: 900;
            color: var(--primary-gold);
            margin-bottom: 30px;
            font-family: var(--font-heading);
            letter-spacing: 3px;
            animation: pulse 2s infinite;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 215, 0, 0.2);
            border-left: 4px solid var(--primary-gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        .loading-text {
            font-size: 1.2rem;
            opacity: 0.9;
            animation: fadeInOut 2s infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes fadeInOut {
            0%, 100% { opacity: 0.6; }
            50% { opacity: 1; }
        }

        /* Professional Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.98) !important;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            padding: 0.5rem 0;
            box-shadow: var(--shadow-lg);
        }

        .navbar-brand {
            font-family: var(--font-heading);
            font-weight: 900;
            font-size: 1.8rem;
            color: var(--primary-black) !important;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-decoration: none !important;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            color: var(--primary-gold) !important;
            transform: scale(1.02);
        }

        .navbar-nav .nav-link {
            color: var(--medium-gray) !important;
            font-weight: 500;
            margin: 0 0.8rem;
            padding: 0.8rem 1rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar-nav .nav-link::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--gradient-gold);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-gold) !important;
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px);
        }

        .navbar-nav .nav-link:hover::before {
            width: 80%;
        }

        .btn-demo {
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 25px;
            font-weight: 700;
            text-decoration: none;
            margin: 0 0.3rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

        .btn-demo::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-demo:hover {
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        .btn-demo:hover::before {
            left: 100%;
        }

        /* Hero Section - Enterprise Grade */
        .hero-section {
            background: var(--gradient-primary);
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            overflow: hidden;
        }

        .hero-pattern {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(255, 215, 0, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(255, 215, 0, 0.08) 0%, transparent 50%);
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(2deg); }
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: var(--pure-white);
            text-align: center;
            padding: 2rem 0;
        }

        .hero-badge {
            display: inline-block;
            background: rgba(255, 215, 0, 0.2);
            color: var(--primary-gold);
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 215, 0, 0.3);
            animation: slideInDown 1s ease-out;
        }

        .hero-title {
            font-family: var(--font-heading);
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 2rem;
            line-height: 1.1;
            animation: slideInUp 1s ease-out;
        }

        .hero-title .highlight {
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-subtitle {
            font-size: 1.4rem;
            margin-bottom: 3rem;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.95;
            line-height: 1.6;
            animation: slideInUp 1s ease-out 0.2s both;
        }

        .hero-stats {
            display: flex;
            justify-content: center;
            gap: 3rem;
            margin-bottom: 3rem;
            animation: slideInUp 1s ease-out 0.4s both;
        }

        .hero-stat {
            text-align: center;
        }

        .hero-stat-number {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--primary-gold);
            font-family: var(--font-heading);
        }

        .hero-stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }

        .hero-cta {
            animation: slideInUp 1s ease-out 0.6s both;
        }

        .btn-primary-hero {
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 1.2rem 2.5rem;
            border: none;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            margin: 0.5rem;
            transition: all 0.4s ease;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
        }

        .btn-secondary-hero {
            background: transparent;
            color: var(--pure-white);
            padding: 1.2rem 2.5rem;
            border: 2px solid var(--pure-white);
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            margin: 0.5rem;
            transition: all 0.4s ease;
            backdrop-filter: blur(10px);
        }

        .btn-primary-hero:hover {
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .btn-secondary-hero:hover {
            background: var(--pure-white);
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-5px);
        }

        /* Floating Elements */
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 1;
        }

        .floating-icon {
            position: absolute;
            color: rgba(255, 215, 0, 0.3);
            font-size: 2rem;
            animation: floatIcon 8s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) { top: 15%; left: 10%; animation-delay: 0s; }
        .floating-icon:nth-child(2) { top: 25%; right: 15%; animation-delay: 2s; }
        .floating-icon:nth-child(3) { bottom: 30%; left: 20%; animation-delay: 4s; }
        .floating-icon:nth-child(4) { bottom: 20%; right: 25%; animation-delay: 6s; }
        .floating-icon:nth-child(5) { top: 50%; left: 5%; animation-delay: 1s; }
        .floating-icon:nth-child(6) { top: 40%; right: 8%; animation-delay: 3s; }

        @keyframes floatIcon {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg);
                opacity: 0.3;
            }
            25% { 
                transform: translateY(-15px) rotate(90deg);
                opacity: 0.5;
            }
            50% { 
                transform: translateY(-30px) rotate(180deg);
                opacity: 0.7;
            }
            75% { 
                transform: translateY(-15px) rotate(270deg);
                opacity: 0.5;
            }
        }

        /* Animations */
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Trust Indicators */
        .trust-section {
            background: var(--pure-white);
            padding: 4rem 0;
            border-bottom: 1px solid #e9ecef;
        }

        .trust-logos {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 3rem;
            opacity: 0.6;
            filter: grayscale(100%);
            transition: all 0.3s ease;
        }

        .trust-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--medium-gray);
        }

        /* Features Section - Enterprise Focus */
        .features-section {
            padding: 6rem 0;
            background: var(--light-gray);
        }

        .section-header {
            text-align: center;
            margin-bottom: 4rem;
        }

        .section-badge {
            display: inline-block;
            background: rgba(255, 215, 0, 0.1);
            color: var(--dark-gold);
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .section-title {
            font-family: var(--font-heading);
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: var(--primary-black);
            line-height: 1.2;
        }

        .section-subtitle {
            font-size: 1.3rem;
            color: #6c757d;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 4rem;
        }

        .feature-card {
            background: var(--pure-white);
            padding: 3rem;
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid #e9ecef;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-gold);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-xl);
            border-color: var(--primary-gold);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 215, 0, 0.1);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .feature-icon i {
            font-size: 2rem;
            color: var(--primary-gold);
        }

        .feature-card:hover .feature-icon {
            background: var(--gradient-gold);
            transform: scale(1.1);
        }

        .feature-card:hover .feature-icon i {
            color: var(--primary-black);
        }

        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--primary-black);
            font-family: var(--font-heading);
        }

        .feature-description {
            color: #6c757d;
            line-height: 1.6;
            font-size: 1rem;
        }

        /* Stats Section */
        .stats-section {
            background: var(--gradient-primary);
            padding: 6rem 0;
            color: var(--pure-white);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 3rem;
        }

        .stat-card {
            text-align: center;
            padding: 2rem;
        }

        .stat-number {
            font-size: 3.5rem;
            font-weight: 900;
            color: var(--primary-gold);
            margin-bottom: 0.5rem;
            font-family: var(--font-heading);
            counter-reset: number;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 500;
        }

        /* Pricing Section - Enterprise */
        .pricing-section {
            padding: 6rem 0;
            background: var(--pure-white);
        }

        .pricing-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-top: 4rem;
        }

        .pricing-card {
            background: var(--pure-white);
            border: 2px solid #e9ecef;
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .pricing-card.featured {
            border-color: var(--primary-gold);
            transform: scale(1.05);
            box-shadow: var(--shadow-xl);
            position: relative;
        }

        .pricing-card.featured::before {
            content: 'Most Popular';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 0.5rem 2rem;
            border-radius: 25px;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: var(--shadow-md);
        }

        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-xl);
            border-color: var(--primary-gold);
        }

        .plan-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--primary-black);
            font-family: var(--font-heading);
        }

        .plan-price {
            font-size: 3rem;
            font-weight: 900;
            color: var(--primary-gold);
            margin-bottom: 0.5rem;
            font-family: var(--font-heading);
        }

        .plan-period {
            color: #6c757d;
            margin-bottom: 2rem;
            font-size: 1rem;
        }

        .plan-features {
            list-style: none;
            margin-bottom: 2.5rem;
            text-align: left;
        }

        .plan-features li {
            padding: 0.8rem 0;
            color: #6c757d;
            position: relative;
            padding-left: 2rem;
            border-bottom: 1px solid #f8f9fa;
        }

        .plan-features li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: var(--success);
            font-weight: bold;
            font-size: 1.2rem;
        }

        .btn-pricing {
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s ease;
            width: 100%;
            display: inline-block;
        }

        .btn-pricing:hover {
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        /* Contact Section */
        .contact-section {
            background: var(--gradient-primary);
            color: var(--pure-white);
            padding: 6rem 0;
        }

        .contact-content {
            text-align: center;
            max-width: 800px;
            margin: 0 auto;
        }

        .contact-title {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: var(--primary-gold);
            font-family: var(--font-heading);
        }

        .contact-subtitle {
            font-size: 1.3rem;
            margin-bottom: 3rem;
            opacity: 0.9;
        }

        .contact-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }

        .contact-item {
            text-align: center;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .contact-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-5px);
        }

        .contact-item i {
            font-size: 2rem;
            color: var(--primary-gold);
            margin-bottom: 1rem;
        }

        .contact-item h5 {
            margin-bottom: 0.5rem;
            color: var(--pure-white);
        }

        .contact-item a {
            color: var(--primary-gold);
            text-decoration: none;
            font-weight: 500;
        }

        .contact-item a:hover {
            color: var(--pure-white);
            text-decoration: underline;
        }

        /* Footer */
        .footer {
            background: var(--primary-black);
            color: var(--pure-white);
            padding: 3rem 0 1rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-section h5 {
            color: var(--primary-gold);
            margin-bottom: 1rem;
            font-family: var(--font-heading);
        }

        .footer-section p,
        .footer-section a {
            color: #ccc;
            text-decoration: none;
            line-height: 1.8;
        }

        .footer-section a:hover {
            color: var(--primary-gold);
        }

        .footer-bottom {
            border-top: 1px solid #333;
            padding-top: 1.5rem;
            text-align: center;
            color: #999;
        }

        .footer-bottom a {
            color: var(--primary-gold);
            text-decoration: none;
        }

        /* Back to Top */
        .back-to-top {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 50px;
            height: 50px;
            background: var(--gradient-gold);
            color: var(--primary-black);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            opacity: 0;
            visibility: hidden;
            z-index: 1000;
        }

        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
        }

        .back-to-top:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
            }

            .hero-stats {
                flex-direction: column;
                gap: 1.5rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .btn-primary-hero,
            .btn-secondary-hero {
                padding: 1rem 1.5rem;
                font-size: 1rem;
                display: block;
                margin: 0.5rem auto;
                max-width: 280px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .feature-card {
                padding: 2rem;
            }

            .pricing-card.featured {
                transform: none;
            }

            .contact-title {
                font-size: 2rem;
            }

            .navbar-brand {
                font-size: 1.3rem;
            }

            .floating-elements {
                display: none;
            }
        }

        @media (max-width: 480px) {
            .hero-title {
                font-size: 2rem;
            }

            .section-title {
                font-size: 1.8rem;
            }

            .pricing-card,
            .feature-card {
                padding: 1.5rem;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* Print Styles */
        @media print {
            .navbar,
            .back-to-top,
            .loading-screen {
                display: none !important;
            }
        }
    </style>
</head>

<body>
    <!-- Loading Screen -->
    <div class="loading-screen" id="loadingScreen">
        <div class="loading-content">
            <div class="loading-logo">GLINTA AFRICA</div>
            <div class="loading-spinner"></div>
            <div class="loading-text">Loading Enterprise Solutions...</div>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg" id="mainNavbar">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}">GLINTA AFRICA</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Solutions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn-demo" href="{$app_url}/landing/contact">
                            <i class="fas fa-cog me-1"></i>Request Demo
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn-demo" href="{$app_url}/landing/contact">
                            <i class="fas fa-user me-1"></i>Contact Us
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-pattern"></div>
        <div class="floating-elements">
            <i class="floating-icon fas fa-wifi"></i>
            <i class="floating-icon fas fa-network-wired"></i>
            <i class="floating-icon fas fa-shield-alt"></i>
            <i class="floating-icon fas fa-chart-line"></i>
            <i class="floating-icon fas fa-credit-card"></i>
            <i class="floating-icon fas fa-users"></i>
        </div>
        <div class="container">
            <div class="hero-content">
                <div class="hero-badge">
                    <i class="fas fa-award me-2"></i>Enterprise-Grade Solution
                </div>
                <h1 class="hero-title">
                    Africa's Most <span class="highlight">Advanced</span><br>
                    Hotspot Billing Platform
                </h1>
                <p class="hero-subtitle">
                    Transform your WiFi infrastructure into a revenue-generating powerhouse with our enterprise-grade billing system. 
                    Trusted by Fortune 500 companies and leading ISPs across 50+ countries.
                </p>
                <div class="hero-stats">
                    <div class="hero-stat">
                        <div class="hero-stat-number" data-count="10000">0</div>
                        <div class="hero-stat-label">Enterprise Clients</div>
                    </div>
                    <div class="hero-stat">
                        <div class="hero-stat-number" data-count="500000">0</div>
                        <div class="hero-stat-label">Connected Users</div>
                    </div>
                    <div class="hero-stat">
                        <div class="hero-stat-number" data-count="99">0</div>
                        <div class="hero-stat-label">Uptime SLA %</div>
                    </div>
                </div>
                <div class="hero-cta">
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20schedule%20an%20enterprise%20demo" class="btn-primary-hero" target="_blank">
                        <i class="fas fa-calendar-check me-2"></i>Schedule Enterprise Demo
                    </a>
                    <a href="#features" class="btn-secondary-hero">
                        <i class="fas fa-play me-2"></i>Explore Platform
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Trust Indicators -->
    <section class="trust-section">
        <div class="container">
            <div class="text-center mb-4">
                <p class="text-muted">Trusted by leading organizations worldwide</p>
            </div>
            <div class="trust-logos">
                <div class="trust-logo">Enterprise Hotels</div>
                <div class="trust-logo">Major ISPs</div>
                <div class="trust-logo">Shopping Malls</div>
                <div class="trust-logo">Universities</div>
                <div class="trust-logo">Corporate Offices</div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features-section">
        <div class="container">
            <div class="section-header">
                <div class="section-badge">
                    <i class="fas fa-rocket me-2"></i>Enterprise Solutions
                </div>
                <h2 class="section-title">Comprehensive Enterprise Platform</h2>
                <p class="section-subtitle">
                    Built for scale, security, and performance. Our platform delivers enterprise-grade capabilities 
                    that grow with your business requirements.
                </p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h4 class="feature-title">Enterprise Security</h4>
                    <p class="feature-description">
                        Bank-grade encryption, multi-factor authentication, compliance with SOC 2, ISO 27001, 
                        and GDPR. Complete audit trails and role-based access control.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-network-wired"></i>
                    </div>
                    <h4 class="feature-title">Network Infrastructure</h4>
                    <p class="feature-description">
                        Seamless integration with MikroTik, Cisco, Ubiquiti, and major network equipment. 
                        Support for RADIUS, captive portals, and advanced QoS management.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h4 class="feature-title">Advanced Analytics</h4>
                    <p class="feature-description">
                        Real-time dashboards, predictive analytics, revenue optimization insights, 
                        and comprehensive reporting with customizable KPI tracking.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <h4 class="feature-title">Payment Ecosystem</h4>
                    <p class="feature-description">
                        Support for 50+ payment gateways including M-Pesa, Stripe, PayPal, 
                        crypto payments, and enterprise billing with automated invoicing.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-cloud"></i>
                    </div>
                    <h4 class="feature-title">Cloud Infrastructure</h4>
                    <p class="feature-description">
                        99.99% uptime SLA, global CDN, auto-scaling, disaster recovery, 
                        and hybrid cloud deployment options for maximum reliability.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <h4 class="feature-title">API & Integrations</h4>
                    <p class="feature-description">
                        RESTful APIs, webhooks, SDK support, CRM integrations, 
                        and white-label solutions for seamless business integration.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" data-count="50">0</div>
                    <div class="stat-label">Countries Served</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" data-count="1000000">0</div>
                    <div class="stat-label">Daily Transactions</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" data-count="24">0</div>
                    <div class="stat-label">Enterprise Support</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" data-count="99">0</div>
                    <div class="stat-label">Customer Satisfaction</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="pricing-section">
        <div class="container">
            <div class="section-header">
                <div class="section-badge">
                    <i class="fas fa-tags me-2"></i>Enterprise Pricing
                </div>
                <h2 class="section-title">Scalable Enterprise Solutions</h2>
                <p class="section-subtitle">
                    Transparent pricing that scales with your business. All plans include 24/7 support, 
                    enterprise security, and dedicated account management.
                </p>
            </div>

            <div class="pricing-grid">
                <div class="pricing-card">
                    <h3 class="plan-name">Business</h3>
                    <div class="plan-price">KES 1,000</div>
                    <div class="plan-period">per month</div>
                    <ul class="plan-features">
                        <li>Up to 50 concurrent users</li>
                        <li>Single location deployment</li>
                        <li>Basic captive portal</li>
                        <li>Standard payment gateways</li>
                        <li>Email support (24h response)</li>
                        <li>Basic analytics dashboard</li>
                    </ul>
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Business%20plan" class="btn-pricing" target="_blank">
                        Start Business Plan
                    </a>
                </div>

                <div class="pricing-card">
                    <h3 class="plan-name">Corporate</h3>
                    <div class="plan-price">KES 2,500</div>
                    <div class="plan-period">per month</div>
                    <ul class="plan-features">
                        <li>Up to 150 concurrent users</li>
                        <li>Multi-location support (3 sites)</li>
                        <li>Advanced portal customization</li>
                        <li>Premium payment integrations</li>
                        <li>Priority support (4h response)</li>
                        <li>Advanced analytics & reporting</li>
                    </ul>
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Corporate%20plan" class="btn-pricing" target="_blank">
                        Start Corporate Plan
                    </a>
                </div>

                <div class="pricing-card featured">
                    <h3 class="plan-name">Enterprise</h3>
                    <div class="plan-price">KES 5,000</div>
                    <div class="plan-period">per month</div>
                    <ul class="plan-features">
                        <li>Up to 500 concurrent users</li>
                        <li>Unlimited locations</li>
                        <li>White-label solution</li>
                        <li>API access & integrations</li>
                        <li>24/7 phone support (1h response)</li>
                        <li>Custom analytics & BI tools</li>
                    </ul>
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Enterprise%20plan" class="btn-pricing" target="_blank">
                        Start Enterprise Plan
                    </a>
                </div>

                <div class="pricing-card">
                    <h3 class="plan-name">Global</h3>
                    <div class="plan-price">KES 10,000</div>
                    <div class="plan-period">per month</div>
                    <ul class="plan-features">
                        <li>Unlimited users & locations</li>
                        <li>Custom development included</li>
                        <li>Dedicated infrastructure</li>
                        <li>Dedicated account manager</li>
                        <li>SLA guarantee (99.99% uptime)</li>
                        <li>On-premise deployment option</li>
                    </ul>
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Global%20enterprise%20plan" class="btn-pricing" target="_blank">
                        Contact Enterprise Sales
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact-section">
        <div class="container">
            <div class="contact-content">
                <h2 class="contact-title">Ready to Transform Your Business?</h2>
                <p class="contact-subtitle">
                    Join thousands of satisfied enterprise customers. Schedule a personalized demo 
                    and see how Glinta Africa can revolutionize your WiFi infrastructure.
                </p>

                <div class="contact-info">
                    <div class="contact-item">
                        <i class="fas fa-envelope"></i>
                        <h5>Enterprise Sales</h5>
                        <a href="mailto:info@glintaafrica.com">info@glintaafrica.com</a><br>
                        <a href="mailto:watsonwambugu@yahoo.com">watsonwambugu@yahoo.com</a>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-phone-alt"></i>
                        <h5>24/7 Support</h5>
                        <a href="tel:+254700123456">+254 700 123 456</a>
                    </div>
                    <div class="contact-item">
                        <i class="fab fa-whatsapp"></i>
                        <h5>WhatsApp Business</h5>
                        <a href="https://wa.me/254711503023" target="_blank">+254 711 503 023</a>
                    </div>
                </div>

                <div class="mt-4">
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20schedule%20an%20enterprise%20consultation" class="btn-primary-hero" target="_blank">
                        <i class="fas fa-calendar-check me-2"></i>Schedule Enterprise Consultation
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h5>Glinta Africa</h5>
                    <p>Africa's leading enterprise hotspot billing platform. Empowering businesses to monetize their WiFi networks with cutting-edge technology and unparalleled support.</p>
                </div>
                <div class="footer-section">
                    <h5>Solutions</h5>
                    <p><a href="#features">Enterprise Platform</a></p>
                    <p><a href="#pricing">Pricing Plans</a></p>
                    <p><a href="#">API Documentation</a></p>
                    <p><a href="#">Integration Partners</a></p>
                </div>
                <div class="footer-section">
                    <h5>Support</h5>
                    <p><a href="#">Enterprise Support</a></p>
                    <p><a href="#">24/7 Technical Help</a></p>
                    <p><a href="#contact">Contact Sales</a></p>
                    <p><a href="#">System Status</a></p>
                </div>
                <div class="footer-section">
                    <h5>Company</h5>
                    <p><a href="#">About Glinta Africa</a></p>
                    <p><a href="#">Careers</a></p>
                    <p><a href="#">Press & Media</a></p>
                    <p><a href="#">Security & Compliance</a></p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Glinta Africa. All rights reserved. | 
                Made with ❤️ by <a href="https://watsonsdevelopers.com">watsonsdevelopers.com</a></p>
            </div>
        </div>
    </footer>

    <!-- Back to Top -->
    <button class="back-to-top" id="backToTop">
        <i class="fas fa-arrow-up"></i>
    </button>

    <!-- Scripts from CDN to avoid local dependency issues -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Loading Screen
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('loadingScreen').classList.add('fade-out');
            }, 2000);
        });

        // Navbar Scroll Effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('mainNavbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Smooth Scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Counter Animation
        function animateCounters() {
            const counters = document.querySelectorAll('[data-count]');
            const observerOptions = { threshold: 0.5 };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const counter = entry.target;
                        const target = parseInt(counter.getAttribute('data-count'));
                        const duration = 2500;
                        const increment = target / (duration / 16);
                        let current = 0;

                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= target) {
                                current = target;
                                clearInterval(timer);
                            }
                            counter.textContent = Math.floor(current).toLocaleString();
                        }, 16);

                        observer.unobserve(counter);
                    }
                });
            }, observerOptions);

            counters.forEach(counter => observer.observe(counter));
        }

        // Back to Top Button
        const backToTop = document.getElementById('backToTop');
        window.addEventListener('scroll', function() {
            if (window.scrollY > 300) {
                backToTop.classList.add('visible');
            } else {
                backToTop.classList.remove('visible');
            }
        });

        backToTop.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Initialize counter animation
        animateCounters();

        // Intersection Observer for animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe elements for animation
        document.querySelectorAll('.feature-card, .pricing-card, .stat-card').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(30px)';
            el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(el);
        });

        // Performance optimizations
        const lazyImages = document.querySelectorAll('img[data-src]');
        if (lazyImages.length > 0) {
            const imageObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.classList.remove('lazy');
                        imageObserver.unobserve(img);
                    }
                });
            });

            lazyImages.forEach(img => imageObserver.observe(img));
        }
    </script>
</body>
</html>