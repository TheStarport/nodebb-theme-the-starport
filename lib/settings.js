const { promisify } = require('util');
const winston = require.main.require('winston');

const db = require.main.require('./src/database');

const getObject = promisify(db.getObject);
const setObject = promisify(db.setObject);
const getObjectField = promisify(db.getObjectField);

const convert = {
    bbKey: (x) => x || '',
    bbKeyId: (x) => x || '',
    bucketName: (x) => x || '',
    webhookUrl: (x) => x || '',
    adminWebhookUrl: (x) => x || '',
};

const getSettings = async () => {
    const { bbKeyId, bbKey, bucketName, webhookUrl, adminWebhookUrl } = await getObject('theme-the-starport:settings') || {};
    return {
        bbKeyId: convert.bbKeyId(bbKeyId),
        bbKey: convert.bbKey(bbKey),
        bucketName: convert.bucketName(bucketName),
        webhookUrl: convert.webhookUrl(webhookUrl),
        adminWebhookUrl: convert.adminWebhookUrl(adminWebhookUrl)
    };
};

const setSettings = async (settings) => {
    winston.info("Saving Starport Settings");
    if (!settings.bbKey || !settings.bbKeyId) {
        throw Error('BBKey/BBKeyId not provided');
    }

    try {
        await setObject('theme-the-starport:settings', settings);
        winston.info("Saved Starport Settings");
    }
    catch (err) {
        winston.error("Failed to save starport settings.", err);
    }
}

const getSetting = async (key) => {
    const value = await getObjectField('theme-the-starport:settings', key);
    if (!convert[key]) {
        throw Error('invalid-data');
    }
    return convert[key](value);
};

module.exports = {
    getSettings,
    getSetting,
    setSettings,
};
