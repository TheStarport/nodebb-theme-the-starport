const {
    getObject,
    getObjectField,
    setObject,
} = require.main.require('./src/database');

const convert = {
    bbKey: (x) => x || '',
    bbKeyId: (x) => x || '',
    bucketId: (x) => x || '',
};

const getSettings = async () => {
    const { bbKeyId, bbKey, bucketId } = await getObject('theme-the-starport:settings') || {};
    return {
        bbKeyId: convert.bbKeyId(bbKeyId),
        bbKey: convert.bbKey(bbKey),
        bucketId: convert.bucketId(bucketId)
    };
};

const setSettings = async (settings) => {
    if (!settings.bbKey || !settings.bbKeyId) {
        throw Error('BBKey/BBKeyId not provided');
    }

    await setObject('theme-the-starport:settings', settings);
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
