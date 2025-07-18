<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Complete Hotspot Billing System for WiFi Hotspots, ISPs, and Internet Service Providers. Manage your hotspot business with ease.">
    <meta name="keywords" content="hotspot billing, wifi management, mikrotik billing, internet service provider, ISP billing, hotspot management">
    <meta property="og:title" content="Glinta Africa - Hotspot Billing Solutions">
    <meta property="og:description" content="Transform your WiFi business with Africa's most advanced hotspot billing system.">
    <meta property="og:type" content="website">
    <meta name="twitter:card" content="summary_large_image">
    
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/fonts/font-awesome/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-gold: #FFD700;
            --dark-gold: #DAA520;
            --light-gold: #FFF8DC;
            --primary-black: #000000;
            --dark-gray: #1a1a1a;
            --medium-gray: #333333;
            --light-gray: #f8f9fa;
            --pure-white: #ffffff;
            --success-green: #28a745;
            --info-blue: #007bff;
            --warning-orange: #fd7e14;
            --danger-red: #dc3545;
            --border-color: #e9ecef;
            --shadow-light: 0 2px 10px rgba(0,0,0,0.1);
            --shadow-medium: 0 5px 20px rgba(0,0,0,0.15);
            --shadow-heavy: 0 10px 40px rgba(0,0,0,0.2);
            --gradient-primary: linear-gradient(135deg, var(--primary-black) 0%, var(--dark-gray) 100%);
            --gradient-gold: linear-gradient(135deg, var(--primary-gold) 0%, var(--dark-gold) 100%);
            --font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            --font-heading: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
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

        /* Loading Screen */
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
            transition: opacity 0.5s ease-out;
        }

        .loading-content {
            text-align: center;
            color: var(--pure-white);
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 215, 0, 0.3);
            border-left: 4px solid var(--primary-gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Navigation */
        .navbar {
            background: var(--pure-white) !important;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            padding: 15px 0;
        }

        .navbar.scrolled {
            padding: 10px 0;
            box-shadow: var(--shadow-medium);
        }

        .navbar-brand {
            font-family: var(--font-heading);
            font-weight: 900;
            font-size: 28px;
            color: var(--primary-black) !important;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-decoration: none !important;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            color: var(--primary-gold) !important;
            transform: scale(1.05);
        }

        .navbar-nav .nav-link {
            color: var(--medium-gray) !important;
            font-weight: 500;
            margin: 0 10px;
            padding: 10px 15px !important;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-gold) !important;
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px);
        }

        .btn-demo {
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-weight: 700;
            text-decoration: none;
            margin: 0 5px;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-light);
        }

        .btn-demo:hover {
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }

        /* Hero Section */
        .hero-section {
            background: var(--gradient-primary);
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            overflow: hidden;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.8) 0%, rgba(26,26,26,0.7) 100%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: var(--pure-white);
            text-align: center;
            padding: 100px 0;
        }

        .hero-title {
            font-family: var(--font-heading);
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 30px;
            line-height: 1.2;
            animation: fadeInUp 1s ease-out;
        }

        .hero-title .highlight {
            color: var(--primary-gold);
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .hero-subtitle {
            font-size: 1.5rem;
            margin-bottom: 40px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
            animation: fadeInUp 1s ease-out 0.2s both;
        }

        .hero-cta {
            animation: fadeInUp 1s ease-out 0.4s both;
        }

        .btn-primary-large {
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 18px 40px;
            border: none;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            margin: 10px;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-medium);
        }

        .btn-primary-large:hover {
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }

        .btn-secondary-large {
            background: transparent;
            color: var(--pure-white);
            padding: 18px 40px;
            border: 2px solid var(--pure-white);
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            margin: 10px;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .btn-secondary-large:hover {
            background: var(--pure-white);
            color: var(--primary-black);
            text-decoration: none;
            transform: translateY(-5px);
        }

        /* Floating Icons Animation */
        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }

        .floating-icon {
            position: absolute;
            color: var(--primary-gold);
            font-size: 24px;
            opacity: 0.3;
            animation: float 6s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) { top: 20%; left: 10%; animation-delay: 0s; }
        .floating-icon:nth-child(2) { top: 40%; right: 15%; animation-delay: 1s; }
        .floating-icon:nth-child(3) { bottom: 30%; left: 20%; animation-delay: 2s; }
        .floating-icon:nth-child(4) { bottom: 20%; right: 25%; animation-delay: 3s; }
        .floating-icon:nth-child(5) { top: 60%; left: 50%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(120deg); }
            66% { transform: translateY(10px) rotate(240deg); }
        }

        /* Stats Section */
        .stats-section {
            background: var(--light-gray);
            padding: 80px 0;
        }

        .stat-card {
            text-align: center;
            padding: 40px 20px;
            background: var(--pure-white);
            border-radius: 15px;
            box-shadow: var(--shadow-light);
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-medium);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 900;
            color: var(--primary-gold);
            margin-bottom: 10px;
            font-family: var(--font-heading);
        }

        .stat-label {
            font-size: 1.1rem;
            color: var(--medium-gray);
            font-weight: 600;
        }

        /* Features Section */
        .features-section {
            padding: 100px 0;
            background: var(--pure-white);
        }

        .section-title {
            font-family: var(--font-heading);
            font-size: 3rem;
            font-weight: 800;
            text-align: center;
            margin-bottom: 20px;
            color: var(--primary-black);
        }

        .section-subtitle {
            font-size: 1.2rem;
            text-align: center;
            margin-bottom: 60px;
            color: var(--medium-gray);
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .feature-card {
            background: var(--pure-white);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 3px;
            background: var(--gradient-gold);
            transition: all 0.3s ease;
        }

        .feature-card:hover::before {
            left: 0;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-medium);
            border-color: var(--primary-gold);
        }

        .feature-icon {
            font-size: 48px;
            color: var(--primary-gold);
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(10deg);
        }

        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--primary-black);
            font-family: var(--font-heading);
        }

        .feature-description {
            color: var(--medium-gray);
            line-height: 1.7;
        }

        /* How It Works Section */
        .how-it-works {
            background: var(--light-gray);
            padding: 100px 0;
        }

        .process-step {
            text-align: center;
            margin-bottom: 50px;
            position: relative;
        }

        .step-number {
            width: 80px;
            height: 80px;
            background: var(--gradient-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 900;
            color: var(--primary-black);
            margin: 0 auto 30px;
            box-shadow: var(--shadow-light);
        }

        .step-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--primary-black);
            font-family: var(--font-heading);
        }

        .step-description {
            color: var(--medium-gray);
            max-width: 300px;
            margin: 0 auto;
        }

        /* Pricing Section */
        .pricing-section {
            background: var(--pure-white);
            padding: 100px 0;
        }

        .pricing-card {
            background: var(--pure-white);
            border: 2px solid var(--border-color);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
        }

        .pricing-card.featured {
            border-color: var(--primary-gold);
            transform: scale(1.05);
            box-shadow: var(--shadow-medium);
        }

        .pricing-card.featured::before {
            content: 'Most Popular';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 8px 25px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-medium);
            border-color: var(--primary-gold);
        }

        .plan-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary-black);
            font-family: var(--font-heading);
        }

        .plan-price {
            font-size: 3rem;
            font-weight: 900;
            color: var(--primary-gold);
            margin-bottom: 10px;
            font-family: var(--font-heading);
        }

        .plan-period {
            color: var(--medium-gray);
            margin-bottom: 30px;
        }

        .plan-features {
            list-style: none;
            margin-bottom: 40px;
        }

        .plan-features li {
            padding: 8px 0;
            color: var(--medium-gray);
            position: relative;
            padding-left: 25px;
        }

        .plan-features li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: var(--success-green);
            font-weight: bold;
        }

        /* Testimonials Section */
        .testimonials-section {
            background: var(--light-gray);
            padding: 100px 0;
        }

        .testimonial-card {
            background: var(--pure-white);
            border-radius: 20px;
            padding: 40px;
            margin: 20px;
            text-align: center;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-medium);
        }

        .testimonial-text {
            font-style: italic;
            font-size: 1.1rem;
            color: var(--medium-gray);
            margin-bottom: 30px;
            line-height: 1.8;
        }

        .testimonial-author {
            font-weight: 700;
            color: var(--primary-black);
            margin-bottom: 5px;
        }

        .testimonial-company {
            color: var(--primary-gold);
            font-weight: 600;
        }

        /* FAQ Section */
        .faq-section {
            background: var(--pure-white);
            padding: 100px 0;
        }

        .faq-item {
            margin-bottom: 20px;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            overflow: hidden;
        }

        .faq-question {
            background: var(--light-gray);
            padding: 20px;
            cursor: pointer;
            font-weight: 600;
            color: var(--primary-black);
            transition: all 0.3s ease;
            position: relative;
        }

        .faq-question:hover {
            background: var(--primary-gold);
            color: var(--primary-black);
        }

        .faq-question::after {
            content: '+';
            position: absolute;
            right: 20px;
            font-size: 1.5rem;
            transition: transform 0.3s ease;
        }

        .faq-question.active::after {
            transform: rotate(45deg);
        }

        .faq-answer {
            padding: 20px;
            background: var(--pure-white);
            color: var(--medium-gray);
            line-height: 1.7;
            display: none;
        }

        /* Contact Section */
        .contact-section {
            background: var(--light-gray);
            padding: 100px 0;
        }

        .contact-form {
            background: var(--pure-white);
            border-radius: 20px;
            padding: 50px;
            box-shadow: var(--shadow-light);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-control {
            border: 2px solid var(--border-color);
            border-radius: 10px;
            padding: 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-gold);
            box-shadow: 0 0 0 0.2rem rgba(255, 215, 0, 0.25);
            outline: none;
        }

        .btn-submit {
            background: var(--gradient-gold);
            color: var(--primary-black);
            padding: 15px 40px;
            border: none;
            border-radius: 25px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }

        /* Newsletter Section */
        .newsletter-section {
            background: var(--gradient-primary);
            color: var(--pure-white);
            padding: 80px 0;
            text-align: center;
        }

        .newsletter-form {
            max-width: 500px;
            margin: 0 auto;
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .newsletter-input {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
        }

        .newsletter-btn {
            background: var(--primary-gold);
            color: var(--primary-black);
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        /* Footer */
        .footer {
            background: var(--primary-black);
            color: var(--pure-white);
            padding: 60px 0 30px;
        }

        .footer-section {
            margin-bottom: 40px;
        }

        .footer-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary-gold);
            font-family: var(--font-heading);
        }

        .footer-link {
            color: var(--pure-white);
            text-decoration: none;
            display: block;
            padding: 5px 0;
            transition: all 0.3s ease;
        }

        .footer-link:hover {
            color: var(--primary-gold);
            text-decoration: none;
            padding-left: 10px;
        }

        .social-icons {
            margin-top: 20px;
        }

        .social-icon {
            display: inline-block;
            width: 40px;
            height: 40px;
            background: var(--medium-gray);
            color: var(--pure-white);
            text-align: center;
            line-height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            background: var(--primary-gold);
            color: var(--primary-black);
            transform: translateY(-3px);
        }

        /* Back to Top Button */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: var(--gradient-gold);
            color: var(--primary-black);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 20px;
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
            box-shadow: var(--shadow-medium);
        }

        /* Cookie Consent */
        .cookie-consent {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: var(--primary-black);
            color: var(--pure-white);
            padding: 20px;
            z-index: 1000;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .cookie-consent.show {
            transform: translateY(0);
        }

        .cookie-text {
            margin-bottom: 15px;
        }

        .cookie-buttons {
            text-align: center;
        }

        .cookie-btn {
            background: var(--primary-gold);
            color: var(--primary-black);
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            margin: 0 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .animate-on-scroll {
            opacity: 0;
            transition: all 0.6s ease;
        }

        .animate-on-scroll.animated {
            opacity: 1;
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }

        .slide-in-left {
            animation: slideInLeft 0.6s ease-out;
        }

        .slide-in-right {
            animation: slideInRight 0.6s ease-out;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .navbar-brand {
                font-size: 20px;
            }

            .hero-content {
                padding: 50px 0;
            }

            .newsletter-form {
                flex-direction: column;
            }

            .newsletter-input {
                margin-bottom: 15px;
            }

            .pricing-card.featured {
                transform: none;
            }

            .contact-form {
                padding: 30px;
            }

            .floating-icons {
                display: none;
            }

            .stat-number {
                font-size: 2rem;
            }

            .plan-price {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .hero-title {
                font-size: 2rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
            }

            .btn-primary-large,
            .btn-secondary-large {
                padding: 15px 25px;
                font-size: 1rem;
                display: block;
                margin: 10px auto;
                max-width: 250px;
            }

            .feature-card,
            .pricing-card,
            .testimonial-card {
                padding: 20px;
            }

            .section-title {
                font-size: 1.8rem;
            }

            .back-to-top {
                bottom: 20px;
                right: 20px;
                width: 45px;
                height: 45px;
                font-size: 18px;
            }
        }
    </style>
</head>

<body>
    <!-- Loading Screen -->
    <div class="loading-screen" id="loadingScreen">
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <h3>Loading Glinta Africa</h3>
            <p>Premium Hotspot Solutions</p>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top" id="mainNavbar">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}">GLINTA AFRICA</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#how-it-works">How It Works</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#testimonials">Reviews</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#faq">FAQ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn-demo" href="{$app_url}/landing/contact">Request Demo</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn-demo" href="{$app_url}/landing/contact">Contact Us</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-overlay"></div>
        <div class="floating-icons">
            <i class="floating-icon fa fa-wifi"></i>
            <i class="floating-icon fa fa-users"></i>
            <i class="floating-icon fa fa-credit-card"></i>
            <i class="floating-icon fa fa-chart-line"></i>
            <i class="floating-icon fa fa-shield"></i>
        </div>
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title">
                    Africa's Most <span class="highlight">Advanced</span><br>
                    Hotspot Billing System
                </h1>
                <p class="hero-subtitle">
                    Transform your WiFi business with enterprise-grade billing solutions. 
                    Trusted by 10,000+ businesses across Africa for seamless connectivity and revenue growth.
                </p>
                <div class="hero-cta">
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20start%20a%20free%20trial" class="btn-primary-large" target="_blank">Start Free Trial</a>
                    <a href="#features" class="btn-secondary-large">Explore Features</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number" data-count="10000">0</div>
                        <div class="stat-label">Active Businesses</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number" data-count="500000">0</div>
                        <div class="stat-label">Connected Users</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number" data-count="50">0</div>
                        <div class="stat-label">Countries</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number" data-count="99">0</div>
                        <div class="stat-label">Uptime %</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features-section">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">Comprehensive Hotspot Solutions</h2>
                    <p class="section-subtitle">Everything you need to run a successful WiFi business, all in one powerful platform</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-wifi feature-icon"></i>
                        <h4 class="feature-title">Captive Portal</h4>
                        <p class="feature-description">Fully customizable branded login portal with multi-language support, social media login, and advanced user authentication.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-users feature-icon"></i>
                        <h4 class="feature-title">User Management</h4>
                        <p class="feature-description">Complete customer relationship management with detailed profiles, usage analytics, and automated communications.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-credit-card feature-icon"></i>
                        <h4 class="feature-title">Payment Integration</h4>
                        <p class="feature-description">Support for M-Pesa, Airtel Money, PayPal, Stripe, and 50+ payment gateways with instant service activation.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-chart-line feature-icon"></i>
                        <h4 class="feature-title">Advanced Analytics</h4>
                        <p class="feature-description">Real-time dashboards, revenue reports, usage analytics, and predictive business insights.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-shield feature-icon"></i>
                        <h4 class="feature-title">Enterprise Security</h4>
                        <p class="feature-description">Bank-grade encryption, fraud detection, secure payment processing, and compliance with international standards.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-mobile feature-icon"></i>
                        <h4 class="feature-title">Mobile Responsive</h4>
                        <p class="feature-description">Fully optimized for mobile devices with native app experience and offline capabilities.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-cogs feature-icon"></i>
                        <h4 class="feature-title">MikroTik Integration</h4>
                        <p class="feature-description">Seamless integration with MikroTik RouterOS, automated configuration, and remote management capabilities.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-ticket feature-icon"></i>
                        <h4 class="feature-title">Voucher System</h4>
                        <p class="feature-description">Flexible voucher generation, batch printing, QR codes, and multi-tier pricing strategies.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <i class="fa fa-cloud feature-icon"></i>
                        <h4 class="feature-title">Cloud Infrastructure</h4>
                        <p class="feature-description">99.9% uptime guarantee, automatic backups, global CDN, and enterprise-grade hosting.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="how-it-works">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">How It Works</h2>
                    <p class="section-subtitle">Get started in minutes with our simple 4-step process</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="process-step animate-on-scroll">
                        <div class="step-number">1</div>
                        <h4 class="step-title">Sign Up</h4>
                        <p class="step-description">Create your account and choose the perfect plan for your business needs.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="process-step animate-on-scroll">
                        <div class="step-number">2</div>
                        <h4 class="step-title">Configure</h4>
                        <p class="step-description">Set up your hotspot settings, pricing, and customize your branded portal.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="process-step animate-on-scroll">
                        <div class="step-number">3</div>
                        <h4 class="step-title">Connect</h4>
                        <p class="step-description">Integrate with your MikroTik router and payment gateways in minutes.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="process-step animate-on-scroll">
                        <div class="step-number">4</div>
                        <h4 class="step-title">Launch</h4>
                        <p class="step-description">Go live and start generating revenue from your WiFi network immediately.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="pricing-section">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">Transparent Pricing</h2>
                    <p class="section-subtitle">Choose the perfect plan for your hotspot business with no hidden fees</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card animate-on-scroll">
                        <h3 class="plan-name">Starter</h3>
                        <div class="plan-price">KES 1,000</div>
                        <div class="plan-period">per month</div>
                        <ul class="plan-features">
                            <li>Up to 50 concurrent users</li>
                            <li>1 location</li>
                            <li>Basic captive portal</li>
                            <li>M-Pesa integration</li>
                            <li>Email support</li>
                            <li>Mobile responsive</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started" class="btn-primary-large" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card animate-on-scroll">
                        <h3 class="plan-name">Growth</h3>
                        <div class="plan-price">KES 2,500</div>
                        <div class="plan-period">per month</div>
                        <ul class="plan-features">
                            <li>Up to 150 concurrent users</li>
                            <li>3 locations</li>
                            <li>Advanced portal customization</li>
                            <li>Multiple payment gateways</li>
                            <li>Priority support</li>
                            <li>Analytics dashboard</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started" class="btn-primary-large" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card featured animate-on-scroll">
                        <h3 class="plan-name">Professional</h3>
                        <div class="plan-price">KES 5,000</div>
                        <div class="plan-period">per month</div>
                        <ul class="plan-features">
                            <li>Up to 500 concurrent users</li>
                            <li>10 locations</li>
                            <li>Full white-label solution</li>
                            <li>API access</li>
                            <li>24/7 phone support</li>
                            <li>Advanced analytics</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started" class="btn-primary-large" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card animate-on-scroll">
                        <h3 class="plan-name">Enterprise</h3>
                        <div class="plan-price">KES 10,000</div>
                        <div class="plan-period">per month</div>
                        <ul class="plan-features">
                            <li>Unlimited users</li>
                            <li>Unlimited locations</li>
                            <li>Custom development</li>
                            <li>Dedicated account manager</li>
                            <li>SLA guarantee</li>
                            <li>On-premise option</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Enterprise%20plan" class="btn-primary-large" target="_blank">Contact Sales</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="testimonials-section">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">What Our Customers Say</h2>
                    <p class="section-subtitle">Join thousands of satisfied customers across Africa</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="testimonial-card animate-on-scroll">
                        <p class="testimonial-text">
                            "Glinta Africa transformed our hotel's WiFi service. Revenue increased by 300% in the first month. The system is incredibly user-friendly and reliable."
                        </p>
                        <div class="testimonial-author">Sarah Mwangi</div>
                        <div class="testimonial-company">Grand Palace Hotel, Nairobi</div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="testimonial-card animate-on-scroll">
                        <p class="testimonial-text">
                            "The M-Pesa integration is seamless. Our customers love the easy payment process, and we've seen a significant reduction in payment-related issues."
                        </p>
                        <div class="testimonial-author">James Ochieng</div>
                        <div class="testimonial-company">Urban Café, Kampala</div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="testimonial-card animate-on-scroll">
                        <p class="testimonial-text">
                            "Outstanding support team! They helped us migrate from our old system in just 2 days. The analytics dashboard provides valuable business insights."
                        </p>
                        <div class="testimonial-author">Amina Hassan</div>
                        <div class="testimonial-company">ConnectNet ISP, Lagos</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section id="faq" class="faq-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="section-title">Frequently Asked Questions</h2>
                    <p class="section-subtitle">Get answers to common questions about our hotspot billing system</p>
                    
                    <div class="faq-item">
                        <div class="faq-question">How quickly can I set up the system?</div>
                        <div class="faq-answer">Most customers are up and running within 30 minutes. Our setup wizard guides you through the entire process, and our support team is available to assist if needed.</div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">Do you support MikroTik routers?</div>
                        <div class="faq-answer">Yes! We have native integration with MikroTik RouterOS and support all major MikroTik models. We also work with other router brands through RADIUS integration.</div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">What payment methods are supported?</div>
                        <div class="faq-answer">We support M-Pesa, Airtel Money, PayPal, Stripe, Flutterwave, and 50+ other payment gateways. Regional payment methods are prioritized for African markets.</div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">Is there a setup fee?</div>
                        <div class="faq-answer">No setup fees! You only pay the monthly subscription. We also offer a 14-day free trial so you can test all features before committing.</div>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">Can I customize the captive portal?</div>
                        <div class="faq-answer">Absolutely! You can fully customize colors, logos, text, and layout. Professional plans include white-label options with your own branding.</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="section-title">Get Started Today</h2>
                    <p class="section-subtitle">Ready to transform your WiFi business? Contact us for a personalized demo</p>
                    
                    <div class="contact-form">
                        <form id="contactForm">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Your Name" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="email" class="form-control" placeholder="Email Address" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="tel" class="form-control" placeholder="Phone Number" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <select class="form-control" required>
                                            <option value="">Select Plan</option>
                                            <option value="starter">Starter - KES 1,000</option>
                                            <option value="growth">Growth - KES 2,500</option>
                                            <option value="professional">Professional - KES 5,000</option>
                                            <option value="enterprise">Enterprise - KES 10,000</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" rows="5" placeholder="Tell us about your business and requirements"></textarea>
                            </div>
                            <button type="submit" class="btn-submit">Send Message</button>
                        </form>
                    </div>
                    
                    <div class="row mt-5">
                        <div class="col-md-4 text-center">
                            <h5><i class="fa fa-envelope"></i> Email</h5>
                            <p><a href="mailto:info@glintaafrica.com" style="color: #007bff; text-decoration: none;">info@glintaafrica.com</a><br><a href="mailto:watsonwambugu@yahoo.com" style="color: #007bff; text-decoration: none;">watsonwambugu@yahoo.com</a></p>
                        </div>
                        <div class="col-md-4 text-center">
                            <h5><i class="fa fa-phone"></i> Phone</h5>
                            <p><a href="https://wa.me/254711503023" target="_blank" style="color: #25D366; text-decoration: none;">+254 711 503 023</a></p>
                        </div>
                        <div class="col-md-4 text-center">
                            <h5><i class="fa fa-whatsapp"></i> WhatsApp</h5>
                            <p><a href="https://wa.me/254711503023" target="_blank" style="color: #25D366; text-decoration: none;">+254 711 503 023</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 mx-auto text-center">
                    <h2>Stay Updated</h2>
                    <p>Get the latest updates, tips, and industry insights delivered to your inbox</p>
                    <form class="newsletter-form" id="newsletterForm">
                        <input type="email" class="newsletter-input" placeholder="Enter your email address" required>
                        <button type="submit" class="newsletter-btn">Subscribe</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="footer-section">
                        <h4 class="footer-title">Glinta Africa</h4>
                        <p>Africa's leading hotspot billing solution provider. Empowering businesses to monetize their WiFi networks with enterprise-grade technology.</p>
                        <div class="social-icons">
                            <a href="#" class="social-icon"><i class="fa fa-facebook"></i></a>
                            <a href="#" class="social-icon"><i class="fa fa-twitter"></i></a>
                            <a href="#" class="social-icon"><i class="fa fa-linkedin"></i></a>
                            <a href="#" class="social-icon"><i class="fa fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <div class="footer-section">
                        <h4 class="footer-title">Product</h4>
                        <a href="#features" class="footer-link">Features</a>
                        <a href="#pricing" class="footer-link">Pricing</a>
                        <a href="#" class="footer-link">API Documentation</a>
                        <a href="#" class="footer-link">Integrations</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <div class="footer-section">
                        <h4 class="footer-title">Support</h4>
                        <a href="#" class="footer-link">Help Center</a>
                        <a href="#" class="footer-link">Live Chat</a>
                        <a href="#contact" class="footer-link">Contact Us</a>
                        <a href="#" class="footer-link">System Status</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <div class="footer-section">
                        <h4 class="footer-title">Company</h4>
                        <a href="#" class="footer-link">About Us</a>
                        <a href="#" class="footer-link">Careers</a>
                        <a href="#" class="footer-link">Press Kit</a>
                        <a href="#" class="footer-link">Partners</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <div class="footer-section">
                        <h4 class="footer-title">Legal</h4>
                        <a href="#" class="footer-link">Privacy Policy</a>
                        <a href="#" class="footer-link">Terms of Service</a>
                        <a href="#" class="footer-link">Cookie Policy</a>
                        <a href="#" class="footer-link">GDPR</a>
                    </div>
                </div>
            </div>
            <hr style="border-color: #333; margin: 40px 0 20px;">
            <div class="row">
                <div class="col-lg-6">
                    <p>&copy; 2025 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-lg-6 text-right">
                    <p>Made with ❤️ by <a href="https://watsonsdevelopers.com" style="color: var(--primary-gold);">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <button class="back-to-top" id="backToTop">
        <i class="fa fa-arrow-up"></i>
    </button>

    <!-- Cookie Consent -->
    <div class="cookie-consent" id="cookieConsent">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <p class="cookie-text">We use cookies to enhance your experience. By continuing to visit this site you agree to our use of cookies.</p>
                </div>
                <div class="col-lg-4">
                    <div class="cookie-buttons">
                        <button class="cookie-btn" onclick="acceptCookies()">Accept</button>
                        <button class="cookie-btn" onclick="declineCookies()">Decline</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="{$app_url}/ui/ui/scripts/jquery.min.js"></script>
    <script src="{$app_url}/ui/ui/scripts/bootstrap.min.js"></script>
    
    <script>
        // Loading Screen
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('loadingScreen').style.opacity = '0';
                setTimeout(function() {
                    document.getElementById('loadingScreen').style.display = 'none';
                }, 500);
            }, 1500);
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
            counters.forEach(counter => {
                const target = parseInt(counter.getAttribute('data-count'));
                const duration = 2000;
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
            });
        }

        // Intersection Observer for Animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animated');
                    if (entry.target.closest('.stats-section')) {
                        animateCounters();
                    }
                }
            });
        }, observerOptions);

        document.querySelectorAll('.animate-on-scroll').forEach(el => {
            observer.observe(el);
        });

        // FAQ Accordion
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', function() {
                const answer = this.nextElementSibling;
                const isActive = this.classList.contains('active');

                // Close all other FAQ items
                document.querySelectorAll('.faq-question').forEach(q => {
                    q.classList.remove('active');
                    q.nextElementSibling.style.display = 'none';
                });

                // Toggle current FAQ item
                if (!isActive) {
                    this.classList.add('active');
                    answer.style.display = 'block';
                }
            });
        });

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

        // Contact Form
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            // Add form submission logic here
            alert('Thank you for your message! We will get back to you within 24 hours.');
        });

        // Newsletter Form
        document.getElementById('newsletterForm').addEventListener('submit', function(e) {
            e.preventDefault();
            // Add newsletter subscription logic here
            alert('Thank you for subscribing to our newsletter!');
        });

        // Cookie Consent
        function showCookieConsent() {
            if (!localStorage.getItem('cookieConsent')) {
                setTimeout(() => {
                    document.getElementById('cookieConsent').classList.add('show');
                }, 2000);
            }
        }

        function acceptCookies() {
            localStorage.setItem('cookieConsent', 'accepted');
            document.getElementById('cookieConsent').classList.remove('show');
        }

        function declineCookies() {
            localStorage.setItem('cookieConsent', 'declined');
            document.getElementById('cookieConsent').classList.remove('show');
        }

        // Initialize
        showCookieConsent();

        // Parallax Effect (subtle)
        window.addEventListener('scroll', function() {
            const scrolled = window.scrollY;
            const parallaxElements = document.querySelectorAll('.hero-section');
            parallaxElements.forEach(element => {
                const speed = 0.5;
                element.style.transform = `translateY(${scrolled * speed}px)`;
            });
        });

        // Mobile Menu Toggle
        document.querySelector('.navbar-toggler').addEventListener('click', function() {
            document.querySelector('.navbar-collapse').classList.toggle('show');
        });

        // Close mobile menu when clicking on links
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function() {
                const navbarCollapse = document.querySelector('.navbar-collapse');
                if (navbarCollapse.classList.contains('show')) {
                    navbarCollapse.classList.remove('show');
                }
            });
        });
    </script>
</body>
</html>