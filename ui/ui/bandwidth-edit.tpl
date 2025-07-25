{include file="sections/header.tpl"}

<div class="row">
	<div class="col-sm-8">
		<div class="panel panel-primary panel-hovered panel-stacked mb30">
			<div class="panel-heading">{Lang::T('Edit Bandwidth')}</div>
			<div class="panel-body">

				<form class="form-horizontal" method="post" role="form" action="{$_url}bandwidth/edit-post">
					<input type="hidden" name="id" value="{$d['id']}">
					<div class="form-group">
						<label class="col-md-3 control-label">{Lang::T('Bandwidth Name')}</label>
						<div class="col-md-9">
							<input type="text" class="form-control" id="name" name="name" value="{$d['name_bw']}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">{Lang::T('Rate Download')}</label>
						<div class="col-md-6">
							<input type="text" class="form-control" id="rate_down" name="rate_down"
								value="{$d['rate_down']}">
						</div>
						<div class="col-md-3">
							<select class="form-control" id="rate_down_unit" name="rate_down_unit">
								<option value="Kbps" {if $d['rate_down_unit'] eq 'Kbps'}selected="selected" {/if}>Kbps
								</option>
								<option value="Mbps" {if $d['rate_down_unit'] eq 'Mbps'}selected="selected" {/if}>Mbps
								</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">{Lang::T('Rate Upload')}</label>
						<div class="col-md-6">
							<input type="text" class="form-control" id="rate_up" name="rate_up" value="{$d['rate_up']}">
						</div>
						<div class="col-md-3">
							<select class="form-control" id="rate_up_unit" name="rate_up_unit">
								<option value="Kbps" {if $d['rate_up_unit'] eq 'Kbps'}selected="selected" {/if}>Kbps
								</option>
								<option value="Mbps" {if $d['rate_up_unit'] eq 'Mbps'}selected="selected" {/if}>Mbps
								</option>
							</select>
						</div>
					</div>
					<div class="panel-heading">{Lang::T('Optional')}</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Burst Limit</label>
						<div class="col-md-9">
							<input type="text" class="form-control" id="burst_limit" name="burst[]"
								placeholder="[Burst/Limit]" value="{$burst[0]}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Burst Threshold</label>
						<div class="col-md-9">
							<input type="text" class="form-control" id="burst_threshold" name="burst[]"
								placeholder="[Burst/Threshold]" value="{$burst[1]}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Burst Time</label>
						<div class="col-md-9">
							<input type="text" class="form-control" id="burst_time" name="burst[]"
								placeholder="[Burst/Time]" value="{$burst[2]}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Priority</label>
						<div class="col-md-9">
							<input type="number" class="form-control" id="burst_priority" name="burst[]"
								placeholder="[Priority]" value="{$burst[3]}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Limit At</label>
						<div class="col-md-9">
							<input type="text" class="form-control" id="burst_limit_at" name="burst[]" placeholder="[Limit/At]"
								value="{$burst[4]}">
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<small>{Lang::T('Editing Bandwidth will not automatically update the plan, you need to edit the plan then save again')}</small>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button class="btn btn-primary" onclick="return ask(this, 'Continue the Bandwidth change process?')" type="submit">{Lang::T('Save Change')}</button>
							Or <a href="{$_url}bandwidth/list">{Lang::T('Cancel')}</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-sm-4">
		<div class="panel panel-default">
			<div class="panel-heading">{Lang::T('Burst Limit Preset')}</div>
			<div class="list-group">
				<a href="#" class="list-group-item active">2x</a>
				<a href="javascript:burstIt('2M/2M 4M/4M 1536K/1536K 16/16 8 1M/1M')" class="list-group-item">2M to
					4M</a>
				<a href="javascript:burstIt('3M/3M 6M/6M 2304K/2304K 16/16 8 1536K/1536K')" class="list-group-item">3M
					to 6M</a>
				<a href="javascript:burstIt('4M/4M 8M/8M 3M/3M 16/16 8 2M/2M')" class="list-group-item">4M to 8M</a>
				<a href="javascript:burstIt('5M/5M 10M/10M 3840k/3840k 16/16 8 2560k/2560k')" class="list-group-item">5M to
					10M</a>
				<a href="javascript:burstIt('6M/6M 12M/12M 4608k/4608k 16/16 8 3M/3M')" class="list-group-item">6M to 12M</a>
				<a href="javascript:burstIt('7M/7M 14M/14M 5376k/5376k 16/16 8 3584k/3584k')" class="list-group-item">7M to
					14M</a>
				<a href="javascript:burstIt('8M/8M 16M/16M 6M/6M 16/16 8 4M/4M')" class="list-group-item">8M to 16M</a>
				<a href="javascript:burstIt('9M/9M 18M/18M 6912k/6912k 16/16 8 4608k/4608k')" class="list-group-item">9M to
					18M</a>
				<a href="javascript:burstIt('10M/10M 20M/20M 7680k/7680k 16/16 8 5M/5M')" class="list-group-item">10M to 20M</a>
				<a href="#" class="list-group-item active">upto 1MB</a>
				<a href="javascript:burstIt('1M/1M 2M/2M 768k/768k 16/16 8 512k/512k')" class="list-group-item">1M upto 2M</a>
				<a href="javascript:burstIt('2M/2M 3M/3M 1536k/1536k 12/12 8 1024k/1024k')" class="list-group-item">2M upto 3M</a>
				<a href="javascript:burstIt('3M/3M 4M/4M 2450k/2450k 10/10 8 1536k/1536k')" class="list-group-item">3M upto 4M</a>
				<a href="javascript:burstIt('4M/4M 5M/5M 3M/3M 10/10 8 2M/2M')" class="list-group-item">4M upto 5M</a>
				<a href="javascript:burstIt('5M/5M 6M/6M 3680k/3680k 10/10 8 2450k/2450k')" class="list-group-item">5M upto 6M</a>
				<a href="javascript:burstIt('6M/6M 7M/7M 4560k/4560k 11/11 8 3M/3M')" class="list-group-item">6M upto 7M</a>
				<a href="javascript:burstIt('7M/7M 8M/8M 5460k/5460k 12/12 8 3640k/3640k')" class="list-group-item">7M upto 8M</a>
				<a href="javascript:burstIt('8M/8M 9M/9M 6M/6M 12/12 8 4M/4M')" class="list-group-item">8M upto 9M</a>
				<a href="javascript:burstIt('9M/9M 10M/10M 6820k/6820k 12/12 8 4550k/4550k')" class="list-group-item">9M upto 10M</a>
			</div>
		</div>
	</div>
</div>

<script>
	function burstIt(value) {
		var b = value.split(" ");
		$("#burst_limit").val(b[1]);
		$("#burst_threshold").val(b[2]);
		$("#burst_time").val(b[3]);
		$("#burst_priority").val(b[4]);
		$("#burst_limit_at").val(b[5]);
		var a = b[0].split("/");
		$("#rate_down").val(a[0].replace('M',''));
		$("#rate_up").val(a[1].replace('M',''));
		$('#rate_down_unit').val('Mbps');
		$('#rate_up_unit').val('Mbps');
		window.scrollTo(0, 0);
	}
</script>

{include file="sections/footer.tpl"}
