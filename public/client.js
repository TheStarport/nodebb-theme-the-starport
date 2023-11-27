'use strict';

/*
	Hey there!

	This is the client file for your theme. If you need to do any client-side work in javascript,
	this is where it needs to go.

	You can listen for page changes by writing something like this:

	  $(window).on('action:ajaxify.end', function(ev, data) {
		var url = data.url;
		console.log('I am now at: ' + url);
	  });
*/

$(window).on('action:ajaxify.end', function(ev, data) {
    const url = data.url;
    if (url === 'downloads') {
        window.downloading = window.downloading || false;
        const downloadCards = $('a[data-link][data-token][data-fileId]');
        downloadCards.each(function() {
            $(this).on('click', (_) => {
                if (window.downloading) {
                    // prevent multiple concurrent downloads
                    return;
                }

                $.ajax({
                    type: 'GET',
                    url: `${$(this).attr('data-link')}/b2api/v2/b2_download_file_by_id?fileId=${$(this).attr('data-fileId')}`,
                    dataType: 'json',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', $(this).attr('data-token'));
                        window.downloading = true;
                    },
                    success: function () {
                        window.downloading = false;
                    },
                    error: function () {
                        window.downloading = false;
                    }
                });
            })
        });
    }
});

$(document).on('ready', function () {});
