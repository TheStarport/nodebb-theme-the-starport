const { getSettings } = require('./settings');
const B2 = require('backblaze-b2');
const winston = require.main.require('winston');

let b2 = null;
let reAuthInterval;

let bucketId = null;
let categories = false;
let publicAuthToken = null;

const axios = {
    timeout: 10000
};

function init() {
    return new Promise(async (resolve, reject) => {
        if (reAuthInterval) {
            clearInterval(reAuthInterval);
            b2 = null;
        }

        let settings = await getSettings();

        if (!settings.bbKey || !settings.bbKeyId) {
            reject('Missing bbKey or bbKeyId');
            return;
        }

        if (!settings.bucketName) {
            reject('Missing bucket name');
            return;
        }

        try {
            b2 = new B2({
                applicationKey: settings.bbKey,
                applicationKeyId: settings.bbKeyId,
            });

            winston.info('Authorizing with Backblaze.');
            await b2.authorize(axios);

            winston.info('Getting bucket information');
            let res = await b2.getBucket({
                ...axios,
                bucketName: settings.bucketName,
            });

            bucketId = res.data.buckets[0].bucketId;

            winston.info('Fetching file list');
            res = await b2.listFileNames({
                ...axios,
                bucketId: bucketId,
                maxFileCount: 3000
            });

            categories = {
                0: {
                    name: 'Vanilla Compatible Patches',
                    files: []
                },
                1: {
                    name: 'Modding Tools',
                    files: []
                },
                2: {
                    name: 'Misc Tools',
                    files: []
                },
                3: {
                    name: 'Freelancer Misc (Beta, Manual, etc)',
                    files: []
                },
                4: {
                    name: 'Mods',
                    files: []
                },
                5: {
                    name: 'Archive / Old Lancerreactor Downloads',
                    files: []
                },
                1000: {
                    name: 'Uncategorized',
                    files: []
                }
            };

            res.data.files.forEach((item) => {
                const info = item.fileInfo;

                if (!info || !info.category || !(info.category in categories)) {
                    categories[999].files.push(item);
                    return;
                }

                categories[info.category].files.push(item);
            });

            reAuthInterval = setInterval(init, 1000 * 60 * 60 * 23); // Schedule an authentication every 23hours
            resolve();
        } catch (err) {
            categories = false;
            winston.error(err);
            reject(err);
        }
    });
}

function isAuthed() {
    return b2 !== null;
}

function getCategoriesAndFiles() {
    if (!categories) {
        throw Error('Backblaze has not yet authenticated.');
    }

    return categories;
}

async function requestAuthToken() {
    if (!categories) {
        throw Error('Backblaze has not yet authenticated.');
    }

    const settings = await getSettings();

    if (!publicAuthToken) {
        winston.info('Acquiring Public Download Authorization');
        const auth = await b2.getDownloadAuthorization({
            ...axios,
            bucketId: bucketId,
            validDurationInSeconds: 604800,
            fileNamePrefix: ''
        });

        publicAuthToken = auth.data.authorizationToken;
    }

    return {
        downloadUrl: b2.downloadUrl,
        token: publicAuthToken,
        bucketName: settings.bucketName
    };
}

module.exports = {
    init,
    getCategoriesAndFiles: getCategoriesAndFiles,
    requestAuthToken,
    isAuthed
};
