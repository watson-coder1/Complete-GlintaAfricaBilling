{include file="sections/user-header.tpl"}
<!-- user-pages -->

					<div class="row">
						<div class="col-sm-12">
							<div class="card mb20  card-hovered">
								<div class="card-header">{$_L[$pageHeader]}</div>
								<div class="card-body">
									{include file="$_path/../pages/$PageFile.html"}
								</div>
							</div>
						</div>
					</div>

{include file="sections/user-footer.tpl"}
