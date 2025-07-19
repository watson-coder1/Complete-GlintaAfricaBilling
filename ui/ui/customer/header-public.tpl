<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>{$_title} - {$_c['CompanyName']}</title>
    <link rel="shortcut icon" href="ui/ui/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" type="image/png" sizes="32x32" href="ui/ui/images/favicon-32x32.png">
    <link rel="apple-touch-icon" href="ui/ui/images/favicon.png">

    <link rel="stylesheet" href="ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="ui/ui/styles/modern-AdminLTE.min.css">
    <link rel="stylesheet" href="ui/ui/styles/sweetalert2.min.css" />
    <script src="ui/ui/scripts/sweetalert2.all.min.js"></script>



</head>

<body id="app" class="app off-canvas body-full">
    <div class="container">
        <div class="form-head mb20">
            <h1 class="site-logo h2 mb5 mt5 text-center text-uppercase text-bold"
                style="text-shadow: 2px 2px 4px #757575;">{$_c['CompanyName']}</h1>
            <hr>
        </div>
        {if isset($notify)}
            <script>
                // Display SweetAlert toast notification
                Swal.fire({
                    icon: '{if $notify_t == "s"}success{else}warning{/if}',
                    title: '{$notify}',
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 5000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer)
                        toast.addEventListener('mouseleave', Swal.resumeTimer)
                    }
                });
            </script>
        {/if}