
{* Enhanced Monthly Registered Customers Chart *}
<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">📊 Monthly Customer Registrations (Real Data)</h3>
        <div class="box-tools pull-right">
            <span class="label label-primary">Hotspot + PPPoE</span>
        </div>
    </div>
    <div class="box-body">
        <div class="row">
            <div class="col-md-8">
                <canvas id="enhancedRegistrationsChart" height="200"></canvas>
            </div>
            <div class="col-md-4">
                <div class="info-box bg-blue">
                    <span class="info-box-icon"><i class="fa fa-users"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">This Month</span>
                        <span class="info-box-number">{$realtime_metrics.current_month.new_customers}</span>
                    </div>
                </div>
                <div class="info-box bg-green">
                    <span class="info-box-icon"><i class="fa fa-user-plus"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Today</span>
                        <span class="info-box-number">{$realtime_metrics.today.registrations}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{* Enhanced Monthly Sales Chart *}
<div class="box box-success">
    <div class="box-header with-border">
        <h3 class="box-title">💰 Monthly Revenue (M-Pesa Only)</h3>
        <div class="box-tools pull-right">
            <span class="label label-success">Real Payments</span>
        </div>
    </div>
    <div class="box-body">
        <div class="row">
            <div class="col-md-8">
                <canvas id="enhancedSalesChart" height="200"></canvas>
            </div>
            <div class="col-md-4">
                <div class="info-box bg-green">
                    <span class="info-box-icon"><i class="fa fa-money"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">This Month</span>
                        <span class="info-box-number">KES {$realtime_metrics.current_month.revenue|number_format}</span>
                    </div>
                </div>
                <div class="info-box bg-yellow">
                    <span class="info-box-icon"><i class="fa fa-mobile"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Today</span>
                        <span class="info-box-number">KES {$realtime_metrics.today.revenue|number_format}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Enhanced Customer Registrations Chart
var enhancedRegCtx = document.getElementById("enhancedRegistrationsChart").getContext("2d");
var enhancedRegistrationData = {
    labels: [
        {foreach $enhanced_monthly_registered as $data}
            "{$data.month_name}"{if !$data@last},{/if}
        {/foreach}
    ],
    datasets: [{
        label: "Hotspot Customers",
        backgroundColor: "rgba(54, 162, 235, 0.6)",
        borderColor: "rgba(54, 162, 235, 1)",
        data: [
            {foreach $enhanced_monthly_registered as $data}
                {$data.hotspot}{if !$data@last},{/if}
            {/foreach}
        ]
    }, {
        label: "PPPoE Customers", 
        backgroundColor: "rgba(255, 99, 132, 0.6)",
        borderColor: "rgba(255, 99, 132, 1)",
        data: [
            {foreach $enhanced_monthly_registered as $data}
                {$data.pppoe}{if !$data@last},{/if}
            {/foreach}
        ]
    }]
};

new Chart(enhancedRegCtx, {
    type: "bar",
    data: enhancedRegistrationData,
    options: {
        responsive: true,
        scales: {
            x: { stacked: true },
            y: { 
                stacked: true,
                beginAtZero: true,
                ticks: { stepSize: 1 }
            }
        },
        plugins: {
            title: {
                display: true,
                text: "Customer Registrations by Service Type"
            }
        }
    }
});

// Enhanced Monthly Sales Chart  
var enhancedSalesCtx = document.getElementById("enhancedSalesChart").getContext("2d");
var enhancedSalesData = {
    labels: [
        {foreach $enhanced_monthly_sales as $data}
            "{$data.month_name}"{if !$data@last},{/if}
        {/foreach}
    ],
    datasets: [{
        label: "Hotspot Revenue (KES)",
        backgroundColor: "rgba(75, 192, 192, 0.6)",
        borderColor: "rgba(75, 192, 192, 1)",
        data: [
            {foreach $enhanced_monthly_sales as $data}
                {$data.hotspot_revenue}{if !$data@last},{/if}
            {/foreach}
        ]
    }, {
        label: "PPPoE Revenue (KES)",
        backgroundColor: "rgba(153, 102, 255, 0.6)", 
        borderColor: "rgba(153, 102, 255, 1)",
        data: [
            {foreach $enhanced_monthly_sales as $data}
                {$data.pppoe_revenue}{if !$data@last},{/if}
            {/foreach}
        ]
    }]
};

new Chart(enhancedSalesCtx, {
    type: "line",
    data: enhancedSalesData,
    options: {
        responsive: true,
        scales: {
            y: { 
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return "KES " + value.toLocaleString();
                    }
                }
            }
        },
        plugins: {
            title: {
                display: true,
                text: "Monthly Revenue by Service Type (M-Pesa Payments Only)"
            }
        }
    }
});
</script>
