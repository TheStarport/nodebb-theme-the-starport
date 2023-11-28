const nconf = require.main?.require('nconf');

const assets = `${nconf.get('url')}/assets/plugins/nodebb-theme-the-starport/images/downloads/`

module.exports = {
    "FLMMInstallerv1.31.zip": {
        friendlyName: 'Freelancer Mod Manager v1.3.1',
        image: assets + "flmodman131.jpg",
        description: 'This mod manager lets you activate and deactivate your Freelancer mods with a simple click. Version 1.31 is still used by most of the Freelancer mods, but newer version exists also. Take a look at a mod description and installation manual to check which FLMM version you need.'
    }
};
