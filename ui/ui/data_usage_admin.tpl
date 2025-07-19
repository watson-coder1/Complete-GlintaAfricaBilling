{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-hovered mb20 panel-primary">
            <div class="panel-heading">Data Usage</div>
            <div class="panel-body">
                
                <!-- Search Form -->
                <form method="POST" class="form-inline mb20">
                    <div class="form-group">
                        <input type="text" name="q" value="{$search}" placeholder="Search username" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Search</button>
                    {if $search}
                        <a href="{$_url}plugin/data_usage_admin" class="btn btn-default">Clear</a>
                    {/if}
                </form>

                {if !$has_data}
                    <!-- No Data Available -->
                    <div class="alert alert-info">
                        <h4><i class="fa fa-info-circle"></i> No Data Available</h4>
                        <p>No data usage records found yet.</p>
                        <p>Data will appear here once users start accessing the internet through your system.</p>
                    </div>
                {else}
                    <!-- Data Table -->
                    <p><strong>Total Records: {$total}</strong></p>
                    
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Downloaded</th>
                                    <th>Uploaded</th>
                                    <th>Total Usage</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $data as $row}
                                <tr>
                                    <td>{$row.username}</td>
                                    <td>{$row.downloaded}</td>
                                    <td>{$row.uploaded}</td>
                                    <td><strong>{$row.total}</strong></td>
                                    <td>
                                        <span class="label label-{$row.status_class}">
                                            {$row.status}
                                        </span>
                                    </td>
                                    <td>{$row.date}</td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                {/if}
                
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}