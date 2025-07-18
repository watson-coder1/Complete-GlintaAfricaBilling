{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">RADIUS Users Management</h3>
                <div class="box-tools pull-right">
                    <a href="{$_url}radius_manager" class="btn btn-default btn-sm">
                        <i class="fa fa-arrow-left"></i> Back to Dashboard
                    </a>
                    <a href="{$_url}radius_manager/test_user" class="btn btn-success btn-sm">
                        <i class="fa fa-plus"></i> Create Test User
                    </a>
                </div>
            </div>
            <div class="box-body">
                {if isset($error)}
                    <div class="alert alert-danger">
                        <h4><i class="fa fa-exclamation-triangle"></i> Error</h4>
                        <p>{$error}</p>
                    </div>
                {else}
                    <div class="row">
                        <div class="col-md-12">
                            <form method="GET" action="{$_url}radius_manager/users" class="form-inline">
                                <div class="form-group">
                                    <label for="search">Search:</label>
                                    <input type="text" name="search" id="search" class="form-control" 
                                           placeholder="Enter username" value="{$search}">
                                </div>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fa fa-search"></i> Search
                                </button>
                                {if $search}
                                    <a href="{$_url}radius_manager/users" class="btn btn-default">
                                        <i class="fa fa-times"></i> Clear
                                    </a>
                                {/if}
                            </form>
                        </div>
                    </div>
                    
                    <br>
                    
                    {if $radius_users}
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Password Type</th>
                                        <th>Created Date</th>
                                        <th>Session Attributes</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $radius_users as $user}
                                        <tr>
                                            <td>{$user->id}</td>
                                            <td>
                                                <strong>{$user->username}</strong>
                                                {assign var="user_attrs" value=[]}
                                                {* Get additional attributes for this user *}
                                                {foreach from=$radius_users as $attr}
                                                    {if $attr->username == $user->username && $attr->attribute != 'Cleartext-Password'}
                                                        {$user_attrs[] = $attr}
                                                    {/if}
                                                {/foreach}
                                            </td>
                                            <td>
                                                <span class="label label-info">{$user->attribute}</span>
                                            </td>
                                            <td>
                                                {if $user->created_at}
                                                    {date('M j, Y H:i', strtotime($user->created_at))}
                                                {else}
                                                    <span class="text-muted">Unknown</span>
                                                {/if}
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#attributesModal{$user->id}">
                                                    <i class="fa fa-list"></i> View Attributes
                                                </button>
                                                
                                                <!-- Modal for user attributes -->
                                                <div class="modal fade" id="attributesModal{$user->id}" tabindex="-1" role="dialog">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                                <h4 class="modal-title">RADIUS Attributes for {$user->username}</h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div id="userAttributes{$user->id}">
                                                                    <i class="fa fa-spinner fa-spin"></i> Loading attributes...
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="{$_url}radius_manager/disconnect/{$user->username}" 
                                                       class="btn btn-warning btn-xs"
                                                       title="Disconnect active sessions">
                                                        <i class="fa fa-power-off"></i>
                                                    </a>
                                                    <a href="{$_url}radius_manager/delete_user/{$user->username}" 
                                                       class="btn btn-danger btn-xs"
                                                       onclick="return confirm('Are you sure you want to delete this RADIUS user and all associated data?')"
                                                       title="Delete user">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    {else}
                        <div class="text-center">
                            <i class="fa fa-user-plus fa-3x text-muted"></i>
                            <h4 class="text-muted">No RADIUS Users Found</h4>
                            {if $search}
                                <p class="text-muted">No users found matching "{$search}".</p>
                                <a href="{$_url}radius_manager/users" class="btn btn-default">
                                    <i class="fa fa-list"></i> Show All Users
                                </a>
                            {else}
                                <p class="text-muted">No RADIUS users have been created yet.</p>
                                <a href="{$_url}radius_manager/test_user" class="btn btn-success">
                                    <i class="fa fa-plus"></i> Create Test User
                                </a>
                            {/if}
                        </div>
                    {/if}
                {/if}
            </div>
        </div>
    </div>
</div>

<script>
// Load user attributes when modal is shown
$(document).on('show.bs.modal', '[id^="attributesModal"]', function (e) {
    var modal = $(this);
    var userId = modal.attr('id').replace('attributesModal', '');
    var username = modal.find('.modal-title').text().split(' ').pop();
    
    // Load attributes via AJAX (you can implement this endpoint)
    // For now, we'll show a placeholder
    setTimeout(function() {
        modal.find('[id^="userAttributes"]').html(`
            <table class="table table-sm">
                <thead>
                    <tr>
                        <th>Attribute</th>
                        <th>Operator</th>
                        <th>Value</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Cleartext-Password</td>
                        <td>:=</td>
                        <td><code>********</code></td>
                    </tr>
                    <tr class="text-muted">
                        <td colspan="3"><i>Additional attributes will be loaded here</i></td>
                    </tr>
                </tbody>
            </table>
        `);
    }, 500);
});
</script>

{include file="sections/footer.tpl"}