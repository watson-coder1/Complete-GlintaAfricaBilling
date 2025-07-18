{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="box box-warning">
            <div class="box-header with-border">
                <h3 class="box-title"><i class="fa fa-trash"></i> Cleanup Old RADIUS Records</h3>
            </div>
            <div class="box-body">
                <div class="alert alert-warning">
                    <h4><i class="fa fa-exclamation-triangle"></i> Warning!</h4>
                    <p>This action will permanently delete old RADIUS accounting records from the database. This cannot be undone.</p>
                </div>
                
                <form method="POST" action="{$_url}radius_manager/cleanup">
                    <div class="form-group">
                        <label for="days">Delete records older than:</label>
                        <div class="input-group">
                            <input type="number" class="form-control" name="days" id="days" 
                                   value="90" min="30" max="365" required>
                            <span class="input-group-addon">days</span>
                        </div>
                        <small class="help-block">
                            Minimum: 30 days, Maximum: 365 days. Default is 90 days.
                        </small>
                    </div>
                    
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">What will be cleaned up?</h4>
                        </div>
                        <div class="panel-body">
                            <ul class="list-unstyled">
                                <li><i class="fa fa-check text-success"></i> Old accounting records (radacct table)</li>
                                <li><i class="fa fa-check text-success"></i> Completed session data</li>
                                <li><i class="fa fa-check text-success"></i> Historical usage statistics</li>
                                <li><i class="fa fa-times text-danger"></i> <strong>Will NOT delete:</strong> Active sessions</li>
                                <li><i class="fa fa-times text-danger"></i> <strong>Will NOT delete:</strong> User authentication data</li>
                                <li><i class="fa fa-times text-danger"></i> <strong>Will NOT delete:</strong> Recent records (last 30 days)</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="alert alert-info">
                        <h4><i class="fa fa-info-circle"></i> Recommendations</h4>
                        <ul>
                            <li><strong>90 days</strong> - Good balance between performance and history</li>
                            <li><strong>180 days</strong> - Keep more history for analysis</li>
                            <li><strong>365 days</strong> - Full year of records (large database)</li>
                        </ul>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" id="confirm_cleanup" required>
                                I understand that this action cannot be undone and will permanently delete old records.
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" name="confirm" value="yes" class="btn btn-danger" 
                                id="cleanup_btn" disabled>
                            <i class="fa fa-trash"></i> Cleanup Old Records
                        </button>
                        <a href="{$_url}radius_manager" class="btn btn-default">
                            <i class="fa fa-arrow-left"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="box box-default">
            <div class="box-header with-border">
                <h3 class="box-title">Database Statistics</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="info-box bg-blue">
                            <span class="info-box-icon"><i class="fa fa-database"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Total Records</span>
                                <span class="info-box-number" id="total_records">Loading...</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box bg-green">
                            <span class="info-box-icon"><i class="fa fa-calendar"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Recent (30 days)</span>
                                <span class="info-box-number" id="recent_records">Loading...</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box bg-yellow">
                            <span class="info-box-icon"><i class="fa fa-clock-o"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Old (90+ days)</span>
                                <span class="info-box-number" id="old_records">Loading...</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box bg-red">
                            <span class="info-box-icon"><i class="fa fa-hdd-o"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Database Size</span>
                                <span class="info-box-number" id="db_size">Loading...</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="alert alert-info">
                    <h4><i class="fa fa-lightbulb-o"></i> Tips for Database Maintenance</h4>
                    <ul>
                        <li>Run cleanup regularly (monthly) to maintain optimal performance</li>
                        <li>Keep at least 90 days of records for troubleshooting and reporting</li>
                        <li>Consider exporting data before cleanup if you need long-term archives</li>
                        <li>Monitor database size growth and adjust cleanup frequency accordingly</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Enable cleanup button only when checkbox is checked
    $('#confirm_cleanup').change(function() {
        $('#cleanup_btn').prop('disabled', !this.checked);
    });
    
    // Load database statistics
    loadDatabaseStats();
});

function loadDatabaseStats() {
    // Simulate loading database statistics
    // In a real implementation, you would make AJAX calls to get actual stats
    setTimeout(function() {
        $('#total_records').text('12,543');
        $('#recent_records').text('1,234');
        $('#old_records').text('8,432');
        $('#db_size').text('45.2 MB');
    }, 1000);
}
</script>

{include file="sections/footer.tpl"}