<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Admin Login - Glinta Africa</title>
    <link rel="shortcut icon" href="ui/ui/images/favicon.png" type="image/png" />
    <link rel="icon" type="image/png" sizes="32x32" href="ui/ui/images/favicon.png">
    <link rel="apple-touch-icon" href="ui/ui/images/favicon.png">

    <link rel="stylesheet" href="ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="ui/ui/styles/modern-AdminLTE.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background: #000000;
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        /* Professional gold gradient background pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                linear-gradient(45deg, #D4AF37 25%, transparent 25%),
                linear-gradient(-45deg, #D4AF37 25%, transparent 25%),
                linear-gradient(45deg, transparent 75%, #D4AF37 75%),
                linear-gradient(-45deg, transparent 75%, #D4AF37 75%);
            background-size: 30px 30px;
            background-position: 0 0, 0 15px, 15px -15px, -15px 0px;
            opacity: 0.03;
            z-index: 1;
        }

        .login-container {
            background: #0A0A0A;
            border: 1px solid #D4AF37;
            border-radius: 0;
            box-shadow: 0 0 40px rgba(212, 175, 55, 0.3);
            padding: 0;
            width: 100%;
            max-width: 450px;
            position: relative;
            z-index: 2;
        }

        .login-header {
            background: #000000;
            border-bottom: 3px solid #D4AF37;
            color: #D4AF37;
            padding: 50px 40px 40px;
            text-align: center;
            position: relative;
        }

        /* Gold accent line */
        .login-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 1px;
            background: linear-gradient(90deg, transparent, #D4AF37, transparent);
        }

        .login-logo {
            width: 90px;
            height: 90px;
            margin: 0 auto 25px;
            background: #000000;
            border: 2px solid #D4AF37;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .login-logo::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            border: 1px solid #D4AF37;
            opacity: 0.5;
        }

        .login-logo img {
            width: 60px;
            height: 60px;
            object-fit: contain;
            filter: brightness(0) invert(1);
        }

        .company-name {
            font-size: 32px;
            font-weight: 300;
            margin: 0 0 10px 0;
            letter-spacing: 4px;
            text-transform: uppercase;
            color: #D4AF37;
        }

        .company-name .highlight {
            font-weight: 700;
        }

        .login-subtitle {
            font-size: 13px;
            margin: 0;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #8B7500;
        }

        .login-body {
            padding: 50px 40px;
            background: #0A0A0A;
        }

        .login-title {
            text-align: center;
            margin-bottom: 40px;
            color: #D4AF37;
            font-weight: 300;
            font-size: 18px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .form-group {
            margin-bottom: 30px;
            position: relative;
        }

        .form-control {
            height: 55px;
            border: 1px solid #333333;
            border-radius: 0;
            padding: 15px 20px 15px 55px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #000000;
            color: #FFFFFF;
        }

        .form-control:focus {
            border-color: #D4AF37;
            box-shadow: 0 0 0 1px #D4AF37;
            background: #000000;
            outline: none;
            color: #FFFFFF;
        }

        .form-control::placeholder {
            color: #666666;
            font-weight: 300;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 1px;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #D4AF37;
            font-size: 16px;
            z-index: 10;
        }

        .login-btn {
            background: #D4AF37;
            border: none;
            height: 55px;
            border-radius: 0;
            font-size: 14px;
            font-weight: 600;
            color: #000000;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            overflow: hidden;
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .login-btn:hover {
            background: #B8941F;
            transform: translateY(-1px);
            box-shadow: 0 5px 20px rgba(212, 175, 55, 0.4);
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 0;
            border: 1px solid;
            padding: 15px 20px;
            margin-bottom: 25px;
            font-weight: 400;
            font-size: 14px;
        }

        .alert-danger {
            background: #1A0000;
            border-color: #8B0000;
            color: #FF6B6B;
        }

        .alert-success {
            background: #001A00;
            border-color: #228B22;
            color: #90EE90;
        }

        .security-notice {
            text-align: center;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #1A1A1A;
        }

        .security-notice small {
            color: #666666;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .security-notice i {
            color: #D4AF37;
            margin-right: 8px;
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 10px;
            }
            
            .login-header {
                padding: 40px 30px 30px;
            }
            
            .login-body {
                padding: 40px 30px;
            }
            
            .company-name {
                font-size: 26px;
            }
        }

        /* Professional corner accents */
        .login-container::before,
        .login-container::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            border: 1px solid #D4AF37;
        }

        .login-container::before {
            top: -1px;
            left: -1px;
            border-right: none;
            border-bottom: none;
        }

        .login-container::after {
            bottom: -1px;
            right: -1px;
            border-left: none;
            border-top: none;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <div class="login-header">
            <div class="login-logo">
                <img src="{$app_url}/ui/ui/images/glinta-logo.png" alt="Glinta Africa Logo" onerror="this.style.display='none'; this.parentNode.innerHTML='<i class=\'fas fa-wifi\' style=\'color: #D4AF37; font-size: 40px;\'></i>';">            </div>
            <h1 class="company-name">
                <span class="highlight">GLINTA</span>AFRICA
            </h1>
            <p class="login-subtitle">ISP Management System</p>
        </div>
        
        <div class="login-body">
            <h3 class="login-title">Administrator Access</h3>
            
            {if isset($notify)}
                {$notify}
            {/if}
            
            <form action="{$_url}admin/post" method="post">
                <input type="hidden" name="csrf_token" value="{$csrf_token}">
                
                <div class="form-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" required class="form-control" name="username" placeholder="Username">
                </div>
                
                <div class="form-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" required class="form-control" name="password" placeholder="Password">
                </div>
                
                <button type="submit" class="btn login-btn btn-block">
                    <i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>
                    LOGIN
                </button>
            </form>
            
            <div class="security-notice">
                <small>
                    <i class="fas fa-shield-alt"></i>
                    SECURE ADMINISTRATION PORTAL
                </small>
            </div>
        </div>
    </div>
</body>

</html>