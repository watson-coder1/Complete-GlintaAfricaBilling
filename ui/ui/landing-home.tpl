<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Enterprise-grade internet billing platform for African ISPs. Advanced hotspot management, automated billing, real-time analytics, and mobile money integration.">
    <meta name="keywords" content="ISP billing software, hotspot management, PPPoE billing, network operations, RADIUS integration, mobile money, African telecommunications">
    <meta name="author" content="Glinta Africa">
    <meta property="og:title" content="Glinta Africa - Enterprise ISP Billing Platform">
    <meta property="og:description" content="Professional-grade billing and network management solution for Internet Service Providers across Africa.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://glintaafrica.com">
    
    <link rel="canonical" href="https://glintaafrica.com">
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
    
    <!-- Chart.js for Technical Visualizations -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
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
        
        /* Custom Hamburger Menu */
        .navbar-toggler {
            padding: 0.25rem;
            background: none;
            border: none;
            outline: none;
        }
        
        .navbar-toggler:focus {
            box-shadow: none;
        }
        
        .navbar-toggler-icon {
            display: flex;
            flex-direction: column;
            width: 24px;
            height: 18px;
            position: relative;
            transform: rotate(0deg);
            transition: 0.3s ease-in-out;
        }
        
        .navbar-toggler-icon span {
            display: block;
            position: absolute;
            height: 3px;
            width: 100%;
            background: var(--black);
            border-radius: 3px;
            opacity: 1;
            left: 0;
            transform: rotate(0deg);
            transition: 0.25s ease-in-out;
        }
        
        .navbar-toggler-icon span:nth-child(1) {
            top: 0px;
        }
        
        .navbar-toggler-icon span:nth-child(2) {
            top: 7px;
        }
        
        .navbar-toggler-icon span:nth-child(3) {
            top: 14px;
        }
        
        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon span:nth-child(1) {
            top: 7px;
            transform: rotate(135deg);
        }
        
        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon span:nth-child(2) {
            opacity: 0;
            left: -24px;
        }
        
        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon span:nth-child(3) {
            top: 7px;
            transform: rotate(-135deg);
        }

        .nav-link {
            color: var(--black);
            font-weight: 500;
            font-size: 0.875rem;
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            color: var(--gold);
            background: var(--gold-light);
        }

        /* Hero Section with Tech Background */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
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
                radial-gradient(circle at 20% 80%, rgba(212, 175, 55, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(212, 175, 55, 0.12) 0%, transparent 50%);
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

        /* Feature Cards */
        .feature-card {
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

        .feature-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .feature-icon {
            width: 56px;
            height: 56px;
            background: var(--gradient-gold);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--black);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--black);
        }

        .feature-description {
            color: var(--gray);
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
        }

        .feature-list {
            list-style: none;
            padding: 0;
            margin-bottom: 1.5rem;
        }

        .feature-list li {
            padding: 0.5rem 0;
            color: var(--gray);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gold-light);
        }

        .feature-list li:last-child {
            border-bottom: none;
        }

        .feature-list li i {
            color: var(--gold);
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        /* Technical Demo Section with Pattern */
        .demo-section {
            background: linear-gradient(rgba(248, 248, 248, 0.95), rgba(248, 248, 248, 0.95)),
                        url('https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            padding: 4rem 0;
            position: relative;
        }

        .demo-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                repeating-linear-gradient(
                    45deg,
                    rgba(212, 175, 55, 0.03) 0px,
                    rgba(212, 175, 55, 0.03) 2px,
                    transparent 2px,
                    transparent 10px
                );
        }

        .demo-card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            height: 100%;
        }

        .demo-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .demo-icon {
            width: 40px;
            height: 40px;
            background: var(--gradient-gold);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--black);
            font-size: 1rem;
        }

        /* Metrics Section */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .metric-item {
            text-align: center;
            padding: 1.5rem;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--gray-200);
        }

        .metric-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--gold);
            font-family: 'JetBrains Mono', monospace;
        }

        .metric-label {
            font-size: 0.875rem;
            color: var(--gray);
            margin-top: 0.5rem;
        }

        /* Code Demo */
        .code-demo {
            background: var(--black);
            color: var(--white);
            border-radius: 8px;
            padding: 1rem;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            line-height: 1.4;
            overflow-x: auto;
        }

        .code-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--gray-700);
        }

        .code-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .code-dot.red { background: #ff5f57; }
        .code-dot.yellow { background: #ffbd2e; }
        .code-dot.green { background: #28ca42; }

        /* CTA Section */
        .cta-section {
            background: var(--gradient-black);
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
            background: var(--gradient-gold);
            color: var(--black);
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
        }

        .btn-outline-primary {
            border: 1px solid var(--gold);
            color: var(--gold);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--gold);
            color: var(--black);
        }

        .btn-accent {
            background: var(--gradient-gold);
            color: var(--black);
        }

        .btn-accent:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
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
            .container {
                padding-left: 1rem;
                padding-right: 1rem;
            }
            
            .hero {
                padding: 5rem 0 2rem;
                text-align: center;
            }
            
            .display-2 {
                font-size: 1.8rem;
                line-height: 1.3;
                margin-bottom: 1rem;
            }
            
            .lead {
                font-size: 1rem;
                margin-bottom: 1.5rem;
            }
            
            .hero .row {
                flex-direction: column-reverse;
            }
            
            .hero .col-lg-6:first-child {
                margin-top: 2rem;
            }
            
            .hero .row.g-3 .col-4 {
                flex: 0 0 50%;
                max-width: 50%;
            }
            
            .hero .row.g-3 .col-4:last-child {
                flex: 0 0 100%;
                max-width: 100%;
                margin-top: 1rem;
            }
            
            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
            
            .feature-card {
                padding: 1.25rem;
                margin-bottom: 1rem;
            }
            
            .feature-icon {
                font-size: 2rem;
            }
            
            .metrics-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .navbar-brand {
                font-size: 1.25rem;
            }
            
            .position-absolute {
                display: none !important;
            }
        }
        
        /* Tablets - Medium devices (768px and up) */
        @media (min-width: 576px) and (max-width: 991.98px) {
            .hero {
                padding: 6rem 0 3rem;
            }
            
            .display-2 {
                font-size: 2.5rem;
            }
            
            h1 { font-size: 2.25rem; }
            h2 { font-size: 1.875rem; }
            
            .feature-card {
                padding: 1.75rem;
            }
            
            .metrics-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 1.5rem;
            }
            
            .hero .row.g-3 .col-4 {
                flex: 0 0 33.333333%;
                max-width: 33.333333%;
            }
        }
        
        /* Large tablets and small laptops */
        @media (min-width: 992px) and (max-width: 1199.98px) {
            .hero {
                padding: 7rem 0 4rem;
            }
            
            .display-2 {
                font-size: 2.75rem;
            }
            
            .metrics-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        /* Extra large devices (1200px and up) */
        @media (min-width: 1200px) {
            .hero {
                padding: 8rem 0 5rem;
            }
            
            .display-2 {
                font-size: 3rem;
            }
            
            .metrics-grid {
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
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon">
                    <span></span>
                    <span></span>
                    <span></span>
                </span>
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
    <section class="hero" style="position: relative; overflow: hidden;">
        <!-- Animated Floating Elements -->
        <div class="position-absolute" style="top: 10%; left: 5%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(212,175,55,0.15) 0%, transparent 70%); border-radius: 50%; animation: float 8s ease-in-out infinite;"></div>
        <div class="position-absolute" style="top: 60%; right: 10%; width: 200px; height: 200px; background: radial-gradient(circle, rgba(44,82,130,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 10s ease-in-out infinite reverse;"></div>
        <div class="position-absolute" style="top: 30%; right: 20%; width: 100px; height: 100px; background: radial-gradient(circle, rgba(212,175,55,0.12) 0%, transparent 70%); border-radius: 50%; animation: float 6s ease-in-out infinite;"></div>
        
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2">Internet Billing Made <span style="color: var(--gold); animation: glow 2s ease-in-out infinite alternate;">Simple</span>!</h1>
                    <p class="lead">Because who said enterprise software has to be boring? 😴<br>
                    Professional ISP billing that actually makes you smile 😊</p>
                    
                    <!-- Fun Stats Bar -->
                    <div class="row g-3 mb-4">
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.1); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1" style="color: var(--gold);">⚡</div>
                                <small class="text-white">Lightning Fast</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.1); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1" style="color: var(--gold);"><i class="fas fa-bullseye"></i></div>
                                <small class="text-white">Dead Simple</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.1); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1" style="color: var(--gold);">💰</div>
                                <small class="text-white">Money Maker</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#demo-section" class="btn btn-accent btn-lg px-4 py-3" style="position: relative; overflow: hidden; animation: pulse 2s infinite;" onmouseover="this.style.transform='scale(1.05) rotate(1deg)'; this.style.boxShadow='0 10px 30px rgba(212,175,55,0.4)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'; this.style.boxShadow='none'">
                            <i class="fas fa-rocket me-2"></i>🎮 Play with Demo!
                        </a>
                        <a href="{$app_url}/contact" class="btn btn-outline-primary btn-lg px-4 py-3" style="transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'; this.innerHTML='<i class=\"fas fa-coffee me-2\"></i>☕ Let\'s Chat!'" onmouseout="this.style.background='transparent'; this.innerHTML='<i class=\"fas fa-phone me-2\"></i>📞 Contact Sales'">
                            <i class="fas fa-phone me-2"></i>📞 Contact Sales
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Interactive Dashboard Preview -->
                    <div class="position-relative">
                        <div class="bg-white rounded-lg p-4 shadow-lg" style="border-radius: 20px; transform: perspective(1000px) rotateY(-10deg) rotateX(5deg); transition: all 0.3s ease;" onmouseover="this.style.transform='perspective(1000px) rotateY(-5deg) rotateX(2deg) scale(1.02)'" onmouseout="this.style.transform='perspective(1000px) rotateY(-10deg) rotateX(5deg) scale(1)'">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-danger rounded-circle" style="width: 12px; height: 12px;"></div>
                                <div class="bg-warning rounded-circle mx-2" style="width: 12px; height: 12px;"></div>
                                <div class="bg-success rounded-circle" style="width: 12px; height: 12px;"></div>
                                <span class="ms-3 small text-muted">✨ glintaafrica.com/admin</span>
                            </div>
                            <img src="{$app_url}/ui/ui/images/dashboard-demo.png" alt="Look at this beautiful dashboard!" class="img-fluid rounded" style="border: 3px solid var(--gold);">
                            
                            <!-- Animated Play Button -->
                            <div class="position-absolute top-50 start-50 translate-middle" style="animation: bounce 2s infinite;">
                                <div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 80px; height: 80px; background: var(--gradient-gold); cursor: pointer; box-shadow: 0 10px 30px rgba(212,175,55,0.3);" onclick="window.location.href='{$app_url}/landing/contact'">
                                    <i class="fas fa-play text-dark" style="font-size: 1.5rem; margin-left: 5px;"></i>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Floating Emojis -->
                        <div class="position-absolute" style="top: 10%; right: -10px; animation: float 3s ease-in-out infinite; font-size: 2rem;">💻</div>
                        <div class="position-absolute" style="bottom: 20%; left: -20px; animation: float 4s ease-in-out infinite reverse; font-size: 2rem;"><i class="fas fa-chart-bar" style="color: var(--gold);"></i></div>
                        <div class="position-absolute" style="top: 70%; right: 10%; animation: float 5s ease-in-out infinite; font-size: 1.5rem;">🎉</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- CSS Animations -->
        <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        @keyframes glow {
            from { text-shadow: 0 0 10px var(--gold), 0 0 20px var(--gold), 0 0 30px var(--gold); }
            to { text-shadow: 0 0 20px var(--gold), 0 0 30px var(--gold), 0 0 40px var(--gold); }
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
        </style>
    </section>

    <!-- Visual Features Gallery -->
    <section class="py-5" style="background: linear-gradient(rgba(245,245,245,0.8), rgba(245,245,245,0.8)), url('https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover;">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12" data-aos="fade-up">
                    <h2>Why Our Users Actually <em>Love</em> Us</h2>
                    <p class="lead" style="color: var(--gray);">No more "Why is this so complicated?" moments 🤯</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card" style="transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='translateY(-10px) scale(1.02)'; this.style.boxShadow='0 20px 40px rgba(212,175,55,0.2)'" onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='var(--shadow-sm)'">
                        <div class="feature-icon">
                            📱
                        </div>
                        <h5 class="feature-title">Mobile Money Magic ✨</h5>
                        <p class="feature-description">M-Pesa, Airtel Money, MTN MoMo - we speak all the money languages! Your customers pay, boom 💥 - instant activation. No more "Did the payment go through?" anxiety 😅</p>
                        <div class="text-center mt-3">
                            <span class="badge" style="background: var(--gradient-gold); color: var(--black); font-size: 0.7rem;">Instant Activation</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card" style="transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='translateY(-10px) scale(1.02)'; this.style.boxShadow='0 20px 40px rgba(212,175,55,0.2)'" onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='var(--shadow-sm)'">
                        <div class="feature-icon">
                            📶
                        </div>
                        <h5 class="feature-title">WiFi on Autopilot 🤖</h5>
                        <p class="feature-description">Set it and forget it! Our system manages your hotspots like a boss. Bandwidth control? ✅ User limits? ✅ Your sanity? Preserved! 😌</p>
                        <div class="text-center mt-3">
                            <span class="badge" style="background: var(--gradient-gold); color: var(--black); font-size: 0.7rem;">Zero Stress</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card" style="transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='translateY(-10px) scale(1.02)'; this.style.boxShadow='0 20px 40px rgba(212,175,55,0.2)'" onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='var(--shadow-sm)'">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line" style="color: var(--gold);"></i>
                        </div>
                        <h5 class="feature-title">Analytics That Don't Suck 📈</h5>
                        <p class="feature-description">Pretty charts that actually mean something! Track everything in real-time without needing a PhD in Data Science 🎓</p>
                        <div class="text-center mt-3">
                            <span class="badge" style="background: var(--gradient-gold); color: var(--black); font-size: 0.7rem;">📈 Easy Insights</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card" style="transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='translateY(-10px) scale(1.02)'; this.style.boxShadow='0 20px 40px rgba(212,175,55,0.2)'" onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='var(--shadow-sm)'">
                        <div class="feature-icon">
                            🛡️
                        </div>
                        <h5 class="feature-title">Security? We Got You! 🔐</h5>
                        <p class="feature-description">Enterprise-grade RADIUS that's tougher than your grandmother's cookies 🍪. Your network stays locked down while you sleep peacefully 😴</p>
                        <div class="text-center mt-3">
                            <span class="badge" style="background: var(--gradient-gold); color: var(--black); font-size: 0.7rem;">🔒 Fort Knox Level</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Live Demo Section -->
    <section id="demo-section" class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>🎮 Take It for a Spin!</h2>
                    <p class="text-lg" style="color: var(--gray);">Warning: May cause uncontrollable excitement 😄</p>
                    <div class="d-flex justify-content-center gap-3 mb-4">
                        <span class="badge bg-primary">🔥 Live Data</span>
                        <span class="badge bg-success">⚡ Real Features</span>
                        <span class="badge bg-warning text-dark">Zero Setup</span>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-12" data-aos="fade-up">
                    <div class="demo-card text-center">
                        <img src="{$app_url}/ui/ui/images/dashboard-demo.png" 
                             alt="Live Dashboard Demo - Glinta Africa ISP Billing Platform" class="img-fluid rounded mb-4 shadow-lg" style="border: 2px solid var(--gold);">
                        <h4 id="demo-section">Your New Favorite Dashboard</h4>
                        <p style="color: var(--gray);">This isn't just a demo - it's a full-blown playground! Click around, break things (you can't actually break anything 😉), and see why our users never want to leave.</p>
                        <div class="row g-3 mb-4">
                            <div class="col-4">
                                <div class="text-center">
                                    <div class="h5 mb-1">⏱️</div>
                                    <small style="color: var(--gray);">5 min setup</small>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="text-center">
                                    <div class="h5 mb-1">🤝</div>
                                    <small style="color: var(--gray);">Human support</small>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="text-center">
                                    <div class="h5 mb-1">💸</div>
                                    <small style="color: var(--gray);">Fair pricing</small>
                                </div>
                            </div>
                        </div>
                        <a href="{$app_url}/landing/contact" class="btn btn-primary btn-lg" style="animation: wiggle 2s ease-in-out infinite;" onmouseover="this.innerHTML='<i class=\"fas fa-rocket me-2\"></i>🎉 Let\'s Gooo!'" onmouseout="this.innerHTML='<i class=\"fas fa-handshake me-2\"></i>💬 Contact Us'">
                            <i class="fas fa-handshake me-2"></i>💬 Contact Us
                        </a>
                        
                        <style>
                        @keyframes wiggle {
                            0%, 100% { transform: rotate(0deg); }
                            25% { transform: rotate(1deg); }
                            75% { transform: rotate(-1deg); }
                        }
                        </style>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="demo-card">
                        <div class="demo-header">
                            <div class="demo-icon">
                                <i class="fas fa-code"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">API Integration</h6>
                                <small style="color: var(--gray);">RESTful API for custom development</small>
                            </div>
                        </div>
                        <div class="code-demo">
                            <div class="code-header">
                                <div class="code-dot red"></div>
                                <div class="code-dot yellow"></div>
                                <div class="code-dot green"></div>
                                <span class="text-xs ms-2" style="color: var(--gray);">api_example.php</span>
                            </div>
                            <pre><code>// Create new hotspot user
$api = new GlintaAPI($apiKey);
$user = $api->createUser([
    'username' => 'john@example.com',
    'package' => 'daily_unlimited',
    'payment_method' => 'mpesa'
]);

// Auto-provision on payment
if ($payment->confirmed) {
    $radius->activateUser($user->id);
}</code></pre>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Success Metrics -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>🌍 We're Kind of a Big Deal</h2>
                    <p class="text-lg" style="color: var(--gray);">Not to brag, but we're powering ISPs from Cape Town to Cairo 🦁<br>
                    <small>(Okay, maybe we're bragging just a little 😏)</small></p>
                </div>
            </div>
            <div class="metrics-grid" data-aos="fade-up" data-aos-delay="200">
                <div class="metric-item">
                    <div class="metric-value" id="activeISPs">2,500+</div>
                    <div class="metric-label">Active ISPs</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="endUsers">850K+</div>
                    <div class="metric-label">End Users</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="uptime">99.9%</div>
                    <div class="metric-label">Uptime</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="countries">15+</div>
                    <div class="metric-label">Countries</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Use Cases with Images -->
    <section class="demo-section">
        <div class="container position-relative">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>We Fit Everywhere (Seriously!)</h2>
                    <p class="text-lg" style="color: var(--gray);">From "I just want WiFi in my café" to "I'm building the next Safaricom" 📡<br>
                    <small>We scale with your dreams (and your budget) 💰</small></p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1521017432531-fbd92d768814?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Café WiFi" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-coffee"></i>
                        </div>
                        <h5>☕ Café & Restaurant WiFi</h5>
                        <p class="text-sm" style="color: var(--gray);">Turn your café into a WiFi goldmine! ⚡ Time-based packages, instant M-Pesa payments, and happy customers who actually tip better when they have good internet 😉</p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Community Network" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-building"></i>
                        </div>
                        <h5>🏘️ Community Networks</h5>
                        <p class="text-sm" style="color: var(--gray);">Be the neighborhood hero! 🦸‍♂️ Connect everyone with centralized billing that actually works. No more chasing payments door-to-door 🚪</p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1577495508048-b635879837f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Enterprise ISP" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-city"></i>
                        </div>
                        <h5>🏢 Enterprise ISP</h5>
                        <p class="text-sm" style="color: var(--gray);">Go big or go home! Scale to thousands without breaking a sweat. PPPoE, RADIUS, automation - we've got all the fancy acronyms covered.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Ready to Join the Fun?</h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">Stop wrestling with complicated software 🤼‍♂️<br>
                    Life's too short for boring billing systems! Let's make your ISP business actually enjoyable 🎉</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="#demo-section" class="btn btn-accent">
                            <i class="fas fa-play me-2"></i>View Live Demo
                        </a>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn btn-outline-primary" style="color: white; border-color: white;">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp: +254 711 503 023
                        </a>
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
                    <p class="text-sm mb-3" style="color: rgba(255,255,255,0.8);">Professional ISP billing and network management platform designed for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-linkedin"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-github"></i></a>
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
                    <h6>Solutions</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/services">ISP Billing</a>
                        <a href="{$app_url}/services">Hotspot WiFi</a>
                        <a href="{$app_url}/services">Mobile Money</a>
                        <a href="{$app_url}/services">RADIUS Server</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Resources</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="#">Documentation</a>
                        <a href="{$app_url}/about">About</a>
                        <a href="#">Support</a>
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
            <hr class="my-4" style="border-color: rgba(212, 175, 55, 0.3);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="text-sm mb-0" style="color: rgba(255,255,255,0.7);">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-sm mb-0" style="color: rgba(255,255,255,0.7);">Built with excellence for African telecommunications</p>
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

        // Animate counter values
        function animateCounter(element, target) {
            let current = 0;
            const increment = target / 100;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target;
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current);
                }
            }, 20);
        }

        // Initialize metric animations on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const metrics = entry.target.querySelectorAll('.metric-value');
                    metrics.forEach(metric => {
                        const id = metric.id;
                        if (id === 'activeISPs') metric.textContent = '2,500+';
                        else if (id === 'endUsers') metric.textContent = '850K+';
                        else if (id === 'uptime') metric.textContent = '99.9%';
                        else if (id === 'countries') metric.textContent = '15+';
                    });
                    observer.unobserve(entry.target);
                }
            });
        });

        const metricsGrid = document.querySelector('.metrics-grid');
        if (metricsGrid) {
            observer.observe(metricsGrid);
        }
    </script>
</body>
</html>