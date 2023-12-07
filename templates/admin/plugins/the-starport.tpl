<div class="row">
    <div class="col-lg-9">
        <form class="plugin-calendar-settings" id="plugin-calendar-settings">
            <div class="panel panel-default">
                <div class="panel-heading">Calendar</div>
                <div class="panel-body">
                    <div class="form-group row">
                        <label for="bbKeyId" class="col-xs-12 col-sm-8">
                            The backblaze key id (or account id if using a master key) for authenticating to backblaze.
                        </label>
                        <div class="col-xs-12 col-sm-4">
                            <input type="text" class="form-control" name="bbKeyId" id="bbKeyId" value="{settings.bbKeyId}" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="bbKey" class="col-xs-12 col-sm-8">
                            The secret key for authenticating against a backblaze key id
                        </label>
                        <div class="col-xs-12 col-sm-4">
                            <input type="password" class="form-control" name="bbKey" id="bbKey" value="{settings.bbKey}" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="bucketName" class="col-xs-12 col-sm-8">
                            The bucket containing the files you want to be accessible
                        </label>
                        <div class="col-xs-12 col-sm-4">
                            <input type="text" class="form-control" name="bucketName" id="bucketName" value="{settings.bucketName}" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="webhook-url" class="col-xs-12 col-sm-8">
                            The Discord webhook url to post whenever a new post is made to the forum
                        </label>
                        <div class="col-xs-12 col-sm-4">
                            <input type="text" class="form-control" name="webhook-url" id="webhook-url" value="{settings.webhookUrl}" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="admin-webhook-url" class="col-xs-12 col-sm-8">
                            The Discord webhook url to post to whenever a new user is created on the forum
                        </label>
                        <div class="col-xs-12 col-sm-4">
                            <input type="text" class="form-control" name="admin-webhook-url" id="admin-webhook-url" value="{settings.adminWebhookUrl}" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="col-lg-3">
        <div class="panel panel-default">
            <div class="panel-heading">Control Panel</div>
            <div class="panel-body">
                <button class="btn btn-primary" id="save">Save Settings</button>
            </div>
        </div>
    </div>
</div>
