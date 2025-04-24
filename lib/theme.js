'use strict';

const meta = require.main.require('./src/meta');
const winston = require.main.require('winston');
const User = require.main.require('./src/user');

const _ = require.main.require('lodash')

const controllers = require('./controllers');
const {getSettings, setSettings} = require("./settings");
const { widgetInit, renderRecentTopicsWidget, defineWidgets, renderHTMLWidget, renderTextWidget } = require('./widget');

const { init: bbInit } = require('./bb');

const library = module.exports;

const defaults = {
    bbKey: '',
    bbKeyId: '',
    bucketName: '',
    webhookUrl: '',
    adminWebhookUrl: '',
};

library.init = async function (params) {
    widgetInit(params);

    const { router, middleware } = params;
    const routeHelpers = require.main.require('./src/routes/helpers');

    routeHelpers.setupAdminPageRoute(router, '/admin/plugins/the-starport', [], controllers.renderAdminPage);
    routeHelpers.setupAdminPageRoute(router, '/admin/plugins/the-starport/save', [], controllers.saveAdminPageApi);

    routeHelpers.setupPageRoute(router, '/downloads', [
        middleware.ensureLoggedIn,
    ], controllers.renderDownloadArchive);

    const old = await getSettings();
    const settings = { ...defaults, ...old };

    const shallowEqual = (a, b) => Object.keys(a).every((key) => a[key] === b[key]);
    const changed = !shallowEqual(settings, old);
    if (changed) {
        await setSettings(settings);
    }

    bbInit()
        .then(() => winston.info("Backblaze Initalized"))
        .catch((x) => winston.warn("Failed to initalize Backblaze: " + x));
};

library.addAdminNavigation = async function (header) {
    header.plugins.push({
        route: '/plugins/the-starport',
        icon: 'fa-paint-brush',
        name: 'The Starport',
    });
    return header;
};

library.defineWidgetAreas = async function (areas) {
    const locations = ['header', 'sidebar', 'footer'];
    const templates = [
        'categories.tpl', 'category.tpl', 'topic.tpl', 'users.tpl',
        'unread.tpl', 'recent.tpl', 'popular.tpl', 'top.tpl', 'tags.tpl', 'tag.tpl',
        'login.tpl', 'register.tpl', 'world.tpl'
    ];
    function capitalizeFirst(str) {
        return str.charAt(0).toUpperCase() + str.slice(1);
    }
    templates.forEach((template) => {
        locations.forEach((location) => {
            areas.push({
                name: `${capitalizeFirst(template.split('.')[0])} ${capitalizeFirst(location)}`,
                template: template,
                location: location,
            });
        });
    });

    areas = areas.concat([
        {
            name: 'Main post header',
            template: 'topic.tpl',
            location: 'mainpost-header',
        },
        {
            name: 'Main post footer',
            template: 'topic.tpl',
            location: 'mainpost-footer',
        },
        {
            name: 'Sidebar Footer',
            template: 'global',
            location: 'sidebar-footer',
        },
        {
            name: 'Brand Header',
            template: 'global',
            location: 'brand-header',
        },
        {
            name: 'About me (before)',
            template: 'account/profile.tpl',
            location: 'profile-aboutme-before',
        },
        {
            name: 'About me (after)',
            template: 'account/profile.tpl',
            location: 'profile-aboutme-after',
        },
        {
            name: 'Chat Header',
            template: 'chats.tpl',
            location: 'header',
        },
    ]);

    return areas;
};

library.getAdminSettings = async function (hookData) {
    if (hookData.plugin === 'the-starport') {
        hookData.values = {
            ...defaults,
            ...hookData.values,
        };
    }
    return hookData;
};

library.filterMiddlewareRenderHeader = async function (hookData) {
    hookData.templateData.bootswatchSkinOptions = await meta.css.getSkinSwitcherOptions(hookData.req.uid);
    return hookData;
};

library.onAddToApprovalQueue = async function (hookData) {
    const settings = await getSettings();

    if (!settings.adminWebhookUrl) {
        return hookData;
    }

    await fetch(settings.adminWebhookUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            content: `A new user has registered and is awaiting approval in the registration queue.`
        })
    });

    return hookData;
};

library.onPostCreate = async function (hookData) {
    const settings = await getSettings();

    if (!settings.webhookUrl) {
        return hookData;
    }

    const name = (await User.getUsernamesByUids([hookData.post.uid]))[0];

    await fetch(settings.webhookUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            embeds: [
                {
                    type: "rich",
                    title: `A new post at The Starport`,
                    description: _.truncate(hookData.post.content, { length: 255 }),
                    color: 0x00FFFF,
                    author: {
                        name: name,
                        url: `https://the-starport.com/forums/user/${name}`
                    },
                    timestamp: new Date(hookData.post.timestamp).toISOString(),
                    url: `https://the-starport.com/forums/post/${hookData.post.pid}`
                }
            ]
        })
    });

    return hookData;
};

library.renderRecentTopicsWidget = renderRecentTopicsWidget;
library.defineWidgets = defineWidgets;
library.renderHTMLWidget = renderHTMLWidget;
library.renderTextWidget = renderTextWidget;
