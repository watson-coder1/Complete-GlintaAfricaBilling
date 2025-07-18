<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa Privacy Policy - How we collect, use, and protect your personal information in our ISP billing platform.">
    <meta name="keywords" content="privacy policy, data protection, Glinta Africa privacy, ISP data security">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/privacy">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --gold: #D4AF37;
            --gold-light: #F4E4C1;
            --gold-dark: #B8941F;
            --black: #000000;
            --black-soft: #1a1a1a;
            --white: #FFFFFF;
            --white-soft: #f8f8f8;
            --gray: #666666;
            --shadow: 0 5px 20px rgba(0,0,0,0.1);
            --shadow-lg: 0 15px 40px rgba(0,0,0,0.2);
            --shadow-gold: 0 10px 30px rgba(212,175,55,0.3);
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 50%, #B8941F 100%);
            --gradient-black: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
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
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.7;
            color: var(--black);
            background: var(--white);
            overflow-x: hidden;
        }

        /* Creative Logo Typography */
        .logo-brand {
            font-family: 'Orbitron', monospace;
            font-size: 1.8rem;
            font-weight: 900;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            position: relative;
            transition: all 0.3s ease;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .logo-brand:hover {
            transform: scale(1.05);
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding: 1.2rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 2000;
        }

        .navbar-nav .nav-link {
            color: var(--black);
            font-weight: 600;
            margin: 0 0.5rem;
            padding: 0.8rem 1.2rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .navbar-nav .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--gradient-gold);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .navbar-nav .nav-link:hover::before {
            left: 0;
        }

        .navbar-nav .nav-link:hover {
            color: var(--white);
            transform: translateY(-2px);
        }

        /* Header */
        .page-header {
            background: var(--gradient-black);
            color: var(--white);
            padding: 120px 0 80px;
            margin-top: 80px;
        }

        .page-header h1 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 3.5rem;
            font-weight: 700;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.5rem;
        }

        /* Content */
        .content-section {
            padding: 4rem 0;
        }

        .content-section h2 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2rem;
            font-weight: 600;
            color: var(--black);
            margin: 3rem 0 1.5rem;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .content-section h3 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--black);
            margin: 2rem 0 1rem;
        }

        .content-section p {
            margin-bottom: 1.5rem;
            text-align: justify;
        }

        .content-section ul, .content-section ol {
            margin: 1.5rem 0;
            padding-left: 2rem;
        }

        .content-section li {
            margin-bottom: 0.5rem;
        }

        /* Footer */
        .footer {
            background: var(--gradient-black);
            color: var(--white);
            padding: 4rem 0 2rem;
            margin-top: 4rem;
        }

        .footer h5 {
            color: var(--gold);
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            padding: 0.3rem 0;
        }

        .footer a:hover {
            color: var(--gold);
            transform: translateX(5px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2.5rem;
            }
            
            .logo-brand {
                font-size: 1.5rem;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="logo-brand" href="{$app_url}">
                GLINTA<span style="color: var(--gold);">•</span>AFRICA
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars text-dark"></i>
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
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1>Privacy Policy</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        How we collect, use, and protect your personal information
                    </p>
                    <p style="color: rgba(255, 255, 255, 0.7);">
                        Last updated: December 15, 2024
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Content Section -->
    <section class="content-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <p>
                        At Glinta Africa, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our internet billing platform and services.
                    </p>

                    <h2>1. Information We Collect</h2>

                    <h3>Personal Information</h3>
                    <p>We may collect personal information that you provide directly to us, including:</p>
                    <ul>
                        <li>Name, email address, and contact information</li>
                        <li>Business information (company name, address, industry)</li>
                        <li>Account credentials and login information</li>
                        <li>Payment information (processed securely through our payment partners)</li>
                        <li>Communication preferences and support requests</li>
                    </ul>

                    <h3>Usage Information</h3>
                    <p>We automatically collect certain information about your use of our services:</p>
                    <ul>
                        <li>IP addresses and device information</li>
                        <li>Browser type and operating system</li>
                        <li>Pages visited and features used</li>
                        <li>Time and duration of visits</li>
                        <li>Referral sources and exit pages</li>
                    </ul>

                    <h3>Customer Data</h3>
                    <p>For ISP operators using our platform, we may process customer data on your behalf, including:</p>
                    <ul>
                        <li>End-user account information</li>
                        <li>Usage and billing data</li>
                        <li>Payment transaction records</li>
                        <li>Network performance metrics</li>
                    </ul>

                    <h2>2. How We Use Your Information</h2>

                    <p>We use the collected information for the following purposes:</p>
                    <ul>
                        <li><strong>Service Provision:</strong> To provide, operate, and maintain our billing platform</li>
                        <li><strong>Account Management:</strong> To create and manage your account and provide customer support</li>
                        <li><strong>Payment Processing:</strong> To process payments and prevent fraud</li>
                        <li><strong>Communication:</strong> To send service updates, security alerts, and marketing communications</li>
                        <li><strong>Improvement:</strong> To analyze usage patterns and improve our services</li>
                        <li><strong>Compliance:</strong> To comply with legal obligations and protect our rights</li>
                    </ul>

                    <h2>3. Information Sharing and Disclosure</h2>

                    <p>We do not sell, trade, or rent your personal information. We may share information in the following circumstances:</p>

                    <h3>Service Providers</h3>
                    <p>We may share information with trusted third-party service providers who assist us in operating our platform, including:</p>
                    <ul>
                        <li>Cloud hosting and infrastructure providers</li>
                        <li>Payment processors (M-Pesa, Airtel Money, etc.)</li>
                        <li>Customer support and communication tools</li>
                        <li>Security and fraud prevention services</li>
                    </ul>

                    <h3>Legal Requirements</h3>
                    <p>We may disclose information if required by law or in response to:</p>
                    <ul>
                        <li>Court orders or legal proceedings</li>
                        <li>Government requests or regulatory requirements</li>
                        <li>Protection of our rights, property, or safety</li>
                        <li>Investigation of fraud or security issues</li>
                    </ul>

                    <h3>Business Transfers</h3>
                    <p>In the event of a merger, acquisition, or sale of assets, customer information may be transferred as part of the business transaction.</p>

                    <h2>4. Data Security</h2>

                    <p>We implement robust security measures to protect your information:</p>
                    <ul>
                        <li><strong>Encryption:</strong> All data transmissions are encrypted using SSL/TLS protocols</li>
                        <li><strong>Access Controls:</strong> Strict access controls and authentication mechanisms</li>
                        <li><strong>Regular Audits:</strong> Regular security assessments and vulnerability testing</li>
                        <li><strong>Compliance:</strong> Adherence to industry security standards and best practices</li>
                        <li><strong>Data Centers:</strong> Secure, certified data centers with 24/7 monitoring</li>
                    </ul>

                    <h2>5. Data Retention</h2>

                    <p>We retain personal information for as long as necessary to:</p>
                    <ul>
                        <li>Provide our services and maintain your account</li>
                        <li>Comply with legal, regulatory, or contractual requirements</li>
                        <li>Resolve disputes and enforce our agreements</li>
                        <li>Support business operations and continuity</li>
                    </ul>

                    <p>When information is no longer needed, we securely delete or anonymize it in accordance with our data retention policies.</p>

                    <h2>6. Your Rights and Choices</h2>

                    <p>You have the following rights regarding your personal information:</p>
                    <ul>
                        <li><strong>Access:</strong> Request access to your personal information</li>
                        <li><strong>Correction:</strong> Request correction of inaccurate or incomplete information</li>
                        <li><strong>Deletion:</strong> Request deletion of your personal information (subject to legal requirements)</li>
                        <li><strong>Portability:</strong> Request a copy of your data in a portable format</li>
                        <li><strong>Opt-out:</strong> Unsubscribe from marketing communications</li>
                        <li><strong>Restriction:</strong> Request limitation of processing in certain circumstances</li>
                    </ul>

                    <p>To exercise these rights, please contact us at privacy@glintaafrica.com.</p>

                    <h2>7. International Data Transfers</h2>

                    <p>Our services may involve the transfer of information to countries outside your jurisdiction. When we transfer personal information internationally, we ensure appropriate safeguards are in place, including:</p>
                    <ul>
                        <li>Standard contractual clauses approved by relevant authorities</li>
                        <li>Adequacy decisions by data protection authorities</li>
                        <li>Certification schemes and codes of conduct</li>
                    </ul>

                    <h2>8. Children's Privacy</h2>

                    <p>Our services are not directed to children under 13 years of age. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information promptly.</p>

                    <h2>9. Changes to This Privacy Policy</h2>

                    <p>We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of any material changes by:</p>
                    <ul>
                        <li>Posting the updated policy on our website</li>
                        <li>Sending email notifications to registered users</li>
                        <li>Displaying prominent notices in our platform</li>
                    </ul>

                    <p>Your continued use of our services after any changes indicates your acceptance of the updated Privacy Policy.</p>

                    <h2>10. Contact Us</h2>

                    <p>If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us:</p>

                    <div style="background: var(--white-soft); padding: 2rem; border-radius: 10px; margin: 2rem 0;">
                        <p><strong>Glinta Africa</strong></p>
                        <p>Email: privacy@glintaafrica.com</p>
                        <p>Phone: +254 700 123 456</p>
                        <p>Address: Nairobi, Kenya</p>
                    </div>

                    <p>We are committed to resolving any privacy concerns promptly and transparently. Our privacy team will respond to your inquiries within 48 hours during business days.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <h5>Company</h5>
                    <a href="{$app_url}/about">About Us</a>
                    <a href="{$app_url}/careers">Careers</a>
                    <a href="{$app_url}/news">News & Press</a>
                    <a href="{$app_url}/investors">Investor Relations</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Products</h5>
                    <a href="{$app_url}/hotspot">Hotspot Solutions</a>
                    <a href="{$app_url}/pppoe">PPPoE Management</a>
                    <a href="{$app_url}/billing">Billing Platform</a>
                    <a href="{$app_url}/analytics">Analytics Suite</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Support</h5>
                    <a href="{$app_url}/help">Help Center</a>
                    <a href="{$app_url}/documentation">Documentation</a>
                    <a href="{$app_url}/community">Community Forum</a>
                    <a href="{$app_url}/contact">Contact Support</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Legal</h5>
                    <a href="{$app_url}/privacy">Privacy Policy</a>
                    <a href="{$app_url}/terms">Terms of Service</a>
                    <a href="{$app_url}/security">Security</a>
                    <a href="{$app_url}/compliance">Compliance</a>
                </div>
            </div>
            <hr style="border-color: var(--gold); margin: 3rem 0 2rem;">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">Made with ❤️ in Africa | <a href="https://watsonsdevelopers.com" style="color: var(--gold);">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>