<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Security measures and data protection at Glinta Africa. Learn about our enterprise-grade security protocols.">
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
        .security-feature { background: #f8f9fa; padding: 2rem; border-radius: 15px; margin-bottom: 2rem; border-left: 4px solid var(--gold); }
        .security-icon { color: var(--gold); font-size: 2rem; margin-bottom: 1rem; }
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
                <h1>Security & Data Protection</h1>
                <p class="lead" style="color: rgba(255, 255, 255, 0.9);">Enterprise-grade security measures protecting your business and customer data</p>
            </div></div>
        </div>
    </section>

    <section style="padding: 4rem 0;">
        <div class="container">
            <div class="row"><div class="col-lg-8 mx-auto">
                <div class="security-feature">
                    <div class="security-icon"><i class="fas fa-shield-alt"></i></div>
                    <h3>SSL/TLS Encryption</h3>
                    <p>All data transmitted between your browser and our servers is encrypted using industry-standard SSL/TLS protocols. This ensures that sensitive information like payment details and customer data cannot be intercepted.</p>
                </div>

                <div class="security-feature">
                    <div class="security-icon"><i class="fas fa-lock"></i></div>
                    <h3>Data Encryption at Rest</h3>
                    <p>All customer data stored in our databases is encrypted using AES-256 encryption. This means even if someone gains unauthorized access to our servers, your data remains protected.</p>
                </div>

                <div class="security-feature">
                    <div class="security-icon"><i class="fas fa-user-shield"></i></div>
                    <h3>Multi-Factor Authentication</h3>
                    <p>Admin accounts are protected with multi-factor authentication (MFA) to prevent unauthorized access. This adds an extra layer of security beyond just passwords.</p>
                </div>

                <div class="security-feature">
                    <div class="security-icon"><i class="fas fa-server"></i></div>
                    <h3>Secure Infrastructure</h3>
                    <p>Our servers are hosted in certified data centers with 24/7 monitoring, redundant power systems, and physical security controls. Regular security audits ensure compliance with international standards.</p>
                </div>

                <div class="security-feature">
                    <div class="security-icon"><i class="fas fa-eye"></i></div>
                    <h3>Audit Logging</h3>
                    <p>All system activities are logged and monitored. We maintain detailed audit trails of user actions, system changes, and access attempts for security analysis and compliance purposes.</p>
                </div>

                <div class="security-feature">
                    <div class="security-icon"><i class="fas fa-sync-alt"></i></div>
                    <h3>Regular Backups</h3>
                    <p>Your data is automatically backed up multiple times daily to secure, geographically distributed locations. This ensures business continuity and data recovery capabilities.</p>
                </div>

                <h2>Security Certifications</h2>
                <p>Glinta Africa maintains the following security standards:</p>
                <ul>
                    <li>ISO 27001 Information Security Management</li>
                    <li>SOC 2 Type II Compliance</li>
                    <li>GDPR Compliance for European customers</li>
                    <li>PCI DSS for payment processing</li>
                </ul>

                <h2>Report Security Issues</h2>
                <p>If you discover a security vulnerability, please report it immediately to our security team at <a href="mailto:security@glintaafrica.com">security@glintaafrica.com</a>. We take all security reports seriously and will respond within 24 hours.</p>
            </div></div>
        </div>
    </section>
</body>
</html>