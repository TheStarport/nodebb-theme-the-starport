{{{ if privileges.topics:reply }}}
<div component="topic/quickreply/container" class="quick-reply d-flex gap-3 mb-4">
	<div class="icon hidden-xs">
		<a class="d-inline-block position-relative" href="{{{ if loggedInUser.userslug }}}{config.relative_path}/user/{loggedInUser.userslug}{{{ else }}}#{{{ end }}}">
			{buildAvatar(loggedInUser, "48px", true, "", "user/picture")}
			{{{ if loggedInUser.status }}}<span component="user/status" class="position-absolute translate-middle-y border border-white border-2 rounded-circle status {loggedInUser.status}"><span class="visually-hidden">[[global:{loggedInUser.status}]]</span></span>{{{ end }}}
		</a>
	</div>
	<form class="flex-grow-1 d-flex flex-column gap-2" method="post" action="{config.relative_path}/compose">
		<input type="hidden" name="tid" value="{tid}" />
		<input type="hidden" name="_csrf" value="{config.csrf_token}" />
		<div class="quickreply-message position-relative">
			<textarea rows="4" name="content" component="topic/quickreply/text" class="form-control mousetrap" placeholder="[[modules:composer.textarea.placeholder]]"></textarea>
			<div class="imagedrop"><div>[[topic:composer.drag_and_drop_images]]</div></div>
		</div>
		<div>
			<div class="d-flex justify-content-end gap-2">
				<button type="submit" component="topic/quickreply/expand" class="btn btn-sm btn-outline" formmethod="get"><i class="fa fa-expand"></i></button>
				<button type="submit" component="topic/quickreply/button" class="btn btn-sm btn-primary">[[topic:post_quick_reply]]</button>
			</div>
		</div>
	</form>
	<form class="d-none" component="topic/quickreply/upload" method="post" enctype="multipart/form-data">
		<input type="file" name="files[]" multiple class="hidden"/>
	</form>

</div>
{{{ end }}}
