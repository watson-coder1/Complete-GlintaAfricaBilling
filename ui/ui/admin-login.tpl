<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Admin Login - Glinta Africa</title>
    <link rel="shortcut icon" href="ui/ui/images/logo.png" type="image/x-icon" />

    <link rel="stylesheet" href="ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="ui/ui/styles/modern-AdminLTE.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 0;
            width: 100%;
            max-width: 400px;
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, #2C3E50 0%, #3498DB 100%);
            color: white;
            padding: 40px 30px 30px;
            text-align: center;
            position: relative;
        }

        .login-logo {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .login-logo img {
            width: 50px;
            height: 50px;
            object-fit: contain;
        }

        .company-name {
            font-size: 28px;
            font-weight: 700;
            margin: 0 0 10px 0;
            letter-spacing: -0.5px;
        }

        .company-name .highlight {
            color: #3498DB;
        }

        .login-subtitle {
            font-size: 16px;
            opacity: 0.9;
            margin: 0;
            font-weight: 300;
        }

        .login-body {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-control {
            height: 50px;
            border: 2px solid #E8ECF4;
            border-radius: 12px;
            padding: 15px 20px 15px 50px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #F8F9FA;
        }

        .form-control:focus {
            border-color: #3498DB;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            background: white;
            outline: none;
        }

        .form-control::placeholder {
            color: #8E9BAE;
            font-weight: 400;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #8E9BAE;
            font-size: 18px;
            z-index: 10;
        }

        .login-btn {
            background: linear-gradient(135deg, #3498DB 0%, #2C3E50 100%);
            border: none;
            height: 50px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
            background: linear-gradient(135deg, #2980B9 0%, #1A252F 100%);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-danger {
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A24 100%);
            color: white;
        }

        .alert-success {
            background: linear-gradient(135deg, #00D2FF 0%, #3A7BD5 100%);
            color: white;
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 10px;
                border-radius: 15px;
            }
            
            .login-header {
                padding: 30px 20px 20px;
            }
            
            .login-body {
                padding: 30px 20px;
            }
            
            .company-name {
                font-size: 24px;
            }
        }

        .background-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }

        .background-animation::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% { transform: translateY(0px) rotate(0deg); }
            100% { transform: translateY(-100px) rotate(360deg); }
        }
    </style>
</head>

<body>
    <div class="background-animation"></div>
    
    <div class="login-container">
        <div class="login-header">
            <div class="login-logo">
                <img src="{$app_url}/ui/ui/images/logo.png" alt="Glinta Africa Logo" onerror="this.style.display='none'; this.parentNode.innerHTML='<i class=\'fas fa-wifi\' style=\'color: #3498DB; font-size: 30px;\'></i>';">
            </div>
            <h1 class="company-name">
                <span class="highlight">Glinta</span>Africa
            </h1>
            <p class="login-subtitle">ISP Management System</p>
        </div>
        
        <div class="login-body">
            <h3 style="text-align: center; margin-bottom: 30px; color: #2C3E50; font-weight: 600;">Admin Portal</h3>
            
            {if isset($notify)}
                {$notify}
            {/if}
            
            <form action="{$_url}admin/post" method="post">
                <input type="hidden" name="csrf_token" value="{$csrf_token}">
                
                <div class="form-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" required class="form-control" name="username" placeholder="Enter your username">
                </div>
                
                <div class="form-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" required class="form-control" name="password" placeholder="Enter your password">
                </div>
                
                <button type="submit" class="btn login-btn btn-block">
                    <i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>
                    Access Admin Panel
                </button>
            </form>
            
            <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #E8ECF4;">
                <small style="color: #8E9BAE;">
                    <i class="fas fa-shield-alt" style="margin-right: 5px;"></i>
                    Secure Admin Access
                </small>
            </div>
        </div>
    </div>
</body>

</html>