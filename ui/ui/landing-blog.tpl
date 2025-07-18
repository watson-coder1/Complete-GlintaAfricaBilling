<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional insights on ISP management, network operations, and telecommunications technology. Expert analysis of African internet infrastructure and business strategies.">
    <meta name="keywords" content="ISP blog, network management, telecommunications, African internet, professional ISP solutions, enterprise network operations">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/blog">
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="{$app_url}/ui/ui/images/favicon.ico">
    <link rel="icon" type="image/png" sizes="32x32" href="{$app_url}/ui/ui/images/favicon.ico">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/favicon.ico">
    <link rel="apple-touch-icon" sizes="180x180" href="{$app_url}/ui/ui/images/favicon.ico">
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Manrope:wght@400;500;600;700&family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    
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
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 8rem 0 4rem;
            position: relative;
            overflow: hidden;
        }
        
        /* Animations */
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
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.8; }
            100% { opacity: 1; }
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

        /* Category Filter */
        .category-filter {
            background: var(--gray-50);
            padding: 2rem 0;
        }

        .category-btn {
            background: white;
            color: var(--gray-600);
            border: 1px solid var(--gray-200);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            margin: 0.25rem;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .category-btn:hover,
        .category-btn.active {
            background: var(--gradient-primary);
            color: white;
            border-color: var(--primary);
        }

        /* Blog Cards */
        .blog-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
        }

        .blog-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .blog-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .blog-card:hover .blog-image {
            transform: scale(1.05);
        }

        .blog-content {
            padding: 1.5rem;
        }

        .blog-category {
            background: var(--gradient-accent);
            color: var(--primary);
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .blog-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.75rem;
            line-height: 1.3;
        }

        .blog-excerpt {
            color: var(--gray-600);
            font-size: 0.875rem;
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .blog-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 0.75rem;
            color: var(--gray-500);
        }

        .blog-date {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .blog-read-time {
            color: var(--accent);
            font-weight: 500;
        }

        .blog-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .blog-link:hover {
            color: var(--primary-light);
            transform: translateX(2px);
        }

        /* Featured Post */
        .featured-post {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            margin-bottom: 3rem;
        }

        .featured-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .featured-content {
            padding: 2rem;
        }

        .featured-badge {
            background: var(--gradient-primary);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .featured-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 1rem;
        }

        .featured-excerpt {
            font-size: 1rem;
            color: var(--gray-600);
            margin-bottom: 1.5rem;
        }

        /* Newsletter Section */
        .newsletter-section {
            background: var(--primary);
            color: white;
            padding: 4rem 0;
        }

        .newsletter-form {
            max-width: 400px;
            margin: 0 auto;
        }

        .newsletter-input {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.75rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
        }

        .newsletter-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .newsletter-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(212, 175, 55, 0.2);
        }

        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 3rem;
        }

        .page-link {
            color: var(--primary);
            border: 1px solid var(--gray-200);
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
            border-radius: 6px;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }

        .page-link:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .page-item.active .page-link {
            background: var(--primary);
            border-color: var(--primary);
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
            color: var(--accent);
            margin-bottom: 1rem;
            font-weight: 700;
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

        /* Hero section enhancements */
        .hero-stat-box {
            background: rgba(212,175,55,0.15);
            border: 2px solid rgba(212,175,55,0.3);
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .hero-stat-box:hover {
            transform: scale(1.05);
            background: rgba(212,175,55,0.2);
        }
        
        .hero-btn {
            transition: all 0.3s ease;
        }
        
        .hero-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(212,175,55,0.3);
        }
        
        .hero-btn-outline {
            transition: all 0.3s ease;
        }
        
        .hero-btn-outline:hover {
            background: rgba(255,255,255,0.1);
        }
        
        .hero-image {
            transform: perspective(1000px) rotateY(-5deg);
            transition: all 0.3s ease;
        }
        
        .hero-image:hover {
            transform: perspective(1000px) rotateY(0deg) scale(1.02);
        }

        /* Enhanced Responsive Design for Blog */
        
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
            
            .blog-image {
                height: 160px;
            }
            
            .featured-image {
                height: 180px;
            }
            
            .featured-title {
                font-size: 1.3rem;
                line-height: 1.4;
            }
            
            .featured-excerpt {
                font-size: 0.9rem;
                line-height: 1.5;
            }
            
            .blog-title {
                font-size: 1.1rem;
                line-height: 1.4;
            }
            
            .blog-excerpt {
                font-size: 0.85rem;
                line-height: 1.4;
            }
            
            .category-btn {
                font-size: 0.8rem;
                padding: 0.4rem 0.8rem;
                margin: 0.2rem;
            }
            
            .featured-post .row {
                flex-direction: column;
            }
            
            .featured-content {
                padding: 1.5rem;
            }
            
            .position-absolute {
                display: none !important;
            }
            
            .hero-image {
                transform: none;
                margin-top: 1rem;
            }
            
            .newsletter-section {
                padding: 3rem 0;
            }
            
            .newsletter-form .input-group {
                flex-direction: column;
            }
            
            .newsletter-input {
                margin-bottom: 1rem;
                border-radius: 6px;
            }
            
            .footer .row {
                text-align: center;
            }
            
            .footer .col-lg-4, .footer .col-lg-2 {
                margin-bottom: 2rem;
            }
        }
        
        /* Tablets - Medium devices (768px and up) */
        @media (min-width: 576px) and (max-width: 991.98px) {
            .hero {
                padding: 6rem 0 3rem;
            }
            
            .display-2 {
                font-size: 2.2rem;
            }
            
            h1 { font-size: 2.25rem; }
            h2 { font-size: 1.875rem; }
            
            .blog-image {
                height: 200px;
            }
            
            .featured-image {
                height: 220px;
            }
            
            .featured-title {
                font-size: 1.6rem;
            }
            
            .hero .row.g-3 .col-4 {
                flex: 0 0 33.333333%;
                max-width: 33.333333%;
            }
            
            .category-btn {
                font-size: 0.85rem;
                padding: 0.5rem 1rem;
            }
        }
        
        /* Large tablets and small laptops */
        @media (min-width: 992px) and (max-width: 1199.98px) {
            .hero {
                padding: 7rem 0 4rem;
            }
            
            .display-2 {
                font-size: 2.5rem;
            }
            
            .blog-image {
                height: 220px;
            }
            
            .featured-image {
                height: 250px;
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
            
            .blog-image {
                height: 250px;
            }
            
            .featured-image {
                height: 300px;
            }
        }
        
        /* Custom hamburger menu for blog page */
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
        <div class="position-absolute" style="top: 70%; right: 10%; width: 200px; height: 200px; background: radial-gradient(circle, rgba(44,82,130,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 10s ease-in-out infinite reverse;"></div>
        
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2">The ISP <span style="color: var(--gold); animation: glow 2s ease-in-out infinite alternate;">Knowledge Hub</span></h1>
                    <p class="lead">Expert insights and practical solutions for Internet Service Providers across Africa.<br>
Real stories, proven strategies, and breakthrough moments from industry professionals.<br>
<small style="color: rgba(255,255,255,0.8); font-style: italic;">Professional guidance for modern ISP operations</small></p>
                    
                    <!-- Blog Stats -->
                    <div class="row g-3 mb-4">
                        <div class="col-4">
                            <div class="text-center p-3 rounded hero-stat-box">
                                <div class="h4 mb-1" style="color: var(--gold);">📚</div>
                                <small class="text-white">50+ Articles</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded hero-stat-box">
                                <div class="h4 mb-1" style="color: var(--gold);">⚡</div>
                                <small class="text-white">Expert Insights</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded hero-stat-box">
                                <div class="h4 mb-1" style="color: var(--gold);"><i class="fas fa-bullseye"></i></div>
                                <small class="text-white">Practical Solutions</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#latest-posts" class="btn btn-accent btn-lg px-4 py-3 hero-btn">
                            <i class="fas fa-book-reader me-2"></i>Explore Articles
                        </a>
                        <a href="#newsletter" class="btn btn-outline-primary btn-lg px-4 py-3 hero-btn-outline">
                            <i class="fas fa-envelope me-2"></i>Subscribe
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Blog Visual -->
                    <div class="position-relative">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                             alt="Blog Reading and Learning" class="img-fluid rounded shadow-lg hero-image">
                        
                        <!-- Animated Blog Topics -->
                        <div class="position-absolute top-0 start-0 m-3 bg-success text-white rounded p-2 shadow" style="animation: bounce 3s infinite;">
                            <small>🔥 Hot Topics</small>
                        </div>
                        <div class="position-absolute bottom-0 end-0 m-3 bg-warning text-dark rounded p-2 shadow" style="animation: bounce 4s infinite reverse;">
                            <small>💡 ISP Tips</small>
                        </div>
                        
                        <!-- Floating Icons -->
                        <div class="position-absolute" style="top: 20%; right: -30px; animation: float 3s ease-in-out infinite; font-size: 2rem;">📝</div>
                        <div class="position-absolute" style="bottom: 30%; left: -30px; animation: float 4s ease-in-out infinite reverse; font-size: 2rem;">💭</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Category Filter -->
    <section class="category-filter">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <div class="mb-3">
                        <h6 class="text-gray-600 mb-3">Filter by Category</h6>
                        <a href="#" class="category-btn active">All Posts</a>
                        <a href="#" class="category-btn">Network Operations</a>
                        <a href="#" class="category-btn">Enterprise Solutions</a>
                        <a href="#" class="category-btn">Security</a>
                        <a href="#" class="category-btn">Technology Trends</a>
                        <a href="#" class="category-btn">Industry Analysis</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Post -->
    <section class="py-5">
        <div class="container">
            <div class="featured-post" data-aos="fade-up">
                <div class="row g-0">
                    <div class="col-md-6">
                        <img src="https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Team Working on ISP Solutions" class="featured-image">
                    </div>
                    <div class="col-md-6">
                        <div class="featured-content">
                            <div class="featured-badge">Featured Article</div>
                            <h2 class="featured-title">Building Africa's Leading ISP Management Platform</h2>
                            <p class="featured-excerpt">
                                A comprehensive guide to transforming internet service operations through advanced billing systems, mobile money integration, and automated network management. Learn from real-world implementations and proven strategies for scaling ISP businesses across Africa.
                            </p>
                            
                            <!-- Key Insight -->
                            <div class="alert alert-info d-flex align-items-center mb-3" style="background: rgba(212,175,55,0.1); border: 1px solid var(--accent); border-left: 4px solid var(--accent);">
                                <i class="fas fa-lightbulb text-warning me-2"></i>
                                <small><strong>Key Insight:</strong> Successful ISP platforms require seamless integration of billing, authentication, and customer management systems.</small>
                            </div>
                            <div class="blog-meta mb-3">
                                <div class="blog-date">
                                    <i class="fas fa-calendar text-gray-400"></i>
                                    <span>January 15, 2025</span>
                                </div>
                                <div class="blog-read-time">12 min read</div>
                            </div>
                            <a href="{$app_url}/blog/future-isp-africa" class="blog-link">
                                Read Full Article <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Blog Posts -->
    <section class="pb-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <article class="blog-card">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1510915361894-db8b60106cb1?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Security" class="blog-image">
                            <div class="position-absolute top-0 end-0 m-3">
                                <span class="badge bg-danger">🔥 Hot Topic</span>
                            </div>
                        </div>
                        <div class="blog-content">
                            <div class="blog-category">Security</div>
                            <h3 class="blog-title">RADIUS Security: Advanced Network Authentication and Access Control</h3>
                            <p class="blog-excerpt">
                                Comprehensive security implementation strategies for RADIUS authentication systems, including best practices for user management and network access control.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Jan 10, 2025</span>
                                </div>
                                <div class="blog-read-time">8 min read</div>
                            </div>
                            <a href="{$app_url}/blog/radius-security-guide" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>


                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <article class="blog-card">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Payment Integration" class="blog-image">
                            <div class="position-absolute top-0 end-0 m-3">
                                <span class="badge bg-success">💰 Money Magic</span>
                            </div>
                        </div>
                        <div class="blog-content">
                            <div class="blog-category">Technology Trends</div>
                            <h3 class="blog-title">M-Pesa Integration: Seamless Mobile Money Payment Processing</h3>
                            <p class="blog-excerpt">
                                Technical implementation guide for M-Pesa payment gateway integration, including API setup, callback handling, and automated service activation.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 28, 2024</span>
                                </div>
                                <div class="blog-read-time">15 min read</div>
                            </div>
                            <a href="{$app_url}/blog/mpesa-integration-guide" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <article class="blog-card">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1551808525-51a94da548ce?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Analytics" class="blog-image">
                            <div class="position-absolute bottom-0 start-0 m-3">
                                <span class="badge bg-info">📈 Data Nerd Alert</span>
                            </div>
                        </div>
                        <div class="blog-content">
                            <div class="blog-category">Enterprise Solutions</div>
                            <h3 class="blog-title">Network Analytics: InfluxDB and Grafana for ISP Monitoring</h3>
                            <p class="blog-excerpt">
                                Building enterprise-grade network monitoring dashboards with InfluxDB time-series data and Grafana visualization.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 20, 2024</span>
                                </div>
                                <div class="blog-read-time">12 min read</div>
                            </div>
                            <a href="{$app_url}/blog/network-analytics-influxdb-grafana" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <article class="blog-card">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1518432031352-d6fc5c10da5a?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Automation" class="blog-image">
                            <div class="position-absolute top-0 start-0 m-3">
                                <span class="badge bg-warning text-dark">🤖 Automation Magic</span>
                            </div>
                        </div>
                        <div class="blog-content">
                            <div class="blog-category">Network Operations</div>
                            <h3 class="blog-title">Network Automation: Mikrotik RouterOS API Programming</h3>
                            <p class="blog-excerpt">
                                Advanced automation techniques for Mikrotik RouterOS using API programming for bulk user management and configuration.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 15, 2024</span>
                                </div>
                                <div class="blog-read-time">9 min read</div>
                            </div>
                            <a href="{$app_url}/blog/mikrotik-routeros-api-automation" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <article class="blog-card">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Industry Analysis" class="blog-image">
                            <div class="position-absolute bottom-0 end-0 m-3">
                                <span class="badge bg-dark">Market Intel</span>
                            </div>
                        </div>
                        <div class="blog-content">
                            <div class="blog-category">Industry Analysis</div>
                            <h3 class="blog-title">African Telecommunications Market: 2025 Industry Report</h3>
                            <p class="blog-excerpt">
                                Comprehensive analysis of African telecommunications markets, regulatory environments, and growth opportunities for professional ISPs.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 10, 2024</span>
                                </div>
                                <div class="blog-read-time">20 min read</div>
                            </div>
                            <a href="{$app_url}/blog/kenya-internet-market-2025" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="700">
                    <article class="blog-card">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1547036967-23d11aacaee0?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Future of African ISPs" class="blog-image">
                            <div class="position-absolute top-0 end-0 m-3">
                                <span class="badge bg-success">Future Vision</span>
                            </div>
                        </div>
                        <div class="blog-content">
                            <div class="blog-category">ISP Business</div>
                            <h3 class="blog-title">The Future of Internet Service Provision in Africa</h3>
                            <p class="blog-excerpt">
                                Discover how African ISPs are revolutionizing internet access with innovative billing solutions, mobile money integration, and community-focused approaches.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 15, 2024</span>
                                </div>
                                <div class="blog-read-time">5 min read</div>
                            </div>
                            <a href="{$app_url}/blog/future-isp-africa" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>
            </div>

            <!-- Pagination -->
            <nav aria-label="Blog pagination">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    <li class="page-item active">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </section>

    <!-- Dynamic Content Section -->
    <section class="py-5" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
        <div class="container">
            <div class="row g-4">
                <!-- Real-time Stats -->
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="mb-3">
                            <i class="fas fa-users fa-2x" style="color: var(--accent);"></i>
                        </div>
                        <h4 class="h5 mb-2">Active ISPs</h4>
                        <div class="h3 mb-2" style="color: var(--primary); font-weight: 700;" id="active-isps">2,450+</div>
                        <small class="text-muted">Growing daily across Africa</small>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="mb-3">
                            <i class="fas fa-globe-africa fa-2x" style="color: var(--accent);"></i>
                        </div>
                        <h4 class="h5 mb-2">Connected Users</h4>
                        <div class="h3 mb-2" style="color: var(--primary); font-weight: 700;" id="connected-users">180,000+</div>
                        <small class="text-muted">Online right now</small>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="mb-3">
                            <i class="fas fa-chart-line fa-2x" style="color: var(--accent);"></i>
                        </div>
                        <h4 class="h5 mb-2">Data Processed</h4>
                        <div class="h3 mb-2" style="color: var(--primary); font-weight: 700;" id="data-processed">45.2 TB</div>
                        <small class="text-muted">This month</small>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="mb-3">
                            <i class="fas fa-clock fa-2x" style="color: var(--accent);"></i>
                        </div>
                        <h4 class="h5 mb-2">Uptime</h4>
                        <div class="h3 mb-2" style="color: var(--primary); font-weight: 700;" id="uptime">99.9%</div>
                        <small class="text-muted">Last 30 days</small>
                    </div>
                </div>
            </div>
            
            <!-- Featured Resources -->
            <div class="row mt-5">
                <div class="col-12 text-center mb-4">
                    <h3>Featured Resources</h3>
                    <p class="text-muted">Essential tools and guides for ISP professionals</p>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-download fa-2x" style="color: var(--accent);"></i>
                            </div>
                            <h5 class="card-title">API Documentation</h5>
                            <p class="card-text">Complete integration guide for developers</p>
                            <a href="#" class="btn btn-outline-primary btn-sm">Download PDF</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-video fa-2x" style="color: var(--accent);"></i>
                            </div>
                            <h5 class="card-title">Video Tutorials</h5>
                            <p class="card-text">Step-by-step setup and configuration</p>
                            <a href="#" class="btn btn-outline-primary btn-sm">Watch Now</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-comments fa-2x" style="color: var(--accent);"></i>
                            </div>
                            <h5 class="card-title">Community Forum</h5>
                            <p class="card-text">Connect with other ISP professionals</p>
                            <a href="#" class="btn btn-outline-primary btn-sm">Join Discussion</a>
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
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">
                        <span id="newsletter-title">Stay Updated on ISP Technology</span>
                        <div class="small mt-2" style="color: rgba(255,255,255,0.7);">
                            <i class="fas fa-users me-1"></i><span id="subscriber-count">12,500+</span> professionals already subscribed
                        </div>
                    </h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">
                        Get the latest insights on network operations, security, and telecommunications technology delivered to your inbox.
                        <br><strong>Weekly digest</strong> • <strong>Expert analysis</strong> • <strong>Industry news</strong>
                    </p>
                    <div class="newsletter-form">
                        <div class="input-group">
                            <input type="email" class="form-control newsletter-input" placeholder="Enter your email address" required>
                            <button class="btn btn-accent" type="submit">
                                <i class="fas fa-paper-plane me-2"></i>Subscribe
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <p class="text-sm" style="color: rgba(255,255,255,0.7);">
                            For technical inquiries: 
                            <a href="mailto:watsonwambugu@yahoo.com" style="color: var(--accent);">watsonwambugu@yahoo.com</a> | 
                            <a href="https://wa.me/254711503023" target="_blank" style="color: var(--accent);">WhatsApp: +254 711 503 023</a>
                        </p>
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
                    <p class="text-sm mb-3" style="color: var(--accent);">Professional ISP solutions and technical insights for African telecommunications. Expert analysis of network operations and enterprise technology.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Categories</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="#">Network Operations</a>
                        <a href="#">Enterprise Solutions</a>
                        <a href="#">Security</a>
                        <a href="#">Technology Trends</a>
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
                        <a href="{$app_url}/about">About</a>
                        <a href="#">API Reference</a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6>Contact</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="mailto:watsonwambugu@yahoo.com">Technical Team</a>
                        <a href="https://wa.me/254711503023" target="_blank">WhatsApp</a>
                        <a href="{$app_url}/contact">Contact Form</a>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: var(--gray-700);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="text-sm text-gray-500 mb-0">&copy; 2025 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-sm mb-0" style="color: var(--accent);">Professional insights for African telecommunications</p>
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

        // Category filter functionality
        document.querySelectorAll('.category-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Remove active class from all buttons
                document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Here you could add filtering logic for blog posts
                console.log('Filter by:', this.textContent);
            });
        });

        // Newsletter form submission
        document.querySelector('.newsletter-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            if (email) {
                // Here you would handle the newsletter subscription
                alert('Thank you for subscribing to our technical insights!');
                this.reset();
            }
        });
        
        // Dynamic stats animation
        function animateStats() {
            const stats = [
                { id: 'active-isps', target: 2450, suffix: '+' },
                { id: 'connected-users', target: 180000, suffix: '+' },
                { id: 'data-processed', target: 45.2, suffix: ' TB' },
                { id: 'uptime', target: 99.9, suffix: '%' }
            ];
            
            stats.forEach(stat => {
                const element = document.getElementById(stat.id);
                if (element) {
                    let current = 0;
                    const increment = stat.target / 100;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= stat.target) {
                            current = stat.target;
                            clearInterval(timer);
                        }
                        
                        if (stat.id === 'data-processed') {
                            element.textContent = current.toFixed(1) + stat.suffix;
                        } else if (stat.id === 'uptime') {
                            element.textContent = current.toFixed(1) + stat.suffix;
                        } else {
                            element.textContent = Math.floor(current).toLocaleString() + stat.suffix;
                        }
                    }, 20);
                }
            });
        }
        
        // Dynamic newsletter titles
        const newsletterTitles = [
            'Stay Updated on ISP Technology',
            'Get Expert ISP Insights',
            'Join the ISP Knowledge Network',
            'Master ISP Operations'
        ];
        
        function rotateNewsletterTitle() {
            const titleElement = document.getElementById('newsletter-title');
            if (titleElement && newsletterTitles.length > 0) {
                let currentIndex = 0;
                setInterval(() => {
                    titleElement.style.opacity = '0';
                    setTimeout(() => {
                        currentIndex = (currentIndex + 1) % newsletterTitles.length;
                        titleElement.textContent = newsletterTitles[currentIndex];
                        titleElement.style.opacity = '1';
                    }, 300);
                }, 4000);
            }
        }
        
        // Dynamic subscriber count
        function updateSubscriberCount() {
            const countElement = document.getElementById('subscriber-count');
            if (countElement) {
                let count = 12500;
                setInterval(() => {
                    count += Math.floor(Math.random() * 3) + 1;
                    countElement.textContent = count.toLocaleString() + '+';
                }, 30000); // Update every 30 seconds
            }
        }
        
        // Initialize dynamic features
        setTimeout(() => {
            animateStats();
            rotateNewsletterTitle();
            updateSubscriberCount();
        }, 1000);
    </script>
</body>
</html>