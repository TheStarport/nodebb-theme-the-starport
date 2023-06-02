<div class="cookie-consent" style="text-align: center;">
    <button style="display:none;">{dismiss}</button>
    {message} <a target="_blank" rel="noopener" href="{link_url}">{link}</a><span class="highlight"> | </span>
    <a id="dismiss" target="_blank" rel="noopener" href="#">Dismiss</a>
</div>
<script>
    document.getElementById('dismiss').addEventListener('click', function(event) {
		// Save consent cookie and remove warning element
		event.preventDefault();
		localStorage.setItem('cookieconsent', '1');
		document.getElementsByClassName('cookie-consent')[0].remove()
		document.body.removeClass('cookie-consent-open');

	});
</script>
