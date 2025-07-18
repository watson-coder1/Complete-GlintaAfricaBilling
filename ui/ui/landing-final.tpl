<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Revolutionary internet billing solutions for hotspot and PPPoE. Empowering African ISPs and internet providers with cutting-edge technology.">
    <meta name="keywords" content="internet billing software, hotspot management, PPPoE billing, ISP software, WISP billing, African internet solutions">
    <meta name="author" content="Glinta Africa">
    <meta property="og:title" content="Glinta Africa - Transforming Internet Access Across Africa">
    <meta property="og:description" content="Next-generation billing platform for internet providers. Seamless hotspot and PPPoE management with automated payments.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://glintaafrica.com">
    
    <link rel="canonical" href="https://glintaafrica.com">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Dynamic Visual Styles -->
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

        .logo-brand::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: var(--gradient-gold);
            border-radius: 8px;
            opacity: 0;
            z-index: -1;
            transition: opacity 0.3s ease;
        }

        .logo-brand:hover::before {
            opacity: 0.1;
        }

        .logo-brand:hover {
            transform: scale(1.05);
        }

        /* Dynamic Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding: 1.2rem 0;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 2000;
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.98);
            box-shadow: var(--shadow-gold);
            padding: 0.8rem 0;
        }

        .navbar-nav .nav-link {
            color: var(--black);
            font-weight: 600;
            margin: 0 0.5rem;
            padding: 0.8rem 1.2rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .navbar-nav .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--gradient-gold);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .navbar-nav .nav-link:hover::before {
            left: 0;
        }

        .navbar-nav .nav-link:hover {
            color: var(--white);
            transform: translateY(-2px);
        }

        /* Hero Section with Parallax */
        .hero {
            background: linear-gradient(135deg, rgba(0,0,0,0.8) 0%, rgba(26,26,26,0.6) 100%), 
                        url('https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?ixlib=rb-4.0.3&auto=format&fit=crop&w=2049&q=80') center/cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 20%, rgba(212,175,55,0.2) 0%, transparent 50%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: var(--white);
        }

        .hero-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 4.5rem;
            font-weight: 700;
            line-height: 1.1;
            margin-bottom: 2rem;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: slideInUp 1s ease-out;
        }

        .hero-subtitle {
            font-size: 1.4rem;
            font-weight: 500;
            margin-bottom: 3rem;
            color: rgba(255, 255, 255, 0.9);
            animation: slideInUp 1s ease-out 0.3s both;
        }

        /* Floating Particles */
        .floating-particles {
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
            background: var(--gold);
            border-radius: 50%;
            opacity: 0.6;
            animation: float 8s infinite linear;
        }

        .particle:nth-child(1) { width: 4px; height: 4px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 6px; height: 6px; left: 20%; animation-delay: 2s; }
        .particle:nth-child(3) { width: 3px; height: 3px; left: 60%; animation-delay: 4s; }
        .particle:nth-child(4) { width: 5px; height: 5px; left: 80%; animation-delay: 6s; }
        .particle:nth-child(5) { width: 4px; height: 4px; left: 40%; animation-delay: 1s; }

        @keyframes float {
            0% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
            10% { opacity: 0.6; }
            90% { opacity: 0.6; }
            100% { transform: translateY(-100px) rotate(360deg); opacity: 0; }
        }

        /* Dynamic Buttons */
        .btn {
            font-weight: 700;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            font-size: 1.1rem;
        }

        .btn-primary {
            background: var(--gradient-gold);
            color: var(--black);
            box-shadow: var(--shadow-gold);
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--gradient-black);
            transition: left 0.4s ease;
            z-index: -1;
        }

        .btn-primary:hover::before {
            left: 0;
        }

        .btn-primary:hover {
            color: var(--gold);
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(212,175,55,0.4);
        }

        .btn-outline {
            background: transparent;
            color: var(--white);
            border: 2px solid var(--gold);
        }

        .btn-outline:hover {
            background: var(--gold);
            color: var(--black);
            transform: translateY(-3px);
        }

        /* Dynamic Cards */
        .feature-card {
            background: var(--white);
            border-radius: 20px;
            padding: 3rem 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            height: 100%;
            border: 1px solid rgba(212, 175, 55, 0.1);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-gold);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-gold);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 2rem;
            color: var(--black);
            font-size: 2rem;
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
        }

        /* Service Cards */
        .service-card {
            background: var(--black-soft);
            color: var(--white);
            border-radius: 25px;
            padding: 3rem 2rem;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            border: 2px solid transparent;
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: var(--gradient-gold);
            border-radius: 25px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .service-card:hover::before {
            opacity: 1;
        }

        .service-card:hover {
            transform: translateY(-5px);
        }

        /* Complex Pricing Cards */
        .pricing-card {
            background: var(--white);
            border-radius: 25px;
            padding: 3rem 2rem;
            position: relative;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 2px solid rgba(212, 175, 55, 0.1);
            overflow: hidden;
        }

        .pricing-card.featured {
            background: var(--gradient-black);
            color: var(--white);
            transform: scale(1.05);
            z-index: 10;
        }

        .pricing-card.featured::before {
            content: 'Most Popular';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gradient-gold);
            color: var(--black);
            padding: 0.5rem 2rem;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
        }

        .pricing-card.featured:hover {
            transform: scale(1.05) translateY(-10px);
        }

        .price {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 4rem;
            font-weight: 700;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 1rem 0;
        }

        /* African-themed sections */
        .africa-section {
            background: linear-gradient(135deg, rgba(212,175,55,0.1) 0%, rgba(248,244,224,0.3) 100%);
            position: relative;
        }

        .africa-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="10" cy="10" r="1" fill="%23D4AF37" opacity="0.1"/><circle cx="30" cy="30" r="1" fill="%23D4AF37" opacity="0.1"/><circle cx="50" cy="50" r="1" fill="%23D4AF37" opacity="0.1"/><circle cx="70" cy="70" r="1" fill="%23D4AF37" opacity="0.1"/><circle cx="90" cy="90" r="1" fill="%23D4AF37" opacity="0.1"/></svg>');
            pointer-events: none;
        }

        /* Stats Counter Animation */
        .stat-number {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 3.5rem;
            font-weight: 700;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        /* Complex Animations */
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

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes shimmer {
            0% { background-position: -1000px 0; }
            100% { background-position: 1000px 0; }
        }

        .shimmer-effect {
            background: linear-gradient(90deg, transparent, rgba(212,175,55,0.4), transparent);
            background-size: 1000px 100%;
            animation: shimmer 3s infinite;
        }

        /* Footer Styling */
        .footer {
            background: var(--gradient-black);
            color: var(--white);
            padding: 4rem 0 2rem;
            position: relative;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: var(--gradient-gold);
        }

        .footer h5 {
            color: var(--gold);
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            padding: 0.3rem 0;
        }

        .footer a:hover {
            color: var(--gold);
            transform: translateX(5px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 3rem;
            }
            
            .logo-brand {
                font-size: 1.5rem;
            }
            
            .pricing-card.featured {
                transform: none;
                margin-bottom: 2rem;
            }
            
            .btn {
                padding: 0.8rem 2rem;
                font-size: 1rem;
            }
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient-black);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 3px solid rgba(212,175,55,0.3);
            border-top: 3px solid var(--gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>

<body>
    <!-- Loading Screen -->
    <div class="loading-overlay" id="loadingScreen">
        <div class="loading-spinner"></div>
    </div>

    <!-- Floating Particles -->
    <div class="floating-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

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
                        <a class="nav-link" href="{$app_url}/services">Services</a>
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
    <section id="home" class="hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content">
                        <h1 class="hero-title" data-aos="fade-up">
                            REVOLUTIONIZING<br>
                            AFRICAN INTERNET
                        </h1>
                        <p class="hero-subtitle" data-aos="fade-up" data-aos-delay="300">
                            Advanced billing solutions for hotspot and PPPoE connections. 
                            Empowering ISPs, resellers, and direct customers across Africa 
                            with cutting-edge technology and seamless payment integration.
                        </p>
                        <div data-aos="fade-up" data-aos-delay="600">
                            <a href="tel:+254711503023" class="btn btn-primary me-3">
                                <i class="fas fa-phone"></i>
                                Call Now
                            </a>
                            <a href="#services" class="btn btn-outline">
                                <i class="fas fa-arrow-down"></i>
                                Explore Services
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left" data-aos-delay="400">
                    <div class="row text-center text-white">
                        <div class="col-md-4 mb-4">
                            <div class="stat-number" data-count="1000">0</div>
                            <div class="stat-label">Active ISPs</div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="stat-number" data-count="100000">0</div>
                            <div class="stat-label">Connected Users</div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="stat-number" data-count="15">0</div>
                            <div class="stat-label">Countries</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Captive Portal Demo Section -->
    <section id="captive-demo" class="section py-5" style="background: var(--bg-secondary);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 class="display-4 fw-bold mb-4">Experience Our Captive Portal</h2>
                    <p class="lead text-muted">See how customers easily purchase hotspot packages through our intuitive interface</p>
                </div>
            </div>
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <div class="captive-portal-mockup" style="background: var(--white); border-radius: 20px; padding: 2rem; box-shadow: var(--shadow-lg); border: 1px solid rgba(212, 175, 55, 0.2);">
                        <div class="mockup-header" style="background: var(--gradient-gold); color: var(--black); padding: 1rem; border-radius: 10px 10px 0 0; text-align: center; font-weight: 700;">
                            <i class="fas fa-wifi me-2"></i>WiFi Hotspot Portal
                        </div>
                        <div class="mockup-body" style="padding: 2rem 1rem;">
                            <h4 class="text-center mb-4">Welcome to Glinta WiFi</h4>
                            <div class="package-options">
                                <div class="package-card" style="border: 2px solid var(--gold); border-radius: 10px; padding: 1rem; margin-bottom: 1rem; cursor: pointer; transition: all 0.3s ease;">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">1 Hour Package</h6>
                                            <small class="text-muted">Fast browsing speed</small>
                                        </div>
                                        <div class="text-end">
                                            <span class="fw-bold" style="color: var(--gold);">KSH 50</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="package-card" style="border: 2px solid var(--gold); border-radius: 10px; padding: 1rem; margin-bottom: 1rem; cursor: pointer; transition: all 0.3s ease;">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Daily Package</h6>
                                            <small class="text-muted">24 hours unlimited</small>
                                        </div>
                                        <div class="text-end">
                                            <span class="fw-bold" style="color: var(--gold);">KSH 200</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="package-card" style="border: 2px solid var(--gold); border-radius: 10px; padding: 1rem; margin-bottom: 1rem; cursor: pointer; transition: all 0.3s ease;">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Weekly Package</h6>
                                            <small class="text-muted">7 days unlimited</small>
                                        </div>
                                        <div class="text-end">
                                            <span class="fw-bold" style="color: var(--gold);">KSH 500</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="payment-section" style="margin-top: 2rem;">
                                <h6 class="mb-3">Payment Method</h6>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="payment-option" style="border: 1px solid var(--gold); border-radius: 8px; padding: 1rem; text-align: center; cursor: pointer;">
                                            <i class="fas fa-mobile-alt" style="color: var(--gold); font-size: 1.5rem;"></i>
                                            <div style="font-size: 0.9rem; margin-top: 0.5rem;">M-Pesa</div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="payment-option" style="border: 1px solid var(--gold); border-radius: 8px; padding: 1rem; text-align: center; cursor: pointer;">
                                            <i class="fas fa-credit-card" style="color: var(--gold); font-size: 1.5rem;"></i>
                                            <div style="font-size: 0.9rem; margin-top: 0.5rem;">Card</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-primary w-100 mt-3" style="background: var(--gradient-gold); border: none; color: var(--black); font-weight: 700;">
                                Buy Package
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h3 class="fw-bold mb-4">Simple Customer Experience</h3>
                    <div class="feature-list">
                        <div class="feature-item d-flex align-items-center mb-3">
                            <div class="feature-icon-sm" style="width: 40px; height: 40px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                <i class="fas fa-wifi" style="color: var(--black);"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Connect to WiFi</h6>
                                <small class="text-muted">Automatic redirect to portal</small>
                            </div>
                        </div>
                        <div class="feature-item d-flex align-items-center mb-3">
                            <div class="feature-icon-sm" style="width: 40px; height: 40px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                <i class="fas fa-shopping-cart" style="color: var(--black);"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Choose Package</h6>
                                <small class="text-muted">Select from flexible options</small>
                            </div>
                        </div>
                        <div class="feature-item d-flex align-items-center mb-3">
                            <div class="feature-icon-sm" style="width: 40px; height: 40px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                <i class="fas fa-mobile-alt" style="color: var(--black);"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Pay with Mobile Money</h6>
                                <small class="text-muted">M-Pesa, Airtel Money, etc.</small>
                            </div>
                        </div>
                        <div class="feature-item d-flex align-items-center mb-3">
                            <div class="feature-icon-sm" style="width: 40px; height: 40px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                <i class="fas fa-check-circle" style="color: var(--black);"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Instant Access</h6>
                                <small class="text-muted">Start browsing immediately</small>
                            </div>
                        </div>
                    </div>
                    <div class="demo-buttons mt-4">
                        <a href="{$app_url}/demo-reseller" class="btn btn-primary me-3" target="_blank">
                            <i class="fas fa-cogs me-2"></i>
                            Try Reseller Demo
                        </a>
                        <a href="{$app_url}/demo-customer" class="btn btn-outline-dark" target="_blank">
                            <i class="fas fa-user me-2"></i>
                            Try Customer Demo
                        </a>
                    </div>
                    <div class="demo-credentials mt-3" style="background: var(--bg-secondary); padding: 1rem; border-radius: 8px; border-left: 4px solid var(--gold);">
                        <h6 class="mb-2">Demo Login Credentials:</h6>
                        <p class="mb-1"><strong>Username:</strong> Trial</p>
                        <p class="mb-0"><strong>Password:</strong> Trialpass</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="section py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 class="display-4 fw-bold mb-4">Who We Serve</h2>
                    <p class="lead text-muted">Comprehensive internet billing solutions for every business model</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-right">
                    <div class="service-card h-100">
                        <img src="https://images.unsplash.com/photo-1521737604893-d14cc237f11d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" 
                             alt="ISP Providers" class="img-fluid rounded mb-4" style="height: 200px; width: 100%; object-fit: cover;">
                        <h3 class="fw-bold mb-3" style="color: var(--gold);">For Internet Service Providers</h3>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Complete ISP billing platform</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Hotspot & PPPoE management</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Automated payment collection</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Real-time monitoring & analytics</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>White-label solutions</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20need%20ISP%20billing%20solutions" 
                           class="btn btn-primary mt-3" target="_blank">
                            <i class="fab fa-whatsapp"></i>
                            Get ISP Solution
                        </a>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="service-card h-100">
                        <img src="https://images.unsplash.com/photo-1560472354-b33ff0c44a43?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" 
                             alt="End Users" class="img-fluid rounded mb-4" style="height: 200px; width: 100%; object-fit: cover;">
                        <h3 class="fw-bold mb-3" style="color: var(--gold);">For End Users & Businesses</h3>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Direct internet packages</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Hotspot access solutions</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>PPPoE home connections</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>Mobile money payments</li>
                            <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: var(--gold);"></i>24/7 customer support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20need%20internet%20packages" 
                           class="btn btn-primary mt-3" target="_blank">
                            <i class="fab fa-whatsapp"></i>
                            Get Internet Package
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="section africa-section py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 class="display-4 fw-bold mb-4">Advanced Features</h2>
                    <p class="lead text-muted">Cutting-edge technology built for African markets</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Hotspot Management</h4>
                        <p class="text-muted">Complete WiFi hotspot billing with captive portal, user management, and real-time monitoring.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h4 class="fw-bold mb-3">PPPoE Solutions</h4>
                        <p class="text-muted">Advanced PPPoE connection management with bandwidth control and automated provisioning.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Mobile Money Integration</h4>
                        <p class="text-muted">Seamless M-Pesa, Airtel Money, and other mobile payment gateway integrations.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-analytics"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Real-time Analytics</h4>
                        <p class="text-muted">Comprehensive dashboards with revenue tracking, user analytics, and performance metrics.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Enterprise Security</h4>
                        <p class="text-muted">Advanced security features with fraud detection and secure payment processing.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4 class="fw-bold mb-3">24/7 Support</h4>
                        <p class="text-muted">Round-the-clock technical support and customer service for all our clients.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="section py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 class="display-4 fw-bold mb-4">Flexible Pricing Plans</h2>
                    <p class="lead text-muted">Choose the perfect plan for your business needs</p>
                </div>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="pricing-card text-center">
                        <h3 class="fw-bold mb-3">Starter</h3>
                        <div class="price">KSH 5,000</div>
                        <p class="text-muted mb-4">per month</p>
                        <ul class="list-unstyled mb-4">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Up to 100 users</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Basic hotspot management</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Mobile money integration</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Email support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20the%20Starter%20plan" 
                           class="btn btn-outline-dark w-100" target="_blank">
                            Choose Plan
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="pricing-card featured text-center">
                        <h3 class="fw-bold mb-3">Professional</h3>
                        <div class="price">KSH 15,000</div>
                        <p class="mb-4" style="color: rgba(255,255,255,0.8);">per month</p>
                        <ul class="list-unstyled mb-4">
                            <li class="mb-2"><i class="fas fa-check me-2" style="color: var(--gold);"></i>Up to 1,000 users</li>
                            <li class="mb-2"><i class="fas fa-check me-2" style="color: var(--gold);"></i>Full hotspot & PPPoE</li>
                            <li class="mb-2"><i class="fas fa-check me-2" style="color: var(--gold);"></i>Advanced analytics</li>
                            <li class="mb-2"><i class="fas fa-check me-2" style="color: var(--gold);"></i>Priority support</li>
                            <li class="mb-2"><i class="fas fa-check me-2" style="color: var(--gold);"></i>White-label option</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20the%20Professional%20plan" 
                           class="btn btn-primary w-100" target="_blank">
                            Choose Plan
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="pricing-card text-center">
                        <h3 class="fw-bold mb-3">Enterprise</h3>
                        <div class="price">Custom</div>
                        <p class="text-muted mb-4">pricing</p>
                        <ul class="list-unstyled mb-4">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Unlimited users</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Custom integrations</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Dedicated support</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>On-premise deployment</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20need%20Enterprise%20pricing" 
                           class="btn btn-outline-dark w-100" target="_blank">
                            Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="section africa-section py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" 
                         alt="African Technology" class="img-fluid rounded shadow-lg">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2 class="display-4 fw-bold mb-4">About Glinta Africa</h2>
                    <p class="lead mb-4">
                        Leading provider of internet billing solutions across Africa. We specialize in 
                        comprehensive billing platforms for internet service providers and direct 
                        internet services for end users.
                    </p>
                    <p class="mb-4">
                        Our advanced technology supports both hotspot and PPPoE connections, with 
                        seamless mobile money integration designed specifically for African markets. 
                        We've helped over 1,000 ISPs streamline their operations and serve more 
                        than 100,000 connected users across 15 countries.
                    </p>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success me-3 fs-4"></i>
                                <span class="fw-bold">ISO 27001 Certified</span>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success me-3 fs-4"></i>
                                <span class="fw-bold">99.9% Uptime SLA</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="section py-5" style="background: var(--gradient-black);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center" data-aos="fade-up">
                    <h2 class="display-4 fw-bold mb-4 text-white">Ready to Get Started?</h2>
                    <p class="lead mb-5 text-white">
                        Join thousands of satisfied customers across Africa. Contact us today for a 
                        personalized demo and see how our solutions can transform your business.
                    </p>
                    <div class="row g-3 justify-content-center">
                        <div class="col-md-4">
                            <a href="tel:+254711503023" class="btn btn-primary btn-lg w-100">
                                <i class="fas fa-phone me-2"></i>
                                Call +254 711 503 023
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20learn%20more" 
                               class="btn btn-outline" style="border-color: var(--gold); color: var(--gold);" target="_blank">
                                <i class="fab fa-whatsapp me-2"></i>
                                WhatsApp Chat
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="{$app_url}/index.php?_route=admin" class="btn btn-outline" 
                               style="border-color: var(--gold); color: var(--gold);" target="_blank">
                                <i class="fas fa-desktop me-2"></i>
                                Try Demo
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <h5>Company</h5>
                    <a href="{$app_url}/about">About Us</a>
                    <a href="{$app_url}/careers">Careers</a>
                    <a href="{$app_url}/news">News & Press</a>
                    <a href="{$app_url}/investors">Investor Relations</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Products</h5>
                    <a href="{$app_url}/hotspot">Hotspot Solutions</a>
                    <a href="{$app_url}/pppoe">PPPoE Management</a>
                    <a href="{$app_url}/billing">Billing Platform</a>
                    <a href="{$app_url}/analytics">Analytics Suite</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Support</h5>
                    <a href="{$app_url}/help">Help Center</a>
                    <a href="{$app_url}/documentation">Documentation</a>
                    <a href="{$app_url}/community">Community Forum</a>
                    <a href="{$app_url}/contact">Contact Support</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Legal</h5>
                    <a href="{$app_url}/privacy">Privacy Policy</a>
                    <a href="{$app_url}/terms">Terms of Service</a>
                    <a href="{$app_url}/security">Security</a>
                    <a href="{$app_url}/compliance">Compliance</a>
                </div>
            </div>
            <hr style="border-color: var(--gold); margin: 3rem 0 2rem;">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">Made with ❤️ in Africa | <a href="https://watsonsdevelopers.com" style="color: var(--gold);">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS animations
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true
        });

        // Loading screen
        window.addEventListener('load', function() {
            const loadingScreen = document.getElementById('loadingScreen');
            loadingScreen.style.opacity = '0';
            setTimeout(() => {
                loadingScreen.style.display = 'none';
            }, 500);
        });

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
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

        // Counter animation
        function animateCounters() {
            const counters = document.querySelectorAll('.stat-number[data-count]');
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

        // Trigger counter animation when hero section is visible
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateCounters();
                    observer.unobserve(entry.target);
                }
            });
        });

        const heroSection = document.querySelector('.hero');
        if (heroSection) {
            observer.observe(heroSection);
        }

        // Dynamic card effects
        document.querySelectorAll('.feature-card, .service-card, .pricing-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px)';
            });
            
            card.addEventListener('mouseleave', function() {
                if (!this.classList.contains('featured')) {
                    this.style.transform = 'translateY(0)';
                } else {
                    this.style.transform = 'scale(1.05) translateY(0)';
                }
            });
        });
    </script>
</body>
</html>