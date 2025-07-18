<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Learn about Glinta Africa's mission to transform African telecommunications. Professional ISP billing solutions built for African markets with mobile money integration.">
    <meta name="keywords" content="Glinta Africa, ISP solutions, African telecommunications, mobile money billing, professional network management, enterprise ISP platform">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/about">
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="{$app_url}/ui/ui/images/favicon.svg">
    <link rel="icon" type="image/png" sizes="32x32" href="{$app_url}/ui/ui/images/favicon-32x32.png">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/favicon-32x32.png">
    <link rel="apple-touch-icon" sizes="180x180" href="{$app_url}/ui/ui/images/favicon-32x32.png">
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Manrope:wght@400;500;600;700&family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #1a365d;
            --primary-light: #2d5282;
            --primary-dark: #0f2a44;
            --accent: #d4af37;
            --accent-light: #f4e4c1;
            --accent-dark: #b8941f;
            --secondary: #4a5568;
            --success: #38a169;
            --warning: #ed8936;
            --danger: #e53e3e;
            --info: #3182ce;
            --light: #f7fafc;
            --dark: #1a202c;
            --gray-50: #fafafa;
            --gray-100: #f5f5f5;
            --gray-200: #e5e5e5;
            --gray-300: #d4d4d4;
            --gray-400: #a3a3a3;
            --gray-500: #737373;
            --gray-600: #525252;
            --gray-700: #404040;
            --gray-800: #262626;
            --gray-900: #171717;
            --gradient-primary: linear-gradient(135deg, #1a365d 0%, #2d5282 100%);
            --gradient-accent: linear-gradient(135deg, #d4af37 0%, #f4e4c1 100%);
            --gradient-hero: linear-gradient(135deg, #0f2a44 0%, #1a365d 50%, #2d5282 100%);
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
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
            color: var(--gray-700);
            background: var(--light);
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Professional Typography */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Manrope', sans-serif;
            font-weight: 600;
            line-height: 1.2;
            color: var(--dark);
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

        /* Hero Section */
        .hero {
            background: var(--gradient-hero);
            color: white;
            padding: 8rem 0 4rem;
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

        /* Stats Cards */
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .stats-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
            margin-bottom: 0.5rem;
        }

        .stats-label {
            font-weight: 500;
            color: var(--gray-700);
            font-size: 0.875rem;
        }

        /* Mission Section */
        .mission-section {
            background: var(--gray-50);
            padding: 4rem 0;
        }

        .mission-card {
            background: white;
            border-radius: 12px;
            padding: 3rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            text-align: center;
        }

        .mission-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 2rem;
        }

        /* Values Section */
        .value-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .value-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
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

        /* Timeline */
        .timeline {
            position: relative;
            padding: 2rem 0;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 2px;
            height: 100%;
            background: var(--gray-300);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 3rem;
        }

        .timeline-content {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            width: 45%;
        }

        .timeline-item:nth-child(odd) .timeline-content {
            margin-left: auto;
        }

        .timeline-item:nth-child(even) .timeline-content {
            margin-right: auto;
        }

        .timeline-badge {
            position: absolute;
            top: 1rem;
            left: 50%;
            transform: translateX(-50%);
            width: 40px;
            height: 40px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .timeline-year {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        /* Team Section */
        .team-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .team-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .team-avatar {
            width: 100px;
            height: 100px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
        }

        .team-name {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .team-role {
            color: var(--accent);
            font-weight: 500;
            font-size: 0.875rem;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Impact Section */
        .impact-section {
            background: var(--primary);
            color: white;
            padding: 4rem 0;
        }

        .impact-item {
            text-align: center;
            padding: 1.5rem;
        }

        .impact-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent);
            font-family: 'JetBrains Mono', monospace;
            margin-bottom: 0.5rem;
        }

        .impact-label {
            font-size: 0.875rem;
            color: rgba(255, 255, 255, 0.9);
        }

        /* CTA Section */
        .cta-section {
            background: var(--gray-50);
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

        /* Footer */
        .footer {
            background: var(--dark);
            color: var(--gray-300);
            padding: 3rem 0 1rem;
        }

        .footer h6 {
            color: white;
            margin-bottom: 1rem;
        }

        .footer a {
            color: var(--gray-400);
            text-decoration: none;
            font-size: 0.875rem;
            transition: color 0.2s ease;
        }

        .footer a:hover {
            color: var(--accent);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 6rem 0 3rem;
            }
            
            h1 { font-size: 2rem; }
            h2 { font-size: 1.75rem; }
            
            .timeline::before {
                left: 2rem;
            }
            
            .timeline-content {
                width: calc(100% - 5rem);
                margin-left: 5rem !important;
            }
            
            .timeline-badge {
                left: 2rem;
                transform: translateX(-50%);
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
                        <a class="btn btn-primary" href="https://glintaafrica.com/admin" target="_blank">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" style="position: relative; overflow: hidden;">
        <!-- Animated Floating Elements -->
        <div class="position-absolute" style="top: 15%; left: 10%; width: 120px; height: 120px; background: radial-gradient(circle, rgba(212,175,55,0.15) 0%, transparent 70%); border-radius: 50%; animation: float 7s ease-in-out infinite;"></div>
        <div class="position-absolute" style="top: 70%; right: 15%; width: 180px; height: 180px; background: radial-gradient(circle, rgba(212,175,55,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 9s ease-in-out infinite reverse;"></div>
        
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2">🌍 Meet the Team That <span style="color: var(--accent); animation: glow 2s ease-in-out infinite alternate;">Actually Gets It</span></h1>
                    <p class="lead">We're not your typical tech company 🤓<br>
We actually understand that African ISPs need solutions that work with M-Pesa, not Silicon Valley fantasies 💭</p>
                    
                    <!-- Fun Team Stats -->
                    <div class="row g-3 mb-4">
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1" style="color: var(--accent);">☕</div>
                                <small class="text-white">Coffee Addicts</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1" style="color: var(--accent);">🏠</div>
                                <small class="text-white">Africa Based</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3);">
                                <div class="h4 mb-1" style="color: var(--accent);">🎯</div>
                                <small class="text-white">Problem Solvers</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent btn-lg px-4 py-3" style="animation: pulse 2s infinite;" onmouseover="this.style.transform='scale(1.05) rotate(1deg)'; this.style.boxShadow='0 10px 30px rgba(212,175,55,0.4)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'; this.style.boxShadow='none'">
                            <i class="fas fa-rocket me-2"></i>🎮 Explore Platform
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary btn-lg px-4 py-3" style="transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'; this.innerHTML='<i class=\"fas fa-coffee me-2\"></i>☕ Let\'s Chat!'" onmouseout="this.style.background='transparent'; this.innerHTML='<i class=\"fas fa-envelope me-2\"></i>📧 Contact Us'">
                            <i class="fas fa-envelope me-2"></i>📧 Contact Us
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Team Illustration -->
                    <div class="position-relative">
                        <div class="bg-white rounded-lg p-4 shadow-lg" style="border-radius: 20px; transform: perspective(1000px) rotateY(-10deg) rotateX(5deg); transition: all 0.3s ease;" onmouseover="this.style.transform='perspective(1000px) rotateY(-5deg) rotateX(2deg) scale(1.02)'" onmouseout="this.style.transform='perspective(1000px) rotateY(-10deg) rotateX(5deg) scale(1)'">
                            <!-- Team Avatar Grid -->
                            <div class="row g-3">
                                <div class="col-6">
                                    <div class="team-mini-card text-center p-3 rounded" style="background: var(--gradient-primary); color: white;">
                                        <div class="h2 mb-2">👨‍💻</div>
                                        <small>Tech Lead</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="team-mini-card text-center p-3 rounded" style="background: var(--gradient-accent); color: var(--primary);">
                                        <div class="h2 mb-2">🎨</div>
                                        <small>UI/UX Guru</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="team-mini-card text-center p-3 rounded" style="background: var(--gradient-accent); color: var(--primary);">
                                        <div class="h2 mb-2">📊</div>
                                        <small>Data Wizard</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="team-mini-card text-center p-3 rounded" style="background: var(--gradient-primary); color: white;">
                                        <div class="h2 mb-2">🛡️</div>
                                        <small>Security Expert</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Floating Icons -->
                        <div class="position-absolute" style="top: 10%; right: -10px; animation: float 3s ease-in-out infinite; font-size: 2rem;">💡</div>
                        <div class="position-absolute" style="bottom: 20%; left: -20px; animation: float 4s ease-in-out infinite reverse; font-size: 2rem;">🚀</div>
                        <div class="position-absolute" style="top: 70%; right: 10%; animation: float 5s ease-in-out infinite; font-size: 1.5rem;">⭐</div>
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
            from { text-shadow: 0 0 10px var(--accent), 0 0 20px var(--accent), 0 0 30px var(--accent); }
            to { text-shadow: 0 0 20px var(--accent), 0 0 30px var(--accent), 0 0 40px var(--accent); }
        }
        .team-mini-card {
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .team-mini-card:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        </style>
    </section>

    <!-- Mission Section -->
    <section class="mission-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="mission-card" data-aos="fade-up">
                        <div class="mission-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <h2 class="mb-3">🎯 Our Mission (It's Pretty Cool)</h2>
                        <p class="text-lg text-gray-600 mb-4">Simple: Stop ISPs from pulling their hair out 😤<br>
Build software that actually works with how Africa does business - mobile money, prepaid everything, and "just make it work" mentality 💪</p>
                        <p class="text-gray-600">We believe internet should be as easy to sell as airtime ⚡ No more "the system is down" excuses or "payment didn't go through" headaches. Just smooth, reliable ISP operations that let you focus on growing your business (and maybe sleeping better at night) 😴</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>🏆 The Numbers Don't Lie</h2>
                    <p class="text-lg text-gray-600">These aren't just numbers - they're real ISPs making real money with zero stress 💰</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="stats-card">
                        <div class="stats-number" id="isps">150+</div>
                        <div class="stats-label">ISPs Deployed</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="stats-card">
                        <div class="stats-number" id="customers">500K+</div>
                        <div class="stats-label">End Users Served</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="stats-card">
                        <div class="stats-number" id="countries">15</div>
                        <div class="stats-label">African Countries</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="stats-card">
                        <div class="stats-number" id="uptime">99.9%</div>
                        <div class="stats-label">Platform Uptime</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Story Timeline -->
    <section class="py-5" style="background: white;">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>📖 How We Got Here (The Plot Twist Story)</h2>
                    <p class="text-lg text-gray-600">Spoiler alert: We actually started as ISP operators who got fed up with terrible software 🤬</p>
                </div>
            </div>
            <div class="timeline">
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-badge">2020</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2020</div>
                        <h5>🚀 "Enough is Enough!"</h5>
                        <p class="text-gray-600">Started because we were tired of ISP software that looked like it was built in 1999 😅 First platform that actually understood M-Pesa isn't just "another payment option" - it's THE payment option!</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left">
                    <div class="timeline-badge">2021</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2021</div>
                        <h5>🛡️ Getting Serious About Security</h5>
                        <p class="text-gray-600">Added enterprise-grade RADIUS because "trust me bro" isn't a valid authentication protocol 🔐 Now your network is more secure than most banks!</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-badge">2022</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2022</div>
                        <h5>🤖 Robots Take Over (The Good Kind)</h5>
                        <p class="text-gray-600">Automated all the boring stuff so ISPs can stop manually configuring routers at 2 AM ⏰ 60% less work = 60% more sleep = 100% happier ISP operators!</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left">
                    <div class="timeline-badge">2023</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2023</div>
                        <h5>💼 Going Full Enterprise Mode</h5>
                        <p class="text-gray-600">Added all the fancy enterprise stuff without the fancy enterprise prices 💸 Because why should only big telcos have nice things?</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-badge">2024</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2024</div>
                        <h5>🌟 Plot Twist: We're Actually Good At This</h5>
                        <p class="text-gray-600">Turns out listening to real ISPs and building what they actually need works! Who knew? 🤷‍♂️ Now we're in 15 countries and counting!</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-5" style="background: var(--gray-50);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>💎 Our Values (We Actually Mean These)</h2>
                    <p class="text-lg text-gray-600">No corporate buzzword bingo here - these are the real deal 🎯</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h5>🔧 Actually Good at Tech Stuff</h5>
                        <p class="text-sm text-gray-600">We write code that doesn't break at 3 AM 💻 Enterprise-grade doesn't mean enterprise-complicated. We keep it professional but not pretentious!</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-globe-africa"></i>
                        </div>
                        <h5>🌍 Africa First, Always</h5>
                        <p class="text-sm text-gray-600">We're not trying to "adapt" some American software for Africa 🙄 We built this FROM SCRATCH for how African ISPs actually work. M-Pesa isn't an afterthought - it's the main event!</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5>🔒 Fort Knox Level Security</h5>
                        <p class="text-sm text-gray-600">Your data is safer than your grandmother's secret recipe 👵 Bank-grade security without the bank-grade headaches. Sleep peacefully knowing hackers will find easier targets!</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>🤝 Humans Who Actually Help</h5>
                        <p class="text-sm text-gray-600">Real people, real solutions, real fast ⚡ No phone trees, no "have you tried turning it off and on again?" We actually know how to fix things!</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5>📈 Grows With Your Dreams</h5>
                        <p class="text-sm text-gray-600">Start small, dream big! 🚀 Whether you're running WiFi in one café or building the next Safaricom, our platform scales without breaking (or breaking the bank)!</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <h5>🔄 Always Getting Better</h5>
                        <p class="text-sm text-gray-600">We're constantly adding cool new features 🆕 Not because we're bored, but because ISPs keep asking for them. Customer feedback = our product roadmap!</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Impact Section -->
    <section class="impact-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 style="color: white;">📊 The Results Speak For Themselves</h2>
                    <p class="text-lg" style="color: rgba(255,255,255,0.9);">These aren't just pretty numbers - they're real ISPs making real money 💰</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="impact-item">
                        <div class="impact-number">98%</div>
                        <div class="impact-label">Payment Success Rate</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="impact-item">
                        <div class="impact-number">65%</div>
                        <div class="impact-label">Operational Cost Reduction</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="impact-item">
                        <div class="impact-number">3x</div>
                        <div class="impact-label">Faster Customer Onboarding</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="impact-item">
                        <div class="impact-number">24/7</div>
                        <div class="impact-label">Technical Support</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">🚀 Ready to Join the Cool Kids Club?</h2>
                    <p class="text-lg text-gray-600 mb-4">Stop struggling with software that fights you 🥊<br>
Let's chat about how we can make your ISP business actually fun to run! (Yes, that's possible) 😊</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-primary">
                            <i class="fas fa-envelope me-2"></i>Email: watsonwambugu@yahoo.com
                        </a>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn btn-accent">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp: +254 711 503 023
                        </a>
                    </div>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-outline-primary">
                            <i class="fas fa-external-link-alt me-2"></i>Explore Platform
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
                    <p class="text-sm mb-3" style="color: var(--accent);">Professional ISP billing and network management solutions for African telecommunications infrastructure. Enterprise-grade platform built for African markets.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Company</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/about">About Us</a>
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="#">Careers</a>
                        <a href="#">Press</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Features</a>
                        <a href="{$app_url}/services">Services</a>
                        <a href="{$app_url}/pricing">Pricing</a>
                        <a href="https://glintaafrica.com/admin" target="_blank">Dashboard</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Support</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="#">Documentation</a>
                        <a href="{$app_url}/contact">Contact</a>
                        <a href="#">API Reference</a>
                        <a href="#">System Status</a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6>Contact</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="mailto:watsonwambugu@yahoo.com">Technical Sales</a>
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
                    <p class="text-sm text-gray-500 mb-0">Professional solutions for African telecommunications</p>
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

        // Animate stats counters
        function animateCounter(element, target, suffix = '') {
            let current = 0;
            const increment = target / 100;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target + suffix;
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current) + suffix;
                }
            }, 20);
        }

        // Animate counters when they come into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const element = entry.target;
                    const text = element.textContent;
                    
                    if (text.includes('+')) {
                        const num = parseInt(text.replace(/[^\d]/g, ''));
                        const suffix = text.includes('K') ? 'K+' : '+';
                        animateCounter(element, num, suffix);
                    } else if (text.includes('%')) {
                        const num = parseFloat(text.replace('%', ''));
                        animateCounter(element, num, '%');
                    } else if (text.includes('x')) {
                        const num = parseInt(text.replace('x', ''));
                        animateCounter(element, num, 'x');
                    } else if (!isNaN(parseInt(text))) {
                        const num = parseInt(text);
                        animateCounter(element, num);
                    }
                }
            });
        });

        // Observe all stat numbers
        document.querySelectorAll('.stats-number, .impact-number').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>