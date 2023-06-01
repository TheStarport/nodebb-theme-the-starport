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

$(document).ready(function () {
	function shouldFade(elements) {
		let openFound = false;
		elements.forEach(function(element) {
			if(element.classList.contains('open')) {
				openFound = true;
			}
		});
		return openFound;
	}

	console.log('test');
	const fadeOutElements = document.querySelectorAll('.navbar dropdown');
	console.log(fadeOutElements);

	document.addEventListener('click', function() {
		console.log('event fired');
		if(shouldFade([...fadeOutElements])) {
			console.log('should fade');
			document.getElementById('fade-content').style.display = 'block';
		}
		else {
			console.log('dont fade');
			document.getElementById('fade-content').style.display = 'none';
		}
	});
});
