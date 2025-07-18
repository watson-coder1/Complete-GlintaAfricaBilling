<?php
/**
 * Direct test of Daraja form fields
 */
?>
<!DOCTYPE html>
<html>
<head>
    <title>Daraja Form Direct Test</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .test-section { background: #f0f0f0; padding: 20px; margin: 20px 0; border-radius: 5px; }
        input { width: 100%; padding: 10px; margin: 10px 0; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>🔧 Daraja Form Direct Test</h1>
    
    <div class="test-section">
        <h2>Test 1: Exact Copy of Daraja Form Fields</h2>
        <form method="POST">
            <div class="form-group">
                <label for="callback_url">Callback URL</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="callback_url" 
                           name="callback_url" value="https://glintaafrica.com/?_route=callback/mpesa">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="alert('Copy button clicked')">
                            Copy
                        </button>
                    </span>
                </div>
                <small class="help-block">Configure this URL in your Daraja App settings</small>
            </div>
            
            <div class="form-group">
                <label for="timeout_url">Timeout URL</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="timeout_url" 
                           name="timeout_url" value="https://glintaafrica.com/?_route=callback/mpesa">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="alert('Copy button clicked')">
                            Copy
                        </button>
                    </span>
                </div>
                <small class="help-block">Timeout callback URL for failed transactions</small>
            </div>
            
            <button type="submit">Test Submit</button>
        </form>
        
        <?php
        if ($_POST) {
            echo "<div class='success'>";
            echo "<h3>✅ Form submitted successfully!</h3>";
            echo "<p>Callback URL: " . htmlspecialchars($_POST['callback_url'] ?? 'Not received') . "</p>";
            echo "<p>Timeout URL: " . htmlspecialchars($_POST['timeout_url'] ?? 'Not received') . "</p>";
            echo "</div>";
        }
        ?>
    </div>
    
    <div class="test-section">
        <h2>JavaScript Field Check</h2>
        <button onclick="checkFields()">Check Fields Status</button>
        <div id="field-status"></div>
    </div>
    
    <script>
    function checkFields() {
        var status = document.getElementById('field-status');
        var callback = document.getElementById('callback_url');
        var timeout = document.getElementById('timeout_url');
        
        var html = '<h3>Field Status:</h3>';
        
        if (callback) {
            html += '<p class="success">✅ Callback URL field found</p>';
            html += '<ul>';
            html += '<li>ReadOnly: ' + callback.readOnly + '</li>';
            html += '<li>Disabled: ' + callback.disabled + '</li>';
            html += '<li>Type: ' + callback.type + '</li>';
            html += '<li>Value: ' + callback.value + '</li>';
            html += '</ul>';
        } else {
            html += '<p class="error">❌ Callback URL field not found</p>';
        }
        
        if (timeout) {
            html += '<p class="success">✅ Timeout URL field found</p>';
            html += '<ul>';
            html += '<li>ReadOnly: ' + timeout.readOnly + '</li>';
            html += '<li>Disabled: ' + timeout.disabled + '</li>';
            html += '<li>Type: ' + timeout.type + '</li>';
            html += '<li>Value: ' + timeout.value + '</li>';
            html += '</ul>';
        } else {
            html += '<p class="error">❌ Timeout URL field not found</p>';
        }
        
        status.innerHTML = html;
    }
    
    // Auto-check on load
    window.onload = function() {
        console.log('Page loaded, checking fields...');
        checkFields();
    };
    </script>
    
    <div class="test-section">
        <h2>🎯 Next Steps:</h2>
        <ol>
            <li>Can you type in the fields above?</li>
            <li>Click "Check Fields Status" to see field properties</li>
            <li>If this works but Daraja form doesn't, it's a template/JavaScript issue</li>
            <li>Check browser console (F12) for errors</li>
        </ol>
        
        <p><strong>Go back to Daraja form:</strong><br>
        <a href="http://localhost/?_route=paymentgateway/Daraja">http://localhost/?_route=paymentgateway/Daraja</a></p>
    </div>
</body>
</html>