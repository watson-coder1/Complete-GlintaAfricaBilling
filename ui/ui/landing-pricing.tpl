<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional ISP billing platform pricing. Enterprise-grade features with transparent pricing for African telecommunications. Custom solutions available.">
    <meta name="keywords" content="ISP pricing, billing software cost, enterprise ISP solution, mobile money billing, professional network management pricing">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/pricing">
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="{$app_url}/ui/ui/images/favicon.svg">
    <link rel="icon" type="image/png" sizes="32x32" href="{$app_url}/ui/ui/images/favicon-32x32.png">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/favicon-32x32.png">
    <link rel="apple-touch-icon" sizes="180x180" href="{$app_url}/ui/ui/images/favicon-32x32.png">
    
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

        /* Hero Section with Tech Background */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 80vh;
            color: white;
            padding: 8rem 0 4rem;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
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
                radial-gradient(circle at 80% 20%, rgba(212, 175, 55, 0.08) 0%, transparent 50%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            color: white;
            margin-bottom: 1.5rem;
        }

        .hero .lead {
            font-size: 1.125rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
        }

        /* Pricing Cards */
        .pricing-card {
            background: white;
            border-radius: 12px;
            padding: 2.5rem 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .pricing-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: linear-gradient(45deg, var(--gold) 0%, var(--gold-light) 100%);
            opacity: 0.03;
            border-radius: 50%;
            transform: translate(30px, -30px);
            transition: all 0.3s ease;
        }

        .pricing-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }
        
        .pricing-card:hover::before {
            opacity: 0.08;
            transform: translate(25px, -25px) scale(1.2);
        }

        .pricing-card.featured {
            border-color: var(--accent);
            box-shadow: var(--shadow-lg);
            transform: scale(1.02);
        }

        .pricing-card.featured::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-accent);
        }

        .pricing-badge {
            background: var(--gradient-accent);
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1.5rem;
            display: inline-block;
        }

        .pricing-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .pricing-subtitle {
            color: var(--gray-600);
            font-size: 0.875rem;
            margin-bottom: 2rem;
        }

        .pricing-price {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
            margin-bottom: 0.25rem;
        }

        .pricing-period {
            color: var(--gray-500);
            font-size: 0.875rem;
            margin-bottom: 2rem;
        }

        .pricing-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem;
        }

        .pricing-features li {
            padding: 0.75rem 0;
            color: var(--gray-600);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            align-items: center;
        }

        .pricing-features li:last-child {
            border-bottom: none;
        }

        .pricing-features li i {
            color: var(--success);
            margin-right: 0.75rem;
            font-size: 0.75rem;
            width: 16px;
        }

        .pricing-features li.unavailable {
            color: var(--gray-400);
        }

        .pricing-features li.unavailable i {
            color: var(--gray-300);
        }

        /* Value Proposition with Visual Pattern */
        .value-section {
            background: linear-gradient(rgba(245, 245, 245, 0.95), rgba(245, 245, 245, 0.95)),
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="hexagon" width="50" height="50" patternUnits="userSpaceOnUse"><polygon points="25,8 42,17 42,33 25,42 8,33 8,17" fill="none" stroke="%23D4AF37" stroke-width="1" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23hexagon)"/></svg>');
            padding: 4rem 0;
            position: relative;
        }

        .value-card {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            text-align: center;
            border: 1px solid var(--gray-200);
            height: 100%;
            transition: all 0.3s ease;
        }

        .value-card:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }

        .value-icon {
            width: 64px;
            height: 64px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.75rem;
            margin: 0 auto 1.5rem;
        }

        /* ROI Calculator */
        .roi-section {
            background: white;
            padding: 4rem 0;
        }

        .roi-calculator {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
        }

        .roi-metric {
            text-align: center;
            padding: 1.5rem;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--gray-200);
        }

        .roi-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
        }

        .roi-label {
            font-size: 0.875rem;
            color: var(--gray-600);
            margin-top: 0.5rem;
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

        .btn-pricing {
            width: 100%;
            justify-content: center;
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

        /* Enhanced Pricing Card Animations */
        .pricing-card {
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            cursor: pointer;
        }
        
        @keyframes glow {
            0%, 100% { box-shadow: 0 0 5px rgba(212,175,55,0.4); }
            50% { box-shadow: 0 0 20px rgba(212,175,55,0.8), 0 0 30px rgba(212,175,55,0.4); }
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .pricing-card::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(212, 175, 55, 0.1), transparent);
            transform: rotate(45deg) translate(-100%, -100%);
            transition: transform 0.6s ease;
        }
        
        .pricing-card:hover::after {
            transform: rotate(45deg) translate(100%, 100%);
        }
        
        .pricing-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .pricing-card.featured {
            transform: scale(1.05);
            border: 2px solid var(--gold);
            box-shadow: 0 15px 35px rgba(212, 175, 55, 0.2);
        }
        
        .pricing-card.featured:hover {
            transform: translateY(-8px) scale(1.08);
            box-shadow: 0 25px 50px rgba(212, 175, 55, 0.3);
        }
        
        .pricing-price {
            position: relative;
            transition: all 0.3s ease;
        }
        
        .pricing-card:hover .pricing-price {
            transform: scale(1.1);
            color: var(--gold);
        }
        
        /* Floating Badge Animation */
        .pricing-badge {
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
        }
        
        /* Button Pulse Effect */
        .btn-pricing {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .btn-pricing::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.3s ease;
        }
        
        .btn-pricing:hover::before {
            width: 300px;
            height: 300px;
        }
        
        /* Success Stories Enhanced */
        .success-story {
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .success-story:hover {
            transform: translateY(-10px) rotate(2deg);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 6rem 0 3rem;
            }
            
            h1 { font-size: 2rem; }
            h2 { font-size: 1.75rem; }
            
            .pricing-card {
                padding: 2rem 1.5rem;
                margin-bottom: 2rem;
            }
            
            .pricing-card.featured {
                transform: none;
                margin: 1rem 0;
            }
            
            .pricing-card:hover {
                transform: translateY(-4px) scale(1.01);
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

    <!-- Hero Section -->
    <section class="hero" style="background: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #2C5282 100%); min-height: 80vh; display: flex; align-items: center; position: relative; overflow: hidden;">
        <!-- Animated Background Elements -->
        <div style="position: absolute; top: 10%; left: 10%; width: 100px; height: 100px; border-radius: 50%; background: rgba(212,175,55,0.1); animation: float 6s ease-in-out infinite;"></div>
        <div style="position: absolute; top: 60%; right: 15%; width: 80px; height: 80px; border-radius: 50%; background: rgba(212,175,55,0.1); animation: float 8s ease-in-out infinite reverse;"></div>
        <div style="position: absolute; bottom: 20%; left: 20%; width: 60px; height: 60px; border-radius: 50%; background: rgba(212,175,55,0.1); animation: float 7s ease-in-out infinite;"></div>
        
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2 text-white">💰 Pricing That Won't <span style="color: var(--gold); animation: glow 2s ease-in-out infinite alternate;">Break the Bank</span>!</h1>
                    <p class="lead text-white-50 mb-4">Finally, ISP billing that costs less than your morning coffee! ☕ Choose a plan that grows with your business (and your sanity).</p>
                    
                    <!-- Fun Stats -->
                    <div class="row g-3 mb-4">
                        <div class="col-6">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3); transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='scale(1.05) rotate(2deg)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'">
                                <div class="h4 mb-1" style="color: var(--gold);">💸</div>
                                <small class="text-white">Save 60% on IT costs</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3); transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='scale(1.05) rotate(-2deg)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'">
                                <div class="h4 mb-1" style="color: var(--gold);">🚀</div>
                                <small class="text-white">Setup in 24 hours</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#pricing-plans" class="btn btn-accent btn-lg px-4 py-3" style="animation: pulse 2s infinite;" onmouseover="this.style.transform='scale(1.05) rotate(1deg)'; this.style.boxShadow='0 10px 30px rgba(212,175,55,0.4)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'; this.style.boxShadow='none'">
                            💳 See Pricing
                        </a>
                        <a href="#demo-section" class="btn btn-outline-light btn-lg px-4 py-3" style="transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'; this.innerHTML='🎮 Try Demo Now!'" onmouseout="this.style.background='transparent'; this.innerHTML='🎯 Live Demo'">
                            🎯 Live Demo
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Pricing Visual -->
                    <div class="position-relative">
                        <img src="https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                             alt="Affordable Pricing" class="img-fluid rounded shadow-lg" style="transform: perspective(1000px) rotateY(10deg); transition: all 0.3s ease;" onmouseover="this.style.transform='perspective(1000px) rotateY(0deg) scale(1.02)'" onmouseout="this.style.transform='perspective(1000px) rotateY(10deg) scale(1)'">
                        
                        <!-- Animated Price Tags -->
                        <div class="position-absolute top-0 start-0 m-3 bg-success text-white rounded p-2 shadow" style="animation: bounce 3s infinite;">
                            <small>🏷️ Best Value</small>
                        </div>
                        <div class="position-absolute bottom-0 end-0 m-3 bg-warning text-dark rounded p-2 shadow" style="animation: bounce 4s infinite reverse;">
                            <small>💎 Premium Quality</small>
                        </div>
                        
                        <!-- Floating Icons -->
                        <div class="position-absolute" style="top: 20%; right: -30px; animation: float 3s ease-in-out infinite; font-size: 2rem;">💰</div>
                        <div class="position-absolute" style="bottom: 30%; left: -30px; animation: float 4s ease-in-out infinite reverse; font-size: 2rem;">📊</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Success Stories Gallery -->
    <section class="py-5" style="background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 class="text-white">Trusted by ISPs Across Africa</h2>
                    <p class="text-white-50">See how our clients transform their operations</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4" data-aos="zoom-in" data-aos-delay="100">
                    <div class="success-story bg-white rounded p-4 text-center shadow-sm">
                        <div class="position-relative mb-3">
                            <img src="https://images.unsplash.com/photo-1521017432531-fbd92d768814?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&h=200&q=80" 
                                 alt="Café Network" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                            <div class="position-absolute top-0 end-0 bg-success text-white px-2 py-1 rounded-bottom-start">
                                <small><i class="fas fa-check me-1"></i>Active</small>
                            </div>
                        </div>
                        <h6 class="text-primary">Café Networks</h6>
                        <div class="d-flex justify-content-center gap-3 mb-2">
                            <div class="text-center">
                                <strong class="text-success">200+</strong>
                                <br><small class="text-muted">Locations</small>
                            </div>
                            <div class="text-center">
                                <strong class="text-info">5K+</strong>
                                <br><small class="text-muted">Daily Users</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="success-story bg-white rounded p-4 text-center shadow-sm">
                        <div class="position-relative mb-3">
                            <img src="https://images.unsplash.com/photo-1577495508048-b635879837f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&h=200&q=80" 
                                 alt="Enterprise ISP" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                            <div class="position-absolute top-0 end-0 bg-primary text-white px-2 py-1 rounded-bottom-start">
                                <small><i class="fas fa-star me-1"></i>Featured</small>
                            </div>
                        </div>
                        <h6 class="text-primary">Enterprise ISPs</h6>
                        <div class="d-flex justify-content-center gap-3 mb-2">
                            <div class="text-center">
                                <strong class="text-success">50+</strong>
                                <br><small class="text-muted">Companies</small>
                            </div>
                            <div class="text-center">
                                <strong class="text-info">100K+</strong>
                                <br><small class="text-muted">Subscribers</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="zoom-in" data-aos-delay="300">
                    <div class="success-story bg-white rounded p-4 text-center shadow-sm">
                        <div class="position-relative mb-3">
                            <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&h=200&q=80" 
                                 alt="Community Networks" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                            <div class="position-absolute top-0 end-0 bg-warning text-dark px-2 py-1 rounded-bottom-start">
                                <small><i class="fas fa-heart me-1"></i>Popular</small>
                            </div>
                        </div>
                        <h6 class="text-primary">Community Networks</h6>
                        <div class="d-flex justify-content-center gap-3 mb-2">
                            <div class="text-center">
                                <strong class="text-success">1K+</strong>
                                <br><small class="text-muted">Households</small>
                            </div>
                            <div class="text-center">
                                <strong class="text-info">25K+</strong>
                                <br><small class="text-muted">Connections</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Humorous Intro Section -->
    <section class="py-5" style="background: var(--white-soft);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>🎭 Choose Your Adventure (Pricing Edition)</h2>
                    <p class="text-lg text-gray-600 mb-4">We know pricing pages are about as exciting as watching paint dry, so we added some personality! 😄</p>
                    
                    <!-- Fun Comparison -->
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.1); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1">🍕</div>
                                <small>Our Monthly Plan = 2 Pizza Dinners</small>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.1); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1">☕</div>
                                <small>Cheaper than your daily coffee habit</small>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.1); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1">🚗</div>
                                <small>Less than your monthly fuel bill</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Enhanced Pricing Section -->
    <section class="py-5" id="pricing-plans" style="background: linear-gradient(rgba(248,248,248,0.95), rgba(248,248,248,0.95)), url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="ISP Pricing Plans" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2>Professional Plans</h2>
                    <p class="text-lg text-gray-600">Scalable solutions for ISPs of all sizes with transparent pricing.</p>
                    <div class="row g-3 mt-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">3</h4>
                                <small class="text-muted">Plan Options</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">Free</h4>
                                <small class="text-muted">Trial Period</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="pricing-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&h=150&q=80" 
                                 alt="Starter Plan" class="img-fluid rounded" style="height: 120px; width: 100%; object-fit: cover;">
                        </div>
                        <h3 class="pricing-title">🌱 "Baby Steps" Starter</h3>
                        <p class="pricing-subtitle">Perfect for ISPs still figuring things out</p>
                        <div class="pricing-price">$10</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 100 customers (that's a good start!)</li>
                            <li><i class="fas fa-check"></i> RADIUS integration (no more headaches)</li>
                            <li><i class="fas fa-check"></i> M-Pesa integration (because cash is so 2010)</li>
                            <li><i class="fas fa-check"></i> Customer portal (let them help themselves)</li>
                            <li><i class="fas fa-check"></i> Email support (we actually reply!)</li>
                        </ul>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-primary btn-pricing">
                            <i class="fas fa-envelope me-2"></i>Get Started
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="pricing-card featured">
                        <div class="pricing-badge">Most Popular</div>
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&h=150&q=80" 
                                 alt="Professional Plan" class="img-fluid rounded" style="height: 120px; width: 100%; object-fit: cover;">
                        </div>
                        <h3 class="pricing-title">🚀 "I'm Serious Now" Professional</h3>
                        <p class="pricing-subtitle">For ISPs ready to impress their customers</p>
                        <div class="pricing-price">$25</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> 500 customers (now we're talking!)</li>
                            <li><i class="fas fa-check"></i> Advanced RADIUS (enterprise-grade stuff)</li>
                            <li><i class="fas fa-check"></i> All mobile money (M-Pesa, Airtel, the works)</li>
                            <li><i class="fas fa-check"></i> Priority support (we pick up the phone!)</li>
                            <li><i class="fas fa-check"></i> API access (for the tech-savvy)</li>
                        </ul>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-accent btn-pricing">
                            <i class="fas fa-envelope me-2"></i>Get Started
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="pricing-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&h=150&q=80" 
                                 alt="Enterprise Plan" class="img-fluid rounded" style="height: 120px; width: 100%; object-fit: cover;">
                        </div>
                        <h3 class="pricing-title">👑 "Boss Mode" Enterprise</h3>
                        <p class="pricing-subtitle">For ISPs who've conquered their market</p>
                        <div class="pricing-price">$50</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Unlimited customers (go wild!)</li>
                            <li><i class="fas fa-check"></i> Full platform access (all the bells & whistles)</li>
                            <li><i class="fas fa-check"></i> White-label solution (put your brand on it)</li>
                            <li><i class="fas fa-check"></i> 24/7 phone support (yes, even at 3 AM)</li>
                            <li><i class="fas fa-check"></i> Custom integrations (we code what you need)</li>
                        </ul>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary btn-pricing">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Value Proposition -->
    <section class="value-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Why Choose Glinta Africa</h2>
                    <p class="text-lg text-gray-600">Enterprise-grade features that deliver real business value</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h5>Faster Deployment</h5>
                        <p class="text-sm text-gray-600">Get up and running in 24 hours with our automated setup process</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5>Increased Revenue</h5>
                        <p class="text-sm text-gray-600">Average 35% revenue increase through automated billing and payments</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Better Customer Experience</h5>
                        <p class="text-sm text-gray-600">Self-service portal reduces support tickets by 60%</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5>Enterprise Security</h5>
                        <p class="text-sm text-gray-600">Bank-grade security with 99.9% uptime SLA guarantee</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ROI Calculator -->
    <section class="roi-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="roi-calculator" data-aos="fade-up">
                        <div class="text-center mb-4">
                            <h3>Return on Investment</h3>
                            <p class="text-gray-600">See how much you can save with automated billing</p>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">3x</div>
                                    <div class="roi-label">Faster Customer Onboarding</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">60%</div>
                                    <div class="roi-label">Reduction in Support Tickets</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">98%</div>
                                    <div class="roi-label">Payment Success Rate</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">6</div>
                                    <div class="roi-label">Months to Break Even</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- All Plans Include -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>All Plans Include</h2>
                    <p class="text-lg text-gray-600">Essential features included in every plan</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h6>Mobile Money Integration</h6>
                        <p class="text-sm text-gray-600">M-Pesa, Airtel Money, MTN MoMo</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6>RADIUS Authentication</h6>
                        <p class="text-sm text-gray-600">FreeRADIUS with AAA support</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <h6>Regular Updates</h6>
                        <p class="text-sm text-gray-600">Monthly platform updates</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h6>24/7 Support</h6>
                        <p class="text-sm text-gray-600">Email and chat support</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Enhanced Dynamic CTA -->
    <section class="py-5" style="background: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #2C5282 100%); position: relative; overflow: hidden;">
        <div class="container">
            <!-- Animated Background Elements -->
            <div class="position-absolute" style="top: 20%; left: 5%; width: 80px; height: 80px; background: radial-gradient(circle, rgba(212,175,55,0.15) 0%, transparent 70%); border-radius: 50%; animation: float 4s ease-in-out infinite;"></div>
            <div class="position-absolute" style="top: 70%; right: 10%; width: 120px; height: 120px; background: radial-gradient(circle, rgba(212,175,55,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 6s ease-in-out infinite reverse;"></div>
            
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2 class="text-white mb-4">Choose Your Perfect Plan</h2>
                    <p class="text-white-50 mb-4">Join thousands of ISPs across Africa who trust our platform for their billing operations.</p>
                    
                    <!-- Pricing Highlights -->
                    <div class="row g-3 mb-4">
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-dollar-sign text-white"></i>
                                </div>
                                <div>
                                    <strong>From $10/month</strong><br>
                                    <small class="text-white-50">Transparent pricing</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-info rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-rocket text-white"></i>
                                </div>
                                <div>
                                    <strong>3-Day Setup</strong><br>
                                    <small class="text-white-50">Quick deployment</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-warning rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-shield-alt text-dark"></i>
                                </div>
                                <div>
                                    <strong>99.9% Uptime</strong><br>
                                    <small class="text-white-50">Guaranteed SLA</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-danger rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-headset text-white"></i>
                                </div>
                                <div>
                                    <strong>24/7 Support</strong><br>
                                    <small class="text-white-50">Expert assistance</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#demo-section" class="btn btn-lg px-4 py-3" style="background: var(--gradient-gold); color: var(--black); font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(212,175,55,0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                            <i class="fas fa-play me-2"></i>Try Live Demo
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-light btn-lg px-4 py-3" style="border-radius: 8px; transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'" onmouseout="this.style.background='transparent'">
                            <i class="fas fa-envelope me-2"></i>Get Custom Quote
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Interactive Pricing Calculator -->
                    <div class="bg-white rounded-lg p-4 shadow-lg" style="border-radius: 12px;">
                        <div class="text-center mb-4">
                            <h5 class="text-dark">Quick Savings Calculator</h5>
                            <p class="text-muted small">See your potential monthly savings</p>
                        </div>
                        
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="text-center p-3 bg-light rounded">
                                    <div class="h4 text-success mb-1">$500</div>
                                    <small class="text-muted">Monthly Savings</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="text-center p-3 bg-light rounded">
                                    <div class="h4 text-info mb-1">35%</div>
                                    <small class="text-muted">Revenue Increase</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="text-center p-3 bg-light rounded">
                                    <div class="h4 text-warning mb-1">60%</div>
                                    <small class="text-muted">Less Support Tickets</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="text-center p-3 bg-light rounded">
                                    <div class="h4 text-primary mb-1">3x</div>
                                    <small class="text-muted">Faster Onboarding</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-center mt-4">
                            <a href="https://wa.me/254711503023" target="_blank" class="btn btn-success btn-sm">
                                <i class="fab fa-whatsapp me-1"></i>Chat with Sales
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Interactive Demo Section -->
    <section class="py-5" id="demo-section" style="background: linear-gradient(rgba(248,248,248,0.95), rgba(248,248,248,0.95)), url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2>Experience Glinta Africa Live</h2>
                    <p class="text-gray-600 mb-4">Get instant access to our complete ISP billing platform with real features and live data.</p>
                    
                    <!-- Demo Features -->
                    <div class="row g-3 mb-4">
                        <div class="col-12">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success me-3"></i>
                                <span>Live dashboard with real ISP metrics</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success me-3"></i>
                                <span>Mobile money integration demo</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success me-3"></i>
                                <span>Customer management features</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success me-3"></i>
                                <span>Network monitoring tools</span>
                            </div>
                        </div>
                    </div>
                    
                    <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-primary btn-lg px-5 py-3" style="border-radius: 8px; font-weight: 600; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(44,82,130,0.3)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                        <i class="fas fa-rocket me-2"></i>Launch Demo Dashboard
                    </a>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Dashboard Preview with Animation -->
                    <div class="position-relative">
                        <div class="bg-white rounded-lg shadow-lg p-3" style="border-radius: 12px; transform: perspective(1000px) rotateY(-10deg) rotateX(5deg);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-danger rounded-circle" style="width: 8px; height: 8px;"></div>
                                <div class="bg-warning rounded-circle mx-1" style="width: 8px; height: 8px;"></div>
                                <div class="bg-success rounded-circle" style="width: 8px; height: 8px;"></div>
                                <span class="ms-3 small text-muted">Live Demo Dashboard</span>
                            </div>
                            <img src="{$app_url}/ui/ui/images/dashboard-demo.png" alt="Live Demo Dashboard" class="img-fluid rounded" style="border: 1px solid #e9ecef;">
                            
                            <!-- Animated Play Button -->
                            <div class="position-absolute top-50 start-50 translate-middle">
                                <div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 70px; height: 70px; background: var(--gradient-gold); animation: pulse 2s infinite; cursor: pointer;" onclick="window.open('https://glintaafrica.com/admin', '_blank')">
                                    <i class="fas fa-play text-dark fs-4"></i>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Floating Info Cards -->
                        <div class="position-absolute" style="top: 10%; right: -20px; animation: float 3s ease-in-out infinite;">
                            <div class="bg-primary text-white px-3 py-2 rounded shadow" style="font-size: 0.75rem;">
                                <i class="fas fa-users me-1"></i>Live Users: 1,247
                            </div>
                        </div>
                        
                        <div class="position-absolute" style="bottom: 20%; left: -30px; animation: float 4s ease-in-out infinite reverse;">
                            <div class="bg-success text-white px-3 py-2 rounded shadow" style="font-size: 0.75rem;">
                                <i class="fas fa-dollar-sign me-1"></i>Revenue: KES 125K
                            </div>
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
                <div class="col-lg-4">
                    <h6>Glinta Africa</h6>
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management pricing for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-linkedin"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Plans</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/pricing">Starter Plan</a>
                        <a href="{$app_url}/pricing">Professional</a>
                        <a href="{$app_url}/pricing">Enterprise</a>
                        <a href="{$app_url}/pricing">Custom Solutions</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Features</a>
                        <a href="{$app_url}/services">Services</a>
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
                        <a href="mailto:watsonwambugu@yahoo.com">Email Sales</a>
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
                    <p class="text-sm text-gray-500 mb-0">Professional pricing for professional ISPs</p>
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

        // Animate ROI values
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const values = entry.target.querySelectorAll('.roi-value');
                    values.forEach(value => {
                        const text = value.textContent;
                        if (text.includes('x') || text.includes('%')) {
                            // Animate numeric values
                            const num = parseInt(text);
                            if (num) {
                                let current = 0;
                                const increment = num / 30;
                                const timer = setInterval(() => {
                                    current += increment;
                                    if (current >= num) {
                                        value.textContent = text;
                                        clearInterval(timer);
                                    } else {
                                        value.textContent = Math.floor(current) + text.replace(num, '');
                                    }
                                }, 50);
                            }
                        }
                    });
                }
            });
        });

        const roiSection = document.querySelector('.roi-calculator');
        if (roiSection) {
            observer.observe(roiSection);
        }
    </script>
</body>
</html>