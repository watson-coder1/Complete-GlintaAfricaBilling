<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Processing Payment - Glinta Africa WiFi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #000000, #006B3F, #FFD700);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        .logo {
            font-size: 48px;
            color: #FFD700;
            margin-bottom: 20px;
        }
        .status {
            font-size: 24px;
            color: #006B3F;
            margin: 20px 0;
        }
        .message {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .loading {
            width: 50px;
            height: 50px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #006B3F;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .package-info {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .package-info h3 {
            color: #006B3F;
            margin-bottom: 15px;
        }
        .package-detail {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
        }
        .help {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            text-align: left;
        }
        .help h4 {
            color: #856404;
            margin-bottom: 10px;
        }
        .help ul {
            color: #856404;
            margin-left: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">G</div>
        <h1>Glinta Africa WiFi</h1>
        
        <div id="status" class="status">Processing M-Pesa Payment...</div>
        <div id="message" class="message">
            Check your phone for the M-Pesa STK push notification and enter your PIN to complete the transaction.
        </div>
        
        <div class="loading" id="loading"></div>
        
        {if $plan}
        <div class="package-info">
            <h3>📦 Package: {$plan->name_plan}</h3>
            <div class="package-detail">
                <span>Amount:</span>
                <strong>KES {$plan->price}</strong>
            </div>
            <div class="package-detail">
                <span>Duration:</span>
                <strong>{$plan->validity} {$plan->validity_unit}</strong>
            </div>
        </div>
        {/if}
        
        <div class="help">
            <h4>💡 Payment Help</h4>
            <ul>
                <li>Ensure you have sufficient M-Pesa balance</li>
                <li>Check if your phone number is registered for M-Pesa</li>
                <li>Try again after a few minutes if STK push fails</li>
                <li>Contact 0711311897 for support</li>
            </ul>
        </div>
    </div>
    
    <script>
        // Simple, guaranteed JavaScript polling
        var sessionId = '{$session_id}';
        var baseUrl = '{$_url}';
        var pollCount = 0;
        var maxPolls = 40; // 2 minutes at 3-second intervals
        
        // Test that JavaScript is working
        document.getElementById('message').innerHTML += '<br><small style="color: green;">JavaScript loaded successfully!</small>';
        
        // Simple polling function
        function checkStatus() {
            pollCount++;
            
            // Update loading message
            document.getElementById('message').innerHTML = 'Checking payment status... (attempt ' + pollCount + ')';
            
            // Create XMLHttpRequest
            var xhr = new XMLHttpRequest();
            xhr.open('POST', baseUrl + 'captive_portal/status/' + sessionId, true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        try {
                            var data = JSON.parse(xhr.responseText);
                            
                            if (data.status === 'completed') {
                                // Payment successful!
                                document.getElementById('status').innerText = '✅ Payment Successful!';
                                document.getElementById('message').innerHTML = 'Your payment has been processed. Redirecting to success page...';
                                document.getElementById('loading').style.display = 'none';
                                
                                // Redirect after 2 seconds
                                setTimeout(function() {
                                    window.location.href = data.redirect || baseUrl + 'captive_portal/success/' + sessionId;
                                }, 2000);
                                return;
                            } else if (data.status === 'failed') {
                                // Payment failed
                                document.getElementById('status').innerText = '❌ Payment Failed';
                                document.getElementById('message').innerHTML = 'Payment failed: ' + data.message;
                                document.getElementById('loading').style.display = 'none';
                                return;
                            }
                            // Otherwise continue polling
                        } catch (e) {
                            console.error('JSON parse error:', e);
                        }
                    }
                    
                    // Continue polling if not completed and under max attempts
                    if (pollCount < maxPolls) {
                        setTimeout(checkStatus, 3000); // Check again in 3 seconds
                    } else {
                        // Timeout
                        document.getElementById('status').innerText = '⏰ Checking Timeout';
                        document.getElementById('message').innerHTML = 'Payment check timeout. If you completed payment, please refresh the page or contact support.';
                        document.getElementById('loading').style.display = 'none';
                    }
                }
            };
            
            xhr.send(JSON.stringify({check: true}));
        }
        
        // Start checking after 2 seconds
        setTimeout(checkStatus, 2000);
        
        // Visual feedback that polling started
        setTimeout(function() {
            document.getElementById('message').innerHTML += '<br><small style="color: blue;">Starting payment monitoring...</small>';
        }, 1000);
        
    </script>
</body>
</html>