<?php
echo "Updating captive_portal_success.tpl with proper authentication...\n";

// Read the template file
$template_file = "ui/ui/captive_portal_success.tpl";
$content = file_get_contents($template_file);

// Backup first
copy($template_file, $template_file . ".backup");
echo "✓ Backup created: {$template_file}.backup\n";

// Find and replace the buildMikrotikAuthUrl function
$start_marker = "function buildMikrotikAuthUrl() {";
$end_marker = "var mikrotikAuthUrl = buildMikrotikAuthUrl();";

$start_pos = strpos($content, $start_marker);
$end_pos = strpos($content, $end_marker);

if ($start_pos !== false && $end_pos !== false) {
    // New function code
    $new_function = '// Build proper MikroTik authentication URL with RADIUS credentials
function buildMikrotikAuthUrl() {
    var loginUrl = \'{$mikrotik_link_login_only}\' || \'http://192.168.88.1/login\';
    var username = \'{$radius_username}\' || \'{$mikrotik_username}\';
    var password = \'{$radius_password}\' || \'{$mikrotik_password}\';
    var dst = \'https://www.google.com\';

    console.log(\'=== Building MikroTik Auth URL ===\');
    console.log(\'Login URL:\', loginUrl);
    console.log(\'RADIUS Username:\', username);
    console.log(\'RADIUS Password:\', password);
    console.log(\'Destination:\', dst);

    // Method 1: Try iframe authentication first
    var iframe = document.createElement(\'iframe\');
    iframe.style.display = \'none\';
    iframe.src = loginUrl + \'?username=\' + encodeURIComponent(username) +
                 \'&password=\' + encodeURIComponent(password) +
                 \'&dst=\' + encodeURIComponent(dst);
    document.body.appendChild(iframe);

    // Method 2: Form submission as backup
    setTimeout(function() {
        var form = document.createElement(\'form\');
        form.method = \'POST\';
        form.action = loginUrl;
        form.style.display = \'none\';

        var fields = {
            \'username\': username,
            \'password\': password,
            \'dst\': dst,
            \'popup\': \'true\'
        };

        for (var key in fields) {
            var input = document.createElement(\'input\');
            input.type = \'hidden\';
            input.name = key;
            input.value = fields[key];
            form.appendChild(input);
        }

        document.body.appendChild(form);
        form.submit();
    }, 1500);

    // Return destination URL
    return dst;
}

// Auto-authenticate on page load
window.addEventListener(\'load\', function() {
    console.log(\'Page loaded, starting MikroTik authentication...\');
    setTimeout(function() {
        buildMikrotikAuthUrl();
    }, 500);
});

// Update the redirect URL to use MikroTik authentication
';

    // Replace the old function
    $before = substr($content, 0, $start_pos);
    $after = substr($content, $end_pos);

    $content = $before . $new_function . $after;

    // Write back
    file_put_contents($template_file, $content);
    echo "✓ Updated captive_portal_success.tpl with new authentication code\n";
} else {
    echo "⚠ Could not find the function to replace. Manual update may be needed.\n";
}

echo "\nNow clearing cache and restarting services...\n";
