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
        const downloadCards = $('a[data-link][data-token][data-name][data-bucket]');
        downloadCards.each(function() {
            $(this).on('click', () => window.location.href =
                `${$(this).attr('data-link')}/file/${$(this).attr('data-bucket')}/${$(this).attr('data-name')}?Authorization=${$(this).attr('data-token')}`)
        });
    }
});

$(document).on('ready', function () {});
