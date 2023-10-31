'use strict';

const Controllers = module.exports;

const accountHelpers = require.main.require('./src/controllers/accounts/helpers');
const helpers = require.main.require('./src/controllers/helpers');

Controllers.renderAdminPage = (req, res) => {
    res.render('admin/plugins/the-starport', {
        title: '[[themes/the-starport:theme-name]]',
    });
};

Controllers.renderThemeSettings = async (req, res, next) => {
    const userData = await accountHelpers.getUserDataByUserSlug(req.params.userslug, req.uid, req.query);
    if (!userData) {
        return next();
    }
    const lib = require('../library');
    userData.theme = await lib.loadThemeConfig(userData.uid);

    userData.title = '[[themes/the-starport:settings.title]]';
    userData.breadcrumbs = helpers.buildBreadcrumbs([
        { text: userData.username, url: `/user/${userData.userslug}` },
        { text: '[[themes/the-starport:settings.title]]' },
    ]);

    res.render('account/theme', userData);
};