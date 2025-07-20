<?php
// Create an appealing redirect page for MikroTik hotspot
$redirect_html = '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="2;url=https://glintaafrica.com/?_route=captive_portal">
    <title>Glinta Africa - Connecting You</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            color: #ffffff;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .container {
            text-align: center;
            padding: 2rem;
            position: relative;
            z-index: 10;
        }
        
        .logo-container {
            margin-bottom: 2rem;
            animation: pulse 2s ease-in-out infinite;
        }
        
        .logo {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: bold;
            color: #1a1a1a;
            box-shadow: 0 10px 30px rgba(255, 215, 0, 0.3);
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(90deg, #FFD700, #FFA500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .subtitle {
            font-size: 1.2rem;
            color: #cccccc;
            margin-bottom: 2rem;
        }
        
        .loader {
            width: 60px;
            height: 60px;
            margin: 2rem auto;
            position: relative;
        }
        
        .loader-circle {
            width: 100%;
            height: 100%;
            border: 3px solid rgba(255, 215, 0, 0.1);
            border-top: 3px solid #FFD700;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        .status {
            color: #FFD700;
            font-size: 1.1rem;
            margin-top: 1rem;
            animation: fadeInOut 2s ease-in-out infinite;
        }
        
        .africa-pattern {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.05;
            background-image: 
                repeating-linear-gradient(45deg, transparent, transparent 35px, #FFD700 35px, #FFD700 70px),
                repeating-linear-gradient(-45deg, transparent, transparent 35px, #FFA500 35px, #FFA500 70px);
            z-index: 1;
        }
        
        .dots {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 2;
        }
        
        .dot {
            position: absolute;
            width: 4px;
            height: 4px;
            background: #FFD700;
            border-radius: 50%;
            opacity: 0;
            animation: float 4s linear infinite;
        }
        
        .dot:nth-child(1) { left: 10%; animation-delay: 0s; }
        .dot:nth-child(2) { left: 30%; animation-delay: 0.5s; }
        .dot:nth-child(3) { left: 50%; animation-delay: 1s; }
        .dot:nth-child(4) { left: 70%; animation-delay: 1.5s; }
        .dot:nth-child(5) { left: 90%; animation-delay: 2s; }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @keyframes fadeInOut {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }
        
        @keyframes float {
            0% {
                bottom: -10%;
                opacity: 0;
            }
            10% {
                opacity: 0.5;
            }
            90% {
                opacity: 0.5;
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
        }
    </style>
</head>
<body>
    <div class="africa-pattern"></div>
    <div class="dots">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
    </div>
    
    <div class="container">
        <div class="logo-container">
            <div class="logo">GA</div>
        </div>
        
        <h1>Glinta Africa</h1>
        <p class="subtitle">Connecting Communities Across Africa</p>
        
        <div class="loader">
            <div class="loader-circle"></div>
        </div>
        
        <p class="status">Redirecting to payment portal...</p>
    </div>
    
    <script>
        // Fallback redirect in case meta refresh fails
        setTimeout(function() {
            window.location.href = "https://glintaafrica.com/?_route=captive_portal";
        }, 2000);
    </script>
</body>
</html>';

// Save the HTML content to a file
file_put_contents('mikrotik_redirect.html', $redirect_html);

echo "Redirect page created successfully!\n\n";
echo "The HTML has been saved to 'mikrotik_redirect.html'\n\n";
echo "To use this in MikroTik, copy this command:\n\n";

// Create the MikroTik command with properly escaped content
$escaped_html = str_replace(['"', "\n", "\r"], ['\"', '', ''], $redirect_html);
echo '/file add name="hotspot/login.html" contents="' . $escaped_html . '"' . "\n";
?>