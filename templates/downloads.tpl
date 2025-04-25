<div data-widget-area="header">
    {{{each widgets.header}}}
    {{widgets.header.html}}
    {{{end}}}
</div>

<div class="row register flex-fill">
    <div class="d-flex flex-column gap-2">
        {{{ if categories }}}
        {{{ each categories }}}
        {{{ if categories.files.length }}}
        <div class="row">
            <div class="col-md-auto">
                <a id="#{categories.name}" href="#{categories.name}"><i class="fa fa-paragraph"></i></a>
            </div>
            <div class="col">
                <h2>{categories.name}</h2>
            </div>
        </div>
        <div class="row">
            {{{ each ./files }}}
            <div class="col-xl-4 col-lg-6 col-sm-12 mb-3">
                <div class="card h-100 hover-dim border-0"
                     {{{ if ./image }}}style="background-size: cover; background-blend-mode: overlay; background-image: url('{./image}');"{{{ end }}}>
                    <a href="#" data-link="{downloadUrl}" data-token="{token}" data-name="{./fileName}"
                       data-bucket="{bucket}" class="d-block h-100 text-decoration-none"
                       style="max-height: 250px;">
                        <div class="card-body d-flex flex-column gap-1 h-100">
                            <div class="d-flex flex-column">
                                {{{ if ./fileInfo.friendlyname }}}
                                <div class="flex-grow-1 fs-6 fw-semibold">{./fileInfo.friendlyname}</div>
                                {{{ else }}}
                                <div class="flex-grow-1 fs-6 fw-semibold">{./fileName}</div>
                                {{{ end }}}

                                <div class="flex-shrink-0 text-sm">
                                    <i class="text-muted fa-solid fa-file-zipper"></i> {./fileSize}
                                </div>
                            </div>
                            <div class="text-sm" style="overflow: hidden; white-space: nowrap;">
                                {{{ if ./fileInfo.description }}}
                                <p>{./fileInfo.description}</p>
                                {{{ end }}}
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            {{{ end }}}
        </div>
        {{{ end }}}
        {{{ end }}}
        {{{ else }}}
        <div class="col-12">
            <div class="alert alert-warning">
                No files are located within the archive.
            </div>
        </div>
        {{{ end }}}
    </div>
</div>
<div data-widget-area="footer">
    {{{each widgets.footer}}}
    {{widgets.footer.html}}
    {{{end}}}
</div>
