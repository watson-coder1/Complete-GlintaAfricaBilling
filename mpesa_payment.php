<?php

/**
 * M-Pesa Payment Interface for Captive Portal
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * Customer-facing payment page
 */

require_once 'init.php';

// Check if M-Pesa is enabled
if (!$config['daraja_enabled']) {
    die('M-Pesa payments are currently disabled');
}

$error = '';
$success = '';
$plans = [];

// Get available plans
$hotspot_plans = ORM::for_table('tbl_plans')->where('type', 'Hotspot')->find_many();
$pppoe_plans = ORM::for_table('tbl_plans')->where('type', 'PPPOE')->find_many();

$plans['hotspot'] = $hotspot_plans;
$plans['pppoe'] = $pppoe_plans;

// Handle payment request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $phone_number = _post('phone_number');
    $plan_id = _post('plan_id');
    $service_type = _post('service_type');
    $customer_name = _post('customer_name');
    
    // Validate input
    if (empty($phone_number) || empty($plan_id) || empty($service_type) || empty($customer_name)) {
        $error = 'All fields are required';
    } else {
        // Validate phone number
        $phone_number = preg_replace('/[^0-9]/', '', $phone_number);
        if (strlen($phone_number) < 9) {
            $error = 'Invalid phone number';
        } else {
            // Get plan details
            $plan = ORM::for_table('tbl_plans')->find_one($plan_id);
            if (!$plan) {
                $error = 'Invalid plan selected';
            } else {
                // Create or get customer
                $username = 'mpesa_' . time() . '_' . substr($phone_number, -4);
                
                $customer = ORM::for_table('tbl_customers')->where('phonenumber', $phone_number)->find_one();
                if (!$customer) {
                    $customer = ORM::for_table('tbl_customers')->create();
                    $customer->username = $username;
                    $customer->password = substr(md5($phone_number . time()), 0, 8);
                    $customer->fullname = $customer_name;
                    $customer->phonenumber = $phone_number;
                    $customer->service_type = $service_type;
                    $customer->status = 'Inactive';
                    $customer->created_at = date('Y-m-d H:i:s');
                    $customer->save();
                } else {
                    $username = $customer->username;
                }
                
                // Create payment gateway record
                $payment = ORM::for_table('tbl_payment_gateway')->create();
                $payment->username = $username;
                $payment->gateway = 'Daraja';
                $payment->plan_id = $plan_id;
                $payment->plan_name = $plan->name_plan;
                $payment->routers_id = 1; // Default router
                $payment->routers = 'Default';
                $payment->price = $plan->price;
                $payment->payment_method = 'M-Pesa STK Push';
                $payment->payment_channel = 'Mobile';
                $payment->created_date = date('Y-m-d H:i:s');
                $payment->status = 1; // Unpaid
                $payment->save();
                
                // Include Daraja functions
                include_once $PAYMENTGATEWAY_PATH . '/Daraja.php';
                
                // Initiate STK Push
                $stk_result = Daraja_stk_push(
                    $phone_number,
                    $plan->price,
                    'PAY' . $payment->id,
                    $plan->name_plan . ' - Internet Package'
                );
                
                if ($stk_result['success']) {
                    // Update payment record with checkout ID
                    $payment->checkout_request_id = $stk_result['checkout_request_id'];
                    $payment->gateway_trx_id = $stk_result['merchant_request_id'];
                    $payment->pg_request = json_encode($stk_result);
                    $payment->save();
                    
                    $success = 'Payment request sent! Please check your phone and enter your M-Pesa PIN to complete the payment.';
                    $checkout_id = $stk_result['checkout_request_id'];
                } else {
                    $error = 'Failed to initiate payment: ' . $stk_result['message'];
                    
                    // Delete failed payment record
                    $payment->delete();
                }
            }
        }
    }
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-Pesa Payment - Internet Packages</title>
    <link rel="stylesheet" href="ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="ui/ui/fonts/font-awesome/css/font-awesome.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .payment-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 500px;
            margin: 0 auto;
        }
        .payment-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .payment-body {
            padding: 30px;
        }
        .plan-card {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .plan-card:hover {
            border-color: #28a745;
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        .plan-card.selected {
            border-color: #28a745;
            background-color: #f8fff9;
        }
        .plan-price {
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
        }
        .btn-mpesa {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
            color: white;
            padding: 15px 30px;
            font-size: 16px;
            border-radius: 25px;
            width: 100%;
            transition: all 0.3s;
        }
        .btn-mpesa:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(40, 167, 69, 0.3);
        }
        .service-tabs {
            display: flex;
            margin-bottom: 20px;
        }
        .service-tab {
            flex: 1;
            padding: 10px;
            text-align: center;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            cursor: pointer;
            transition: all 0.3s;
        }
        .service-tab.active {
            background: #28a745;
            color: white;
        }
        .service-tab:first-child {
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }
        .service-tab:last-child {
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h2><i class="fa fa-wifi"></i> Internet Packages</h2>
                <p>Pay with M-Pesa for instant internet access</p>
            </div>
            
            <div class="payment-body">
                <?php if ($error): ?>
                    <div class="alert alert-danger">
                        <i class="fa fa-exclamation-triangle"></i> <?php echo $error; ?>
                    </div>
                <?php endif; ?>
                
                <?php if ($success): ?>
                    <div class="alert alert-success">
                        <i class="fa fa-check-circle"></i> <?php echo $success; ?>
                        <div class="mt-3">
                            <button class="btn btn-info" onclick="checkPaymentStatus('<?php echo $checkout_id ?? ''; ?>')">
                                <i class="fa fa-refresh"></i> Check Payment Status
                            </button>
                        </div>
                    </div>
                <?php else: ?>
                    <form method="post" id="paymentForm">
                        <div class="form-group">
                            <label>Select Service Type</label>
                            <div class="service-tabs">
                                <div class="service-tab active" data-service="Hotspot">
                                    <i class="fa fa-wifi"></i> Hotspot
                                </div>
                                <div class="service-tab" data-service="PPPOE">
                                    <i class="fa fa-globe"></i> PPPoE
                                </div>
                            </div>
                            <input type="hidden" name="service_type" id="service_type" value="Hotspot">
                        </div>
                        
                        <div class="form-group">
                            <label>Choose Package</label>
                            <div id="hotspot-plans" class="plans-container">
                                <?php foreach ($plans['hotspot'] as $plan): ?>
                                    <div class="plan-card" data-plan="<?php echo $plan->id; ?>">
                                        <div class="row">
                                            <div class="col-xs-8">
                                                <h4><?php echo $plan->name_plan; ?></h4>
                                                <small class="text-muted">
                                                    <?php if ($plan->typebp == 'Limited'): ?>
                                                        <?php echo $plan->time_limit . ' ' . $plan->time_unit; ?>
                                                    <?php else: ?>
                                                        Unlimited
                                                    <?php endif; ?>
                                                </small>
                                            </div>
                                            <div class="col-xs-4 text-right">
                                                <div class="plan-price">KSh <?php echo number_format($plan->price); ?></div>
                                            </div>
                                        </div>
                                        <input type="radio" name="plan_id" value="<?php echo $plan->id; ?>" style="display: none;">
                                    </div>
                                <?php endforeach; ?>
                            </div>
                            
                            <div id="pppoe-plans" class="plans-container" style="display: none;">
                                <?php foreach ($plans['pppoe'] as $plan): ?>
                                    <div class="plan-card" data-plan="<?php echo $plan->id; ?>">
                                        <div class="row">
                                            <div class="col-xs-8">
                                                <h4><?php echo $plan->name_plan; ?></h4>
                                                <small class="text-muted">
                                                    <?php if ($plan->typebp == 'Limited'): ?>
                                                        <?php echo $plan->time_limit . ' ' . $plan->time_unit; ?>
                                                    <?php else: ?>
                                                        Unlimited
                                                    <?php endif; ?>
                                                </small>
                                            </div>
                                            <div class="col-xs-4 text-right">
                                                <div class="plan-price">KSh <?php echo number_format($plan->price); ?></div>
                                            </div>
                                        </div>
                                        <input type="radio" name="plan_id" value="<?php echo $plan->id; ?>" style="display: none;">
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="customer_name">Full Name</label>
                            <input type="text" name="customer_name" id="customer_name" class="form-control" 
                                   placeholder="Enter your full name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone_number">M-Pesa Phone Number</label>
                            <input type="tel" name="phone_number" id="phone_number" class="form-control" 
                                   placeholder="e.g., 0712345678" required>
                        </div>
                        
                        <button type="submit" class="btn btn-mpesa">
                            <i class="fa fa-mobile"></i> Pay with M-Pesa
                        </button>
                    </form>
                <?php endif; ?>
            </div>
        </div>
    </div>
    
    <script src="ui/ui/scripts/jquery.min.js"></script>
    <script src="ui/ui/scripts/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            // Service tab switching
            $('.service-tab').click(function() {
                $('.service-tab').removeClass('active');
                $(this).addClass('active');
                
                var service = $(this).data('service');
                $('#service_type').val(service);
                
                $('.plans-container').hide();
                if (service === 'Hotspot') {
                    $('#hotspot-plans').show();
                } else {
                    $('#pppoe-plans').show();
                }
                
                // Clear selected plan
                $('.plan-card').removeClass('selected');
                $('input[name="plan_id"]').prop('checked', false);
            });
            
            // Plan selection
            $('.plan-card').click(function() {
                $('.plan-card').removeClass('selected');
                $(this).addClass('selected');
                $(this).find('input[name="plan_id"]').prop('checked', true);
            });
            
            // Form validation
            $('#paymentForm').submit(function(e) {
                if (!$('input[name="plan_id"]:checked').length) {
                    e.preventDefault();
                    alert('Please select a package');
                }
            });
        });
        
        function checkPaymentStatus(checkoutId) {
            if (!checkoutId) return;
            
            $.ajax({
                url: 'check_payment_status.php',
                method: 'POST',
                data: { checkout_id: checkoutId },
                success: function(response) {
                    if (response.success) {
                        if (response.status === 'paid') {
                            alert('Payment successful! Your internet access has been activated.');
                            location.reload();
                        } else if (response.status === 'failed') {
                            alert('Payment failed. Please try again.');
                        } else {
                            alert('Payment is still being processed. Please wait...');
                        }
                    }
                },
                error: function() {
                    alert('Error checking payment status');
                }
            });
        }
    </script>
</body>
</html>