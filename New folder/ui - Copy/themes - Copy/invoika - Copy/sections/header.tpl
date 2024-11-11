<!DOCTYPE html>
<html>

<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="light" data-sidebar-size="lg"
    data-sidebar-image="none" data-preloader="disable">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>{$_title} - {$_c['CompanyName']}</title>
<link rel="shortcut icon" href="ui/ui/images/logo.png" type="image/x-icon" />
<link rel="stylesheet" href="ui/ui/fonts/ionicons/css/ionicons.min.css">
<link rel="stylesheet" href="ui/ui/fonts/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="ui/ui/styles/select2.min.css" />
<link rel="stylesheet" href="ui/ui/styles/select2-bootstrap.min.css" />
<link rel="stylesheet" href="ui/ui/styles/sweetalert2.min.css" />
<link rel="stylesheet" href="ui/ui/styles/plugins/pace.css" />
<script src="ui/ui/scripts/sweetalert2.all.min.js"></script>

<link href="ui/themes/invoika/assets/libs/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css" />
<script src="ui/themes/invoika/assets/js/layout.js"></script>
<link href="ui/themes/invoika/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="ui/themes/invoika/assets/css/app.min.css" rel="stylesheet" type="text/css" />
<link href="ui/themes/invoika/assets/css/icons.min.css" rel="stylesheet" type="text/css" />

<style>
    ::-moz-selection {
        /* Code for Firefox */
        color: rgb(255, 255, 255);
        background: rgb(88, 0, 165);
    }

    ::selection {
        color: rgb(255, 255, 255);
        background: rgb(88, 0, 165);
    }

    .select2-container .select2-selection--single .select2-selection__rendered {
        margin-top: 0px !important;
    }

    @media (min-width: 768px) {
        .outer {
            height: 200px
                /* Or whatever */
        }
    }

    th:first-child,
    td:first-child {
        position: sticky;
        left: 0px;
        background-color: #f9f9f9;
    }


    .text1line {
        display: block;
        /* or inline-block */
        text-overflow: ellipsis;
        word-wrap: break-word;
        overflow: hidden;
        max-height: 1em;
        line-height: 1em;
    }
</style>

{if isset($xheader)}
    {$xheader}
{/if}

</head>

<body>

    <div id="layout-wrapper">

        <header id="page-topbar">
            <div class="layout-width">
                <div class="navbar-header">
                    <div class="d-flex">
                        <!-- LOGO -->
                        <div class="navbar-brand-box horizontal-logo">
                            <a href="{$_url}dashboard" class="logo logo-dark">
                                <span class="logo-sm">
                                    <span class="logo-lg">{$_c['CompanyName']}</span>
                                </span>
                                <span class="logo-lg">
                                    <span class="logo-lg">{$_c['CompanyName']}</span>
                                </span>
                            </a>

                            <a href="{$_url}dashboard" class="logo logo-light">
                                <span class="logo-sm">
                                    <span class="logo-lg">{$_c['CompanyName']}</span>
                                </span>
                                <span class="logo-lg">
                                    <span class="logo-lg">{$_c['CompanyName']}</span>
                                </span>
                            </a>
                        </div>

                        <button type="button"
                            class="btn btn-sm px-3 fs-16 header-item vertical-menu-btn topnav-hamburger"
                            id="topnav-hamburger-icon">
                            <span class="hamburger-icon">
                                <span></span>
                                <span></span>
                                <span></span>
                            </span>
                        </button>


                    </div>

                    <div class="d-flex align-items-center">


                        <div class="ms-1 header-item d-none d-sm-flex">
                            <button type="button" class="btn btn-icon btn-topbar btn-ghost-primary rounded-circle"
                                data-toggle="fullscreen">
                                <i class='las la-expand fs-24'></i>
                            </button>
                        </div>

                        <div class="ms-1 header-item d-none d-sm-flex">
                            <button type="button"
                                class="btn btn-icon btn-topbar btn-ghost-primary rounded-circle light-dark-mode">
                                <i class='las la-moon fs-24'></i>
                            </button>
                        </div>

                        <div class="dropdown header-item">
                            <button type="button" class="btn" id="page-header-user-dropdown" data-bs-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                <span class="d-flex align-items-center">
                                    <img class="rounded-circle header-profile-user"
                                        src="ui/themes/invoika/assets/images/users/avatar-4.jpg" alt="Header Avatar">
                                    <span class="text-start ms-xl-2">
                                        <span class="d-none d-xl-inline-block fw-medium user-name-text fs-16">Calvin
                                            D. <i class="las la-angle-down fs-12 ms-1"></i></span>
                                    </span>
                                </span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-end">
                                <!-- item-->
                                <a class="dropdown-item" href="#"><i class="bx bx-user fs-15 align-middle me-1"></i>
                                    <span key="t-profile">Profile</span></a>
                                <a class="dropdown-item" href="#"><i class="bx bx-wallet fs-15 align-middle me-1"></i>
                                    <span key="t-my-wallet">My
                                        Wallet</span></a>
                                <a class="dropdown-item d-block" href="#"><span
                                        class="badge bg-success float-end">11</span><i
                                        class="bx bx-wrench fs-15 align-middle me-1"></i>
                                    <span key="t-settings">Settings</span></a>
                                <a class="dropdown-item" href="auth-lockscreen.html"><i
                                        class="bx bx-lock-open fs-15 align-middle me-1"></i>
                                    <span key="t-lock-screen">Lock
                                        screen</span></a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="#"><i
                                        class="bx bx-power-off fs-15 align-middle me-1 text-danger"></i>
                                    <span key="t-logout">Logout</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="app-menu navbar-menu">
            <!-- LOGO -->
            <div class="navbar-brand-box">
                <!-- Dark Logo-->
                <a href="{$_url}dashboard" class="logo logo-dark">
                    <span class="logo-sm">
                        <span class="logo-lg">{$_c['CompanyName']}</span>
                    </span>
                    <span class="logo-lg">
                        <span class="logo-lg">{$_c['CompanyName']}</span>
                    </span>
                </a>
                <!-- Light Logo-->
                <a href="{$_url}dashboard" class="logo logo-light">
                    <span class="logo-sm">
                        <span class="logo-lg">{$_c['CompanyName']}</span>
                    </span>
                    <span class="logo-lg">
                        <span class="logo-lg">{$_c['CompanyName']}</span>
                    </span>
                </a>
                <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover"
                    id="vertical-hover">
                    <i class="ri-record-circle-line"></i>
                </button>
            </div>

            <div id="scrollbar">
                <div class="container-fluid">
                    <div id="two-column-menu"></div>
                    <ul class="navbar-nav" id="navbar-nav">
                        <li class="menu-title"><span data-key="t-menu">Menu</span></li>
                        <li class="nav-item">
                            <a class="nav-link menu-link active" href="{$_url}dashboard">
                                <i class="las la-house-damage"></i> <span data-key="t-dashboard">Dashboard</span>
                            </a>
                        </li>
                        {$_MENU_AFTER_DASHBOARD}
                        {if !in_array($_admin['user_type'],['Report'])}
                            <li class="nav-item">
                                <a class="nav-link menu-link collapsed" href="#sidebarcustomers" data-bs-toggle="collapse"
                                    role="button" aria-expanded="false" aria-controls="sidebarcustomers">
                                    <i class="las la-users"></i> <span data-key="t-customers">{Lang::T('Customer')}</span>
                                </a>
                                <div class="menu-dropdown collapse {if in_array($_system_menu, ['customers', 'map'])}show{/if}"
                                    id="sidebarcustomers" style="">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="{$_url}customers"
                                                class="nav-link {if $_system_menu eq 'customers' }active{/if}"
                                                data-key="t-lists">{Lang::T('Lists')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}map/customer"
                                                class="nav-link {if $_system_menu eq 'map' }active{/if}"
                                                data-key="t-location">{Lang::T('Location')}</a>
                                        </li>
                                        {$_MENU_CUSTOMERS}
                                    </ul>
                                </div>
                            </li>
                            {$_MENU_AFTER_CUSTOMERS}
                            <li class="nav-item">
                                <a class="nav-link menu-link collapsed" href="#sidebarservices" data-bs-toggle="collapse"
                                    role="button" aria-expanded="false" aria-controls="sidebarservices">
                                    <i class="las bi-ticket"></i> <span data-key="t-services">{Lang::T('Services')}</span>
                                </a>
                                <div class="menu-dropdown collapse {if in_array($_system_menu, ['plan'])}show{/if}"
                                    id="sidebarservices" style="">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="{$_url}plan/voucher"
                                                class="nav-link {if $_routes[1] eq 'voucher' }active{/if}"
                                                data-key="t-vouchers">{Lang::T('Vouchers')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}plan/refill"
                                                class="nav-link {if $_routes[1] eq 'refill' }active{/if}"
                                                data-key="t-refill">{Lang::T('Refill Customer')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}plan/recharge"
                                                class="nav-link {if $_routes[1] eq 'recharge' }active{/if}"
                                                data-key="t-recharge">{Lang::T('Recharge Customer')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}plan/deposit"
                                                class="nav-link {if $_routes[1] eq 'deposit' }active{/if}"
                                                data-key="t-deposit">{Lang::T('Refill Balance')}</a>
                                        </li>
                                        {$_MENU_SERVICES}
                                    </ul>
                                </div>
                            </li>
                        {/if}
                        {$_MENU_AFTER_SERVICES}
                        {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                            <li class="nav-item">
                                <a class="nav-link menu-link collapsed" href="#sidebarinternetplan"
                                    data-bs-toggle="collapse" role="button" aria-expanded="false"
                                    aria-controls="sidebarinternetplan">
                                    <i class="ion ion-cube"></i> <span
                                        data-key="t-internet-plan">{Lang::T('Internet Plan')}</span>
                                </a>
                                <div class="menu-dropdown collapse {if $_system_menu eq 'services'}show{/if}"
                                    id="sidebarinternetplan" style="">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="{$_url}services/hotspot"
                                                class="nav-link {if $_routes[1] eq 'hotspot' }active{/if}"
                                                data-key="t-hotspot">Hotspot</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}services/pppoe"
                                                class="nav-link {if $_routes[1] eq 'pppoe' }active{/if}"
                                                data-key="t-pppoe">PPPOE</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}bandwidth/list"
                                                class="nav-link {if $_routes[1] eq 'list' }active{/if}"
                                                data-key="t-bandwidth">{Lang::T('Bandwidth')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}services/balance"
                                                class="nav-link {if $_routes[1] eq 'balance' }active{/if}"
                                                data-key="t-balance">{Lang::T('Customer Balance')}</a>
                                        </li>
                                        {$_MENU_PLANS}
                                    </ul>
                                </div>
                            </li>
                        {/if}
                        {$_MENU_AFTER_PLANS}
                        <li class="nav-item">
                            <a class="nav-link menu-link collapsed" href="#sidebarreports" data-bs-toggle="collapse"
                                role="button" aria-expanded="false" aria-controls="sidebarreports">
                                <i class="ion ion-clipboard"></i> <span data-key="t-reports">{Lang::T('Reports')}</span>
                            </a>
                            <div class="menu-dropdown collapse {if $_system_menu eq 'reports'}show{/if}"
                                id="sidebarreports" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="{$_url}reports/daily-report"
                                            class="nav-link {if $_routes[1] eq 'daily-report' }active{/if}"
                                            data-key="t-daily-report">{Lang::T('Daily Reports')}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="{$_url}reports/by-period"
                                            class="nav-link {if $_routes[1] eq 'by-period' }active{/if}"
                                            data-key="t-by-period">{Lang::T('Period Reports')}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="{$_url}reports/activation"
                                            class="nav-link {if $_routes[1] eq 'activation' }active{/if}"
                                            data-key="t-activation">{Lang::T('Activation History')}</a>
                                    </li>
                                    {$_MENU_REPORTS}
                                </ul>
                            </div>
                        </li>
                        {$_MENU_AFTER_REPORTS}
                        <li class="nav-item">
                            <a class="nav-link menu-link collapsed" href="#sidebarsendmessage" data-bs-toggle="collapse"
                                role="button" aria-expanded="false" aria-controls="sidebarsendmessage">
                                <i class="ion ion-android-chat"></i> <span
                                    data-key="t-send-message">{Lang::T('Send Message')}</span>
                            </a>
                            <div class="menu-dropdown collapse {if $_system_menu eq 'message'}show{/if}"
                                id="sidebarsendmessage" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="{$_url}message/send"
                                            class="nav-link {if $_routes[1] eq 'send' }active{/if}"
                                            data-key="t-single-customer">{Lang::T('Single Customer')}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="{$_url}message/send_bulk"
                                            class="nav-link {if $_routes[1] eq 'send_bulk' }active{/if}"
                                            data-key="t-bulk-customers">{Lang::T('Bulk Customers')}</a>
                                    </li>
                                    {$_MENU_MESSAGE}
                                </ul>
                            </div>
                        </li>
                        {$_MENU_AFTER_MESSAGE}
                        {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                            <li class="nav-item">
                                <a class="nav-link menu-link collapsed" href="#sidebarnetwork" data-bs-toggle="collapse"
                                    role="button" aria-expanded="false" aria-controls="sidebarnetwork">
                                    <i class="ion ion-network"></i> <span data-key="t-network">{Lang::T('Network')}</span>
                                </a>
                                <div class="menu-dropdown collapse {if $_system_menu eq 'network'}show{/if}"
                                    id="sidebarnetwork" style="">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="{$_url}routers/list"
                                                class="nav-link {if $_routes[0] eq 'routers' and $_routes[1] eq 'list' }active{/if}"
                                                data-key="t-routers">{Lang::T('Routers')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}pool/list"
                                                class="nav-link {if $_routes[0] eq 'pool' and $_routes[1] eq 'list' }active{/if}"
                                                data-key="t-ip-pool">{Lang::T('IP Pool')}</a>
                                        </li>
                                        {$_MENU_NETWORK}
                                    </ul>
                                </div>
                            </li>
                            {$_MENU_AFTER_NETWORKS}
                            {if $_admin['user_type'] eq 'SuperAdmin'}
                                <li class="nav-item">
                                    <a class="nav-link menu-link collapsed" href="#sidebarmanager" data-bs-toggle="collapse"
                                        role="button" aria-expanded="false" aria-controls="sidebarmanager">
                                        <i class="ion ion-person-stalker"></i> <span
                                            data-key="t-manager">{Lang::T('Manager')}</span>
                                    </a>
                                    <div class="menu-dropdown collapse {if $_system_menu eq 'manager'}show{/if}"
                                        id="sidebarmanager" style="">
                                        <ul class="nav nav-sm flex-column">
                                            <li class="nav-item">
                                                <a href="{$_url}users/list"
                                                    class="nav-link {if $_routes[0] eq 'users' and $_routes[1] eq 'list' }active{/if}"
                                                    data-key="t-users">{Lang::T('Users')}</a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="{$_url}users/role"
                                                    class="nav-link {if $_routes[0] eq 'users' and $_routes[1] eq 'role' }active{/if}"
                                                    data-key="t-role">{Lang::T('Role')}</a>
                                            </li>
                                            {$_MENU_MANAGER}
                                        </ul>
                                    </div>
                                </li>
                                {$_MENU_AFTER_MANAGER}
                            {/if}
                        {/if}
                        {$_MENU_AFTER_PAGES}
                        <li class="nav-item">
                            <a class="nav-link menu-link collapsed" href="#sidebarsettings" data-bs-toggle="collapse"
                                role="button" aria-expanded="false" aria-controls="sidebarsettings">
                                <i class="ion ion-gear-a"></i> <span>{Lang::T('Settings')}</span>
                            </a>
                            <div class="menu-dropdown collapse {if $_system_menu eq 'settings' || $_system_menu eq 'paymentgateway'}show{/if}"
                                id="sidebarsettings" style="">
                                <ul class="nav nav-sm flex-column">
                                    {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                                        <li class="nav-item">
                                            <a href="{$_url}settings/app"
                                                class="nav-link {if $_system_menu eq 'app' }active{/if}"
                                                data-key="t-lists">{Lang::T('General Settings')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}settings/localisation"
                                                class="nav-link {if $_system_menu eq 'localisation' }active{/if}"
                                                data-key="t-lists">{Lang::T('Localisation')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}settings/maintenance"
                                                class="nav-link {if $_system_menu eq 'maintenance' }active{/if}"
                                                data-key="t-lists">{Lang::T('Maintenance Mode')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}settings/notifications"
                                                class="nav-link {if $_system_menu eq 'notifications' }active{/if}"
                                                data-key="t-lists">{Lang::T('User Notification')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}settings/devices"
                                                class="nav-link {if $_system_menu eq 'devices' }active{/if}"
                                                data-key="t-lists">{Lang::T('Devices')}</a>
                                        </li>
                                    {/if}
                                    {if in_array($_admin['user_type'],['SuperAdmin','Admin','Agent'])}
                                        <li class="nav-item">
                                            <a href="{$_url}settings/users"
                                                class="nav-link {if $_system_menu eq 'users' }active{/if}"
                                                data-key="t-lists">{Lang::T('Administrator Users')}</a>
                                        </li>
                                    {/if}
                                    {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                                        <li class="nav-item">
                                            <a href="{$_url}settings/dbstatus"
                                                class="nav-link {if $_system_menu eq 'dbstatus' }active{/if}"
                                                data-key="t-lists">{Lang::T('Backup/Restore')}</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="{$_url}paymentgateway"
                                                class="nav-link {if $_system_menu eq 'paymentgateway' }active{/if}"
                                                data-key="t-lists">
                                                <span class="text">{Lang::T('Payment Gateway')}</span>
                                            </a>
                                        </li>
                                        {$_MENU_SETTINGS}
                                        <li class="nav-item">
                                            <a href="{$_url}pluginmanager"
                                                class="nav-link {if $_system_menu eq 'pluginmanager' }active{/if}"
                                                data-key="t-lists"><i class="glyphicon glyphicon-tasks"></i>
                                                {Lang::T('Plugin Manager')} <small class="label pull-right">Free</small></a>
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                        </li>
                        {$_MENU_AFTER_SETTINGS}
                        {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                            <li class="nav-item">
                                <a class="nav-link menu-link collapsed" href="#sidebarlogs" data-bs-toggle="collapse"
                                    role="button" aria-expanded="false" aria-controls="sidebarlogs">
                                    <i class="ion ion-clock"></i> <span>{Lang::T('Logs')}</span>
                                </a>
                                <div class="menu-dropdown collapse {if $_system_menu eq 'logs'}show{/if}" id="sidebarlogs"
                                    style="">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="{$_url}logs/phpnuxbill"
                                                class="nav-link {if $_system_menu eq 'phpnuxbill' }active{/if}"
                                                data-key="t-lists">PhpNuxBill</a>
                                        </li>
                                        {if $_c['radius_enable']}
                                            <li class="nav-item">
                                                <a href="{$_url}logs/radius"
                                                    class="nav-link {if $_system_menu eq 'radius' }active{/if}"
                                                    data-key="t-lists">Radius</a>
                                            </li>
                                        {/if}
                                        {$_MENU_LOGS}
                                    </ul>
                                </div>
                            </li>
                        {/if}
                        {$_MENU_AFTER_LOGS}
                        {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                            <li class="nav-item">
                                <a href="{if $_c['docs_clicked'] != 'yes'}{$_url}settings/docs{else}./docs/{/if}"
                                    class="nav-link {if $_system_menu eq 'community'}active{/if}">
                                    <i class="ion ion-ios-bookmarks"></i>
                                    <span class="text">{Lang::T('Documentation')}</span>
                                    {if $_c['docs_clicked'] != 'yes'}
                                        <span class="pull-right-container"><small
                                                class="label pull-right bg-green">New</small></span>
                                    {/if}
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="{$_url}community" class="nav-link {if $_system_menu eq 'community'}active{/if}">
                                    <i class="ion ion-chatboxes"></i>
                                    <span class="text">{Lang::T('Community')}</span>
                                </a>
                            </li>
                        {/if}
                        {$_MENU_AFTER_COMMUNITY}

                        <div class="help-box text-center">
                            <img src="assets/images/create-invoice.png" class="img-fluid" alt>
                            <p class="mb-3 mt-2 text-muted">Upgrade To Pro
                                For More Features</p>
                            <div class="mt-3">
                                <a href="invoice-add.html" class="btn btn-primary"> Create
                                    Invoice</a>
                            </div>
                        </div>
                    </ul>
                </div>
            </div>
            <div class="sidebar-background"></div>
        </div>



        <div class="vertical-overlay"></div>



        <div class="main-content">

            <div class="page-content">
                <div class="container-fluid">


                    <section class="content-header">
                        <h1>{$_title} </h1>
                    </section>
                    {if isset($notify)}
                        <script>
                            // Display SweetAlert toast notification
                            Swal.fire({
                                icon: '{if $notify_t == "s"}success{else}error{/if}',
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