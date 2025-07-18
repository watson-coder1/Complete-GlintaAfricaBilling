<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Complete documentation for Glinta Africa ISP billing platform. Setup guides, API references, and tutorials.">
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
        .doc-card { background: white; border-radius: 15px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 5px 20px rgba(0,0,0,0.1); border: 1px solid rgba(212, 175, 55, 0.2); transition: transform 0.3s ease; }
        .doc-card:hover { transform: translateY(-5px); }
        .doc-icon { color: var(--gold); font-size: 2.5rem; margin-bottom: 1rem; }
        .code-block { background: #f8f9fa; padding: 1rem; border-radius: 8px; border-left: 4px solid var(--gold); margin: 1rem 0; }
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
                <h1>Documentation</h1>
                <p class="lead" style="color: rgba(255, 255, 255, 0.9);">Complete guides and API references for developers and administrators</p>
            </div></div>
        </div>
    </section>

    <section style="padding: 4rem 0;">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="doc-card">
                        <div class="doc-icon"><i class="fas fa-rocket"></i></div>
                        <h4>Quick Start Guide</h4>
                        <p>Get your ISP billing system up and running in minutes. Step-by-step setup instructions for new installations.</p>
                        <ul>
                            <li>System requirements</li>
                            <li>Installation process</li>
                            <li>Initial configuration</li>
                            <li>First customer setup</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="doc-card">
                        <div class="doc-icon"><i class="fas fa-wifi"></i></div>
                        <h4>Hotspot Configuration</h4>
                        <p>Learn how to configure and manage WiFi hotspots, captive portals, and customer authentication.</p>
                        <ul>
                            <li>Router setup</li>
                            <li>Captive portal customization</li>
                            <li>Package configuration</li>
                            <li>Bandwidth management</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="doc-card">
                        <div class="doc-icon"><i class="fas fa-mobile-alt"></i></div>
                        <h4>Mobile Money Integration</h4>
                        <p>Configure M-Pesa, Airtel Money, and other African mobile payment gateways for seamless transactions.</p>
                        <div class="code-block">
                            <code>
                                // M-Pesa Configuration<br>
                                $mpesa_config = [<br>
                                &nbsp;&nbsp;'consumer_key' => 'your_key',<br>
                                &nbsp;&nbsp;'consumer_secret' => 'your_secret',<br>
                                &nbsp;&nbsp;'environment' => 'sandbox'<br>
                                ];
                            </code>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="doc-card">
                        <div class="doc-icon"><i class="fas fa-code"></i></div>
                        <h4>API Reference</h4>
                        <p>Complete REST API documentation for integrating with third-party systems and custom applications.</p>
                        <div class="code-block">
                            <code>
                                GET /api/customers<br>
                                POST /api/packages<br>
                                PUT /api/payments<br>
                                DELETE /api/sessions
                            </code>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-lg-8 mx-auto">
                    <h2>System Requirements</h2>
                    <div class="doc-card">
                        <h5>Server Requirements</h5>
                        <ul>
                            <li><strong>PHP:</strong> 7.4 or higher</li>
                            <li><strong>MySQL:</strong> 5.7 or higher</li>
                            <li><strong>Apache/Nginx:</strong> Latest stable version</li>
                            <li><strong>Storage:</strong> Minimum 500MB free space</li>
                            <li><strong>Memory:</strong> 2GB RAM recommended</li>
                        </ul>
                    </div>

                    <h2>Installation Guide</h2>
                    <div class="doc-card">
                        <h5>Step 1: Download and Extract</h5>
                        <div class="code-block">
                            <code>
                                wget https://releases.glintaafrica.com/latest.zip<br>
                                unzip latest.zip<br>
                                cd glinta-billing/
                            </code>
                        </div>

                        <h5>Step 2: Database Setup</h5>
                        <div class="code-block">
                            <code>
                                mysql -u root -p<br>
                                CREATE DATABASE glinta_billing;<br>
                                GRANT ALL PRIVILEGES ON glinta_billing.* TO 'glinta'@'localhost';<br>
                                FLUSH PRIVILEGES;
                            </code>
                        </div>

                        <h5>Step 3: Configuration</h5>
                        <p>Edit the configuration file and set your database credentials:</p>
                        <div class="code-block">
                            <code>
                                cp config.sample.php config.php<br>
                                nano config.php
                            </code>
                        </div>
                    </div>

                    <h2>API Authentication</h2>
                    <div class="doc-card">
                        <p>All API requests require authentication using API keys. Include your API key in the request headers:</p>
                        <div class="code-block">
                            <code>
                                curl -H "Authorization: Bearer YOUR_API_KEY" \<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;https://yoursite.com/api/customers
                            </code>
                        </div>
                    </div>

                    <h2>Support</h2>
                    <div class="doc-card">
                        <p>Need help with implementation? Our technical team is available:</p>
                        <ul>
                            <li><strong>Email:</strong> <a href="mailto:developers@glintaafrica.com">developers@glintaafrica.com</a></li>
                            <li><strong>Phone:</strong> +254 700 123 456</li>
                            <li><strong>Community:</strong> <a href="{$app_url}/community">Join our forum</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>