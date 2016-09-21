define(['jquery', 'knockout', 'knockout.mapping', 'setting'], function ($, ko, mapping, setting) {

    function NewComponent(params) {
        var _this = this;
        this.config = params.config;
        this.config.data = ko.observable({});
        this.template = ko.observable("_$loading");
        var type = this.config.type();

        $.get(setting[type].list.url + '?new=true', function (data) {
            _this.config.data(mapping.fromJS(data.rows[0]));
            _this.template(type + '$new');
        });

        this.save = function () {
            var data = mapping.toJSON(this.config.data());
            $.ajax({
                type: "POST",
                url: setting[type].save.url,
                contentType: "application/json",
                data: data
            }).done(function (rs) {
                params.config.show(false);
            });
        }

        this.close = function() {
          params.config.show(false);
        }
    }

    return NewComponent;
});
