<!DOCTYPE html>
<html lang="en">

<head>
    <title>SpeedRadius Installer</title>
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <link type='text/css' href='css/style.css' rel='stylesheet' />
    <link type='text/css' href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body style='background-color: #FBFBFB;'>
    <div id='main-container'>
        <img src="img/logo.png" class="img-responsive" alt="Logo" />
        <hr>

        <div class="span12">
            <h4> SpeedRadius Installer </h4>
            <?php
            $passed = '';
            $ltext = '';
            if (version_compare(PHP_VERSION, '7.2.0') >= 0) {
                $ltext .= 'To Run SpeedRadius  You need at least PHP version 7.2.0, Your PHP Version is: ' . PHP_VERSION . " Tested <strong>---PASSED---</strong><br/>";
                $passed .= '1';
            } else {
                $ltext .= 'To Run SpeedRadius  You need at least PHP version 7.2.0, Your PHP Version is: ' . PHP_VERSION . " Tested <strong>---FAILED---</strong><br/>";
                $passed .= '0';
            }

            if (extension_loaded('PDO')) {
                $ltext .= 'PDO is installed on your server: ' . "Tested <strong>---PASSED---</strong><br/>";
                $passed .= '1';
            } else {
                $ltext = 'PDO is installed on your server: ' . "Tested <strong>---FAILED---</strong><br/>";
                $passed .= '0';
            }

            if (extension_loaded('pdo_mysql')) {
                $ltext .= 'PDO MySQL driver is enabled on your server: ' . "Tested <strong>---PASSED---</strong><br/>";
                $passed .= '1';
            } else {
                $ltext .= 'PDO MySQL driver is not enabled on your server: ' . "Tested <strong>---FAILED---</strong><br/>";
                $passed .= '0';
            }

            if ($passed == '111') {
                echo ("<br/> $ltext <br/> Great! System Test Completed. You can run SpeedRadius on your server. Click Continue For Next Step.
				<br><br>
                <a href=\"update.php\" class=\"btn btn-warning\">Update System From SpeedRadius</a>
                <br><br><br><br>
				<a href=\"step3.php\" class=\"btn btn-primary\">Continue to Install SpeedRadius</a><br><br>");
            } else {
                echo ("<br/> $ltext <br/> Sorry. The requirements of SpeedRadius  is not available on your server.
				Contact with us at Whatsapp <a href=\"https://t.me/phpnuxbill\">@phpnuxbill</a> with this code- $passed Or contact with your server administrator
				<br><br>
				<a href=\"#\" class=\"btn btn-primary disabled\">Correct The Problem To Continue</a>");
            }
            ?>
        </div>
    </div>
    <div class="footer">Copyright &copy; 2024 SpeedRadius. All Rights Reserved<br /><br /></div>
</body>

</html>