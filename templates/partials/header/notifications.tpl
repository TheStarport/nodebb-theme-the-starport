<a href="{relative_path}/notifications" class="navbar-link" data-bs-toggle="dropdown" id="notif_dropdown" data-ajaxify="false" role="button">
    <i component="notifications/icon" class="fa fa-fw {{{ if unreadCount.notification}}}fa-bell{{{ else }}}fa-bell-o{{{ end }}} unread-count" data-content="{unreadCount.notification}"></i>
</a>
<ul class="p-0 mt-3 navbar-dropdown dropdown-menu dropdown-menu-end" aria-labelledby="notif_dropdown">
    <li>
        <ul component="notifications/list" class="notification-list">
            <li class="loading-text">
                <a href="#"><i class="fa fa-refresh fa-spin"></i> [[global:notifications.loading]]</a>
            </li>
        </ul>
    </li>
    <li class="notif-dropdown-link">
        <hr class="my-1"/>
        <div class="d-flex flex-column justify-content-center">
            <a role="button" href="#" class="text-center"><i class="fa fa-check-double"></i> [[notifications:mark-all-read]]</a>
            <a class="text-center" href="{relative_path}/notifications"><i class="fa fa-list"></i> [[notifications:see-all]]</a>
        </div>
    </li>
</ul>
