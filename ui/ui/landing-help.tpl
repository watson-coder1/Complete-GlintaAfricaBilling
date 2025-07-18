<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Help Center for Glinta Africa ISP billing platform. Get support, tutorials, and answers to common questions.">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --gold: #D4AF37;
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 50%, #B8941F 100%);
            --gradient-black: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
        }
        body { font-family: 'Inter', sans-serif; line-height: 1.7; color: #000; }
        .logo-brand { font-family: 'Orbitron', monospace; font-size: 1.8rem; font-weight: 900; background: var(--gradient-gold); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-decoration: none; letter-spacing: 2px; text-transform: uppercase; }
        .navbar { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border-bottom: 1px solid rgba(212, 175, 55, 0.2); padding: 1.2rem 0; position: fixed; width: 100%; top: 0; z-index: 2000; }
        .page-header { background: var(--gradient-black); color: white; padding: 120px 0 80px; margin-top: 80px; }
        .page-header h1 { font-family: 'Space Grotesk', sans-serif; font-size: 3.5rem; font-weight: 700; background: var(--gradient-gold); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 1.5rem; }
        .help-card { background: white; border-radius: 15px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 5px 20px rgba(0,0,0,0.1); border: 1px solid rgba(212, 175, 55, 0.2); }
        .help-icon { color: var(--gold); font-size: 2.5rem; margin-bottom: 1rem; }
        .faq-item { margin-bottom: 1.5rem; padding: 1.5rem; background: #f8f9fa; border-radius: 10px; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="logo-brand" href="{$app_url}">GLINTA<span style="color: var(--gold);">•</span>AFRICA</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="{$app_url}">← Back to Home</a>
            </div>
        </div>
    </nav>

    <section class="page-header">
        <div class="container">
            <div class="row"><div class="col-lg-8 mx-auto text-center">
                <h1>Help Center</h1>
                <p class="lead" style="color: rgba(255, 255, 255, 0.9);">Get help with your ISP billing platform</p>
            </div></div>
        </div>
    </section>

    <section style="padding: 4rem 0;">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="help-card text-center">
                        <div class="help-icon"><i class="fas fa-book"></i></div>
                        <h4>Getting Started</h4>
                        <p>Learn how to set up your ISP billing system, configure hotspot settings, and manage your first customers.</p>
                        <a href="{$app_url}/documentation" class="btn btn-outline-warning">View Guides</a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="help-card text-center">
                        <div class="help-icon"><i class="fas fa-mobile-alt"></i></div>
                        <h4>Mobile Money Setup</h4>
                        <p>Configure M-Pesa, Airtel Money, and other mobile payment gateways for seamless customer payments.</p>
                        <a href="{$app_url}/landing/contact" class="btn btn-outline-warning">Get Support</a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="help-card text-center">
                        <div class="help-icon"><i class="fas fa-headset"></i></div>
                        <h4>24/7 Support</h4>
                        <p>Our technical support team is available around the clock to help with any issues or questions.</p>
                        <a href="tel:+254700123456" class="btn btn-outline-warning">Call Support</a>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-lg-8 mx-auto">
                    <h2>Frequently Asked Questions</h2>
                    
                    <div class="faq-item">
                        <h5>How do I add a new hotspot location?</h5>
                        <p>Go to Network → Hotspots → Add New. Enter your router details, configure the captive portal settings, and test the connection. Our setup wizard guides you through each step.</p>
                    </div>

                    <div class="faq-item">
                        <h5>How do customers pay for internet packages?</h5>
                        <p>Customers connect to your WiFi, are redirected to the captive portal, select a package, and pay using mobile money (M-Pesa, Airtel Money, etc.). Payment is instant and service activates automatically.</p>
                    </div>

                    <div class="faq-item">
                        <h5>Can I customize the captive portal design?</h5>
                        <p>Yes! You can upload your logo, change colors, customize text, and add your branding to create a professional customer experience that matches your business.</p>
                    </div>

                    <div class="faq-item">
                        <h5>What reports are available?</h5>
                        <p>Access comprehensive reports including revenue analytics, customer usage statistics, popular packages, payment summaries, and network performance metrics.</p>
                    </div>

                    <div class="faq-item">
                        <h5>How do I manage customer accounts?</h5>
                        <p>The customer management system allows you to view all users, check their payment history, manage active sessions, send notifications, and provide customer support.</p>
                    </div>

                    <h2>Contact Support</h2>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="help-card">
                                <h5><i class="fas fa-envelope text-warning me-2"></i>Email Support</h5>
                                <p>Get detailed help via email</p>
                                <a href="mailto:support@glintaafrica.com">support@glintaafrica.com</a>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="help-card">
                                <h5><i class="fas fa-phone text-warning me-2"></i>Phone Support</h5>
                                <p>Immediate assistance available</p>
                                <a href="tel:+254700123456">+254 700 123 456</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>