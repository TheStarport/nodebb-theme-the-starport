define('admin/plugins/the-starport', ['alerts'], function (alerts) {
    $('#save').on('click', function () {
        const settings = {
            bbKey: $('#bbKey').val(),
            bbKeyId: $('#bbKeyId').val(),
            bucketName: $('#bucketName').val(),
        };

        $.get(location.origin + config.relative_path + '/admin/plugins/the-starport/save', { settings: JSON.stringify(settings) }, function () {
            alerts.success();
        }).catch(() => alerts.warning("Failed to connect to backblaze. Settings still saved."));
    });
});
