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
    
    <!-- Swiper for Sliders -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    
    <!-- Animate.css for Advanced Animations -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    
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
            --gradient-sunset: linear-gradient(135deg, #ff6b6b 0%, #feca57 100%);
            --gradient-savanna: linear-gradient(135deg, #ffeaa7 0%, #dfe6e9 100%);
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
        
        /* African Pattern Background */
        .african-pattern {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0.03;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M0 0h50v50H0zm50 50h50v50H50z" fill="%23D4AF37"/><circle cx="25" cy="25" r="20" fill="none" stroke="%23D4AF37" stroke-width="2"/><circle cx="75" cy="75" r="20" fill="none" stroke="%23D4AF37" stroke-width="2"/></svg>');
            background-size: 100px 100px;
            pointer-events: none;
        }
        
        /* Animated Gradient Background */
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .gradient-animated {
            background: linear-gradient(-45deg, #D4AF37, #F4E4C1, #B8941F, #D4AF37);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--white);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: opacity 0.5s ease;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 3px solid var(--gold-light);
            border-top-color: var(--gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
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
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 0.8rem 0;
            box-shadow: var(--shadow);
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

        /* Enhanced Hero Section with Video Background */
        .hero {
            min-height: 100vh;
            background: var(--gradient-black);
            position: relative;
            display: flex;
            align-items: center;
            overflow: hidden;
            padding-top: 80px;
        }

        .hero-video-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7));
            z-index: 1;
        }

        .hero-particles {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 2;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: var(--gold);
            border-radius: 50%;
            animation: float 10s infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) translateX(0);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100vh) translateX(50px);
                opacity: 0;
            }
        }

        .hero-content {
            position: relative;
            z-index: 10;
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
            animation: fadeInUp 1s ease;
        }

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

        /* African Map Animation */
        .africa-map-bg {
            position: absolute;
            right: -10%;
            top: 50%;
            transform: translateY(-50%);
            width: 600px;
            height: 600px;
            opacity: 0.1;
            z-index: 1;
        }

        .africa-map-bg svg {
            width: 100%;
            height: 100%;
            fill: var(--gold);
        }

        /* Animated Stats */
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            background: rgba(212, 175, 55, 0.2);
        }

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

        .stat-label {
            color: var(--white);
            font-size: 1.1rem;
            font-weight: 500;
        }

        /* Enhanced Feature Cards with Hover Effects */
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
            top: -100%;
            left: -100%;
            width: 300%;
            height: 300%;
            background: radial-gradient(circle, rgba(212, 175, 55, 0.1) 0%, transparent 70%);
            transition: all 0.6s ease;
        }

        .feature-card:hover::before {
            top: -150%;
            left: -150%;
        }

        .feature-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 50px rgba(212, 175, 55, 0.3);
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
            position: relative;
            z-index: 10;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
        }

        /* Service Showcase with African Imagery */
        .service-showcase {
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.05) 0%, rgba(248, 244, 224, 0.1) 100%);
            padding: 5rem 0;
            position: relative;
            overflow: hidden;
        }

        .service-showcase::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><pattern id="african-pattern" x="0" y="0" width="40" height="40" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="2" fill="%23D4AF37" opacity="0.2"/><path d="M10 10 L30 10 L20 30 Z" fill="none" stroke="%23D4AF37" stroke-width="0.5" opacity="0.1"/></pattern><rect width="200" height="200" fill="url(%23african-pattern)"/></svg>');
            background-size: 200px 200px;
            opacity: 0.5;
        }

        .service-card {
            background: var(--white);
            border-radius: 25px;
            padding: 3rem 2rem;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            border: 2px solid transparent;
            background-image: linear-gradient(var(--white), var(--white)), var(--gradient-gold);
            background-origin: border-box;
            background-clip: padding-box, border-box;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.1);
        }

        /* Interactive Pricing Cards */
        .pricing-card {
            background: var(--white);
            border-radius: 25px;
            padding: 3rem 2rem;
            position: relative;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 2px solid rgba(212, 175, 55, 0.1);
            overflow: hidden;
            cursor: pointer;
        }

        .pricing-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 200px;
            background: var(--gradient-gold);
            transform: translateY(-100%);
            transition: transform 0.6s ease;
            z-index: 0;
        }

        .pricing-card:hover::before {
            transform: translateY(0);
        }

        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(212, 175, 55, 0.3);
            color: var(--white);
        }

        .pricing-card:hover .price,
        .pricing-card:hover h3,
        .pricing-card:hover p,
        .pricing-card:hover li {
            color: var(--white);
            position: relative;
            z-index: 10;
        }

        .pricing-card:hover .btn-primary {
            background: var(--white);
            color: var(--gold);
        }

        .pricing-card.featured {
            background: var(--gradient-black);
            color: var(--white);
            transform: scale(1.05);
            z-index: 10;
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
            position: relative;
            z-index: 10;
        }

        /* Testimonial Carousel with African Leaders */
        .testimonial-section {
            background: var(--black-soft);
            color: var(--white);
            padding: 5rem 0;
            position: relative;
        }

        .testimonial-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 20px;
            padding: 2.5rem;
            position: relative;
        }

        .testimonial-card::before {
            content: '"';
            position: absolute;
            top: -20px;
            left: 30px;
            font-size: 120px;
            color: var(--gold);
            opacity: 0.3;
            font-family: Georgia, serif;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
            margin-top: 2rem;
        }

        .author-image {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-right: 1rem;
            border: 3px solid var(--gold);
        }

        /* African Success Stories Gallery */
        .success-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .success-card {
            position: relative;
            border-radius: 20px;
            overflow: hidden;
            height: 400px;
            cursor: pointer;
            transition: all 0.4s ease;
        }

        .success-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, transparent 50%, rgba(0, 0, 0, 0.9) 100%);
            z-index: 1;
        }

        .success-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .success-card:hover img {
            transform: scale(1.1);
        }

        .success-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 2rem;
            z-index: 2;
            transform: translateY(100px);
            transition: transform 0.4s ease;
        }

        .success-card:hover .success-content {
            transform: translateY(0);
        }

        /* Interactive Map Section */
        .map-section {
            padding: 5rem 0;
            background: var(--white-soft);
            position: relative;
        }

        .africa-interactive-map {
            position: relative;
            max-width: 800px;
            margin: 0 auto;
        }

        .map-pin {
            position: absolute;
            width: 30px;
            height: 30px;
            background: var(--gold);
            border-radius: 50% 50% 50% 0;
            transform: rotate(-45deg);
            cursor: pointer;
            transition: all 0.3s ease;
            animation: pulse 2s infinite;
        }

        .map-pin:hover {
            transform: rotate(-45deg) scale(1.2);
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(212, 175, 55, 0.7);
            }
            70% {
                box-shadow: 0 0 0 20px rgba(212, 175, 55, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(212, 175, 55, 0);
            }
        }

        /* Footer with African Art Pattern */
        .footer {
            background: var(--gradient-black);
            color: var(--white);
            padding: 4rem 0 2rem;
            position: relative;
            overflow: hidden;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><pattern id="kente" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><rect width="10" height="10" fill="%23D4AF37" opacity="0.1"/><rect x="10" y="10" width="10" height="10" fill="%23D4AF37" opacity="0.1"/></pattern><rect width="100" height="100" fill="url(%23kente)"/></svg>');
            background-size: 100px 100px;
            opacity: 0.1;
        }

        /* Buttons */
        .btn {
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
            z-index: -1;
        }

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: var(--gradient-gold);
            border: none;
            color: var(--black);
        }

        .btn-primary:hover {
            color: var(--black);
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(212,175,55,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .stat-number {
                font-size: 2.5rem;
            }
            
            .price {
                font-size: 3rem;
            }
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

        /* Animated Background Shapes */
        .bg-shape {
            position: absolute;
            opacity: 0.1;
            animation: float-shape 20s infinite ease-in-out;
        }

        @keyframes float-shape {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            33% {
                transform: translateY(-20px) rotate(120deg);
            }
            66% {
                transform: translateY(20px) rotate(240deg);
            }
        }

        /* Video Background for sections */
        .video-section {
            position: relative;
            overflow: hidden;
            padding: 5rem 0;
        }

        .video-bg {
            position: absolute;
            top: 50%;
            left: 50%;
            min-width: 100%;
            min-height: 100%;
            width: auto;
            height: auto;
            transform: translateX(-50%) translateY(-50%);
            z-index: -1;
        }

        .video-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            z-index: 0;
        }

        /* Parallax Effect */
        .parallax {
            background-attachment: fixed;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            position: relative;
        }

        /* Glowing Effects */
        .glow {
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 10px var(--gold), 0 0 20px var(--gold), 0 0 30px var(--gold);
            }
            to {
                box-shadow: 0 0 20px var(--gold), 0 0 30px var(--gold), 0 0 40px var(--gold);
            }
        }
    </style>
</head>

<body>
    <!-- Loading Screen -->
    <div class="loading-overlay" id="loadingScreen">
        <div class="loading-spinner"></div>
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

    <!-- Enhanced Hero Section -->
    <section id="home" class="hero">
        <div class="hero-particles">
            <div class="particle" style="top: 20%; left: 10%; animation-delay: 0s;"></div>
            <div class="particle" style="top: 40%; left: 30%; animation-delay: 1s;"></div>
            <div class="particle" style="top: 60%; left: 50%; animation-delay: 2s;"></div>
            <div class="particle" style="top: 30%; left: 70%; animation-delay: 3s;"></div>
            <div class="particle" style="top: 80%; left: 90%; animation-delay: 4s;"></div>
        </div>
        
        <div class="africa-map-bg">
            <svg viewBox="0 0 500 500">
                <path d="M250 50 C350 50 400 150 380 250 C360 350 250 450 250 450 S140 350 120 250 C100 150 150 50 250 50" 
                      fill="currentColor" opacity="0.5"/>
            </svg>
        </div>

        <div class="container">
            <div class="row align-items-center min-vh-100">
                <div class="col-lg-7">
                    <div class="hero-content">
                        <h1 class="hero-title animate__animated animate__fadeInUp">
                            POWERING AFRICA'S<br>
                            <span class="gradient-animated">DIGITAL REVOLUTION</span>
                        </h1>
                        <p class="hero-subtitle text-white fs-5 mb-4 animate__animated animate__fadeInUp animate__delay-1s">
                            Transform your ISP business with Africa's most advanced billing platform. 
                            Built for African entrepreneurs, by African innovators.
                        </p>
                        <div class="hero-features mb-5 animate__animated animate__fadeInUp animate__delay-2s">
                            <div class="d-flex align-items-center mb-3">
                                <div class="feature-check" style="width: 30px; height: 30px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                    <i class="fas fa-check text-black"></i>
                                </div>
                                <span class="text-white">M-Pesa, Airtel Money & MTN MoMo Integration</span>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <div class="feature-check" style="width: 30px; height: 30px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                    <i class="fas fa-check text-black"></i>
                                </div>
                                <span class="text-white">Automated Billing & Customer Management</span>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <div class="feature-check" style="width: 30px; height: 30px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                                    <i class="fas fa-check text-black"></i>
                                </div>
                                <span class="text-white">Real-time Analytics & Revenue Tracking</span>
                            </div>
                        </div>
                        <div class="hero-buttons animate__animated animate__fadeInUp animate__delay-3s">
                            <a href="#demo" class="btn btn-primary btn-lg me-3 mb-3">
                                <i class="fas fa-play-circle me-2"></i>
                                Watch Live Demo
                            </a>
                            <a href="{$app_url}/contact" class="btn btn-outline-light btn-lg mb-3">
                                <i class="fas fa-calendar me-2"></i>
                                Book Free Consultation
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="stat-card animate__animated animate__fadeInRight animate__delay-1s">
                                <div class="stat-number" data-count="25">0</div>
                                <div class="stat-label">African Countries</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card animate__animated animate__fadeInRight animate__delay-2s">
                                <div class="stat-number" data-count="5000">0</div>
                                <div class="stat-label">Active ISPs</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card animate__animated animate__fadeInRight animate__delay-3s">
                                <div class="stat-number" data-count="2">0</div>
                                <div class="stat-label">Million Users</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card animate__animated animate__fadeInRight animate__delay-4s">
                                <div class="stat-number" data-count="99.9">0</div>
                                <div class="stat-label">% Uptime</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- African Success Stories -->
    <section class="py-5 service-showcase">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">Success Stories Across Africa</h2>
                    <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">
                        From bustling Lagos to vibrant Nairobi, see how we're transforming internet access
                    </p>
                </div>
            </div>
            
            <div class="success-gallery">
                <div class="success-card" data-aos="fade-up" data-aos-delay="200">
                    <img src="https://images.unsplash.com/photo-1623921978642-68f32c36c67f?w=800" alt="Kenya Success">
                    <div class="success-content text-white">
                        <h3>Nairobi Tech Hub</h3>
                        <p>500+ hotspots deployed across Kenya's capital, connecting 100,000+ users daily</p>
                        <div class="mt-3">
                            <span class="badge bg-warning text-dark me-2">Kenya</span>
                            <span class="badge bg-warning text-dark">M-Pesa Integration</span>
                        </div>
                    </div>
                </div>
                
                <div class="success-card" data-aos="fade-up" data-aos-delay="300">
                    <img src="https://images.unsplash.com/photo-1589994160839-163cd867cfe8?w=800" alt="Nigeria Success">
                    <div class="success-content text-white">
                        <h3>Lagos Digital Revolution</h3>
                        <p>Powering Nigeria's largest WiFi network with 1,000+ access points</p>
                        <div class="mt-3">
                            <span class="badge bg-warning text-dark me-2">Nigeria</span>
                            <span class="badge bg-warning text-dark">Paystack</span>
                        </div>
                    </div>
                </div>
                
                <div class="success-card" data-aos="fade-up" data-aos-delay="400">
                    <img src="https://images.unsplash.com/photo-1580060839134-75a5edca2e99?w=800" alt="South Africa Success">
                    <div class="success-content text-white">
                        <h3>Cape Town Innovation</h3>
                        <p>Smart city initiative connecting townships with affordable internet</p>
                        <div class="mt-3">
                            <span class="badge bg-warning text-dark me-2">South Africa</span>
                            <span class="badge bg-warning text-dark">PayFast</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Interactive Services Showcase -->
    <section id="services" class="py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">
                        Built for African Innovation
                    </h2>
                    <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">
                        Every feature designed with African businesses in mind
                    </p>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="service-card h-100">
                        <div class="service-icon mb-4">
                            <div style="width: 80px; height: 80px; background: var(--gradient-gold); border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 2.5rem;">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                        </div>
                        <h3>Mobile Money Magic</h3>
                        <p>Seamless integration with M-Pesa, Airtel Money, MTN MoMo, and more. Your customers pay, you get paid - instantly!</p>
                        <ul class="list-unstyled mt-4">
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Instant payment confirmation</li>
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Automatic account activation</li>
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>SMS notifications</li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="service-card h-100">
                        <div class="service-icon mb-4">
                            <div style="width: 80px; height: 80px; background: var(--gradient-gold); border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 2.5rem;">
                                <i class="fas fa-wifi"></i>
                            </div>
                        </div>
                        <h3>Smart Hotspot Control</h3>
                        <p>Manage hundreds of hotspots from one dashboard. Monitor usage, control bandwidth, and maximize revenue.</p>
                        <ul class="list-unstyled mt-4">
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Real-time monitoring</li>
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Bandwidth management</li>
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Multi-location support</li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="400">
                    <div class="service-card h-100">
                        <div class="service-icon mb-4">
                            <div style="width: 80px; height: 80px; background: var(--gradient-gold); border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 2.5rem;">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                        <h3>Revenue Analytics</h3>
                        <p>Track your growth with powerful analytics. Know your best locations, peak times, and customer preferences.</p>
                        <ul class="list-unstyled mt-4">
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Revenue tracking</li>
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Customer insights</li>
                            <li class="mb-2"><i class="fas fa-check text-warning me-2"></i>Growth predictions</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Live Demo Section -->
    <section id="demo" class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2 class="display-4 fw-bold mb-4">See It In Action</h2>
                    <p class="lead mb-4">
                        Experience how easy it is for customers to connect and pay
                    </p>
                    
                    <div class="demo-device" style="position: relative; background: #000; border-radius: 30px; padding: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">
                        <div class="device-screen" style="background: white; border-radius: 20px; overflow: hidden;">
                            <div class="demo-header" style="background: var(--gradient-gold); padding: 1rem; text-align: center;">
                                <h5 class="mb-0 text-black fw-bold">Welcome to Glinta WiFi</h5>
                            </div>
                            
                            <div class="demo-content" style="padding: 2rem;">
                                <div class="package-selection">
                                    <h6 class="mb-3">Select Your Package:</h6>
                                    <div class="package-option mb-3 p-3" style="border: 2px solid var(--gold); border-radius: 10px; cursor: pointer; transition: all 0.3s;">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong>1 Hour Access</strong>
                                                <div class="text-muted small">Perfect for quick browsing</div>
                                            </div>
                                            <div class="text-end">
                                                <div class="price-tag" style="color: var(--gold); font-size: 1.5rem; font-weight: bold;">KSH 50</div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="package-option mb-3 p-3" style="border: 2px solid var(--gold); border-radius: 10px; background: var(--gold); cursor: pointer;">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong>Full Day Pass</strong>
                                                <div class="text-muted small">Unlimited 24 hours</div>
                                            </div>
                                            <div class="text-end">
                                                <div class="price-tag" style="font-size: 1.5rem; font-weight: bold;">KSH 200</div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="package-option mb-3 p-3" style="border: 2px solid var(--gold); border-radius: 10px; cursor: pointer; transition: all 0.3s;">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong>Weekly Bundle</strong>
                                                <div class="text-muted small">Best value for regular users</div>
                                            </div>
                                            <div class="text-end">
                                                <div class="price-tag" style="color: var(--gold); font-size: 1.5rem; font-weight: bold;">KSH 1,000</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="payment-method mt-4">
                                    <h6 class="mb-3">Pay with:</h6>
                                    <div class="d-flex gap-3">
                                        <button class="btn btn-outline-success flex-fill">
                                            <i class="fas fa-mobile-alt me-2"></i>M-Pesa
                                        </button>
                                        <button class="btn btn-outline-danger flex-fill">
                                            <i class="fas fa-mobile-alt me-2"></i>Airtel
                                        </button>
                                    </div>
                                </div>
                                
                                <button class="btn btn-warning btn-lg w-100 mt-4">
                                    <i class="fas fa-wifi me-2"></i>Connect Now
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="demo-features">
                        <h3 class="mb-4">What Makes Us Different</h3>
                        
                        <div class="feature-item d-flex mb-4">
                            <div class="feature-icon-wrapper me-3">
                                <div style="width: 60px; height: 60px; background: rgba(212, 175, 55, 0.1); border-radius: 15px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-bolt text-warning fs-4"></i>
                                </div>
                            </div>
                            <div>
                                <h5>Lightning Fast Setup</h5>
                                <p class="text-muted">Get your entire system running in under 30 minutes. No technical expertise required.</p>
                            </div>
                        </div>
                        
                        <div class="feature-item d-flex mb-4">
                            <div class="feature-icon-wrapper me-3">
                                <div style="width: 60px; height: 60px; background: rgba(212, 175, 55, 0.1); border-radius: 15px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-shield-alt text-warning fs-4"></i>
                                </div>
                            </div>
                            <div>
                                <h5>Bank-Level Security</h5>
                                <p class="text-muted">Your data and transactions are protected with enterprise-grade encryption.</p>
                            </div>
                        </div>
                        
                        <div class="feature-item d-flex mb-4">
                            <div class="feature-icon-wrapper me-3">
                                <div style="width: 60px; height: 60px; background: rgba(212, 175, 55, 0.1); border-radius: 15px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-headset text-warning fs-4"></i>
                                </div>
                            </div>
                            <div>
                                <h5>24/7 African Support</h5>
                                <p class="text-muted">Local support team that understands your business and speaks your language.</p>
                            </div>
                        </div>
                        
                        <div class="mt-5">
                            <a href="{$app_url}/demo-reseller" class="btn btn-primary btn-lg me-3" target="_blank">
                                <i class="fas fa-desktop me-2"></i>
                                Try Admin Demo
                            </a>
                            <a href="{$app_url}/demo-customer" class="btn btn-outline-primary btn-lg" target="_blank">
                                <i class="fas fa-user me-2"></i>
                                Try Customer Portal
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Interactive Map of Africa -->
    <section class="map-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4" data-aos="fade-up">Growing Across Africa</h2>
                    <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">
                        Join thousands of ISPs already transforming internet access
                    </p>
                </div>
            </div>
            
            <div class="africa-interactive-map" data-aos="zoom-in">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Africa_%28orthographic_projection%29.svg/1200px-Africa_%28orthographic_projection%29.svg.png" 
                     alt="Africa Map" 
                     style="width: 100%; height: auto; opacity: 0.1;">
                
                <!-- Map Pins for different countries -->
                <div class="map-pin" style="top: 20%; left: 50%;" data-bs-toggle="tooltip" title="Kenya - 500+ ISPs"></div>
                <div class="map-pin" style="top: 35%; left: 30%;" data-bs-toggle="tooltip" title="Nigeria - 800+ ISPs"></div>
                <div class="map-pin" style="top: 70%; left: 55%;" data-bs-toggle="tooltip" title="South Africa - 300+ ISPs"></div>
                <div class="map-pin" style="top: 25%; left: 65%;" data-bs-toggle="tooltip" title="Ethiopia - 200+ ISPs"></div>
                <div class="map-pin" style="top: 50%; left: 45%;" data-bs-toggle="tooltip" title="Tanzania - 400+ ISPs"></div>
            </div>
            
            <div class="row mt-5">
                <div class="col-md-3 col-6 text-center mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="country-stat">
                        <h3 class="fw-bold" style="color: var(--gold);">25+</h3>
                        <p>Countries</p>
                    </div>
                </div>
                <div class="col-md-3 col-6 text-center mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="country-stat">
                        <h3 class="fw-bold" style="color: var(--gold);">5,000+</h3>
                        <p>Active ISPs</p>
                    </div>
                </div>
                <div class="col-md-3 col-6 text-center mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="country-stat">
                        <h3 class="fw-bold" style="color: var(--gold);">2M+</h3>
                        <p>End Users</p>
                    </div>
                </div>
                <div class="col-md-3 col-6 text-center mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="country-stat">
                        <h3 class="fw-bold" style="color: var(--gold);">$10M+</h3>
                        <p>Processed Monthly</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials with African Business Leaders -->
    <section class="testimonial-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-4 fw-bold mb-4 text-white" data-aos="fade-up">
                        Trusted by Africa's Digital Leaders
                    </h2>
                </div>
            </div>
            
            <div class="swiper testimonialSwiper" data-aos="fade-up">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="fs-5 mb-4">
                                "Glinta transformed our business. We went from managing 10 hotspots manually to 
                                running 200+ locations seamlessly. The M-Pesa integration alone saved us 5 hours daily!"
                            </p>
                            <div class="testimonial-author">
                                <img src="https://i.pravatar.cc/60?img=1" alt="Author" class="author-image">
                                <div>
                                    <h6 class="mb-0">James Mwangi</h6>
                                    <p class="mb-0 text-muted">CEO, NairobiNet Solutions</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="fs-5 mb-4">
                                "The support team understands African business challenges. They helped us integrate 
                                with local payment systems and even advised on pricing strategies. Truly partners!"
                            </p>
                            <div class="testimonial-author">
                                <img src="https://i.pravatar.cc/60?img=2" alt="Author" class="author-image">
                                <div>
                                    <h6 class="mb-0">Fatima Abdullahi</h6>
                                    <p class="mb-0 text-muted">Founder, Lagos WiFi Networks</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="fs-5 mb-4">
                                "Revenue increased by 300% in 6 months. The analytics showed us exactly where to 
                                expand, and the automated billing meant we could scale without hiring more staff."
                            </p>
                            <div class="testimonial-author">
                                <img src="https://i.pravatar.cc/60?img=3" alt="Author" class="author-image">
                                <div>
                                    <h6 class="mb-0">Thabo Motsoeneng</h6>
                                    <p class="mb-0 text-muted">Director, Cape Connect ISP</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5 gradient-animated">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="display-4 fw-bold mb-4 text-black" data-aos="zoom-in">
                        Ready to Transform Your ISP Business?
                    </h2>
                    <p class="lead mb-5 text-black" data-aos="zoom-in" data-aos-delay="100">
                        Join the digital revolution. Start your free trial today.
                    </p>
                    <div data-aos="zoom-in" data-aos-delay="200">
                        <a href="{$app_url}/contact" class="btn btn-dark btn-lg me-3">
                            <i class="fas fa-rocket me-2"></i>
                            Start Free Trial
                        </a>
                        <a href="tel:+254711503023" class="btn btn-outline-dark btn-lg">
                            <i class="fas fa-phone me-2"></i>
                            Call +254 711 503 023
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container position-relative">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h3 class="logo-brand mb-4">GLINTA•AFRICA</h3>
                    <p class="text-white-50">
                        Empowering African ISPs with cutting-edge billing solutions. 
                        Built in Africa, for Africa.
                    </p>
                    <div class="social-links mt-4">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Solutions</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/services" class="text-white-50">Hotspot Billing</a></li>
                        <li><a href="{$app_url}/services" class="text-white-50">PPPoE Management</a></li>
                        <li><a href="{$app_url}/services" class="text-white-50">Payment Gateway</a></li>
                        <li><a href="{$app_url}/services" class="text-white-50">Analytics Suite</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Company</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/about" class="text-white-50">About Us</a></li>
                        <li><a href="{$app_url}/blog" class="text-white-50">Blog</a></li>
                        <li><a href="{$app_url}/careers" class="text-white-50">Careers</a></li>
                        <li><a href="{$app_url}/contact" class="text-white-50">Contact</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Support</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/help" class="text-white-50">Help Center</a></li>
                        <li><a href="{$app_url}/documentation" class="text-white-50">Documentation</a></li>
                        <li><a href="{$app_url}/community" class="text-white-50">Community</a></li>
                        <li><a href="{$app_url}/security" class="text-white-50">Security</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="text-white mb-3">Legal</h5>
                    <ul class="list-unstyled">
                        <li><a href="{$app_url}/privacy" class="text-white-50">Privacy Policy</a></li>
                        <li><a href="{$app_url}/terms" class="text-white-50">Terms of Service</a></li>
                        <li><a href="{$app_url}/compliance" class="text-white-50">Compliance</a></li>
                    </ul>
                </div>
            </div>
            
            <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
            
            <div class="row">
                <div class="col-lg-6">
                    <p class="text-white-50 mb-0">
                        © 2025 Glinta Africa. All rights reserved. Made with ❤️ in Africa
                    </p>
                </div>
                <div class="col-lg-6 text-lg-end">
                    <p class="text-white-50 mb-0">
                        <i class="fas fa-map-marker-alt me-2"></i>
                        Nairobi • Lagos • Cape Town • Cairo
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true
        });

        // Initialize Swiper
        var swiper = new Swiper(".testimonialSwiper", {
            slidesPerView: 1,
            spaceBetween: 30,
            loop: true,
            autoplay: {
                delay: 5000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            breakpoints: {
                768: {
                    slidesPerView: 2,
                },
                1024: {
                    slidesPerView: 3,
                },
            },
        });

        // Counter Animation
        const counters = document.querySelectorAll('.stat-number');
        const speed = 200;

        counters.forEach(counter => {
            const animate = () => {
                const value = +counter.getAttribute('data-count');
                const data = +counter.innerText;
                const time = value / speed;
                
                if (data < value) {
                    counter.innerText = Math.ceil(data + time);
                    setTimeout(animate, 1);
                } else {
                    counter.innerText = value;
                    // Add decimal for percentage
                    if (value === 99.9) {
                        counter.innerText = '99.9';
                    }
                    // Add M for millions
                    if (value === 2) {
                        counter.innerText = '2M+';
                    }
                }
            }
            animate();
        });

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 100) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Loading screen
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('loadingScreen').style.opacity = '0';
                setTimeout(function() {
                    document.getElementById('loadingScreen').style.display = 'none';
                }, 500);
            }, 1000);
        });

        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });

        // Smooth scroll for anchor links
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

        // Package selection animation
        document.querySelectorAll('.package-option').forEach(option => {
            option.addEventListener('click', function() {
                // Remove active class from all
                document.querySelectorAll('.package-option').forEach(opt => {
                    opt.style.background = 'transparent';
                    opt.style.color = 'inherit';
                });
                
                // Add active class to clicked
                this.style.background = 'var(--gold)';
                this.style.color = 'black';
            });
        });

        // Particle generation
        function createParticle() {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 5 + 's';
            particle.style.animationDuration = (Math.random() * 5 + 5) + 's';
            document.querySelector('.hero-particles').appendChild(particle);
            
            setTimeout(() => {
                particle.remove();
            }, 10000);
        }

        // Create particles periodically
        setInterval(createParticle, 1000);
    </script>
</body>
</html>