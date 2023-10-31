{{{ each sessions }}}
<li class="list-group-item text-break" data-uuid="{./uuid}">
	<div class="float-end">
		{{{ if isSelfOrAdminOrGlobalModerator }}}
		{{{ if !./current }}}
		<button class="btn btn-sm btn-outline-secondary" type="button" data-action="revokeSession">[[user:revoke_session]]</button>
		{{{ end }}}
		{{{ end }}}
		{function.userAgentIcons}
		<i class="fa fa-circle text-{{{ if ./current }}}success{{{ else }}}muted{{{ end }}}"></i>
	</div>
	[[user:browser_version_on_platform, {./browser}, {./version}, {./platform}]]<br />
	<small class="timeago text-muted" title="{../datetimeISO}"></small>
	<ul>
		<li><strong>[[global:ip_address]]</strong>: {../ip}</li>
	</ul>
</li>
{{{ end }}}
