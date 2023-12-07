define('admin/plugins/the-starport', ['alerts'], function (alerts) {
    $('#save').on('click', function () {
        const settings = {
            bbKey: $('#bbKey').val(),
            bbKeyId: $('#bbKeyId').val(),
            bucketName: $('#bucketName').val(),
            webhookUrl: $('#webhook-url').val(),
            adminWebhookUrl: $('#admin-webhook-url').val(),
        };

        $.get(location.origin + config.relative_path + '/admin/plugins/the-starport/save', { settings: JSON.stringify(settings) }, function () {
            alerts.success();
        }).catch(() => alerts.warning("Failed to connect to backblaze. Settings still saved."));
    });
});
