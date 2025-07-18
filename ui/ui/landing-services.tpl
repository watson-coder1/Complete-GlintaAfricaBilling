<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional ISP billing services for African telecommunications. RADIUS authentication, mobile money integration, network automation, and enterprise-grade support.">
    <meta name="keywords" content="ISP billing services, RADIUS server, mobile money integration, network automation, telecommunications billing, African ISP solutions">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/services">
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="{$app_url}/ui/ui/images/favicon.ico">
    <link rel="icon" type="image/png" sizes="32x32" href="{$app_url}/ui/ui/images/favicon.ico">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/favicon.ico">
    <link rel="apple-touch-icon" sizes="180x180" href="{$app_url}/ui/ui/images/favicon.ico">
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Space+Grotesk:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --gold: #D4AF37;
            --gold-light: #F4E4C1;
            --gold-dark: #B8941F;
            --black: #000000;
            --black-soft: #1a1a1a;
            --white: #FFFFFF;
            --white-soft: #f8f8f8;
            --teal: #2C5282;
            --teal-light: #4299E1;
            --teal-dark: #1A365D;
            --gray: #666666;
            --gray-light: #f5f5f5;
            --gray-dark: #2d2d2d;
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 50%, #B8941F 100%);
            --gradient-black: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            --gradient-teal: linear-gradient(135deg, #2C5282 0%, #4299E1 100%);
            --gradient-hero: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #2C5282 100%);
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
            --shadow-gold: 0 10px 30px rgba(212,175,55,0.3);
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
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            font-size: 14px;
            line-height: 1.5;
            color: var(--black);
            background: var(--white);
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Professional Typography */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Manrope', sans-serif;
            font-weight: 600;
            line-height: 1.2;
            color: var(--black);
            margin-bottom: 0.5rem;
        }

        h1 { font-size: 2.5rem; }
        h2 { font-size: 2rem; }
        h3 { font-size: 1.5rem; }
        h4 { font-size: 1.25rem; }
        h5 { font-size: 1.125rem; }
        h6 { font-size: 1rem; }

        .display-2 { font-size: 3rem; font-weight: 700; }
        .text-lg { font-size: 1.125rem; }
        .text-sm { font-size: 0.875rem; }
        .text-xs { font-size: 0.75rem; }

        /* Creative Slanted Logo Design */
        .logo-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--gold);
            text-decoration: none;
            letter-spacing: 0.02em;
            display: inline-block;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .logo-brand .mission-statement {
            display: block;
            font-family: 'Inter', sans-serif;
            font-size: 0.6rem;
            font-weight: 500;
            color: var(--gold-dark);
            letter-spacing: 0.1em;
            text-transform: uppercase;
            margin-bottom: 0.2rem;
            transform: skew(-12deg);
            text-shadow: 0 1px 2px rgba(212, 175, 55, 0.2);
        }

        .logo-brand .main-logo {
            display: block;
            position: relative;
            transform: skew(-8deg) scale(1.02);
            text-shadow: none;
            filter: drop-shadow(0 3px 6px rgba(212, 175, 55, 0.4));
        }
        
        .logo-brand .main-logo .gli-part {
            color: #000000;
        }
        
        .logo-brand .main-logo .nta-part {
            background: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 30%, #B8941F 70%, #D4AF37 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .logo-brand .main-logo::before {
            content: '';
            position: absolute;
            top: 0;
            left: -10px;
            right: -10px;
            bottom: 0;
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.1) 0%, rgba(212, 175, 55, 0.05) 100%);
            transform: skew(8deg);
            z-index: -1;
            border-radius: 4px;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .logo-brand .main-logo .icon {
            display: inline-block;
            transform: rotate(-15deg) scale(1.1);
            margin-right: 0.5rem;
            filter: drop-shadow(0 2px 4px rgba(212, 175, 55, 0.3));
        }

        .logo-brand:hover {
            transform: scale(1.08) translateY(-2px);
        }

        .logo-brand:hover .mission-statement {
            color: var(--gold-light);
            transform: skew(-12deg) translateX(2px);
        }

        .logo-brand:hover .main-logo {
            transform: skew(-8deg) scale(1.05);
            filter: drop-shadow(0 5px 12px rgba(212, 175, 55, 0.6));
        }

        .logo-brand:hover .main-logo::before {
            opacity: 1;
        }

        .logo-brand:hover .main-logo .icon {
            transform: rotate(-15deg) scale(1.2);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .logo-brand {
                font-size: 1.5rem;
            }
            
            .logo-brand .mission-statement {
                font-size: 0.55rem;
            }
            
            .logo-brand .main-logo {
                transform: skew(-6deg) scale(1.02);
            }
            
            .logo-brand:hover .main-logo {
                transform: skew(-6deg) scale(1.03);
            }
        }

        @media (max-width: 480px) {
            .logo-brand {
                font-size: 1.3rem;
            }
            
            .logo-brand .mission-statement {
                font-size: 0.5rem;
            }
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--gray-200);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 0.5rem 0;
            box-shadow: var(--shadow);
        }

        .nav-link {
            color: var(--gray-600);
            font-weight: 500;
            font-size: 0.875rem;
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            color: var(--primary);
            background: var(--gray-50);
        }

        /* Modern Hero Section */
        .hero {
            background: linear-gradient(135deg, #1a1a1a 0%, #2C5282 50%, #000000 100%);
            position: relative;
            color: white;
            padding: 8rem 0 4rem;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                radial-gradient(circle at 20% 80%, rgba(212, 175, 55, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(212, 175, 55, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 60% 40%, rgba(44, 82, 130, 0.15) 0%, transparent 50%);
        }
        
        .hero::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: repeating-linear-gradient(
                45deg,
                transparent,
                transparent 2px,
                rgba(212, 175, 55, 0.03) 2px,
                rgba(212, 175, 55, 0.03) 4px
            );
            animation: float 20s linear infinite;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            color: white;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .hero .lead {
            font-size: 1.125rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        
        .hero-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }
        
        .hero-stat {
            text-align: center;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            border: 1px solid rgba(212, 175, 55, 0.3);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }
        
        .hero-stat:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 10px 30px rgba(212, 175, 55, 0.2);
        }
        
        .hero-stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--gold);
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .hero-stat-label {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .hero-buttons {
            margin-top: 2rem;
        }
        
        .hero-buttons .btn {
            margin: 0.5rem;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        
        .hero-buttons .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        
        /* Enhanced Realistic Laptop Mockup */
        .laptop-mockup {
            position: relative;
            max-width: 550px;
            margin: 0 auto;
            padding: 2rem 0;
            transform: perspective(1000px) rotateY(-5deg) rotateX(10deg);
            transition: all 0.4s ease;
        }
        
        .laptop-mockup:hover {
            transform: perspective(1000px) rotateY(0deg) rotateX(5deg) scale(1.02);
        }
        
        /* Laptop Base */
        .laptop-mockup::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: -5%;
            right: -5%;
            height: 25px;
            background: linear-gradient(135deg, #c0c0c0 0%, #a8a8a8 50%, #909090 100%);
            border-radius: 0 0 25px 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            z-index: 1;
        }
        
        /* Laptop Screen Bezel */
        .laptop-mockup::before {
            content: '';
            position: absolute;
            top: 10px;
            left: 5%;
            right: 5%;
            height: calc(75% - 10px);
            background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
            border-radius: 12px 12px 4px 4px;
            border: 4px solid #333;
            box-shadow: 
                inset 0 0 0 2px #555,
                0 10px 30px rgba(0,0,0,0.4);
            z-index: 2;
        }
        
        .laptop-screen {
            position: relative;
            z-index: 10;
            background: #000;
            border-radius: 8px;
            margin: 20px 8% 0 8%;
            overflow: hidden;
            box-shadow: 
                inset 0 0 30px rgba(0,0,0,0.8),
                0 0 20px rgba(212, 175, 55, 0.2);
            border: 1px solid #333;
        }
        
        .laptop-screen::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 25px;
            background: linear-gradient(to bottom, rgba(255,255,255,0.1), transparent);
            z-index: 5;
            pointer-events: none;
        }
        
        .dashboard-image {
            width: 100%;
            height: auto;
            display: block;
            border-radius: 6px;
            transition: all 0.3s ease;
            filter: brightness(1.1) contrast(1.05);
        }
        
        .dashboard-image:hover {
            filter: brightness(1.15) contrast(1.1);
        }
        
        /* Screen glow effect */
        .laptop-screen::after {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            background: radial-gradient(ellipse at center, rgba(212, 175, 55, 0.1) 0%, transparent 70%);
            z-index: -1;
            animation: screenGlow 3s ease-in-out infinite alternate;
        }
        
        @keyframes screenGlow {
            0% { opacity: 0.5; }
            100% { opacity: 0.8; }
        }

        /* Service Cards */
        .service-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, var(--gold) 0%, var(--gold-light) 100%);
            opacity: 0.05;
            border-radius: 50%;
            transform: translate(25px, -25px);
            transition: all 0.3s ease;
        }

        .service-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }
        
        .service-card:hover::before {
            opacity: 0.1;
            transform: translate(20px, -20px) scale(1.1);
        }

        .service-card.featured {
            border-color: var(--accent);
            position: relative;
            transform: scale(1.02);
        }

        .featured-badge {
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gradient-primary);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .service-icon {
            width: 56px;
            height: 56px;
            background: var(--gradient-primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .price-tag {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1rem;
            font-family: 'JetBrains Mono', monospace;
        }

        .service-title {
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--dark);
        }

        .service-description {
            color: var(--gray-600);
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
        }

        .service-features {
            list-style: none;
            padding: 0;
            margin-bottom: 2rem;
        }

        .service-features li {
            padding: 0.5rem 0;
            color: var(--gray-600);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .service-features li:last-child {
            border-bottom: none;
        }

        .service-features li i {
            color: var(--success);
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        /* Process Section with Pattern */
        .process-section {
            background: linear-gradient(rgba(248, 248, 248, 0.95), rgba(248, 248, 248, 0.95)),
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 60 60"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="%23D4AF37" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23dots)"/></svg>');
            padding: 4rem 0;
            position: relative;
        }

        .process-step {
            text-align: center;
            padding: 1.5rem;
            position: relative;
        }

        .process-number {
            width: 60px;
            height: 60px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            font-weight: 600;
            color: white;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Tech Stack */
        .tech-stack {
            background: var(--gray-50);
            padding: 4rem 0;
        }

        .tech-item {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            text-align: center;
            border: 1px solid var(--gray-200);
            transition: all 0.3s ease;
        }

        .tech-item:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }

        .tech-icon {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        /* CTA Section */
        .cta-section {
            background: var(--primary);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }

        /* Buttons */
        .btn {
            font-size: 0.875rem;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            border: none;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
            color: white;
        }

        .btn-outline-primary {
            border: 1px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
        }

        .btn-accent {
            background: var(--gradient-accent);
            color: var(--primary);
        }

        .btn-accent:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
            color: var(--primary);
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

        .footer h6 {
            color: var(--gold);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .footer a {
            color: var(--white);
            text-decoration: none;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            opacity: 0.8;
        }

        .footer a:hover {
            color: var(--gold);
            opacity: 1;
            transform: translateX(2px);
        }

        /* Enhanced Responsive Design */
        
        /* Mobile First - Small devices (576px and down) */
        @media (max-width: 575.98px) {
            .hero {
                padding: 5rem 0 3rem;
            }
            
            .display-2 {
                font-size: 1.8rem;
                line-height: 1.3;
            }
            
            .hero-stats {
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }
            
            .hero-stat {
                padding: 1rem;
            }
            
            .hero-stat-number {
                font-size: 1.8rem;
            }
            
            .hero-buttons .btn {
                width: 100%;
                margin: 0.25rem 0;
            }
            
            .laptop-mockup {
                max-width: 300px;
                padding: 1rem 0;
            }
            
            .service-card {
                padding: 1.25rem;
            }
        }
        
        /* Tablets - Medium devices (768px and up) */
        @media (min-width: 576px) and (max-width: 991.98px) {
            .hero {
                padding: 6rem 0 4rem;
            }
            
            .display-2 {
                font-size: 2.2rem;
            }
            
            .hero-stats {
                grid-template-columns: repeat(2, 1fr);
                gap: 1.5rem;
            }
            
            .laptop-mockup {
                max-width: 400px;
            }
        }
        
        /* Large devices (992px and up) */
        @media (min-width: 992px) {
            .hero-stats {
                grid-template-columns: repeat(4, 1fr);
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg" id="navbar">
        <div class="container">
            <a class="logo-brand" href="{$app_url}">
                <span class="main-logo">
                    <i class="fas fa-network-wired icon"></i><span class="gli-part">GLI</span><span class="nta-part">nta Africa</span>
                </span>
                <span class="mission-statement">Connect • Innovate • Empower</span>
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars"></i>
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
                    <li class="nav-item ms-2">
                        <a class="btn btn-primary" href="#demo-section">
                            <i class="fas fa-play me-1"></i>Live Demo
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Modern Hero Section -->
    <section class="hero">
        <div class="container hero-content">
            <div class="row">
                <div class="col-lg-10 mx-auto text-center">
                    <h1 class="display-2">Professional ISP <span style="color: var(--gold); animation: glow 2s ease-in-out infinite alternate;">Services</span></h1>
                    <p class="lead">Enterprise-grade internet billing solutions designed for African telecommunications.<br>
Advanced network management, automated billing, and seamless mobile money integration.</p>
                    
                    <!-- Hero Stats -->
                    <div class="hero-stats" data-aos="fade-up" data-aos-delay="300">
                        <div class="hero-stat" data-aos="zoom-in" data-aos-delay="400">
                            <span class="hero-stat-number" id="active-users">2,450</span>
                            <span class="hero-stat-label">Active ISPs</span>
                        </div>
                        <div class="hero-stat" data-aos="zoom-in" data-aos-delay="500">
                            <span class="hero-stat-number" id="uptime">99.9%</span>
                            <span class="hero-stat-label">System Uptime</span>
                        </div>
                        <div class="hero-stat" data-aos="zoom-in" data-aos-delay="600">
                            <span class="hero-stat-number" id="countries">15+</span>
                            <span class="hero-stat-label">Countries</span>
                        </div>
                        <div class="hero-stat" data-aos="zoom-in" data-aos-delay="700">
                            <span class="hero-stat-number" id="support">24/7</span>
                            <span class="hero-stat-label">Expert Support</span>
                        </div>
                    </div>
                    
                    <div class="hero-buttons" data-aos="fade-up" data-aos-delay="800">
                        <a href="#dashboard-demo" class="btn btn-accent">
                            <i class="fas fa-desktop me-2"></i>View Live Demo
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-light">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Dashboard Demo Section -->
    <section class="py-5" id="dashboard-demo" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2 class="h1 mb-4">See It In Action</h2>
                    <p class="lead text-muted mb-4">Experience our powerful ISP management dashboard that's helping thousands of providers across Africa streamline their operations.</p>
                    
                    <div class="row g-3 mb-4">
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="bg-primary rounded-circle p-2 me-3">
                                    <i class="fas fa-chart-line text-white"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">Real-time Analytics</h6>
                                    <small class="text-muted">Live network monitoring</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="bg-success rounded-circle p-2 me-3">
                                    <i class="fas fa-mobile-alt text-white"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">Mobile Payments</h6>
                                    <small class="text-muted">M-Pesa integration</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="bg-warning rounded-circle p-2 me-3">
                                    <i class="fas fa-users text-white"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">User Management</h6>
                                    <small class="text-muted">Automated billing</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <div class="bg-info rounded-circle p-2 me-3">
                                    <i class="fas fa-shield-alt text-white"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">RADIUS Security</h6>
                                    <small class="text-muted">Enterprise auth</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-primary btn-lg">
                        <i class="fas fa-external-link-alt me-2"></i>Launch Demo
                    </a>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Laptop Mockup with Dashboard -->
                    <div class="laptop-mockup">
                        <div class="laptop-screen">
                            <img src="{$app_url}/ui/ui/images/demohasboard2.png" 
                                 alt="ISP Dashboard Demo" 
                                 class="dashboard-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Services -->
    <section class="py-5" style="background: linear-gradient(rgba(248,248,248,0.9), rgba(248,248,248,0.9)), url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="ISP Services" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2>Core Services</h2>
                    <p class="text-lg text-gray-600">Professional services for modern ISPs</p>
                    <div class="row g-3 mt-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">5+</h4>
                                <small class="text-muted">Core Services</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">24/7</h4>
                                <small class="text-muted">Support</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="RADIUS Server" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h5 class="service-title">RADIUS Authentication</h5>
                        <p class="service-description">Enterprise RADIUS server with AAA support.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">RFC Compliant</span>
                            <span class="badge bg-light text-dark">CoA Support</span>
                            <span class="badge bg-light text-dark">Load Balancing</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">RADIUS</span>
                            <span class="badge bg-light text-dark me-1">AAA</span>
                            <span class="badge bg-light text-dark">CoA</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Mobile Money" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="service-title">Mobile Money Integration</h5>
                        <p class="service-description">Native API integration with African mobile money platforms.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">M-Pesa STK</span>
                            <span class="badge bg-light text-dark">Airtel Money</span>
                            <span class="badge bg-light text-dark">MTN MoMo</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">M-Pesa</span>
                            <span class="badge bg-light text-dark me-1">API</span>
                            <span class="badge bg-light text-dark">Webhooks</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1544197150-b99a580bb7a8?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Network Automation" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h5 class="service-title">Network Automation</h5>
                        <p class="service-description">Automated network provisioning via SNMP, SSH, and APIs.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">Mikrotik API</span>
                            <span class="badge bg-light text-dark">UniFi</span>
                            <span class="badge bg-light text-dark">SNMP</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">SNMP</span>
                            <span class="badge bg-light text-dark me-1">SSH</span>
                            <span class="badge bg-light text-dark">API</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Analytics Dashboard" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5 class="service-title">Analytics & Monitoring</h5>
                        <p class="service-description">Real-time monitoring with customizable dashboards and alerts.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">Real-time</span>
                            <span class="badge bg-light text-dark">Dashboards</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">InfluxDB</span>
                            <span class="badge bg-light text-dark me-1">Grafana</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Security" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="service-title">Security & Compliance</h5>
                        <p class="service-description">Enterprise security with compliance management and audit trails.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">PCI DSS</span>
                            <span class="badge bg-light text-dark">GDPR</span>
                            <span class="badge bg-light text-dark">SOC 2</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Security</span>
                            <span class="badge bg-light text-dark me-1">Compliance</span>
                            <span class="badge bg-light text-dark">Audit</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1556761175-b413da4baf72?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Support Team" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5 class="service-title">Support & Maintenance</h5>
                        <p class="service-description">24/7 technical support with proactive monitoring and updates.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">24/7 Support</span>
                            <span class="badge bg-light text-dark">Monitoring</span>
                            <span class="badge bg-light text-dark">SLA</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">24/7</span>
                            <span class="badge bg-light text-dark me-1">SLA</span>
                            <span class="badge bg-light text-dark">Support</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Visual Implementation Process -->
    <section class="py-5" style="background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2 class="text-white">Quick Implementation</h2>
                    <p class="text-white-50 mb-4">Get your ISP services running in days, not months.</p>
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded">
                                <h4 class="text-primary mb-1">3</h4>
                                <small class="text-muted">Days Setup</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded">
                                <h4 class="text-primary mb-1">24/7</h4>
                                <small class="text-muted">Support</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="Implementation Process" class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Stack -->
    <section class="py-5" style="background: var(--gray-50);">
        <div class="container">
            <div class="row align-items-center mb-4">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2>Enterprise Technology</h2>
                    <p class="text-lg text-gray-600">Built with proven enterprise technologies.</p>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <img src="https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80" 
                         alt="Technology Stack" class="img-fluid rounded">
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-php"></i>
                        </div>
                        <h6 class="text-sm">PHP 8.2</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h6 class="text-sm">MySQL 8.0</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6 class="text-sm">FreeRADIUS</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-docker"></i>
                        </div>
                        <h6 class="text-sm">Docker</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h6 class="text-sm">InfluxDB</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h6 class="text-sm">OpenSSL</h6>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Visual Packages Section -->
    <section class="py-5" style="background: linear-gradient(rgba(255,255,255,0.9), rgba(255,255,255,0.9)), url('https://images.unsplash.com/photo-1544197150-b99a580bb7a8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1521017432531-fbd92d768814?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="Hotspot Packages" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2>Ready-to-Use Packages</h2>
                    <p class="text-lg text-gray-600">Pre-configured hotspot packages for instant deployment.</p>
                    <div class="row g-3 mt-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">50+</h4>
                                <small class="text-muted">Package Templates</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">Auto</h4>
                                <small class="text-muted">Configuration</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-clock text-primary fs-2 mb-2"></i>
                        <h6>Hourly</h6>
                        <small class="text-muted">KSh 5-20</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-calendar-day text-primary fs-2 mb-2"></i>
                        <h6>Daily</h6>
                        <small class="text-muted">KSh 30-50</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-calendar-week text-primary fs-2 mb-2"></i>
                        <h6>Weekly</h6>
                        <small class="text-muted">KSh 150-300</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-calendar-alt text-primary fs-2 mb-2"></i>
                        <h6>Monthly</h6>
                        <small class="text-muted">KSh 500+</small>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Dynamic Call to Action -->
    <section class="py-5" style="background: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #000000 100%); position: relative; overflow: hidden;">
        <!-- Animated Background Elements -->
        <div class="position-absolute" style="top: -50%; left: -50%; width: 200%; height: 200%; background: repeating-linear-gradient(45deg, transparent, transparent 2px, rgba(212, 175, 55, 0.02) 2px, rgba(212, 175, 55, 0.02) 4px); animation: float 15s linear infinite;"></div>
        
        <div class="container" style="position: relative; z-index: 2;">
            <div class="row">
                <div class="col-lg-10 mx-auto text-center">
                    <h2 class="mb-4" style="color: var(--gold); font-size: 2.5rem; font-weight: 700; text-shadow: 0 4px 8px rgba(212, 175, 55, 0.3);">
                        Ready to Deploy Professional ISP Services?
                    </h2>
                    <p class="text-lg mb-4" style="color: #ffffff; font-size: 1.2rem; line-height: 1.6;">
                        Contact our technical team to discuss your requirements and get a customized solution.
                        <br><span style="color: var(--gold); font-weight: 600;">Join 2,450+ ISPs already using our platform across Africa</span>
                    </p>
                    
                    <!-- Dynamic Stats Row -->
                    <div class="row g-3 mb-5">
                        <div class="col-md-3 col-6">
                            <div class="text-center p-3" style="background: rgba(212, 175, 55, 0.1); border-radius: 15px; border: 1px solid rgba(212, 175, 55, 0.3);">
                                <div style="color: var(--gold); font-size: 1.8rem; font-weight: 700;" id="deployment-time">24hrs</div>
                                <small style="color: rgba(255,255,255,0.8);">Deployment Time</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="text-center p-3" style="background: rgba(212, 175, 55, 0.1); border-radius: 15px; border: 1px solid rgba(212, 175, 55, 0.3);">
                                <div style="color: var(--gold); font-size: 1.8rem; font-weight: 700;" id="support-response">15min</div>
                                <small style="color: rgba(255,255,255,0.8);">Support Response</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="text-center p-3" style="background: rgba(212, 175, 55, 0.1); border-radius: 15px; border: 1px solid rgba(212, 175, 55, 0.3);">
                                <div style="color: var(--gold); font-size: 1.8rem; font-weight: 700;" id="success-rate">99.9%</div>
                                <small style="color: rgba(255,255,255,0.8);">Success Rate</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="text-center p-3" style="background: rgba(212, 175, 55, 0.1); border-radius: 15px; border: 1px solid rgba(212, 175, 55, 0.3);">
                                <div style="color: var(--gold); font-size: 1.8rem; font-weight: 700;" id="training-hours">0hrs</div>
                                <small style="color: rgba(255,255,255,0.8);">Training Required</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn px-4 py-3" style="background: var(--gradient-gold); color: #000; font-weight: 600; border-radius: 50px; transition: all 0.3s ease; box-shadow: 0 5px 20px rgba(212, 175, 55, 0.3);" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 30px rgba(212, 175, 55, 0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 5px 20px rgba(212, 175, 55, 0.3)'">
                            <i class="fas fa-envelope me-2"></i>Email: watsonwambugu@yahoo.com
                        </a>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn px-4 py-3" style="background: transparent; color: white; border: 2px solid var(--gold); font-weight: 600; border-radius: 50px; transition: all 0.3s ease;" onmouseover="this.style.background='rgba(212, 175, 55, 0.1)'; this.style.transform='translateY(-2px)'" onmouseout="this.style.background='transparent'; this.style.transform='translateY(0)'">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp: +254 711 503 023
                        </a>
                    </div>
                    
                    <div class="mt-4">
                        <p style="color: rgba(255,255,255,0.7); font-size: 0.9rem;">
                            <i class="fas fa-shield-alt me-1" style="color: var(--gold);"></i>Enterprise Security • 
                            <i class="fas fa-headset me-1 ms-2" style="color: var(--gold);"></i>24/7 Expert Support • 
                            <i class="fas fa-rocket me-1 ms-2" style="color: var(--gold);"></i>Rapid Deployment
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Enhanced Demo Section -->
    <section class="py-5" id="demo-section" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); position: relative;">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto text-center">
                    <h2 style="color: #000000; font-size: 2.2rem; font-weight: 700; margin-bottom: 1rem;">
                        <span style="color: var(--gold);">Try Our Services</span> - Live Demo Access
                    </h2>
                    <p style="color: #333333; font-size: 1.1rem; line-height: 1.6; margin-bottom: 2rem;">
                        Experience the complete ISP services platform with live dashboard access.
                        <br><strong style="color: var(--gold);">No registration required</strong> • <strong style="color: #000;">Full feature access</strong> • <strong style="color: var(--gold);">Real-time data</strong>
                    </p>
                    
                    <!-- Demo Features Grid -->
                    <div class="row g-3 mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="d-flex align-items-center justify-content-center p-3" style="background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                                <div class="text-center">
                                    <i class="fas fa-tachometer-alt fa-2x mb-2" style="color: var(--gold);"></i>
                                    <h6 style="color: #000; margin: 0;">Live Dashboard</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="d-flex align-items-center justify-content-center p-3" style="background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                                <div class="text-center">
                                    <i class="fas fa-users fa-2x mb-2" style="color: var(--gold);"></i>
                                    <h6 style="color: #000; margin: 0;">User Management</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="d-flex align-items-center justify-content-center p-3" style="background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                                <div class="text-center">
                                    <i class="fas fa-credit-card fa-2x mb-2" style="color: var(--gold);"></i>
                                    <h6 style="color: #000; margin: 0;">Billing System</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="d-flex align-items-center justify-content-center p-3" style="background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                                <div class="text-center">
                                    <i class="fas fa-chart-line fa-2x mb-2" style="color: var(--gold);"></i>
                                    <h6 style="color: #000; margin: 0;">Analytics</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-lg px-5 py-3" style="background: var(--gradient-gold); color: #000; font-weight: 700; border-radius: 50px; font-size: 1.1rem; transition: all 0.3s ease; box-shadow: 0 8px 25px rgba(212, 175, 55, 0.3);" onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 12px 35px rgba(212, 175, 55, 0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 8px 25px rgba(212, 175, 55, 0.3)'">
                        <i class="fas fa-external-link-alt me-2"></i>Launch Demo Dashboard
                    </a>
                    
                    <p style="color: #666; font-size: 0.9rem; margin-top: 1rem;">
                        <i class="fas fa-clock me-1" style="color: var(--gold);"></i>Demo environment resets every 24 hours • 
                        <i class="fas fa-lock me-1 ms-2" style="color: var(--gold);"></i>Secure sandbox environment
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h6>Glinta Africa</h6>
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management services for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-linkedin"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Services</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/services">RADIUS Server</a>
                        <a href="{$app_url}/services">Mobile Money</a>
                        <a href="{$app_url}/services">Network Automation</a>
                        <a href="{$app_url}/services">Analytics</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Features</a>
                        <a href="{$app_url}/pricing">Pricing</a>
                        <a href="#demo-section">Demo</a>
                        <a href="#">API Docs</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Support</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="#">Documentation</a>
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="{$app_url}/about">About</a>
                        <a href="{$app_url}/contact">Contact</a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6>Contact</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="mailto:watsonwambugu@yahoo.com">Email Support</a>
                        <a href="https://wa.me/254711503023" target="_blank">WhatsApp</a>
                        <a href="{$app_url}/contact">Contact Form</a>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: var(--gray-700);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="text-sm text-gray-500 mb-0">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-sm text-gray-500 mb-0">Professional ISP solutions for Africa</p>
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
            duration: 600,
            easing: 'ease-out-sine',
            once: true,
            offset: 100
        });

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    </script>
</body>
</html>