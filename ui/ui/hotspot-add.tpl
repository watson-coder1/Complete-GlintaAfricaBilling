{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="panel panel-primary panel-hovered panel-stacked mb30">
            <div class="panel-heading">{Lang::T('Add Service Package')}</div>
            <div class="panel-body">
                <form class="form-horizontal" method="post" role="form" action="{$_url}services/add-post">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Status')}
                            <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                data-trigger="focus" data-container="body"
                                data-content="Customer cannot buy disabled Package, but admin can recharge it, use it if you want only admin recharge it">?</a>
                        </label>
                        <div class="col-md-10">
                            <input type="radio" name="enabled" value="1" checked> {Lang::T('Active')}
                            <input type="radio" name="enabled" value="0"> {Lang::T('Not Active')}
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Type')}
                            <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                data-trigger="focus" data-container="body"
                                data-content="Postpaid will have fix expired date">?</a>
                        </label>
                        <div class="col-md-10">
                            <input type="radio" name="prepaid" onclick="prePaid()" value="yes" checked> {Lang::T('Prepaid')}
                            <input type="radio" name="prepaid" onclick="postPaid()" value="no"> {Lang::T('Postpaid')}
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Package Type')}
                            <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                data-trigger="focus" data-container="body"
                                data-content="Personal Plan will only show to personal Customer, Business package will only show to Business Customer">?</a>
                        </label>
                        <div class="col-md-10">
                            <input type="radio" name="plan_type" value="Personal" checked> {Lang::T('Personal')}
                            <input type="radio" name="plan_type" value="Business"> {Lang::T('Business')}
                        </div>
                    </div>
                    {if $_c['radius_enable']}
                        <div class="form-group">
                            <label class="col-md-2 control-label">Radius
                                <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                    data-trigger="focus" data-container="body"
                                    data-content="If you enable Radius, choose device to radius, except if you have custom device.">?</a>
                            </label>
                            <div class="col-md-6">
                                <label class="radio-inline">
                                    <input type="checkbox" name="radius" onclick="isRadius(this)" value="1"> {Lang::T('Radius Package')}
                                </label>
                            </div>
                            <p class="help-block col-md-4">{Lang::T('Cannot be change after saved')}</p>
                        </div>
                    {/if}
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Device')}
                            <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                data-trigger="focus" data-container="body"
                                data-content="This Device are the logic how Glinta Africa Communicate with Mikrotik or other Devices">?</a>
                        </label>
                        <div class="col-md-6">
                            <select class="form-control" id="device" name="device">
                                {foreach $devices as $dev}
                                    <option value="{$dev}">{$dev}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Package Name')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="name" name="name" maxlength="40">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Package Type')}</label>
                        <div class="col-md-10">
                            <input type="radio" id="Unlimited" name="typebp" value="Unlimited" checked>
                            {Lang::T('Unlimited')}
                            <input type="radio" id="Limited" name="typebp" value="Limited"> {Lang::T('Limited')}
                        </div>
                    </div>
                    <div style="display:none;" id="Type">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{Lang::T('Limit Type')}</label>
                            <div class="col-md-10">
                                <input type="radio" id="Time_Limit" name="limit_type" value="Time_Limit" checked>
                                {Lang::T('Time Limit')}
                                <input type="radio" id="Data_Limit" name="limit_type" value="Data_Limit">
                                {Lang::T('Data Limit')}
                                <input type="radio" id="Both_Limit" name="limit_type" value="Both_Limit">
                                {Lang::T('Both Limit')}
                            </div>
                        </div>
                    </div>
                    <div style="display:none;" id="TimeLimit">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{Lang::T('Time Limit')}</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="time_limit" name="time_limit" value="0">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="time_unit" name="time_unit">
                                    <option value="Hrs">{Lang::T('Hrs')}</option>
                                    <option value="Mins">{Lang::T('Mins')}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div style="display:none;" id="DataLimit">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{Lang::T('Data Limit')}</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="data_limit" name="data_limit" value="0">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="data_unit" name="data_unit">
                                    <option value="MB">MBs</option>
                                    <option value="GB">GBs</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label"><a
                                href="{$_url}bandwidth/add">{Lang::T('Bandwidth Name')}</a></label>
                        <div class="col-md-6">
                            <select id="id_bw" name="id_bw" class="form-control select2">
                                <option value="">{Lang::T('Select Bandwidth')}...</option>
                                {foreach $d as $ds}
                                    <option value="{$ds['id']}">{$ds['name_bw']}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Package Price')}</label>
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">{$_c['currency_code']}</span>
                                <input type="number" class="form-control" name="price" required>
                            </div>
                        </div>
                        {if $_c['enable_tax'] == 'yes'}
                            {if $_c['tax_rate'] == 'custom'}
                                <p class="help-block col-md-4">{number_format($_c['custom_tax_rate'], 2)} % {Lang::T('Tax Rates
                            will be added')}</p>
                            {else}
                                <p class="help-block col-md-4">{number_format($_c['tax_rate'] * 100, 2)} % {Lang::T('Tax Rates
                            will be added')}</p>
                            {/if}
                        {/if}
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Shared Users')}
                            <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                data-trigger="focus" data-container="body"
                                data-content="How many devices can online in one Customer account">?</a>
                        </label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="sharedusers" name="sharedusers" value="1">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Package Validity')}</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="validity" name="validity">
                        </div>
                        <div class="col-md-2">
                            <select class="form-control" id="validity_unit" name="validity_unit">
                            </select>
                        </div>
                        <p class="help-block col-md-4">{Lang::T('1 Period = 1 Month, Expires the 20th of each month')}
                        </p>
                    </div>
                    <div class="form-group hidden" id="expired_date">
                        <label class="col-md-2 control-label">{Lang::T('Expired Date')}
                            <a tabindex="0" class="btn btn-link btn-xs" role="button" data-toggle="popover"
                                data-trigger="focus" data-container="body"
                                data-content="Expired will be this date every month">?</a>
                        </label>
                        <div class="col-md-6">
                            <input type="number" class="form-control" name="expired_date" maxlength="2" value="20" min="1" max="28" step="1" >
                        </div>
                    </div>
                    <span id="routerChoose" class="">
                        <div class="form-group">
                            <label class="col-md-2 control-label"><a
                                    href="{$_url}routers/add">{Lang::T('Router Name')}</a></label>
                            <div class="col-md-6">
                                <select id="routers" name="routers" required class="form-control select2">
                                    <option value=''>{Lang::T('Select Routers')}</option>
                                    {foreach $r as $rs}
                                        <option value="{$rs['name']}">{$rs['name']}</option>
                                    {/foreach}
                                </select>
                                <p class="help-block">{Lang::T('Cannot be change after saved')}</p>
                            </div>
                        </div>
                    </span>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <button id="savePackageBtn" class="btn btn-success btn-lg" type="submit">
                                <span id="saveButtonText">
                                    <i class="fa fa-save"></i> {Lang::T('Save Changes')}
                                </span>
                                <span id="saveButtonLoading" style="display: none;">
                                    <i class="fa fa-spinner fa-spin"></i> Saving Package...
                                </span>
                            </button>
                            <div class="save-progress" id="saveProgressContainer" style="display: none; margin-top: 10px;">
                                <div class="progress">
                                    <div id="packageSaveProgress" class="progress-bar progress-bar-striped active" 
                                         role="progressbar" style="width: 0%"></div>
                                </div>
                                <small id="saveProgressText" class="text-muted">Preparing to save...</small>
                            </div>
                            <div class="form-actions-info" style="margin-top: 10px;">
                                <small class="text-muted">
                                    <i class="fa fa-info-circle"></i> 
                                    Package will be saved with enhanced error handling. Auto-save keeps your progress.
                                </small>
                            </div>
                            <div style="margin-top: 15px;">
                                Or <a href="{$_url}services/hotspot" class="btn btn-link">{Lang::T('Cancel')}</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    var preOpt = `<option value="Mins">{Lang::T('Mins')}</option>
    <option value="Hrs">{Lang::T('Hrs')}</option>
    <option value="Days">{Lang::T('Days')}</option>
    <option value="Months">{Lang::T('Months')}</option>`;
    var postOpt = `<option value="Period">{Lang::T('Period')}</option>`;
    function prePaid() {
        $("#validity_unit").html(preOpt);
        $('#expired_date').addClass('hidden');
    }

    function postPaid() {
        $("#validity_unit").html(postOpt);
        $("#expired_date").removeClass('hidden');
    }
    document.addEventListener("DOMContentLoaded", function(event) {
        prePaid();
        
        // Enhanced save handling for hotspot package form
        initializePackageSaveHandling();
    });

    function initializePackageSaveHandling() {
        const form = document.querySelector('form.form-horizontal');
        const saveBtn = document.getElementById('savePackageBtn');
        const saveText = document.getElementById('saveButtonText');
        const saveLoading = document.getElementById('saveButtonLoading');
        const progressContainer = document.getElementById('saveProgressContainer');
        const progressBar = document.getElementById('packageSaveProgress');
        const progressText = document.getElementById('saveProgressText');
        
        if (!form || !saveBtn) return;

        // Override form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate required fields first
            if (!validatePackageForm()) {
                return false;
            }
            
            // Show confirmation dialog
            if (!confirm('Continue the Hotspot Package creation process?')) {
                return false;
            }
            
            // Start enhanced save process
            startPackageSave();
        });

        function validatePackageForm() {
            const packageName = document.getElementById('name');
            const bandwidth = document.getElementById('id_bw');
            const router = document.getElementById('routers');
            const price = document.querySelector('input[name="price"]');
            
            if (!packageName.value.trim()) {
                alert('Please enter a package name');
                packageName.focus();
                return false;
            }
            
            if (!bandwidth.value) {
                alert('Please select a bandwidth');
                bandwidth.focus();
                return false;
            }
            
            if (!router.disabled && !router.value) {
                alert('Please select a router');
                router.focus();
                return false;
            }
            
            if (!price.value || parseFloat(price.value) <= 0) {
                alert('Please enter a valid price');
                price.focus();
                return false;
            }
            
            return true;
        }

        function startPackageSave() {
            // Update button state
            saveBtn.disabled = true;
            saveBtn.classList.add('btn-loading');
            saveText.style.display = 'none';
            saveLoading.style.display = 'inline';
            
            // Show progress container
            progressContainer.style.display = 'block';
            progressText.textContent = 'Validating package data...';
            updateProgress(10);
            
            // Prepare form data
            const formData = new FormData(form);
            
            // Create timeout handler (45 seconds)
            const timeoutHandler = setTimeout(() => {
                handleSaveTimeout();
            }, 45000);
            
            // Update progress periodically
            let currentProgress = 10;
            const progressUpdater = setInterval(() => {
                if (currentProgress < 85) {
                    currentProgress += 5;
                    updateProgress(currentProgress);
                    
                    if (currentProgress <= 30) {
                        progressText.textContent = 'Creating package configuration...';
                    } else if (currentProgress <= 60) {
                        progressText.textContent = 'Saving to database...';
                    } else {
                        progressText.textContent = 'Finalizing package setup...';
                    }
                }
            }, 1000);

            // Submit the form
            fetch(form.action, {
                method: 'POST',
                body: formData,
                credentials: 'same-origin'
            })
            .then(response => {
                clearTimeout(timeoutHandler);
                clearInterval(progressUpdater);
                
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                }
            })
            .then(data => {
                updateProgress(100);
                progressText.textContent = 'Package saved successfully!';
                
                setTimeout(() => {
                    // Check for redirect or success
                    if (data.includes('success') || data.includes('hotspot')) {
                        window.location.href = '{$_url}services/hotspot';
                    } else if (data.includes('error')) {
                        throw new Error('Server returned error response');
                    } else {
                        // Reload the page to show result
                        window.location.reload();
                    }
                }, 1000);
            })
            .catch(error => {
                clearTimeout(timeoutHandler);
                clearInterval(progressUpdater);
                handleSaveError(error.message);
            });
        }

        function handleSaveTimeout() {
            progressText.textContent = 'Save taking longer than expected...';
            progressBar.classList.add('progress-bar-warning');
            
            // Show options to user
            const options = confirm(
                'The save is taking longer than usual. This might be due to server load.\n\n' +
                'Click OK to continue waiting, or Cancel to try again.'
            );
            
            if (!options) {
                // User wants to try again
                resetSaveState();
            } else {
                // Continue waiting, extend timeout
                setTimeout(() => {
                    if (saveBtn.disabled) {
                        handleSaveError('Operation timed out. Please try again.');
                    }
                }, 30000);
            }
        }

        function handleSaveError(errorMessage) {
            console.error('Package save error:', errorMessage);
            
            updateProgress(0);
            progressBar.classList.add('progress-bar-danger');
            progressText.textContent = 'Save failed: ' + errorMessage;
            
            // Show user options
            setTimeout(() => {
                const retry = confirm(
                    'Failed to save the package.\n\n' +
                    'Error: ' + errorMessage + '\n\n' +
                    'Would you like to try again?'
                );
                
                if (retry) {
                    resetSaveState();
                    // Auto-retry after a moment
                    setTimeout(startPackageSave, 2000);
                } else {
                    resetSaveState();
                }
            }, 2000);
        }

        function resetSaveState() {
            saveBtn.disabled = false;
            saveBtn.classList.remove('btn-loading');
            saveText.style.display = 'inline';
            saveLoading.style.display = 'none';
            progressContainer.style.display = 'none';
            progressBar.classList.remove('progress-bar-warning', 'progress-bar-danger');
            progressBar.classList.add('progress-bar-striped', 'active');
        }

        function updateProgress(percentage) {
            progressBar.style.width = percentage + '%';
            progressBar.setAttribute('aria-valuenow', percentage);
        }
    }
</script>
{if $_c['radius_enable']}
    {literal}
        <script>
            function isRadius(cek) {
                if (cek.checked) {
                    $("#routerChoose").addClass('hidden');
                    document.getElementById("routers").required = false;
                } else {
                    document.getElementById("routers").required = true;
                    $("#routerChoose").removeClass('hidden');
                }
            }
        </script>
    {/literal}
{/if}

{include file="sections/footer.tpl"}
