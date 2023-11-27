const {getSettings} = require("./settings");
const B2 = require('backblaze-b2');
const winston = require.main.require('winston');

let b2 = null;
let reAuthInterval;

let fileList = false;
let publicAuthToken = null;

const axios = {
    timeout: 10000
}

function init() {
    return new Promise(async (resolve, reject) => {

        if (reAuthInterval) {
            clearInterval(reAuthInterval);
            b2 = null;
        }

        let settings = await getSettings();

        if (!settings.bbKey || !settings.bbKeyId) {
            reject("Missing bbKey or bbKeyId");
            return;
        }

        if (!settings.bucketId) {
            reject("Missing bucket id");
            return;
        }

        try {
            b2 = new B2({
                applicationKey: settings.bbKey,
                applicationKeyId: settings.bbKeyId,
            });

            winston.info("Authorizing with Backblaze.");
            await b2.authorize(axios);

            winston.info("Fetching file list");
            const res = await b2.listFileNames({
                ...axios,
                bucketId: settings.bucketId,
                maxFileCount: 3000
            });

            fileList = res.data;

            reAuthInterval = setInterval(init, 1000 * 60 * 60 * 23); // Schedule an authentication every 23hours
            resolve();
        } catch (err) {
            fileList = false;
            winston.error(err);
            reject(err);
        }
    });
}

function isAuthed() {
    return b2 !== null;
}

function getFiles() {
    if (!fileList) {
        throw Error("Backblaze has not yet authenticated.");
    }

    return fileList.files;
}

async function requestAuthToken() {
    if (!fileList) {
        throw Error("Backblaze has not yet authenticated.");
    }

    const settings = await getSettings();
    
    if (!publicAuthToken) {
        winston.info("Acquiring Public Download Authorization");
        const auth = await b2.getDownloadAuthorization({
            ...axios,
            bucketId: settings.bucketId,
            validDurationInSeconds: 604800,
            fileNamePrefix: '/'
        });
        
        publicAuthToken = auth.data.authorizationToken;
    }

    return {
        downloadUrl: b2.downloadUrl,
        token: publicAuthToken
    };
}

module.exports = {
    init,
    getFiles,
    requestAuthToken,
    isAuthed
}
