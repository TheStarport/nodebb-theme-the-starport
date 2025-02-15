{{{ if privileges.editable }}}
<li {{{ if locked }}}hidden{{{ end }}}><a component="topic/lock" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if locked }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-lock"></i> [[topic:thread-tools.lock]]</a></li>
<li {{{ if !locked }}}hidden{{{ end }}}><a component="topic/unlock" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if !locked }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-unlock"></i> [[topic:thread-tools.unlock]]</a></li>
<li {{{ if pinned }}}hidden{{{ end }}}><a component="topic/pin" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if pinned }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-thumb-tack"></i> [[topic:thread-tools.pin]]</a></li>
<li {{{ if !pinned }}}hidden{{{ end }}}><a component="topic/unpin" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if !pinned }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-thumb-tack fa-rotate-90"></i> [[topic:thread-tools.unpin]]</a></li>

<li><a component="topic/move" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-arrows"></i> [[topic:thread-tools.move]]</a></li>
<li><a component="topic/merge" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-code-fork"></i> [[topic:thread-tools.merge]]</a></li>
<li><a component="topic/fork" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-code-fork"></i> [[topic:thread-tools.fork]]</a></li>
<li><a component="topic/tag" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-tag"></i> [[topic:thread-tools.tag]]</a></li>
{{{ if !scheduled }}}
<li><a component="topic/move-posts" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-arrows"></i> [[topic:thread-tools.move-posts]]</a></li>
{{{ end }}}
<li><a component="topic/mark-unread-for-all" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-inbox"></i> [[topic:thread-tools.markAsUnreadForAll]]</a></li>
<li class="dropdown-divider"></li>
{{{ end }}}

{{{ if privileges.deletable }}}
<li {{{ if deleted }}}hidden{{{ end }}}><a component="topic/delete" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if deleted }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-trash-o"></i> [[topic:thread-tools.delete]]</a></li>
{{{ if !scheduled }}}
<li {{{ if !deleted }}}hidden{{{ end }}}><a component="topic/restore" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if !deleted }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-history"></i> [[topic:thread-tools.restore]]</a></li>
{{{ end }}}
{{{ if privileges.purge }}}
<li {{{ if !deleted }}}hidden{{{ end }}}><a component="topic/purge" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {{{ if !deleted }}}hidden{{{ end }}}"><i class="fa fa-fw text-muted fa-eraser"></i> [[topic:thread-tools.purge]]</a></li>
{{{ end }}}
{{{ if privileges.isAdminOrMod }}}
<li><a component="topic/delete/posts" class="dropdown-item rounded-1 d-flex align-items-center gap-2" href="#"><i class="fa fa-fw text-muted fa-trash-o"></i> [[topic:thread-tools.delete-posts]]</a></li>
{{{ end }}}

{{{ each thread-tools }}}
<li><a href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2 {./class}"><i class="fa fa-fw text-muted {./icon}"></i> {./title}</a></li>
{{{ end }}}
{{{ end }}}
