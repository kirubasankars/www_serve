define(['jquery', 'knockout', 'knockout.mapping', 'setting'], function ($, ko, mapping, setting) {

    function EditComponent(params) {
        var _this = this;
        this.config = params.config;
        this.config.data = ko.observable(null);
        this.template = ko.observable('_$loading');
        var type = _this.config.type();

        function loadData() {
            function callback(data) {
                _this.config.data(mapping.fromJS(data.rows[0]));
                _this.template(type + '$edit');
            }            
            $.get(setting[type].view.url.replace(/\{id\}/g, _this.config.idField()), callback);
        }

        this.idFieldSubscriber = this.config.idField.subscribe(loadData);

        loadData();

        this.save = function () {
            var data = mapping.toJSON(this.config.data());
            $.ajax({
                type: "PUT",
                url: setting[type].save.url,
                contentType: "application/json",
                data: data
            }).done(function (rs) {                
                routeConfig.type = type;
                routeConfig.view('list');
            });
        }

        this.dispose = function () {
            this.idFieldSubscriber.dispose();
        }
    }

    return EditComponent;

});
