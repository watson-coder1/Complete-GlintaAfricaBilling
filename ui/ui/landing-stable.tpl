<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Complete Hotspot Billing System for WiFi Hotspots, ISPs, and Internet Service Providers.">
    
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/fonts/font-awesome/css/font-awesome.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
            line-height: 1.6;
            color: #333;
        }

        /* Navigation */
        .navbar {
            background: #ffffff !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-weight: 900;
            font-size: 24px;
            color: #000000 !important;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-decoration: none !important;
        }

        .navbar-brand:hover {
            color: #FFD700 !important;
        }

        .navbar-nav .nav-link {
            color: #333 !important;
            font-weight: 500;
            margin: 0 10px;
            padding: 10px 15px !important;
        }

        .navbar-nav .nav-link:hover {
            color: #FFD700 !important;
        }

        .btn-demo {
            background: #FFD700;
            color: #000;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            font-weight: 700;
            text-decoration: none;
            margin: 0 5px;
            transition: all 0.3s ease;
        }

        .btn-demo:hover {
            background: #DAA520;
            color: #000;
            text-decoration: none;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            color: #ffffff;
            padding: 150px 0 100px;
            text-align: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 30px;
            color: #FFD700;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .btn-primary {
            background: #FFD700;
            color: #000;
            padding: 18px 35px;
            border: none;
            border-radius: 30px;
            font-weight: 700;
            text-decoration: none;
            margin: 10px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-primary:hover {
            background: #DAA520;
            color: #000;
            text-decoration: none;
            transform: translateY(-3px);
        }

        .btn-secondary {
            background: transparent;
            color: #ffffff;
            padding: 18px 35px;
            border: 2px solid #ffffff;
            border-radius: 30px;
            font-weight: 700;
            text-decoration: none;
            margin: 10px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-secondary:hover {
            background: #ffffff;
            color: #000;
            text-decoration: none;
        }

        /* Features Section */
        .features {
            padding: 100px 0;
            background: #ffffff;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 800;
            text-align: center;
            margin-bottom: 20px;
            color: #000;
        }

        .section-subtitle {
            font-size: 1.1rem;
            text-align: center;
            margin-bottom: 60px;
            color: #666;
        }

        .feature-card {
            background: #ffffff;
            border: 2px solid #FFD700;
            border-radius: 15px;
            padding: 40px;
            margin-bottom: 30px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .feature-icon {
            font-size: 48px;
            color: #FFD700;
            margin-bottom: 20px;
        }

        .feature-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: #000;
        }

        /* Pricing Section */
        .pricing {
            background: #f8f9fa;
            padding: 100px 0;
        }

        .pricing-card {
            background: #ffffff;
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 40px;
            margin-bottom: 30px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .pricing-card:hover {
            border-color: #FFD700;
            transform: translateY(-5px);
        }

        .pricing-card.featured {
            border-color: #FFD700;
            transform: scale(1.05);
        }

        .plan-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #000;
        }

        .plan-price {
            font-size: 2.5rem;
            font-weight: 900;
            color: #FFD700;
            margin-bottom: 20px;
        }

        .plan-features {
            list-style: none;
            margin-bottom: 30px;
        }

        .plan-features li {
            padding: 8px 0;
            color: #666;
        }

        .plan-features li:before {
            content: '✓';
            color: #28a745;
            font-weight: bold;
            margin-right: 10px;
        }

        /* Contact Section */
        .contact {
            background: #000000;
            color: #ffffff;
            padding: 80px 0;
            text-align: center;
        }

        .contact h2 {
            color: #FFD700;
            margin-bottom: 30px;
        }

        .contact a {
            color: #FFD700;
            text-decoration: none;
        }

        .contact a:hover {
            text-decoration: underline;
        }

        /* Footer */
        .footer {
            background: #1a1a1a;
            color: #ffffff;
            padding: 40px 0;
            text-align: center;
        }

        .footer a {
            color: #FFD700;
            text-decoration: none;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .navbar-brand {
                font-size: 18px;
            }

            .btn-primary,
            .btn-secondary {
                padding: 15px 25px;
                font-size: 0.9rem;
                display: block;
                margin: 10px auto;
                max-width: 250px;
            }

            .feature-card,
            .pricing-card {
                padding: 25px;
            }

            .section-title {
                font-size: 2rem;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}">GLINTA AFRICA</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn-demo" href="{$app_url}/index.php?_route=admin" target="_blank">Admin Demo</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn-demo" href="{$app_url}/index.php?_route=login" target="_blank">Customer Demo</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1>Africa's Most Advanced<br>Hotspot Billing System</h1>
                    <p>Transform your WiFi business with enterprise-grade billing solutions. Trusted by 10,000+ businesses across Africa for seamless connectivity and revenue growth.</p>
                    <div>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20start%20a%20free%20trial" class="btn-primary" target="_blank">Start Free Trial</a>
                        <a href="#features" class="btn-secondary">Explore Features</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">Comprehensive Hotspot Solutions</h2>
                    <p class="section-subtitle">Everything you need to run a successful WiFi business</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <i class="fa fa-wifi feature-icon"></i>
                        <h4 class="feature-title">Captive Portal</h4>
                        <p>Fully customizable branded login portal with multi-language support and social media login.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <i class="fa fa-users feature-icon"></i>
                        <h4 class="feature-title">User Management</h4>
                        <p>Complete customer relationship management with detailed profiles and usage analytics.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <i class="fa fa-credit-card feature-icon"></i>
                        <h4 class="feature-title">Payment Integration</h4>
                        <p>M-Pesa, Airtel Money, PayPal, Stripe and 50+ payment gateways with instant activation.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <i class="fa fa-chart-line feature-icon"></i>
                        <h4 class="feature-title">Advanced Analytics</h4>
                        <p>Real-time dashboards, revenue reports, and predictive business insights.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <i class="fa fa-shield feature-icon"></i>
                        <h4 class="feature-title">Enterprise Security</h4>
                        <p>Bank-grade encryption, fraud detection, and international compliance standards.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <i class="fa fa-mobile feature-icon"></i>
                        <h4 class="feature-title">Mobile Responsive</h4>
                        <p>Fully optimized for mobile devices with native app experience.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="pricing">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="section-title">Transparent Pricing</h2>
                    <p class="section-subtitle">Choose the perfect plan for your hotspot business</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card">
                        <h3 class="plan-name">Starter</h3>
                        <div class="plan-price">KES 1,000</div>
                        <p>per month</p>
                        <ul class="plan-features">
                            <li>50 concurrent users</li>
                            <li>1 location</li>
                            <li>Basic captive portal</li>
                            <li>M-Pesa integration</li>
                            <li>Email support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20the%20Starter%20plan" class="btn-primary" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card">
                        <h3 class="plan-name">Growth</h3>
                        <div class="plan-price">KES 2,500</div>
                        <p>per month</p>
                        <ul class="plan-features">
                            <li>150 concurrent users</li>
                            <li>3 locations</li>
                            <li>Advanced portal</li>
                            <li>Multiple payments</li>
                            <li>Priority support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20the%20Growth%20plan" class="btn-primary" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card featured">
                        <h3 class="plan-name">Professional</h3>
                        <div class="plan-price">KES 5,000</div>
                        <p>per month</p>
                        <ul class="plan-features">
                            <li>500 concurrent users</li>
                            <li>10 locations</li>
                            <li>White-label solution</li>
                            <li>API access</li>
                            <li>24/7 phone support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20the%20Professional%20plan" class="btn-primary" target="_blank">Most Popular</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card">
                        <h3 class="plan-name">Enterprise</h3>
                        <div class="plan-price">KES 10,000</div>
                        <p>per month</p>
                        <ul class="plan-features">
                            <li>Unlimited users</li>
                            <li>Unlimited locations</li>
                            <li>Custom development</li>
                            <li>Dedicated manager</li>
                            <li>SLA guarantee</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Enterprise%20plan" class="btn-primary" target="_blank">Contact Sales</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2>Get Started Today</h2>
                    <p style="font-size: 1.2rem; margin: 30px 0;">Ready to transform your hotspot business?</p>
                    
                    <div style="margin: 40px 0;">
                        <p><strong>Email:</strong> <a href="mailto:info@glintaafrica.com">info@glintaafrica.com</a> | <a href="mailto:watsonwambugu@yahoo.com">watsonwambugu@yahoo.com</a></p>
                        <p><strong>Phone:</strong> +254 700 123 456</p>
                        <p><strong>WhatsApp:</strong> <a href="https://wa.me/254711503023" target="_blank" style="color: #25D366;">+254 711 503 023</a></p>
                    </div>
                    
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20contact%20you" class="btn-primary" target="_blank">Contact Us Now</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <p>&copy; 2025 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-lg-6 text-right">
                    <p>Made with ❤️ by <a href="https://watsonsdevelopers.com">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="{$app_url}/ui/ui/scripts/jquery.min.js"></script>
    <script src="{$app_url}/ui/ui/scripts/bootstrap.min.js"></script>
    
    <script>
        // Smooth scrolling
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

        // Mobile menu toggle
        document.querySelector('.navbar-toggler').addEventListener('click', function() {
            document.querySelector('.navbar-collapse').classList.toggle('show');
        });
    </script>
</body>
</html>