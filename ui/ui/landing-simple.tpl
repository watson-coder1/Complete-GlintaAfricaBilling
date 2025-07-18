<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/fonts/font-awesome/css/font-awesome.min.css">
    <style>
        :root {
            --gold: #FFD700;
            --dark-gold: #DAA520;
            --black: #000000;
            --white: #ffffff;
        }
        
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: var(--white);
        }
        
        .hero {
            background: linear-gradient(135deg, var(--black) 0%, #1a1a1a 100%);
            color: var(--white);
            padding: 100px 0;
            text-align: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        
        .hero h1 {
            font-size: 3rem;
            color: var(--gold);
            margin-bottom: 20px;
            font-weight: 900;
        }
        
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }
        
        .btn-gold {
            background: var(--gold);
            color: var(--black);
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-weight: 700;
            text-decoration: none;
            margin: 10px;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-gold:hover {
            background: var(--dark-gold);
            color: var(--black);
            text-decoration: none;
        }
        
        .features {
            padding: 80px 0;
            background: var(--white);
        }
        
        .feature-card {
            background: var(--white);
            border: 2px solid var(--gold);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .feature-icon {
            font-size: 48px;
            color: var(--gold);
            margin-bottom: 20px;
        }
        
        .navbar {
            background: var(--black) !important;
        }
        
        .navbar-brand {
            color: var(--gold) !important;
            font-weight: 900;
            font-size: 24px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .navbar-nav .nav-link {
            color: var(--white) !important;
        }
        
        .navbar-nav .nav-link:hover {
            color: var(--gold) !important;
        }
        
        .footer {
            background: var(--black);
            color: var(--white);
            padding: 40px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
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
                        <a class="nav-link btn btn-gold ml-2" href="{$app_url}/index.php?_route=login">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h1>Enterprise Hotspot Billing Solutions</h1>
                    <p>Transform your WiFi business with Africa's most advanced hotspot billing system.</p>
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20start%20a%20free%20trial" class="btn-gold" target="_blank">Start Free Trial</a>
                    <a href="{$app_url}/index.php?_route=admin" class="btn-gold" target="_blank">Admin Demo</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2>Why Choose Glinta Africa?</h2>
                    <p class="lead">Everything you need to run a successful hotspot business</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="feature-card">
                        <i class="fa fa-wifi feature-icon"></i>
                        <h4>Captive Portal</h4>
                        <p>Customizable branded login portal with voucher system and multi-language support.</p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="feature-card">
                        <i class="fa fa-users feature-icon"></i>
                        <h4>User Management</h4>
                        <p>Complete customer management system with profiles, packages, and usage tracking.</p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="feature-card">
                        <i class="fa fa-credit-card feature-icon"></i>
                        <h4>Payment Integration</h4>
                        <p>M-Pesa, Airtel Money, PayPal, and Stripe integration with instant service activation.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="py-5" style="background: #f8f9fa;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2>Transparent Pricing</h2>
                    <p class="lead">Choose the perfect plan for your hotspot business</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3">
                    <div class="feature-card">
                        <h3>Basic</h3>
                        <div class="h2" style="color: var(--gold);">KES 1,000</div>
                        <p>50 users, 1 location</p>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started" class="btn-gold" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="feature-card">
                        <h3>Starter</h3>
                        <div class="h2" style="color: var(--gold);">KES 2,500</div>
                        <p>150 users, 3 locations</p>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20get%20started" class="btn-gold" target="_blank">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="feature-card">
                        <h3>Professional</h3>
                        <div class="h2" style="color: var(--gold);">KES 5,000</div>
                        <p>500 users, 10 locations</p>
                        <a href="#contact" class="btn-gold">Most Popular</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="feature-card">
                        <h3>Enterprise</h3>
                        <div class="h2" style="color: var(--gold);">KES 10,000</div>
                        <p>Unlimited users & locations</p>
                        <a href="#contact" class="btn-gold">Contact Sales</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2>Get Started Today</h2>
                    <p class="lead">Ready to transform your hotspot business?</p>
                    <div class="mt-4">
                        <p><strong>Email:</strong> <a href="mailto:info@glintaafrica.com">info@glintaafrica.com</a> | <a href="mailto:watsonwambugu@yahoo.com">watsonwambugu@yahoo.com</a></p>
                        <p><strong>Phone:</strong> +254 700 123 456</p>
                        <p><strong>WhatsApp:</strong> <a href="https://wa.me/254711503023" target="_blank" style="color: #25D366; text-decoration: none;">+254 711 503 023</a></p>
                    </div>
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20contact%20you" class="btn-gold" target="_blank">Contact Us Now</a>
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
                    <p>Made with ❤️ by <a href="https://watsonsdevelopers.com" style="color: var(--gold);">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <script src="{$app_url}/ui/ui/scripts/jquery.min.js"></script>
    <script src="{$app_url}/ui/ui/scripts/bootstrap.min.js"></script>
    <script>
        // Smooth scrolling
        $('a[href*="#"]').on('click', function (e) {
            e.preventDefault();
            var target = $(this).attr('href');
            if (target && $(target).length) {
                $('html, body').animate({
                    scrollTop: $(target).offset().top - 70
                }, 800);
            }
        });
    </script>
</body>
</html>