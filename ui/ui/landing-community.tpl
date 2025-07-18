<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Join the Glinta Africa community. Connect with other ISP operators, share experiences, and get help from peers.">
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
        .community-card { background: white; border-radius: 15px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 5px 20px rgba(0,0,0,0.1); border: 1px solid rgba(212, 175, 55, 0.2); }
        .community-icon { color: var(--gold); font-size: 2.5rem; margin-bottom: 1rem; }
        .post-card { background: #f8f9fa; padding: 1.5rem; border-radius: 10px; margin-bottom: 1.5rem; border-left: 4px solid var(--gold); }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: var(--gradient-gold); display: flex; align-items: center; justify-content: center; color: #000; font-weight: bold; margin-right: 1rem; }
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
                <h1>Community Forum</h1>
                <p class="lead" style="color: rgba(255, 255, 255, 0.9);">Connect with fellow ISP operators across Africa</p>
            </div></div>
        </div>
    </section>

    <section style="padding: 4rem 0;">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="community-card text-center">
                        <div class="community-icon"><i class="fas fa-users"></i></div>
                        <h4>2,500+ Members</h4>
                        <p>Join thousands of ISP operators, resellers, and tech enthusiasts sharing knowledge and experiences.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="community-card text-center">
                        <div class="community-icon"><i class="fas fa-comments"></i></div>
                        <h4>Active Discussions</h4>
                        <p>Daily conversations about best practices, troubleshooting, business tips, and industry news.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="community-card text-center">
                        <div class="community-icon"><i class="fas fa-globe-africa"></i></div>
                        <h4>25 Countries</h4>
                        <p>Connect with ISP operators from across Africa, sharing local insights and market knowledge.</p>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-lg-8 mx-auto">
                    <h2>Recent Discussions</h2>
                    
                    <div class="post-card">
                        <div class="d-flex align-items-start">
                            <div class="user-avatar">SM</div>
                            <div>
                                <h6>Best practices for M-Pesa integration in rural areas</h6>
                                <p class="mb-2">By Samuel M. in <strong>Payment Integration</strong> • 2 hours ago</p>
                                <p class="text-muted">Has anyone had experience with M-Pesa timeouts in areas with poor network coverage? Looking for solutions that work well in rural Kenya...</p>
                                <small class="text-muted">💬 12 replies • 👍 8 likes</small>
                            </div>
                        </div>
                    </div>

                    <div class="post-card">
                        <div class="d-flex align-items-start">
                            <div class="user-avatar">AK</div>
                            <div>
                                <h6>Scaling hotspot business to 50+ locations</h6>
                                <p class="mb-2">By Amina K. in <strong>Business Strategy</strong> • 5 hours ago</p>
                                <p class="text-muted">I've successfully grown from 5 to 20 hotspot locations in Nairobi. Now planning to expand to 50+. What challenges should I expect?</p>
                                <small class="text-muted">💬 18 replies • 👍 15 likes</small>
                            </div>
                        </div>
                    </div>

                    <div class="post-card">
                        <div class="d-flex align-items-start">
                            <div class="user-avatar">JO</div>
                            <div>
                                <h6>Custom branding for captive portal</h6>
                                <p class="mb-2">By John O. in <strong>Technical Support</strong> • 1 day ago</p>
                                <p class="text-muted">How do I customize the captive portal to match my brand colors and add my logo? The documentation mentions custom CSS but I need step-by-step guidance.</p>
                                <small class="text-muted">💬 7 replies • 👍 5 likes</small>
                            </div>
                        </div>
                    </div>

                    <div class="post-card">
                        <div class="d-flex align-items-start">
                            <div class="user-avatar">MN</div>
                            <div>
                                <h6>Airtel Money vs M-Pesa: Performance comparison</h6>
                                <p class="mb-2">By Mary N. in <strong>Payment Integration</strong> • 2 days ago</p>
                                <p class="text-muted">After 6 months of using both payment methods, here's my analysis of transaction success rates, customer preferences, and settlement times...</p>
                                <small class="text-muted">💬 25 replies • 👍 22 likes</small>
                            </div>
                        </div>
                    </div>

                    <h2>Popular Categories</h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="community-card">
                                <h5><i class="fas fa-mobile-alt text-warning me-2"></i>Payment Integration</h5>
                                <p>Mobile money setup, troubleshooting, and optimization tips</p>
                                <small class="text-muted">245 topics • 1.2k posts</small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="community-card">
                                <h5><i class="fas fa-chart-line text-warning me-2"></i>Business Strategy</h5>
                                <p>Growth strategies, pricing models, and market insights</p>
                                <small class="text-muted">189 topics • 850 posts</small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="community-card">
                                <h5><i class="fas fa-cogs text-warning me-2"></i>Technical Support</h5>
                                <p>Platform troubleshooting, configuration help, and bug reports</p>
                                <small class="text-muted">312 topics • 1.8k posts</small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="community-card">
                                <h5><i class="fas fa-handshake text-warning me-2"></i>Partnerships</h5>
                                <p>Find partners, resellers, and collaboration opportunities</p>
                                <small class="text-muted">67 topics • 340 posts</small>
                            </div>
                        </div>
                    </div>

                    <div class="community-card text-center mt-4">
                        <h3>Join the Community</h3>
                        <p>Connect with fellow ISP operators, share experiences, and grow your business together.</p>
                        <a href="{$app_url}/landing/contact" class="btn btn-warning btn-lg">
                            <i class="fas fa-users me-2"></i>Join Forum
                        </a>
                        <p class="mt-3"><small>Free to join • 24/7 access • Mobile-friendly</small></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>