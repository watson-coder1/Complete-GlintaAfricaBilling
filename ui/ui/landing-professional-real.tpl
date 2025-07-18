<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional WiFi billing solutions for hotels, restaurants, and businesses. Trusted by 5,000+ establishments across Africa.">
    <meta name="keywords" content="wifi billing, hotspot management, restaurant wifi, hotel internet, business wifi solutions">
    
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #f39c12;
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
            --bg-light: #f8f9fa;
            --white: #ffffff;
            --success: #27ae60;
            --info: #3498db;
            --warning: #f39c12;
            --danger: #e74c3c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
            overflow-x: hidden;
        }

        .section {
            padding: 80px 0;
        }

        .section-sm {
            padding: 60px 0;
        }

        /* Typography */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            line-height: 1.2;
            color: var(--text-dark);
        }

        .display-4 {
            font-size: 3.5rem;
            font-weight: 700;
        }

        .lead {
            font-size: 1.25rem;
            font-weight: 400;
            color: var(--text-light);
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color) !important;
            text-decoration: none;
        }

        .navbar-nav .nav-link {
            font-weight: 500;
            color: var(--text-dark) !important;
            margin: 0 0.5rem;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--accent-color) !important;
        }

        .btn-primary {
            background: var(--accent-color);
            border-color: var(--accent-color);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: #e67e22;
            border-color: #e67e22;
            transform: translateY(-2px);
        }

        .btn-outline-primary {
            color: var(--accent-color);
            border-color: var(--accent-color);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
        }

        .btn-outline-primary:hover {
            background: var(--accent-color);
            border-color: var(--accent-color);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 120px 0 100px;
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
            background: url('https://images.unsplash.com/photo-1556075798-4825dfaaf498?ixlib=rb-4.0.3&auto=format&fit=crop&w=2076&q=80') center/cover;
            opacity: 0.1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            color: white;
            margin-bottom: 1.5rem;
            font-size: 3.5rem;
            font-weight: 700;
        }

        .hero .lead {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            font-size: 1.3rem;
        }

        .hero-stats {
            margin-top: 3rem;
            padding-top: 3rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }

        .hero-stat {
            text-align: center;
            margin-bottom: 2rem;
        }

        .hero-stat h3 {
            color: var(--accent-color);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .hero-stat p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
        }

        /* Features Section */
        .features {
            background: var(--bg-light);
        }

        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            border: 1px solid #e9ecef;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: var(--accent-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }

        .feature-icon i {
            font-size: 2rem;
            color: white;
        }

        .feature-card h4 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--text-dark);
        }

        .feature-card p {
            color: var(--text-light);
            line-height: 1.7;
        }

        /* About Section */
        .about-img {
            border-radius: 12px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .about h2 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
        }

        .about p {
            font-size: 1.1rem;
            color: var(--text-light);
            margin-bottom: 1.5rem;
        }

        .check-list {
            list-style: none;
            padding: 0;
        }

        .check-list li {
            padding: 0.5rem 0;
            color: var(--text-light);
            position: relative;
            padding-left: 2rem;
        }

        .check-list li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: var(--success);
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* Solutions Section */
        .solutions {
            background: white;
        }

        .solution-card {
            background: var(--bg-light);
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }

        .solution-card:hover {
            background: white;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            transform: translateY(-5px);
        }

        .solution-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        /* Pricing Section */
        .pricing {
            background: var(--bg-light);
        }

        .pricing-card {
            background: white;
            border-radius: 12px;
            padding: 2.5rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
            border: 1px solid #e9ecef;
        }

        .pricing-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .pricing-card.popular {
            border-color: var(--accent-color);
            transform: scale(1.05);
        }

        .pricing-card.popular::before {
            content: 'Most Popular';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--accent-color);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .pricing-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .pricing-card .price {
            font-size: 3rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 0.5rem;
        }

        .pricing-card .price-period {
            color: var(--text-light);
            margin-bottom: 2rem;
        }

        .pricing-features {
            list-style: none;
            padding: 0;
            margin-bottom: 2rem;
        }

        .pricing-features li {
            padding: 0.5rem 0;
            color: var(--text-light);
            border-bottom: 1px solid #f8f9fa;
        }

        /* Contact Section */
        .contact {
            background: var(--primary-color);
            color: white;
        }

        .contact h2 {
            color: white;
            margin-bottom: 1.5rem;
        }

        .contact-info {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .contact-info h5 {
            color: var(--accent-color);
            margin-bottom: 1rem;
        }

        .contact-info p {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 0.5rem;
        }

        .contact-info a {
            color: var(--accent-color);
            text-decoration: none;
        }

        .contact-info a:hover {
            color: white;
        }

        /* Footer */
        .footer {
            background: var(--text-dark);
            color: white;
            padding: 3rem 0 1rem;
        }

        .footer h5 {
            color: var(--accent-color);
            margin-bottom: 1rem;
        }

        .footer p, .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
        }

        .footer a:hover {
            color: var(--accent-color);
        }

        .footer-bottom {
            border-top: 1px solid #34495e;
            padding-top: 1.5rem;
            margin-top: 2rem;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .display-4 {
                font-size: 2.5rem;
            }

            .section {
                padding: 60px 0;
            }

            .pricing-card.popular {
                transform: none;
            }

            .hero-stat h3 {
                font-size: 2rem;
            }
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Custom Utilities */
        .text-accent {
            color: var(--accent-color) !important;
        }

        .bg-accent {
            background-color: var(--accent-color) !important;
        }

        .border-accent {
            border-color: var(--accent-color) !important;
        }

        /* Image Styling */
        .img-shadow {
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        /* Animation */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}">Glinta Africa</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#solutions">Solutions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-primary btn-sm" href="{$app_url}/landing/contact">Contact</a>
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
                        <h1 class="display-4">Professional WiFi Billing Solutions</h1>
                        <p class="lead">Transform your business WiFi into a revenue stream. Trusted by hotels, restaurants, and cafes across Africa.</p>
                        <div class="mt-4">
                            <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20learn%20more%20about%20your%20WiFi%20billing%20solutions" class="btn btn-primary btn-lg me-3" target="_blank">Get Started</a>
                            <a href="{$app_url}/landing/contact" class="btn btn-outline-light btn-lg">Request Demo</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="hero-stats">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="hero-stat">
                                    <h3>5,000+</h3>
                                    <p>Businesses Trust Us</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="hero-stat">
                                    <h3>50+</h3>
                                    <p>Countries Served</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="hero-stat">
                                    <h3>99.9%</h3>
                                    <p>Uptime Guarantee</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="section features">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-5 mb-4">Why Choose Glinta Africa?</h2>
                    <p class="lead">Our comprehensive WiFi billing platform is designed specifically for African businesses, with local payment integration and 24/7 support.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h4>Easy Setup</h4>
                        <p>Get your WiFi billing system up and running in minutes. Our intuitive dashboard makes management simple for any business owner.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4>Mobile Payments</h4>
                        <p>Accept M-Pesa, Airtel Money, and other mobile payments. Your customers can pay instantly using their preferred method.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>Real-time Analytics</h4>
                        <p>Track your revenue, monitor usage patterns, and optimize your WiFi business with detailed reports and insights.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4>Secure & Reliable</h4>
                        <p>Bank-level security with 99.9% uptime guarantee. Your business and customer data is always protected.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4>24/7 Support</h4>
                        <p>Our dedicated support team is available around the clock to help you maximize your WiFi revenue potential.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">
                            <i class="fas fa-cog"></i>
                        </div>
                        <h4>Customizable</h4>
                        <p>Brand your WiFi portal with your logo and colors. Create custom packages and pricing to match your business needs.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="section about">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <img src="https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Team working" class="img-fluid about-img">
                </div>
                <div class="col-lg-6">
                    <div class="ps-lg-5">
                        <h2>Built for African Businesses</h2>
                        <p>Since 2020, we've been helping businesses across Africa monetize their WiFi networks. Our platform is designed with local needs in mind, supporting local payment methods and providing region-specific features.</p>
                        <p>From small cafes to large hotels, our scalable solution grows with your business. Join thousands of satisfied customers who have transformed their WiFi from a cost center into a profit driver.</p>
                        <ul class="check-list">
                            <li>Local payment gateway integration</li>
                            <li>Multi-language support</li>
                            <li>Offline billing capabilities</li>
                            <li>Custom branding options</li>
                            <li>Advanced user management</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20learn%20more%20about%20your%20company" class="btn btn-primary mt-3" target="_blank">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Solutions Section -->
    <section id="solutions" class="section solutions">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-5 mb-4">Perfect for Every Business</h2>
                    <p class="lead">Whether you run a small cafe or manage a large hotel chain, our flexible platform adapts to your specific needs.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="solution-card fade-in">
                        <img src="https://images.unsplash.com/photo-1554118811-1e0d58224f24?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80" alt="Restaurant" class="solution-img">
                        <h4>Restaurants & Cafes</h4>
                        <p>Offer complimentary WiFi to customers while generating additional revenue. Perfect for cafes, restaurants, and food courts.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="solution-card fade-in">
                        <img src="https://images.unsplash.com/photo-1564501049412-61c2a3083791?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80" alt="Hotel" class="solution-img">
                        <h4>Hotels & Lodges</h4>
                        <p>Provide premium WiFi services to guests with flexible pricing options. Enhance guest experience while boosting revenue.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="solution-card fade-in">
                        <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80" alt="Retail" class="solution-img">
                        <h4>Retail & Shopping</h4>
                        <p>Keep customers engaged longer with paid WiFi access. Ideal for shopping centers, retail stores, and entertainment venues.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="section pricing">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-5 mb-4">Simple, Transparent Pricing</h2>
                    <p class="lead">Choose a plan that fits your business size. All plans include free setup, training, and ongoing support.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card fade-in">
                        <h3>Starter</h3>
                        <div class="price">KSh 1,000</div>
                        <div class="price-period">per month</div>
                        <ul class="pricing-features">
                            <li>Up to 50 users</li>
                            <li>1 location</li>
                            <li>Basic analytics</li>
                            <li>M-Pesa integration</li>
                            <li>Email support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started%20with%20the%20Starter%20plan" class="btn btn-primary w-100" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card fade-in">
                        <h3>Business</h3>
                        <div class="price">KSh 2,500</div>
                        <div class="price-period">per month</div>
                        <ul class="pricing-features">
                            <li>Up to 150 users</li>
                            <li>3 locations</li>
                            <li>Advanced analytics</li>
                            <li>Multiple payment methods</li>
                            <li>Priority support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started%20with%20the%20Business%20plan" class="btn btn-primary w-100" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card popular fade-in">
                        <h3>Professional</h3>
                        <div class="price">KSh 5,000</div>
                        <div class="price-period">per month</div>
                        <ul class="pricing-features">
                            <li>Up to 500 users</li>
                            <li>10 locations</li>
                            <li>Full analytics suite</li>
                            <li>Custom branding</li>
                            <li>Phone support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started%20with%20the%20Professional%20plan" class="btn btn-primary w-100" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card fade-in">
                        <h3>Enterprise</h3>
                        <div class="price">KSh 10,000</div>
                        <div class="price-period">per month</div>
                        <ul class="pricing-features">
                            <li>Unlimited users</li>
                            <li>Unlimited locations</li>
                            <li>Custom features</li>
                            <li>API access</li>
                            <li>Dedicated support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Enterprise%20plan" class="btn btn-primary w-100" target="_blank">Contact Sales</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="section contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-5 mb-4">Ready to Get Started?</h2>
                    <p class="lead">Join thousands of businesses already using Glinta Africa to monetize their WiFi networks. Contact us today for a free consultation.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="contact-info">
                        <h5><i class="fas fa-envelope me-2"></i> Email Us</h5>
                        <p><a href="mailto:info@glintaafrica.com">info@glintaafrica.com</a></p>
                        <p><a href="mailto:watsonwambugu@yahoo.com">watsonwambugu@yahoo.com</a></p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="contact-info">
                        <h5><i class="fas fa-phone me-2"></i> Call Us</h5>
                        <p>+254 700 123 456</p>
                        <p>Monday - Friday: 8AM - 6PM</p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="contact-info">
                        <h5><i class="fab fa-whatsapp me-2"></i> WhatsApp</h5>
                        <p><a href="https://wa.me/254711503023" target="_blank">+254 711 503 023</a></p>
                        <p>Instant response 24/7</p>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-lg-6 mx-auto text-center">
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20schedule%20a%20consultation" class="btn btn-primary btn-lg" target="_blank">Schedule Free Consultation</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <h5>Glinta Africa</h5>
                    <p>Professional WiFi billing solutions for African businesses. Transform your WiFi into a revenue stream with our easy-to-use platform.</p>
                </div>
                <div class="col-lg-2">
                    <h5>Product</h5>
                    <p><a href="#features">Features</a></p>
                    <p><a href="#pricing">Pricing</a></p>
                    <p><a href="#solutions">Solutions</a></p>
                </div>
                <div class="col-lg-2">
                    <h5>Support</h5>
                    <p><a href="#contact">Contact</a></p>
                    <p><a href="#">Help Center</a></p>
                    <p><a href="#">Status</a></p>
                </div>
                <div class="col-lg-2">
                    <h5>Company</h5>
                    <p><a href="#">About</a></p>
                    <p><a href="#">Careers</a></p>
                    <p><a href="#">Press</a></p>
                </div>
                <div class="col-lg-2">
                    <h5>Legal</h5>
                    <p><a href="#">Privacy</a></p>
                    <p><a href="#">Terms</a></p>
                    <p><a href="#">Security</a></p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Glinta Africa. All rights reserved. | Made with ❤️ by <a href="https://watsonsdevelopers.com">watsonsdevelopers.com</a></p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Smooth scrolling for navigation links
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
            if (window.scrollY > 50) {
                navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                navbar.style.boxShadow = '0 2px 20px rgba(0,0,0,0.15)';
            } else {
                navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                navbar.style.boxShadow = '0 2px 20px rgba(0,0,0,0.1)';
            }
        });

        // Fade in animation on scroll
        function fadeInOnScroll() {
            const elements = document.querySelectorAll('.fade-in');
            elements.forEach(element => {
                const elementTop = element.getBoundingClientRect().top;
                const windowHeight = window.innerHeight;
                if (elementTop < windowHeight - 100) {
                    element.classList.add('visible');
                }
            });
        }

        window.addEventListener('scroll', fadeInOnScroll);
        window.addEventListener('load', fadeInOnScroll);

        // Counter animation for hero stats
        function animateCounters() {
            const counters = document.querySelectorAll('.hero-stat h3');
            counters.forEach(counter => {
                const target = parseInt(counter.textContent.replace(/[^0-9]/g, ''));
                const suffix = counter.textContent.replace(/[0-9]/g, '');
                let current = 0;
                const increment = target / 100;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    counter.textContent = Math.floor(current) + suffix;
                }, 20);
            });
        }

        // Run counter animation when hero section is visible
        const heroSection = document.querySelector('.hero');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateCounters();
                    observer.unobserve(entry.target);
                }
            });
        });
        observer.observe(heroSection);
    </script>
</body>
</html>