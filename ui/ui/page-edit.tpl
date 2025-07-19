{include file="sections/header.tpl"}

<form id="formpages" method="post" role="form" action="{$_url}pages/{$PageFile}-post">
    <div class="row">
        <div class="{if $action=='Voucher'}col-md-8{else}col-md-12{/if}">
            <div class="panel mb20 panel-primary panel-hovered">
                <div class="panel-heading">
                    {if $action!='Voucher'}
                        <div class="btn-group pull-right">
                            <a class="btn btn-danger btn-xs" title="Reset File" href="{$_url}pages/{$PageFile}-reset"
                                onclick="return ask(this, 'Reset File?')"><span class="glyphicon glyphicon-refresh"
                                    aria-hidden="true"></span></a>
                        </div>
                    {/if}
                    {$pageHeader}
                </div>
                <textarea name="html" id="summernote">{$htmls}</textarea>
                {if $writeable}
                    <div class="panel-footer">
                        {if $action=='Voucher'}
                            <label>
                                <input type="checkbox" name="template_save" value="yes"> {Lang::T('Save as template')}
                            </label>
                            <div class="input-group">
                                <span class="input-group-addon" id="basic-addon3">{Lang::T('Template Name')}</span>
                                <input type="text" class="form-control" id="template_name" name="template_name">
                            </div>
                            <br>
                        {/if}
                        <div class="btn-group btn-group-justified" role="group">
                            <div class="btn-group" role="group">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fa fa-save"></i> {Lang::T('Save')}
                                </button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" id="autoSaveToggle" class="btn btn-default" title="Toggle Auto-Save">
                                    <i class="fa fa-clock-o"></i> Auto-Save: <span id="autoSaveStatus">ON</span>
                                </button>
                            </div>
                        </div>
                        <br>
                        <div class="alert alert-info" style="margin-top: 10px;">
                            <i class="fa fa-info-circle"></i> 
                            <strong>Enhanced Save:</strong> Auto-save every 30s • Retry on timeout • Progress indicators • Content backup
                        </div>
                        <input type="text" class="form-control" onclick="this.select()" readonly
                            value="{$app_url}/{$PAGES_PATH}/{$PageFile}.html">
                    </div>
                {else}
                    <div class="panel-footer">
                        {Lang::T("Failed to save page, make sure i can write to folder pages, <i>chmod 664 pages/*.html<i>")}
                    </div>
                {/if}
                {if $PageFile=='Voucher'}
                    <div class="panel-footer">
                        <p class="help-block">
                            <b>[[company_name]]</b> {Lang::T('Your Company Name at Settings')}.<br>
                            <b>[[price]]</b> {Lang::T('Package Price')}.<br>
                            <b>[[voucher_code]]</b> {Lang::T('Voucher Code')}.<br>
                            <b>[[plan]]</b> {Lang::T('Voucher Package')}.<br>
                            <b>[[counter]]</b> {Lang::T('Counter')}.<br>
                        </p>
                    </div>
                {/if}
            </div>
        </div>
        {if $action=='Voucher'}
            <div class="col-md-4">
                {foreach $vouchers as $v}
                    {if is_file("$PAGES_PATH/vouchers/$v")}
                        <div class="panel mb20 panel-primary panel-hovered" style="cursor: pointer;" onclick="selectTemplate(this)">
                            <div class="panel-heading">{str_replace(".html", '', $v)}</div>
                            <div class="panel-body">{include file="$PAGES_PATH/vouchers/$v"}</div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        {/if}
    </div>
</form>
<!-- Include Enhanced Save Script -->
<script src="{$app_url}/ui/ui/scripts/enhanced-save.js"></script>

{literal}
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {
            $('#summernote').summernote();
            
            // Setup auto-save toggle
            let autoSaveEnabled = true;
            const autoSaveToggle = document.getElementById('autoSaveToggle');
            const autoSaveStatus = document.getElementById('autoSaveStatus');
            
            if (autoSaveToggle) {
                autoSaveToggle.addEventListener('click', function() {
                    autoSaveEnabled = !autoSaveEnabled;
                    autoSaveStatus.textContent = autoSaveEnabled ? 'ON' : 'OFF';
                    this.className = autoSaveEnabled ? 'btn btn-success' : 'btn btn-default';
                    
                    // Store preference
                    localStorage.setItem('autoSaveEnabled', autoSaveEnabled);
                });
                
                // Load saved preference
                const savedPreference = localStorage.getItem('autoSaveEnabled');
                if (savedPreference !== null) {
                    autoSaveEnabled = savedPreference === 'true';
                    autoSaveStatus.textContent = autoSaveEnabled ? 'ON' : 'OFF';
                    autoSaveToggle.className = autoSaveEnabled ? 'btn btn-success' : 'btn btn-default';
                }
            }
            
            // Add save status indicator
            const saveIndicator = document.createElement('div');
            saveIndicator.id = 'saveStatusIndicator';
            saveIndicator.style.cssText = `
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 8px 12px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                z-index: 1000;
                display: none;
            `;
            document.body.appendChild(saveIndicator);
        });

        function selectTemplate(f) {
            let children = f.children;
            $('#template_name').val(children[0].innerHTML)
            $('#summernote').summernote('code', children[1].innerHTML);
            window.scrollTo(0, 0);
        }
        
        // Add keyboard shortcut hint
        function showKeyboardShortcuts() {
            if (typeof Swal !== 'undefined') {
                Swal.fire({
                    title: 'Keyboard Shortcuts',
                    html: `
                        <div style="text-align: left;">
                            <p><kbd>Ctrl+S</kbd> - Save content</p>
                            <p><kbd>Ctrl+Shift+S</kbd> - Save and continue editing</p>
                            <p>Auto-save occurs every 30 seconds when enabled</p>
                        </div>
                    `,
                    icon: 'info'
                });
            }
        }
    </script>
{/literal}

{include file="sections/footer.tpl"}
