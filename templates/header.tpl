<!DOCTYPE html>
<html lang="{function.localeToHTML, userLang, defaultLang}" {{{if languageDirection}}}data-dir="{languageDirection}" style="direction: {languageDirection};"{{{end}}}>
<head>
	<title>{browserTitle}</title>
	{{{each metaTags}}}{function.buildMetaTag}{{{end}}}
	<link rel="stylesheet" type="text/css" href="{relative_path}/assets/client{{{if bootswatchSkin}}}-{bootswatchSkin}{{{end}}}{{{ if (languageDirection=="rtl") }}}-rtl{{{ end }}}.css?{config.cache-buster}" />
	{{{each linkTags}}}{function.buildLinkTag}{{{end}}}

	<script>
		var config = JSON.parse('{{configJSON}}');
		var app = {
			user: JSON.parse('{{userJSON}}')
		};

		document.documentElement.style.setProperty('--panel-offset', `${localStorage.getItem('panelOffset') || 0}px`);
	</script>

	{{{if useCustomHTML}}}
	{{customHTML}}
	{{{end}}}
	{{{if useCustomCSS}}}
	<style>{{customCSS}}</style>
	{{{end}}}
</head>

<body class="body-bg {bodyClass} noskin">
	<div class="layout-container d-flex justify-content-between pb-4 pb-md-0">
		<main id="panel" class="d-flex flex-column flex-grow-1" style="min-height: 100vh; max-width: 100vw">
            <nav class="navbar sticky-top navbar-expand-lg container-primary border-0 border-bottom mobile-hide" id="header-menu" component="navbar">
                <div class="container justify-content-start flex-nowrap">
                    <!-- IMPORT partials/header/menu.tpl -->
                </div>
            </nav>
			<script>
				const headerEl = document.getElementById('header-menu');
				if (headerEl) {
					const rect = headerEl.getBoundingClientRect();
					const offset = Math.max(0, rect.bottom);
					document.documentElement.style.setProperty('--panel-offset', offset + `px`);
				} else {
					document.documentElement.style.setProperty('--panel-offset', `0px`);
				}
			</script>
			<div class="container px-md-4 pt-md-4 d-flex flex-column h-100 gap-3 mb-5 mb-lg-0 content" id="content">
			<!-- IMPORT partials/noscript/warning.tpl -->
			<!-- IMPORT partials/noscript/message.tpl -->
