<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Comprehensive internet billing solutions for African ISPs. Hotspot management, PPPoE billing, mobile money integration, and advanced analytics.">
    <meta name="keywords" content="ISP billing software, hotspot management, PPPoE billing, mobile money integration, WiFi monetization, internet service provider solutions">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/services">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Three.js for 3D animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    
    <style>
        :root {
            --gold: #D4AF37;
            --gold-light: #F4E4C1;
            --gold-dark: #B8941F;
            --black: #000000;
            --black-soft: #1a1a1a;
            --white: #FFFFFF;
            --white-soft: #f8f8f8;
            --gray: #666666;
            --shadow: 0 5px 20px rgba(0,0,0,0.1);
            --shadow-lg: 0 15px 40px rgba(0,0,0,0.2);
            --shadow-gold: 0 10px 30px rgba(212,175,55,0.3);
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 50%, #B8941F 100%);
            --gradient-black: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            --gradient-savanna: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
            --gradient-sahara: linear-gradient(135deg, #dda0dd 0%, #98fb98 100%);
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
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
            color: var(--black);
            background: var(--white);
            overflow-x: hidden;
        }

        /* Creative Logo Typography */
        .logo-brand {
            font-family: 'Orbitron', monospace;
            font-size: 1.8rem;
            font-weight: 900;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            position: relative;
            transition: all 0.3s ease;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .logo-brand:hover {
            transform: scale(1.05);
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding: 1.2rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 2000;
        }

        .nav-link {
            color: var(--black);
            font-weight: 500;
            margin: 0 1rem;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 3px;
            background: var(--gradient-gold);
            transition: width 0.3s ease;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Enhanced Hero Section */
        .hero {
            min-height: 100vh;
            background: var(--gradient-black);
            position: relative;
            display: flex;
            align-items: center;
            overflow: hidden;
            padding-top: 80px;
        }

        .hero-canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.8) 0%, rgba(212,175,55,0.1) 100%);
            z-index: 2;
        }

        .hero-content {
            position: relative;
            z-index: 10;
            color: var(--white);
        }

        .hero-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 4rem;
            font-weight: 900;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.5rem;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
        }

        /* African-inspired floating elements */
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 3;
        }

        .floating-element {
            position: absolute;
            background: var(--gold);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        /* Enhanced Service Cards */
        .service-card {
            background: var(--white);
            border-radius: 25px;
            padding: 3rem;
            margin-bottom: 3rem;
            box-shadow: var(--shadow);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(212, 175, 55, 0.2);
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(212, 175, 55, 0.1) 0%, transparent 70%);
            transform: scale(0);
            transition: transform 0.6s ease;
        }

        .service-card:hover::before {
            transform: scale(1);
        }

        .service-card:hover {
            transform: translateY(-20px) scale(1.02);
            box-shadow: 0 30px 60px rgba(212, 175, 55, 0.3);
        }

        .service-icon {
            width: 100px;
            height: 100px;
            background: var(--gradient-gold);
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 2rem;
            color: var(--black);
            font-size: 3rem;
            transition: all 0.3s ease;
            position: relative;
            z-index: 10;
        }

        .service-card:hover .service-icon {
            transform: scale(1.2) rotate(10deg);
        }

        /* Interactive Features Section */
        .features-showcase {
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.05) 0%, rgba(248, 244, 224, 0.1) 100%);
            padding: 6rem 0;
            position: relative;
            overflow: hidden;
        }

        .features-showcase::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300"><defs><pattern id="african-tribal" x="0" y="0" width="60" height="60" patternUnits="userSpaceOnUse"><path d="M30 0 L60 30 L30 60 L0 30 Z" fill="none" stroke="%23D4AF37" stroke-width="1" opacity="0.1"/><circle cx="30" cy="30" r="5" fill="%23D4AF37" opacity="0.05"/></pattern></defs><rect width="300" height="300" fill="url(%23african-tribal)"/></svg>');
            background-size: 300px 300px;
            opacity: 0.3;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(212, 175, 55, 0.2);
        }

        .feature-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.2), transparent);
            transition: left 0.6s ease;
        }

        .feature-card:hover::after {
            left: 100%;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(212, 175, 55, 0.3);
        }

        /* Process Flow with African Art */
        .process-section {
            background: var(--black-soft);
            color: var(--white);
            padding: 6rem 0;
            position: relative;
        }

        .process-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400"><defs><pattern id="adinkra" x="0" y="0" width="80" height="80" patternUnits="userSpaceOnUse"><g fill="none" stroke="%23D4AF37" stroke-width="1" opacity="0.1"><circle cx="40" cy="40" r="30"/><path d="M10 40 L70 40 M40 10 L40 70"/><path d="M20 20 L60 60 M60 20 L20 60"/></g></pattern></defs><rect width="400" height="400" fill="url(%23adinkra)"/></svg>');
            background-size: 400px 400px;
            opacity: 0.1;
        }

        .process-step {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 20px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            position: relative;
            transition: all 0.4s ease;
        }

        .process-step::before {
            content: '';
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 40px;
            height: 40px;
            background: var(--gradient-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: var(--black);
        }

        .process-step:nth-child(1)::before { content: '1'; }
        .process-step:nth-child(2)::before { content: '2'; }
        .process-step:nth-child(3)::before { content: '3'; }
        .process-step:nth-child(4)::before { content: '4'; }

        .process-step:hover {
            transform: translateY(-10px);
            background: rgba(212, 175, 55, 0.1);
        }

        /* Technology Stack Visualization */
        .tech-stack {
            padding: 6rem 0;
            background: var(--white-soft);
            position: relative;
        }

        .tech-item {
            background: var(--white);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .tech-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-gold);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .tech-item:hover::before {
            transform: scaleX(1);
        }

        .tech-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .tech-icon {
            width: 60px;
            height: 60px;
            background: var(--gradient-gold);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            color: var(--black);
            font-size: 1.5rem;
        }

        /* Pricing Comparison */
        .pricing-comparison {
            background: var(--gradient-black);
            color: var(--white);
            padding: 6rem 0;
            position: relative;
        }

        .pricing-table {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            border: 1px solid rgba(212, 175, 55, 0.3);
        }

        .pricing-row {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1.5rem 0;
            transition: all 0.3s ease;
        }

        .pricing-row:hover {
            background: rgba(212, 175, 55, 0.1);
            padding-left: 1rem;
        }

        .check-icon {
            color: var(--gold);
            font-size: 1.2rem;
        }

        /* Call-to-Action */
        .cta-section {
            background: var(--gradient-gold);
            padding: 6rem 0;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><defs><pattern id="kente-pattern" x="0" y="0" width="40" height="40" patternUnits="userSpaceOnUse"><rect width="20" height="20" fill="%23000000" opacity="0.1"/><rect x="20" y="20" width="20" height="20" fill="%23000000" opacity="0.1"/><rect x="10" y="10" width="20" height="20" fill="%23000000" opacity="0.05"/></pattern></defs><rect width="200" height="200" fill="url(%23kente-pattern)"/></svg>');
            background-size: 200px 200px;
            opacity: 0.3;
        }

        .cta-content {
            position: relative;
            z-index: 10;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.2rem;
            }
            
            .service-card {
                padding: 2rem;
            }
            
            .service-icon {
                width: 80px;
                height: 80px;
                font-size: 2rem;
            }
        }

        /* Buttons */
        .btn {
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: var(--gradient-gold);
            border: none;
            color: var(--black);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(212,175,55,0.4);
        }

        .btn-outline-primary {
            border: 2px solid var(--gold);
            color: var(--gold);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--gold);
            color: var(--black);
            transform: translateY(-3px);
        }

        /* Scroll Progress Bar */
        .scroll-progress {
            position: fixed;
            top: 0;
            left: 0;
            width: 0%;
            height: 4px;
            background: var(--gradient-gold);
            z-index: 9999;
            transition: width 0.3s ease;
        }

        /* Loading Animation */
        .loading-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--white);
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: opacity 0.5s ease;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid var(--gold-light);
            border-top: 4px solid var(--gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Interactive Hover Effects */
        .hover-lift:hover {
            transform: translateY(-10px);
            transition: transform 0.3s ease;
        }

        .hover-glow:hover {
            box-shadow: 0 0 30px rgba(212, 175, 55, 0.5);
            transition: box-shadow 0.3s ease;
        }

        /* Animated Counters */
        .counter {
            font-size: 3rem;
            font-weight: 900;
            color: var(--gold);
            font-family: 'Space Grotesk', sans-serif;
        }

        /* Video Background */
        .video-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 12px;
        }

        ::-webkit-scrollbar-track {
            background: var(--white-soft);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gradient-gold);
            border-radius: 6px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--gold-dark);
        }
    </style>
</head>

<body>
    <!-- Loading Animation -->
    <div class="loading-animation" id="loadingAnimation">
        <div class="loading-spinner"></div>
    </div>

    <!-- Scroll Progress Bar -->
    <div class="scroll-progress" id="scrollProgress"></div>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="logo-brand" href="{$app_url}">
                GLINTA<span style="color: var(--gold);">•</span>AFRICA
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars text-dark"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="{$app_url}/services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/blog">Blog</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <canvas class="hero-canvas" id="heroCanvas"></canvas>
        <div class="hero-overlay"></div>
        <div class="floating-elements">
            <div class="floating-element" style="top: 20%; left: 10%; width: 8px; height: 8px; animation-delay: 0s;"></div>
            <div class="floating-element" style="top: 60%; left: 80%; width: 12px; height: 12px; animation-delay: 1s;"></div>
            <div class="floating-element" style="top: 40%; left: 60%; width: 6px; height: 6px; animation-delay: 2s;"></div>
            <div class="floating-element" style="top: 80%; left: 20%; width: 10px; height: 10px; animation-delay: 3s;"></div>
        </div>
        
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 mx-auto text-center">
                    <div class="hero-content">
                        <h1 class="hero-title" data-aos="fade-up">
                            EMPOWERING AFRICA'S<br>
                            DIGITAL INFRASTRUCTURE
                        </h1>
                        <p class="hero-subtitle" data-aos="fade-up" data-aos-delay="200">
                            Comprehensive ISP billing solutions designed for the unique challenges 
                            and opportunities of the African market
                        </p>
                        <div class="mt-5" data-aos="fade-up" data-aos-delay="400">
                            <a href="#services" class="btn btn-primary btn-lg me-3">
                                <i class="fas fa-arrow-down me-2"></i>
                                Explore Services
                            </a>
                            <a href="{$app_url}/contact" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-phone me-2"></i>
                                Request Demo
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Services Section -->
    <section id="services" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">
                        Complete ISP Management Suite
                    </h2>
                    <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">
                        Everything you need to run a successful internet service business in Africa
                    </p>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card hover-lift">
                        <div class="service-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h3 class="mb-3">Hotspot Management</h3>
                        <p class="text-muted mb-4">
                            Deploy and manage thousands of WiFi hotspots across multiple locations. 
                            Real-time monitoring, bandwidth control, and automated customer management.
                        </p>
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Multi-location hotspot deployment
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Real-time bandwidth monitoring
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Automated customer onboarding
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Custom branding for captive portals
                            </li>
                        </ul>
                        <div class="mt-4">
                            <a href="#" class="btn btn-outline-primary">
                                Learn More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card hover-lift">
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3 class="mb-3">Mobile Money Integration</h3>
                        <p class="text-muted mb-4">
                            Seamless integration with all major African mobile money platforms. 
                            Instant payments, automatic activation, and comprehensive reconciliation.
                        </p>
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                M-Pesa, Airtel Money, MTN MoMo support
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Instant payment confirmation
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Automatic service activation
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Advanced reconciliation tools
                            </li>
                        </ul>
                        <div class="mt-4">
                            <a href="#" class="btn btn-outline-primary">
                                Learn More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card hover-lift">
                        <div class="service-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3 class="mb-3">Advanced Analytics</h3>
                        <p class="text-muted mb-4">
                            Make data-driven decisions with comprehensive analytics and reporting. 
                            Track revenue, customer behavior, and network performance in real-time.
                        </p>
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Real-time revenue tracking
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Customer behavior analysis
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Network performance monitoring
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Predictive growth analytics
                            </li>
                        </ul>
                        <div class="mt-4">
                            <a href="#" class="btn btn-outline-primary">
                                Learn More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="service-card hover-lift">
                        <div class="service-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="mb-3">Customer Management</h3>
                        <p class="text-muted mb-4">
                            Comprehensive customer relationship management with automated communications, 
                            support ticketing, and loyalty programs.
                        </p>
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Automated customer communications
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Integrated support ticketing
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Loyalty and rewards programs
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-warning me-2"></i>
                                Multi-language support
                            </li>
                        </ul>
                        <div class="mt-4">
                            <a href="#" class="btn btn-outline-primary">
                                Learn More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Showcase -->
    <section class="features-showcase">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">
                        African-First Features
                    </h2>
                    <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">
                        Features specifically designed for the African market
                    </p>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <i class="fas fa-language text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h4>Multi-Language Support</h4>
                        <p class="text-muted">
                            Support for English, Swahili, French, Arabic, and other African languages
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <i class="fas fa-signal text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h4>Low-Bandwidth Optimization</h4>
                        <p class="text-muted">
                            Optimized for low-bandwidth environments and intermittent connectivity
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <i class="fas fa-coins text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h4>Local Currency Support</h4>
                        <p class="text-muted">
                            Support for all African currencies with real-time exchange rates
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <i class="fas fa-clock text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h4>Flexible Billing Cycles</h4>
                        <p class="text-muted">
                            Adapt to local payment patterns with flexible billing options
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <i class="fas fa-shield-alt text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h4>Regulatory Compliance</h4>
                        <p class="text-muted">
                            Built-in compliance with African telecommunications regulations
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="700">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <i class="fas fa-handshake text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h4>Partner Network</h4>
                        <p class="text-muted">
                            Access to our extensive network of African technology partners
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Process Flow Section -->
    <section class="process-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4 text-white" data-aos="fade-up">
                        How It Works
                    </h2>
                    <p class="lead text-white-50" data-aos="fade-up" data-aos-delay="100">
                        Simple setup, powerful results
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="process-step text-center">
                        <h4 class="text-white mb-3">Setup & Configuration</h4>
                        <p class="text-white-50">
                            Quick 30-minute setup with our guided configuration wizard
                        </p>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="process-step text-center">
                        <h4 class="text-white mb-3">Network Integration</h4>
                        <p class="text-white-50">
                            Seamless integration with your existing network infrastructure
                        </p>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="process-step text-center">
                        <h4 class="text-white mb-3">Payment Setup</h4>
                        <p class="text-white-50">
                            Connect with mobile money and payment gateways
                        </p>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="500">
                    <div class="process-step text-center">
                        <h4 class="text-white mb-3">Go Live</h4>
                        <p class="text-white-50">
                            Launch your service and start generating revenue immediately
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Stack -->
    <section class="tech-stack">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">
                        Built on Proven Technology
                    </h2>
                    <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">
                        Enterprise-grade technology stack designed for African conditions
                    </p>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-php"></i>
                        </div>
                        <h5>PHP Backend</h5>
                        <p class="text-muted">
                            Robust and scalable backend built with modern PHP frameworks
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h5>MySQL Database</h5>
                        <p class="text-muted">
                            Reliable database system with advanced replication and backup
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-js-square"></i>
                        </div>
                        <h5>Modern Frontend</h5>
                        <p class="text-muted">
                            Responsive user interface built with latest web technologies
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-cloud"></i>
                        </div>
                        <h5>Cloud Ready</h5>
                        <p class="text-muted">
                            Deploy on AWS, Azure, or any cloud platform of your choice
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5>Mobile First</h5>
                        <p class="text-muted">
                            Optimized for mobile devices with offline capabilities
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="700">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h5>Security First</h5>
                        <p class="text-muted">
                            End-to-end encryption and advanced security measures
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Success Metrics -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">
                        Proven Results Across Africa
                    </h2>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-3 col-md-6 text-center mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="counter" data-target="5000">0</div>
                    <h5>Active ISPs</h5>
                    <p class="text-muted">Across 25+ African countries</p>
                </div>

                <div class="col-lg-3 col-md-6 text-center mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="counter" data-target="2000000">0</div>
                    <h5>Connected Users</h5>
                    <p class="text-muted">Daily active internet users</p>
                </div>

                <div class="col-lg-3 col-md-6 text-center mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="counter" data-target="50000000">0</div>
                    <h5>Revenue Processed</h5>
                    <p class="text-muted">Monthly transaction volume (USD)</p>
                </div>

                <div class="col-lg-3 col-md-6 text-center mb-4" data-aos="fade-up" data-aos-delay="500">
                    <div class="counter" data-target="99.9">0</div>
                    <h5>% Uptime</h5>
                    <p class="text-muted">Guaranteed service availability</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <div class="cta-content">
                        <h2 class="display-4 fw-bold mb-4 text-black" data-aos="zoom-in">
                            Ready to Transform Your Business?
                        </h2>
                        <p class="lead mb-5 text-black" data-aos="zoom-in" data-aos-delay="100">
                            Join thousands of ISPs already using our platform to grow their business
                        </p>
                        <div data-aos="zoom-in" data-aos-delay="200">
                            <a href="{$app_url}/contact" class="btn btn-dark btn-lg me-3">
                                <i class="fas fa-rocket me-2"></i>
                                Start Free Trial
                            </a>
                            <a href="tel:+254711503023" class="btn btn-outline-dark btn-lg">
                                <i class="fas fa-phone me-2"></i>
                                Schedule Demo
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h3 class="logo-brand mb-4">GLINTA•AFRICA</h3>
                    <p class="text-white-50">
                        Empowering African ISPs with cutting-edge billing solutions. 
                        Built in Africa, for Africa.
                    </p>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Services</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white-50">Hotspot Billing</a></li>
                        <li><a href="#" class="text-white-50">PPPoE Management</a></li>
                        <li><a href="#" class="text-white-50">Mobile Money</a></li>
                        <li><a href="#" class="text-white-50">Analytics</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Company</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/about" class="text-white-50">About Us</a></li>
                        <li><a href="{$app_url}/blog" class="text-white-50">Blog</a></li>
                        <li><a href="{$app_url}/contact" class="text-white-50">Contact</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Support</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/help" class="text-white-50">Help Center</a></li>
                        <li><a href="{$app_url}/documentation" class="text-white-50">Documentation</a></li>
                        <li><a href="{$app_url}/community" class="text-white-50">Community</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Legal</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/privacy" class="text-white-50">Privacy</a></li>
                        <li><a href="{$app_url}/terms" class="text-white-50">Terms</a></li>
                        <li><a href="{$app_url}/security" class="text-white-50">Security</a></li>
                    </ul>
                </div>
            </div>
            
            <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
            
            <div class="row">
                <div class="col-lg-6">
                    <p class="text-white-50 mb-0">
                        © 2025 Glinta Africa. All rights reserved.
                    </p>
                </div>
                <div class="col-lg-6 text-lg-end">
                    <p class="text-white-50 mb-0">
                        Made with ❤️ in Africa
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true,
            offset: 100
        });

        // Loading Animation
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('loadingAnimation').style.opacity = '0';
                setTimeout(function() {
                    document.getElementById('loadingAnimation').style.display = 'none';
                }, 500);
            }, 1000);
        });

        // Scroll Progress Bar
        window.addEventListener('scroll', function() {
            const scrolled = (window.scrollY / (document.documentElement.scrollHeight - window.innerHeight)) * 100;
            document.getElementById('scrollProgress').style.width = scrolled + '%';
        });

        // Animated Counters
        const counters = document.querySelectorAll('.counter');
        const speed = 200;

        const animateCounter = (counter) => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;
            const increment = target / speed;
            
            if (count < target) {
                counter.innerText = Math.ceil(count + increment);
                setTimeout(() => animateCounter(counter), 1);
            } else {
                counter.innerText = target;
                if (target === 99.9) {
                    counter.innerText = '99.9';
                } else if (target >= 1000000) {
                    counter.innerText = (target / 1000000).toFixed(1) + 'M';
                } else if (target >= 1000) {
                    counter.innerText = (target / 1000).toFixed(0) + 'K';
                }
            }
        };

        // Intersection Observer for counters
        const counterObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateCounter(entry.target);
                    counterObserver.unobserve(entry.target);
                }
            });
        });

        counters.forEach(counter => {
            counterObserver.observe(counter);
        });

        // 3D Hero Canvas Animation
        const canvas = document.getElementById('heroCanvas');
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, canvas.offsetWidth / canvas.offsetHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ canvas: canvas, alpha: true });
        
        renderer.setSize(canvas.offsetWidth, canvas.offsetHeight);
        renderer.setClearColor(0x000000, 0);

        // Create floating particles
        const particleGeometry = new THREE.BufferGeometry();
        const particleCount = 50;
        const posArray = new Float32Array(particleCount * 3);
        
        for (let i = 0; i < particleCount * 3; i++) {
            posArray[i] = (Math.random() - 0.5) * 10;
        }
        
        particleGeometry.setAttribute('position', new THREE.BufferAttribute(posArray, 3));
        
        const particleMaterial = new THREE.PointsMaterial({
            size: 0.005,
            color: 0xD4AF37,
            transparent: true,
            opacity: 0.8
        });
        
        const particleSystem = new THREE.Points(particleGeometry, particleMaterial);
        scene.add(particleSystem);
        
        camera.position.z = 3;
        
        // Animation loop
        function animate() {
            requestAnimationFrame(animate);
            
            particleSystem.rotation.x += 0.001;
            particleSystem.rotation.y += 0.001;
            
            renderer.render(scene, camera);
        }
        
        animate();

        // Responsive canvas
        window.addEventListener('resize', function() {
            camera.aspect = canvas.offsetWidth / canvas.offsetHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(canvas.offsetWidth, canvas.offsetHeight);
        });

        // Smooth scrolling for anchor links
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

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 100) {
                navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                navbar.style.boxShadow = '0 2px 20px rgba(0,0,0,0.1)';
            } else {
                navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                navbar.style.boxShadow = 'none';
            }
        });

        // Service card hover effects
        document.querySelectorAll('.service-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-20px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });

        // Feature card animations
        document.querySelectorAll('.feature-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Button ripple effect
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.classList.add('ripple');
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Add ripple CSS
        const style = document.createElement('style');
        style.textContent = `
            .btn {
                position: relative;
                overflow: hidden;
            }
            
            .ripple {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            }
            
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>