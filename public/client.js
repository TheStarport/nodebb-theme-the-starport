'use strict';

function renderDownloadArchive() {
    window.downloading = window.downloading || false;
    const downloadCards = $('a[data-link][data-token][data-name][data-bucket]');
    downloadCards.each(function () {
        const el = $(this);
        el.on('click', () =>
            window.location.href = `${el.attr('data-link')}/file/${el.attr('data-bucket')}/${el.attr('data-name')}?Authorization=${el.attr('data-token')}`);
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

function onPageReady(data) {
    const url = data.url;

    const quickReplyBtn = $("button[component='topic/quickreply/button']");
    if (quickReplyBtn.length) {
        handleQuickReply(quickReplyBtn);
    } else if (url === 'downloads') {
        console.log("Download Page Loaded")
        renderDownloadArchive();
    }
}

(async () => {
    const hooks = await app.require('hooks');

    hooks.on('action:ajaxify.end', (data) => {
        console.log(data);
        onPageReady(data);
    });
})();
