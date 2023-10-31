{{{ each groups }}}
<div class="col-xl-4 col-lg-6 col-sm-12 mb-3" component="groups/summary" data-slug="{./slug}">
	<div class="card h-100 hover-primary border-0">
		<a href="{config.relative_path}/groups/{./slug}" class="d-block h-100 text-decoration-none">
			<div class="card-body d-flex flex-column gap-1 h-100">
				<div class="d-flex">
					<div class="flex-grow-1 fs-6 fw-semibold">{./displayName}</div>
					<div class="flex-shrink-0 text-sm"><i class="text-muted fa-solid fa-user"></i> {./memberCount}</div>
				</div>
				<div class="text-sm">{./description}</div>
			</div>
		</a>
	</div>
</div>
{{{ end }}}
