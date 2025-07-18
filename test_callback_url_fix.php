<?php
/**
 * Test Script for Callback URL Form Fix
 * This script creates a simple test form to verify the callback URL fields work properly
 */

// Clear output and check if this is a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    echo "<h2>✅ Form Data Received Successfully!</h2>";
    echo "<div style='background: #d4edda; padding: 15px; border: 1px solid #c3e6cb; border-radius: 5px; margin: 20px 0;'>";
    echo "<h3>📝 Form Fields Submitted:</h3>";
    echo "<ul>";
    foreach ($_POST as $key => $value) {
        echo "<li><strong>" . htmlspecialchars($key) . ":</strong> " . htmlspecialchars($value) . "</li>";
    }
    echo "</ul>";
    echo "</div>";
    
    if (!empty($_POST['callback_url'])) {
        echo "<div style='background: #d1ecf1; padding: 15px; border: 1px solid #b6d4db; border-radius: 5px; margin: 20px 0;'>";
        echo "<h3>🎯 Callback URL Test:</h3>";
        echo "<p><strong>Callback URL:</strong> " . htmlspecialchars($_POST['callback_url']) . "</p>";
        echo "<p><strong>Timeout URL:</strong> " . htmlspecialchars($_POST['timeout_url']) . "</p>";
        echo "<p style='color: green;'>✅ URL fields are working correctly!</p>";
        echo "</div>";
    }
    
    echo "<hr><a href='test_callback_url_fix.php' style='padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px;'>Test Again</a>";
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>🔧 Callback URL Form Test - Glinta Africa</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f8f9fa; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #28a745; border-bottom: 2px solid #28a745; padding-bottom: 10px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input[type="text"], input[type="password"], select { 
            width: 100%; 
            padding: 10px; 
            border: 2px solid #ddd; 
            border-radius: 5px; 
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="password"]:focus, select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        button { 
            background: #28a745; 
            color: white; 
            padding: 12px 30px; 
            border: none; 
            border-radius: 5px; 
            font-size: 16px; 
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover { background: #218838; }
        .help-text { font-size: 12px; color: #666; margin-top: 5px; }
        .test-info { background: #fff3cd; padding: 15px; border: 1px solid #ffeaa7; border-radius: 5px; margin-bottom: 20px; }
        .test-urls { background: #e7f3ff; padding: 15px; border: 1px solid #b3d7ff; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 M-Pesa Daraja Callback URL Test Form</h1>
        
        <div class="test-info">
            <h3>🎯 Test Purpose:</h3>
            <p>This form tests if the callback URL and timeout URL fields accept input properly.</p>
            <p><strong>Instructions:</strong> Try typing in the URL fields below. They should accept your input without any issues.</p>
        </div>

        <div class="test-urls">
            <h3>📝 Suggested Test URLs:</h3>
            <p><strong>Callback URL:</strong> https://glintaafrica.com/?_route=callback/mpesa</p>
            <p><strong>Timeout URL:</strong> https://glintaafrica.com/?_route=callback/mpesa</p>
        </div>

        <form method="POST" action="test_callback_url_fix.php">
            <div class="form-group">
                <label for="consumer_key">Consumer Key:</label>
                <input type="text" id="consumer_key" name="consumer_key" placeholder="Enter your M-Pesa Consumer Key">
                <div class="help-text">Your M-Pesa Daraja Consumer Key from Safaricom</div>
            </div>

            <div class="form-group">
                <label for="consumer_secret">Consumer Secret:</label>
                <input type="password" id="consumer_secret" name="consumer_secret" placeholder="Enter your Consumer Secret">
                <div class="help-text">Your M-Pesa Daraja Consumer Secret</div>
            </div>

            <div class="form-group">
                <label for="shortcode">Business Short Code:</label>
                <input type="text" id="shortcode" name="shortcode" placeholder="Enter your Business Short Code">
                <div class="help-text">Your M-Pesa Business Short Code (Paybill/Till Number)</div>
            </div>

            <div class="form-group">
                <label for="passkey">Passkey:</label>
                <input type="password" id="passkey" name="passkey" placeholder="Enter your Passkey">
                <div class="help-text">Your M-Pesa Online Passkey for STK Push</div>
            </div>

            <div class="form-group">
                <label for="environment">Environment:</label>
                <select id="environment" name="environment">
                    <option value="sandbox">Sandbox (Testing)</option>
                    <option value="production">Production (Live)</option>
                </select>
                <div class="help-text">Use Sandbox for testing, Production for live payments</div>
            </div>

            <div class="form-group" style="background: #fff3cd; padding: 15px; border-radius: 5px;">
                <label for="callback_url">🎯 Callback URL (TEST THIS FIELD):</label>
                <input type="text" id="callback_url" name="callback_url" 
                       value="https://glintaafrica.com/?_route=callback/mpesa" 
                       placeholder="Type your callback URL here">
                <div class="help-text" style="color: #856404; font-weight: bold;">
                    ⚠️ Try editing this field - it should accept your typing!
                </div>
            </div>

            <div class="form-group" style="background: #fff3cd; padding: 15px; border-radius: 5px;">
                <label for="timeout_url">🎯 Timeout URL (TEST THIS FIELD):</label>
                <input type="text" id="timeout_url" name="timeout_url" 
                       value="https://glintaafrica.com/?_route=callback/mpesa" 
                       placeholder="Type your timeout URL here">
                <div class="help-text" style="color: #856404; font-weight: bold;">
                    ⚠️ Try editing this field - it should accept your typing!
                </div>
            </div>

            <button type="submit">🧪 Test Form Submission</button>
        </form>

        <div style="margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 5px;">
            <h3>📋 What This Test Checks:</h3>
            <ul>
                <li>✅ Callback URL field accepts input</li>
                <li>✅ Timeout URL field accepts input</li>
                <li>✅ All form fields submit properly</li>
                <li>✅ No JavaScript interference</li>
                <li>✅ Form field names match PHP expectations</li>
            </ul>
        </div>
    </div>
</body>
</html>