'use strict';

const { getSetting, getSettings, setSettings} = require("./settings");
const { getFiles, requestAuthToken, isAuthed, init } = require("./bb");

const Controllers = module.exports;

const accountHelpers = require.main.require('./src/controllers/accounts/helpers');
const helpers = require.main.require('./src/controllers/helpers');

Controllers.renderAdminPage = async (req, res) => {
    res.render('admin/plugins/the-starport', {
        settings: await getSettings()
    });
};

Controllers.saveAdminPageApi = (req, res, next) => {
    Promise.resolve()
        .then(() =>  {
            setSettings(JSON.parse(req.query.settings));
            return init();
        })
        .then(() => {
            res.sendStatus(200);
        })
        .catch(next);
};

Controllers.renderDownloadArchive = async (req, res, next) => {
    if (!isAuthed()) {
        res.sendStatus(500);
        return;
    }

    const formatBytes = (bytes, decimals = 2) => {
        if (!+bytes) {
            return '0 Bytes';
        }

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        return `${parseFloat((bytes / Math.pow(k, i)).toFixed(dm))} ${sizes[i]}`;
    }

    const files = getFiles().map((file) => {
        file.fileSize = formatBytes(file.contentLength);
        return file;
    });

    console.log(files);

    const auth = await requestAuthToken();

    res.render('downloads', {
        files: files,
        ...auth
    });
}
