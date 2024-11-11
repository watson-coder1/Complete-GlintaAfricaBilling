{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-hovered mb20 panel-primary">
            <div class="panel-heading">
                <div class="btn-group pull-right">
                    <form action="{$_url}plugin/nas_status" method="post">
                </div>NAS Status: {$nasStatusSummary}                
            </div>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>{Lang::T('Number')}</th>
                            <th>{Lang::T('Location')}</th>
                            <th>{Lang::T('NAS IP Address')}</th>
                            <th>{Lang::T('Status')}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {$no = 1}
                        {foreach from=$nasData item=nas}
                            <tr>
                                <td>{$no++}</td>
                                <td>{$nas.shortname}</td>
                                <td>{$nas.nasname}</td>
                                <td>{if $nas.status == 'online'}{Lang::T('Online')}{else}{Lang::T('Offline')}{/if}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}
