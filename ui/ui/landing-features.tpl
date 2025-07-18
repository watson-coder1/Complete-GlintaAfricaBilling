<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Advanced features of Glinta Africa's enterprise ISP billing platform. Real-time monitoring, automated billing, mobile money integration, and comprehensive network management.">
    <meta name="keywords" content="ISP features, billing automation, mobile money, network monitoring, customer portal, hotspot management, RADIUS integration, enterprise features">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/features">
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
                        url('https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
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

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 70px;
            height: 70px;
            background: linear-gradient(45deg, var(--gold) 0%, var(--gold-light) 100%);
            opacity: 0.04;
            border-radius: 50%;
            transform: translate(20px, -20px);
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }
        
        .feature-card:hover::before {
            opacity: 0.1;
            transform: translate(15px, -15px) scale(1.3);
        }

        .feature-icon {
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

        .feature-title {
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--dark);
        }

        .feature-description {
            color: var(--gray-600);
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
            color: var(--gray-600);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .feature-list li:last-child {
            border-bottom: none;
        }

        .feature-list li i {
            color: var(--success);
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        /* Technical Demo Section */
        .demo-section {
            background: var(--gray-50);
            padding: 4rem 0;
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
            background: var(--gradient-primary);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
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
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
        }

        .metric-label {
            font-size: 0.875rem;
            color: var(--gray-600);
            margin-top: 0.5rem;
        }

        /* Code Demo */
        .code-demo {
            background: var(--dark);
            color: var(--gray-300);
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 6rem 0 3rem;
            }
            
            h1 { font-size: 2rem; }
            h2 { font-size: 1.75rem; }
            
            .feature-card {
                padding: 1.5rem;
            }
            
            .metrics-grid {
                grid-template-columns: repeat(2, 1fr);
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

    <!-- Enhanced Hero Section -->
    <section class="hero" style="background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center; position: relative; overflow: hidden;">
        <!-- Animated Background Elements -->
        <div class="position-absolute" style="top: 15%; left: 10%; width: 100px; height: 100px; background: radial-gradient(circle, rgba(212,175,55,0.15) 0%, transparent 70%); border-radius: 50%; animation: float 6s ease-in-out infinite;"></div>
        <div class="position-absolute" style="top: 70%; right: 15%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(212,175,55,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 8s ease-in-out infinite reverse;"></div>
        
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2 text-white">Enterprise Features</h1>
                    <p class="lead text-white-50">Advanced capabilities designed for professional ISP operations. Real-time monitoring, automated billing, and comprehensive network management.</p>
                    
                    <!-- Feature Highlights -->
                    <div class="row g-3 mb-4">
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-tachometer-alt text-white"></i>
                                </div>
                                <div>
                                    <strong>Real-time</strong><br>
                                    <small class="text-white-50">Live monitoring</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-mobile-alt text-white"></i>
                                </div>
                                <div>
                                    <strong>Mobile Money</strong><br>
                                    <small class="text-white-50">M-Pesa, Airtel</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-warning rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-network-wired text-dark"></i>
                                </div>
                                <div>
                                    <strong>Automation</strong><br>
                                    <small class="text-white-50">Network mgmt</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <div class="bg-info rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                    <i class="fas fa-shield-alt text-white"></i>
                                </div>
                                <div>
                                    <strong>Security</strong><br>
                                    <small class="text-white-50">Enterprise grade</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#demo-section" class="btn btn-lg px-4 py-3" style="background: var(--gradient-gold); color: var(--black); font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(212,175,55,0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                            <i class="fas fa-rocket me-2"></i>Try Live Features
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-light btn-lg px-4 py-3" style="border-radius: 8px; transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'" onmouseout="this.style.background='transparent'">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Feature Dashboard Preview -->
                    <div class="position-relative">
                        <div class="bg-white rounded-lg p-3 shadow-lg" style="border-radius: 12px; transform: perspective(1000px) rotateY(-5deg) rotateX(5deg);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-danger rounded-circle" style="width: 8px; height: 8px;"></div>
                                <div class="bg-warning rounded-circle mx-1" style="width: 8px; height: 8px;"></div>
                                <div class="bg-success rounded-circle" style="width: 8px; height: 8px;"></div>
                                <span class="ms-3 small text-muted">glintaafrica.com/admin</span>
                            </div>
                            <img src="{$app_url}/ui/ui/images/dashboard-demo.png" alt="Enterprise Features Dashboard" class="img-fluid rounded" style="border: 1px solid #e9ecef;">
                            
                            <!-- Animated Play Button -->
                            <div class="position-absolute top-50 start-50 translate-middle">
                                <div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px; background: var(--gradient-gold); animation: pulse 2s infinite; cursor: pointer;" onclick="window.open('https://glintaafrica.com/admin', '_blank')">
                                    <i class="fas fa-play text-dark"></i>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Floating Feature Tags -->
                        <div class="position-absolute" style="top: 15%; right: -20px; animation: float 3s ease-in-out infinite;">
                            <div class="bg-primary text-white px-3 py-2 rounded shadow" style="font-size: 0.75rem;">
                                <i class="fas fa-chart-line me-1"></i>Live Analytics
                            </div>
                        </div>
                        
                        <div class="position-absolute" style="bottom: 25%; left: -30px; animation: float 4s ease-in-out infinite reverse;">
                            <div class="bg-success text-white px-3 py-2 rounded shadow" style="font-size: 0.75rem;">
                                <i class="fas fa-mobile-alt me-1"></i>Mobile Integration
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Features -->
    <section class="py-5" style="background: linear-gradient(rgba(248,248,248,0.95), rgba(248,248,248,0.95)), url('https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="ISP Features" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2>Core Features</h2>
                    <p class="text-lg text-gray-600">Professional-grade capabilities for modern ISP operations</p>
                    <div class="row g-3 mt-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">6+</h4>
                                <small class="text-muted">Core Features</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">100%</h4>
                                <small class="text-muted">Automated</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Real-time Dashboard" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        <h5 class="feature-title">Real-time Dashboard</h5>
                        <p class="feature-description">Live monitoring with customizable widgets and performance metrics.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Real-time</span>
                            <span class="badge bg-light text-dark me-1">Analytics</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Automated Billing" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <h5 class="feature-title">Automated Billing</h5>
                        <p class="feature-description">Intelligent billing automation with flexible pricing and payment processing.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-primary text-white">Recurring</span>
                            <span class="badge bg-primary text-white">Tax Engine</span>
                            <span class="badge bg-primary text-white">Invoicing</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Automation</span>
                            <span class="badge bg-light text-dark me-1">Billing</span>
                            <span class="badge bg-light text-dark">Invoicing</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Mobile Money Integration" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="feature-title">Mobile Money Integration</h5>
                        <p class="feature-description">Native integration with African mobile money platforms.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-success text-white">M-Pesa</span>
                            <span class="badge bg-success text-white">Airtel Money</span>
                            <span class="badge bg-success text-white">MTN MoMo</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">API</span>
                            <span class="badge bg-light text-dark me-1">Webhooks</span>
                            <span class="badge bg-light text-dark">Real-time</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1544197150-b99a580bb7a8?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Network Automation" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h5 class="feature-title">Network Automation</h5>
                        <p class="feature-description">Automated network device management with bulk operations.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-info text-white">Mikrotik API</span>
                            <span class="badge bg-info text-white">UniFi</span>
                            <span class="badge bg-info text-white">SNMP</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">API</span>
                            <span class="badge bg-light text-dark me-1">SNMP</span>
                            <span class="badge bg-light text-dark">Automation</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1556761175-b413da4baf72?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Customer Management" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5 class="feature-title">Customer Management</h5>
                        <p class="feature-description">Comprehensive CRM with support tickets and communication tools.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-warning text-dark">Portal</span>
                            <span class="badge bg-warning text-dark">Tickets</span>
                            <span class="badge bg-warning text-dark">SMS</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">CRM</span>
                            <span class="badge bg-light text-dark me-1">Analytics</span>
                            <span class="badge bg-light text-dark">History</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Security & Compliance" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="feature-title">Security & Compliance</h5>
                        <p class="feature-description">Enterprise-grade security with compliance management and audit trails.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-danger text-white">RBAC</span>
                            <span class="badge bg-danger text-white">2FA</span>
                            <span class="badge bg-danger text-white">GDPR</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Security</span>
                            <span class="badge bg-light text-dark me-1">2FA</span>
                            <span class="badge bg-light text-dark">GDPR</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technical Demos -->
    <section class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Technical Capabilities</h2>
                    <p class="text-lg text-gray-600">Live demonstrations of system functionality</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="demo-card">
                        <div class="demo-header">
                            <div class="demo-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">Real-time Metrics</h6>
                                <small class="text-gray-600">Live system performance data</small>
                            </div>
                        </div>
                        <div style="height: 250px; width: 100%; position: relative;">
                            <canvas id="metricsChart"></canvas>
                        </div>
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
                                <small class="text-gray-600">Mobile money payment flow</small>
                            </div>
                        </div>
                        <div class="code-demo">
                            <div class="code-header">
                                <div class="code-dot red"></div>
                                <div class="code-dot yellow"></div>
                                <div class="code-dot green"></div>
                                <span class="text-xs text-gray-400 ms-2">payment_api.php</span>
                            </div>
                            <pre><code>// M-Pesa STK Push Integration
$payment = new MpesaAPI($config);
$response = $payment->stkPush([
    'amount' => 500,
    'phone' => '254711503023',
    'reference' => 'INV-001',
    'description' => 'Internet Package'
]);

if ($response['success']) {
    // Auto-provision service
    $radius->createUser($username, $password);
    $billing->activatePackage($userId, $packageId);
}</code></pre>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Performance Metrics -->
            <div class="metrics-grid" data-aos="fade-up" data-aos-delay="300">
                <div class="metric-item">
                    <div class="metric-value" id="activeUsers">1,247</div>
                    <div class="metric-label">Active Users</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="throughput">2.4 Gbps</div>
                    <div class="metric-label">Network Throughput</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="uptime">99.9%</div>
                    <div class="metric-label">System Uptime</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="transactions">4,891</div>
                    <div class="metric-label">Daily Transactions</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Integration Features -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>System Integrations</h2>
                    <p class="text-lg text-gray-600">Seamless integration with essential business systems</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6>RADIUS Server</h6>
                        <p class="text-sm text-gray-600">FreeRADIUS integration for authentication and accounting</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h6>Email & SMS</h6>
                        <p class="text-sm text-gray-600">Automated notifications and marketing campaigns</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h6>Analytics</h6>
                        <p class="text-sm text-gray-600">Advanced reporting with business intelligence</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h6>API Access</h6>
                        <p class="text-sm text-gray-600">RESTful API for custom integrations and development</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Dynamic Call to Action -->
    <section class="py-5" style="background: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #2C5282 100%); position: relative; overflow: hidden;">
        <div class="container">
            <!-- Animated Background Elements -->
            <div class="position-absolute" style="top: 10%; left: 10%; width: 100px; height: 100px; background: radial-gradient(circle, rgba(212,175,55,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 6s ease-in-out infinite;"></div>
            <div class="position-absolute" style="top: 60%; right: 15%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(212,175,55,0.08) 0%, transparent 70%); border-radius: 50%; animation: float 8s ease-in-out infinite reverse;"></div>
            
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2 class="text-white mb-4">Ready to Experience These Features?</h2>
                    <p class="text-white-50 mb-4">Get instant access to our live demo dashboard and explore all enterprise features in action.</p>
                    
                    <!-- Feature Highlights -->
                    <div class="row g-3 mb-4">
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <small>Live Dashboard Access</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <small>Real-time Features</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <small>Mobile Money Demo</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center text-white">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <small>Full Feature Set</small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#demo-section" class="btn btn-lg px-4 py-3" style="background: var(--gradient-gold); color: var(--black); font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(212,175,55,0.3)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                            <i class="fas fa-rocket me-2"></i>Launch Live Demo
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-light btn-lg px-4 py-3" style="border-radius: 8px; transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'" onmouseout="this.style.background='transparent'">
                            <i class="fas fa-envelope me-2"></i>Get Personalized Demo
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Interactive Dashboard Preview -->
                    <div class="position-relative">
                        <div class="bg-white rounded-lg p-4 shadow-lg" style="border-radius: 12px; transform: perspective(1000px) rotateY(-5deg) rotateX(5deg);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-danger rounded-circle" style="width: 8px; height: 8px;"></div>
                                <div class="bg-warning rounded-circle mx-1" style="width: 8px; height: 8px;"></div>
                                <div class="bg-success rounded-circle" style="width: 8px; height: 8px;"></div>
                                <span class="ms-3 small text-muted">glintaafrica.com/admin</span>
                            </div>
                            <img src="{$app_url}/ui/ui/images/dashboard-demo.png" alt="Live Demo Preview" class="img-fluid rounded" style="border: 1px solid #e9ecef;">
                            
                            <!-- Animated Pulse Effect -->
                            <div class="position-absolute top-50 start-50 translate-middle">
                                <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px; animation: pulse 2s infinite; background: var(--gradient-gold) !important;">
                                    <i class="fas fa-play text-white"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Add Custom Animations -->
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(212, 175, 55, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(212, 175, 55, 0); }
            100% { box-shadow: 0 0 0 0 rgba(212, 175, 55, 0); }
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>

    <!-- Demo Section -->
    <section class="py-5" id="demo-section" style="background: var(--gray-50);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2>Try Our Features</h2>
                    <p class="text-gray-600 mb-4">Experience all enterprise features with live dashboard access.</p>
                    <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-primary btn-lg">
                        <i class="fas fa-external-link-alt me-2"></i>Launch Demo Dashboard
                    </a>
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
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management features for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-linkedin"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Features</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Real-time Dashboard</a>
                        <a href="{$app_url}/features">Automated Billing</a>
                        <a href="{$app_url}/features">Mobile Money</a>
                        <a href="{$app_url}/features">Network Automation</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/services">Services</a>
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
                    <p class="text-sm text-gray-500 mb-0">Advanced features for professional ISPs</p>
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

        // Real-time metrics chart
        const ctx = document.getElementById('metricsChart').getContext('2d');
        const metricsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00', '24:00'],
                datasets: [{
                    label: 'Bandwidth (Mbps)',
                    data: [120, 90, 150, 280, 350, 420, 380],
                    borderColor: '#1a365d',
                    backgroundColor: 'rgba(26, 54, 93, 0.1)',
                    tension: 0.4,
                    fill: true
                }, {
                    label: 'Active Users',
                    data: [450, 320, 580, 890, 1200, 1450, 1380],
                    borderColor: '#d4af37',
                    backgroundColor: 'rgba(212, 175, 55, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    intersect: false,
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0,0,0,0.1)'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(0,0,0,0.1)'
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
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

        // Animate counters when section comes into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counters = entry.target.querySelectorAll('.metric-value');
                    counters.forEach(counter => {
                        const target = counter.textContent.replace(/[^\d]/g, '');
                        if (target) {
                            animateCounter(counter, parseInt(target));
                        }
                    });
                }
            });
        });

        observer.observe(document.querySelector('.metrics-grid'));

        // Live updates simulation
        setInterval(() => {
            const users = document.getElementById('activeUsers');
            const current = parseInt(users.textContent.replace(',', ''));
            const variation = Math.floor(Math.random() * 20) - 10;
            users.textContent = (current + variation).toLocaleString();
        }, 5000);
    </script>
</body>
</html>