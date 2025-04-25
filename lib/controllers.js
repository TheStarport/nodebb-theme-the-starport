'use strict';

const { getSettings, setSettings} = require("./settings");
const { getCategoriesAndFiles, requestAuthToken, isAuthed, init } = require("./bb");

const winston = require.main.require('winston');

const Controllers = module.exports;

Controllers.renderAdminPage = async (req, res) => {
    res.render('admin/plugins/the-starport', {
        settings: await getSettings()
    });
};

Controllers.saveAdminPageApi = (req, res, next) => {
    setSettings(JSON.parse(req.query.settings))
        .then(init)
        .then(() => res.sendStatus(200))
        .catch((err) => {
            winston.error(err);
            next();
        });
};

Controllers.renderDownloadArchive = async (req, res, next) => {
    if (!isAuthed()) {
        res.sendStatus(500);
        return;
    }

    const settings = await getSettings();

    const formatBytes = (bytes, decimals = 2) => {
        if (!+bytes) {
            return '0 Bytes';
        }

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KiB', 'MiB', 'GiB', 'TiB'];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        return `${parseFloat((bytes / Math.pow(k, i)).toFixed(dm))} ${sizes[i]}`;
    }

    const categories = {};

    for (const [key, value] of Object.entries(getCategoriesAndFiles())) {
        value.files = value.files.map((file) => {
            if (file.fileInfo.description) {
                file.fileInfo.description = file.fileInfo.description
                    .replaceAll('\r', '')
                    .replaceAll('\n', '<br>');
            }

            return {
                "fileInfo": file.fileInfo,
                "fileSize": formatBytes(file.contentLength),
                "fileName": file.fileName,
                "image": null // TODO: Implement image support
            };
        });

        value.files.sort((a, b) => {
            if (!('originaldate' in a)) {
                return false;
            }

            if (!('originaldate' in b)) {
                return true;
            }

            return parseInt(a.originaldate) > parseInt(b.originaldate);
        })

        categories[key] = value;
    }

    try {
        const auth = await requestAuthToken();

        res.render('downloads', {
            bucket: settings.bucketName,
            categories: categories,
            ...auth
        });
    }
    catch (ex) {
        winston.error(ex);
        res.sendStatus(500);
    }
}
