<div class="card card-header text-xs px-2 py-1 fw-semibold border-0 align-self-start">
	[[flags:x_flags_found, {count}]]
</div>

<table class="table table-striped table-hover" component="flags/list">
	<thead>
		<tr>
			<th></th>
			<th class="text-xs text-muted">[[flags:reports]]</th>
			<th class="text-xs text-muted">[[flags:first_reported]]</th>
			<th class="text-xs text-muted">[[flags:state]]</th>
			<th>
				<input type="checkbox" data-action="toggle-all" autocomplete="off" />
			</th>
		</tr>
	</thead>
	<tbody>
		{{{ each flags }}}
		<tr data-flag-id="{./flagId}">
			<td>
				<a class="text-decoration-underline" href="{config.relative_path}/flags/{./flagId}">
					{./target_readable}
				</a>
			</td>
			<td>
				{./heat}
			</td>
			<td><span class="timeago" title="{./datetimeISO}"></span></td>
			<td><span class="badge bg-{./labelClass}">[[flags:state_{./state}]]</span></td>
			<td>
				<input type="checkbox" autocomplete="off" />
			</td>
		</tr>
		{{{end}}}
	</tbody>
</table>

<!-- IMPORT partials/paginator.tpl -->