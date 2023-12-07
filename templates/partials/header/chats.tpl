<a class="navbar-link" data-bs-toggle="dropdown" href="{relative_path}/user/{user.userslug}/chats" id="chat_dropdown" component="chat/dropdown" data-ajaxify="false" role="button">
    {{{ if unreadCount.chat}}}
    <i component="chat/icon" class="fa fa-stack-1x fa-2xs fa-circle" style="color: red; font-size: 8px; padding-left: 1rem; padding-top: 1rem;"></i>
    {{{ end }}}
    <i component="chat/icon" class="fa fa-comment fa-fw unread-count" data-content="{unreadCount.chat}"></i> <span class="d-inline d-sm-none">[[global:header.chats]]</span>
</a>
<ul class="navbar-dropdown pb-0 mt-3 dropdown-menu dropdown-menu-end" aria-labelledby="chat_dropdown">
    <li>
        <ul component="chat/list" class="chat-list chats-list p-0">
            <li class="loading-text">
                <a href="#"><i class="fa fa-refresh fa-spin"></i> [[global:chats.loading]]</a>
            </li>
        </ul>
    </li>
    <li class="notif-dropdown-link">
        <hr class="my-1"/>
        <div class="btn-group d-flex flex-column justify-content-center">
            <a class="text-center" href="#" component="chats/mark-all-read"><i class="fa fa-check-double"></i> [[modules:chat.mark-all-read]]</a>
            <a class="text-center" href="{relative_path}/user/{user.userslug}/chats"><i class="fa fa-comments"></i> [[modules:chat.see-all]]</a>
        </div>
    </li>
</ul>
