<?php
// Create an enhanced African-themed redirect page for MikroTik hotspot
$redirect_html = '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="3;url=https://glintaafrica.com/?_route=captive_portal">
    <title>Glinta Africa - Empowering Digital Africa</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            background: #0a0a0a;
            color: #ffffff;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        
        /* African continent background */
        .africa-bg {
            position: absolute;
            width: 300px;
            height: 350px;
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
            opacity: 0.1;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            clip-path: polygon(50% 0%, 75% 10%, 85% 25%, 90% 40%, 85% 55%, 80% 70%, 70% 85%, 60% 95%, 50% 100%, 40% 95%, 30% 85%, 20% 70%, 15% 55%, 10% 40%, 15% 25%, 25% 10%);
            animation: float 6s ease-in-out infinite;
        }
        
        /* Kente pattern overlay */
        .kente-pattern {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0.03;
            background-image: 
                repeating-linear-gradient(0deg, #FFD700 0px, #FFD700 2px, transparent 2px, transparent 20px),
                repeating-linear-gradient(90deg, #FFA500 0px, #FFA500 2px, transparent 2px, transparent 20px),
                repeating-linear-gradient(45deg, #FF6347 0px, #FF6347 1px, transparent 1px, transparent 15px);
        }
        
        .container {
            text-align: center;
            padding: 2rem;
            position: relative;
            z-index: 10;
            max-width: 500px;
        }
        
        /* Animated logo with African symbols */
        .logo-container {
            position: relative;
            margin-bottom: 2rem;
            animation: pulse 2s ease-in-out infinite;
        }
        
        .logo {
            width: 140px;
            height: 140px;
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 50%, #FF6347 100%);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            font-weight: bold;
            color: #0a0a0a;
            box-shadow: 0 0 60px rgba(255, 215, 0, 0.5);
            position: relative;
        }
        
        /* Rotating African symbols around logo */
        .symbols {
            position: absolute;
            width: 180px;
            height: 180px;
            animation: rotate 20s linear infinite;
        }
        
        .symbol {
            position: absolute;
            font-size: 1.5rem;
            color: #FFD700;
            opacity: 0.6;
        }
        
        .symbol:nth-child(1) { top: 0; left: 50%; transform: translateX(-50%); }
        .symbol:nth-child(2) { top: 50%; right: 0; transform: translateY(-50%); }
        .symbol:nth-child(3) { bottom: 0; left: 50%; transform: translateX(-50%); }
        .symbol:nth-child(4) { top: 50%; left: 0; transform: translateY(-50%); }
        
        h1 {
            font-size: 2.8rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(90deg, #FFD700, #FFA500, #FF6347);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: shimmer 3s ease-in-out infinite;
        }
        
        .tagline {
            font-size: 1rem;
            color: #FFD700;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .subtitle {
            font-size: 1.2rem;
            color: #cccccc;
            margin-bottom: 2rem;
        }
        
        /* Loading animation with African drum beats */
        .loader-container {
            margin: 2rem auto;
            position: relative;
        }
        
        .drum-beats {
            display: flex;
            gap: 8px;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .beat {
            width: 8px;
            height: 40px;
            background: #FFD700;
            border-radius: 4px;
            animation: drumBeat 0.6s ease-in-out infinite;
        }
        
        .beat:nth-child(1) { animation-delay: 0s; height: 20px; }
        .beat:nth-child(2) { animation-delay: 0.1s; height: 35px; }
        .beat:nth-child(3) { animation-delay: 0.2s; height: 25px; }
        .beat:nth-child(4) { animation-delay: 0.3s; height: 40px; }
        .beat:nth-child(5) { animation-delay: 0.4s; height: 30px; }
        
        .progress-bar {
            width: 300px;
            height: 4px;
            background: rgba(255, 215, 0, 0.2);
            border-radius: 2px;
            overflow: hidden;
            margin: 0 auto;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #FFD700, #FFA500);
            animation: loadProgress 3s ease-out;
        }
        
        .status {
            color: #FFD700;
            font-size: 1.1rem;
            margin-top: 1.5rem;
            animation: fadeInOut 2s ease-in-out infinite;
        }
        
        /* Floating African icons */
        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        
        .icon {
            position: absolute;
            font-size: 2rem;
            opacity: 0.1;
            animation: floatUp 15s linear infinite;
            color: #FFD700;
        }
        
        .icon:nth-child(1) { left: 10%; animation-delay: 0s; }
        .icon:nth-child(2) { left: 25%; animation-delay: 3s; }
        .icon:nth-child(3) { left: 40%; animation-delay: 6s; }
        .icon:nth-child(4) { left: 55%; animation-delay: 9s; }
        .icon:nth-child(5) { left: 70%; animation-delay: 12s; }
        .icon:nth-child(6) { left: 85%; animation-delay: 15s; }
        
        /* Features list */
        .features {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 2rem;
            font-size: 0.9rem;
            color: #888;
        }
        
        .feature {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .feature-icon {
            color: #FFD700;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        @keyframes shimmer {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }
        
        @keyframes drumBeat {
            0%, 100% { transform: scaleY(1); opacity: 0.5; }
            50% { transform: scaleY(1.5); opacity: 1; }
        }
        
        @keyframes loadProgress {
            from { width: 0; }
            to { width: 100%; }
        }
        
        @keyframes fadeInOut {
            0%, 100% { opacity: 0.6; }
            50% { opacity: 1; }
        }
        
        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); }
            100% { transform: translateY(-30px) rotate(360deg); }
        }
        
        @keyframes floatUp {
            0% {
                bottom: -10%;
                opacity: 0;
            }
            10% {
                opacity: 0.1;
            }
            90% {
                opacity: 0.1;
            }
            100% {
                bottom: 110%;
                opacity: 0;
            }
        }
        
        @media (max-width: 600px) {
            h1 { font-size: 2rem; }
            .subtitle { font-size: 1rem; }
            .logo { width: 100px; height: 100px; font-size: 2.5rem; }
            .features { flex-direction: column; gap: 0.5rem; }
            .progress-bar { width: 250px; }
        }
    </style>
</head>
<body>
    <div class="africa-bg"></div>
    <div class="kente-pattern"></div>
    
    <div class="floating-icons">
        <div class="icon">🌍</div>
        <div class="icon">☀️</div>
        <div class="icon">🦁</div>
        <div class="icon">🌴</div>
        <div class="icon">⚡</div>
        <div class="icon">💫</div>
    </div>
    
    <div class="container">
        <div class="logo-container">
            <div class="symbols">
                <span class="symbol">☀️</span>
                <span class="symbol">🌍</span>
                <span class="symbol">⚡</span>
                <span class="symbol">💫</span>
            </div>
            <div class="logo">GA</div>
        </div>
        
        <p class="tagline">Ubuntu • Unity • Progress</p>
        <h1>Glinta Africa</h1>
        <p class="subtitle">Empowering Digital Connectivity Across Africa</p>
        
        <div class="loader-container">
            <div class="drum-beats">
                <div class="beat"></div>
                <div class="beat"></div>
                <div class="beat"></div>
                <div class="beat"></div>
                <div class="beat"></div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
        </div>
        
        <p class="status">🌟 Preparing your connection...</p>
        
        <div class="features">
            <div class="feature">
                <span class="feature-icon">⚡</span>
                <span>High-Speed Internet</span>
            </div>
            <div class="feature">
                <span class="feature-icon">🔒</span>
                <span>Secure Connection</span>
            </div>
            <div class="feature">
                <span class="feature-icon">💳</span>
                <span>Easy Payment</span>
            </div>
        </div>
    </div>
    
    <script>
        // Dynamic status messages
        const messages = [
            "🌟 Preparing your connection...",
            "🌍 Connecting Africa...",
            "⚡ Almost ready...",
            "🚀 Launching portal..."
        ];
        
        let messageIndex = 0;
        const statusElement = document.querySelector(".status");
        
        setInterval(() => {
            messageIndex = (messageIndex + 1) % messages.length;
            statusElement.textContent = messages[messageIndex];
        }, 750);
        
        // Redirect after 3 seconds
        setTimeout(function() {
            window.location.href = "https://glintaafrica.com/?_route=captive_portal";
        }, 3000);
    </script>
</body>
</html>';

// Create a minified version for MikroTik
$minified_html = '<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="3;url=https://glintaafrica.com/?_route=captive_portal"><title>Glinta Africa</title><style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:Arial,sans-serif;background:#0a0a0a;color:#fff;height:100vh;display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative}.africa-bg{position:absolute;width:300px;height:350px;background:linear-gradient(135deg,#FFD700 0%,#FFA500 100%);opacity:0.1;top:50%;left:50%;transform:translate(-50%,-50%);clip-path:polygon(50% 0%,75% 10%,85% 25%,90% 40%,85% 55%,80% 70%,70% 85%,60% 95%,50% 100%,40% 95%,30% 85%,20% 70%,15% 55%,10% 40%,15% 25%,25% 10%)}.container{text-align:center;padding:2rem;position:relative;z-index:10}.logo{width:120px;height:120px;background:linear-gradient(135deg,#FFD700 0%,#FFA500 50%,#FF6347 100%);border-radius:50%;display:inline-flex;align-items:center;justify-content:center;font-size:3rem;font-weight:bold;color:#0a0a0a;margin-bottom:2rem;box-shadow:0 0 40px rgba(255,215,0,0.5);animation:pulse 2s infinite}h1{font-size:2.5rem;margin-bottom:0.5rem;color:#FFD700}.tagline{font-size:0.9rem;color:#FFA500;margin-bottom:0.5rem;text-transform:uppercase;letter-spacing:2px}.subtitle{font-size:1.1rem;color:#ccc;margin-bottom:2rem}.drum-beats{display:flex;gap:8px;justify-content:center;margin:2rem auto}.beat{width:8px;height:30px;background:#FFD700;border-radius:4px;animation:drumBeat 0.6s ease-in-out infinite}.beat:nth-child(1){animation-delay:0s}.beat:nth-child(2){animation-delay:0.1s}.beat:nth-child(3){animation-delay:0.2s}.beat:nth-child(4){animation-delay:0.3s}.beat:nth-child(5){animation-delay:0.4s}.status{color:#FFD700;font-size:1rem;margin-top:1.5rem}.features{display:flex;justify-content:center;gap:1.5rem;margin-top:1.5rem;font-size:0.85rem;color:#888}@keyframes pulse{0%,100%{transform:scale(1)}50%{transform:scale(1.05)}}@keyframes drumBeat{0%,100%{transform:scaleY(1);opacity:0.5}50%{transform:scaleY(1.5);opacity:1}}</style></head><body><div class="africa-bg"></div><div class="container"><div class="logo">GA</div><p class="tagline">Ubuntu • Unity • Progress</p><h1>Glinta Africa</h1><p class="subtitle">Empowering Digital Connectivity</p><div class="drum-beats"><div class="beat"></div><div class="beat"></div><div class="beat"></div><div class="beat"></div><div class="beat"></div></div><p class="status">🌟 Preparing your connection...</p><div class="features"><span>⚡ Fast</span><span>🔒 Secure</span><span>💳 Easy Pay</span></div></div><script>const m=["🌟 Preparing connection...","🌍 Connecting Africa...","⚡ Almost ready..."];let i=0;setInterval(()=>{document.querySelector(".status").textContent=m[i=(i+1)%m.length]},750);setTimeout(()=>{window.location.href="https://glintaafrica.com/?_route=captive_portal"},3000)</script></body></html>';

// Save both versions
file_put_contents('mikrotik_redirect_enhanced.html', $redirect_html);
file_put_contents('mikrotik_redirect_minified.html', $minified_html);

echo "Enhanced redirect pages created successfully!\n\n";
echo "Files saved:\n";
echo "1. mikrotik_redirect_enhanced.html (full version)\n";
echo "2. mikrotik_redirect_minified.html (minified for MikroTik)\n\n";

// Create the MikroTik command
$escaped_html = str_replace(['"', "\n", "\r"], ['\"', '', ''], $minified_html);
echo "To use in MikroTik, copy this command:\n\n";
echo '/file add name="hotspot/login.html" contents="' . $escaped_html . '"' . "\n";
?>