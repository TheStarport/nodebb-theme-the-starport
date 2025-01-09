'use strict';

$(window).on('action:ajaxify.end', function (ev, data) {
    onPageReady(data);
});

function onPageReady(data) {
    const url = data.url;

    const quickReplyBtn = $("button[component='topic/quickreply/button']");
    if (quickReplyBtn) {
        handleQuickReply(quickReplyBtn);
    }
    else if (url === 'downloads') {
        renderDownloadArchive();
    }
}

function renderDownloadArchive() {
    window.downloading = window.downloading || false;
    const downloadCards = $('a[data-link][data-token][data-name][data-bucket]');
    downloadCards.each(function () {
        $(this)
            .on('click', () => window.location.href =
                `${$(this)
                    .attr('data-link')}/file/${$(this)
                    .attr('data-bucket')}/${$(this)
                    .attr('data-name')}?Authorization=${$(this)
                    .attr('data-token')}`);
    });
}

function handleQuickReply(quickReplyBtn) {
    quickReplyBtn.prop("disabled", true);
    const inputArea = $("textarea[component='topic/quickreply/text']");

    inputArea.on('input', function () {
        const len = $(this).val().length;
        quickReplyBtn.prop("disabled", len < 5);
    });
}
