const nconf = require.main.require('nconf');
const validator = require.main.require('validator');
const benchpressjs = require.main.require('benchpressjs');
const _ = require.main.require('lodash');

const db = require.main.require('./src/database');
const categories = require.main.require('./src/categories');
const user = require.main.require('./src/user');
const plugins = require.main.require('./src/plugins');
const topics = require.main.require('./src/topics');
const posts = require.main.require('./src/posts');
const groups = require.main.require('./src/groups');
const utils = require.main.require('./src/utils');
const meta = require.main.require('./src/meta');
const privileges = require.main.require('./src/privileges');

let app;
const widgetInit = function (params) {
    app = params.app;
};

function getValuesArray(widget, field) {
    const values = widget.data[field] || '';
    return values.split(',').map(c => parseInt(c, 10)).filter(Boolean);
}

function isVisibleInCategory(widget) {
    const cids = getValuesArray(widget, 'cid');
    return !(
        cids.length &&
        (widget.templateData.template.category || widget.templateData.template.topic) &&
        !cids.includes(parseInt(widget.templateData.cid, 10))
    );
}

function isVisibleInTopic(widget) {
    const tids = getValuesArray(widget, 'tid');
    return !(
        tids.length &&
        widget.templateData.template.topic &&
        !tids.includes(parseInt(widget.templateData.tid, 10))
    );
}

const renderHTMLWidget = async function (widget) {
    if (!isVisibleInCategory(widget) || !isVisibleInTopic(widget)) {
        return null;
    }
    const tpl = widget.data ? widget.data.html : '';
    widget.html = await benchpressjs.compileRender(String(tpl), widget.templateData);
    return widget;
};

const renderTextWidget = async function (widget) {
    if (!isVisibleInCategory(widget)) {
        return null;
    }
    const parseAsPost = !!widget.data.parseAsPost;
    const text = String(widget.data.text);

    if (parseAsPost) {
        widget.html = await plugins.hooks.fire('filter:parse.raw', text);
    } else {
        widget.html = text.replace(/\r\n/g, '<br />');
    }
    return widget;
};

const renderRecentTopicsWidget = async function (widget) {
    const numTopics = (widget.data.numTopics || 8) - 1;
    const cids = getValuesArray(widget, 'cid');

    let key;
    if (cids.length) {
        if (cids.length === 1) {
            key = `cid:${cids[0]}:tids:lastposttime`;
        } else {
            key = cids.map(cid => `cid:${cid}:tids:lastposttime`);
        }
    } else {
        key = 'topics:recent';
    }

    const data = await topics.getTopicsFromSet(key, widget.uid, 0, Math.max(0, numTopics));
    data.topics.forEach((topicData) => {
        if (topicData && !topicData.teaser) {
            topicData.teaser = {
                user: topicData.user,
            };
        }
    });
    widget.html = await app.renderAsync('widgets/recenttopics', {
        topics: data.topics,
        numTopics: numTopics,
        relative_path: nconf.get('relative_path'),
    });
    return widget;
};

const defineWidgets = async function (widgets) {
    const widgetData = [
        {
            widget: 'html',
            name: 'HTML',
            description: 'Any text, html, or embedded script.',
            content: 'admin/partials/widgets/html',
        },
        {
            widget: 'text',
            name: 'Text',
            description: 'Text, optionally parsed as a post.',
            content: 'admin/partials/widgets/text',
        },
        {
            widget: 'recenttopics',
            name: 'Recent Topics',
            description: 'Lists the latest topics on your forum.',
            content: 'admin/partials/widgets/recenttopics',
        },
    ];

    await Promise.all(widgetData.map(async (widget) => {
        widget.content = await app.renderAsync(widget.content, {});
    }));

    widgets = widgets.concat(widgetData);

    return widgets;
};

module.exports = {
    widgetInit,
    renderRecentTopicsWidget,
    renderHTMLWidget,
    renderTextWidget,
    defineWidgets,
};
