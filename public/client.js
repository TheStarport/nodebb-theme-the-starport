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
	// Fade out background when dropdown is open
	function shouldFade(elements) {
		let openFound = false;
		elements.forEach(function(element) {
			if(element.classList.contains('open') || element.getAttribute('aria-expanded') == 'true') {
				openFound = true;
			}
		});
		return openFound;
	}

	const fadeOutElements = document.querySelectorAll('.navbar .dropdown, .dropdown-toggle');

	document.addEventListener('click', function() {
		let fadeElement = document.getElementById('fade-background');
		if(shouldFade([...fadeOutElements])) {
			fadeElement.classList.remove('fade-out-background');
			fadeElement.classList.add('fade-in-background');
		}
		else {
			fadeElement.classList.remove('fade-in-background');
			fadeElement.classList.add('fade-out-background');
		}
	});
});
