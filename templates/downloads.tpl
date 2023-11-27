<div data-widget-area="header">
    {{{each widgets.header}}}
    {{widgets.header.html}}
    {{{end}}}
</div>

<div class="row register flex-fill">
    <div class="d-flex flex-column gap-2 {{{ if widgets.sidebar.length }}}col-lg-9 col-sm-12{{{ else }}}col-lg-12{{{ end }}}">
        <div class="row">
            {{{ if files.length }}}
            {{{ each files }}}
            <div class="col-xl-4 col-lg-6 col-sm-12 mb-3">
                <div class="card h-100 hover-primary border-0">
                    <a href="#" data-link="{downloadUrl}" data-token="{token}" data-fileId="{./fileId}" class="d-block h-100 text-decoration-none">
                        <div class="card-body d-flex flex-column gap-1 h-100">
                            <div class="d-flex">
                                <div class="flex-grow-1 fs-6 fw-semibold">File Name ({./fileName})</div>
                                <div class="flex-shrink-0 text-sm">
                                    <i class="text-muted fa-solid fa-file-zipper"></i>   {./fileSize}
                                </div>
                            </div>
                            <div class="text-sm">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                                nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
                                irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
                                pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
                                deserunt mollit anim id est laborum.
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            {{{ end }}}
            {{{ else }}}
            <div class="col-12">
                <div class="alert alert-warning">
                    No files are located within the archive.
                </div>
            </div>
            {{{ end }}}
        </div>
        <div data-widget-area="sidebar" class="col-lg-3 col-sm-12 {{{ if !widgets.sidebar.length }}}hidden{{{ end }}}">
            {{{each widgets.sidebar}}}
            {{widgets.sidebar.html}}
            {{{end}}}
        </div>
    </div>
</div>
<div data-widget-area="footer">
    {{{each widgets.footer}}}
    {{widgets.footer.html}}
    {{{end}}}
</div>
