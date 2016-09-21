define(['jquery', 'knockout', 'menu', 'setting'], function ($, ko, menu, setting) {

    function ListComponent(params) {
        var _this = this;
        this.config = params.config;
        this.config.data = ko.observable({});
        this.config.selectedRow = ko.observable({});

        this.menu = menu;

        var loadData = function () {

            var callback = function (data) {
                this.config.data(data);
                //template need to be handled 
                this.config.selectedRow(data.rows[0]);
                setTimeout(function () {
                    $('.list-items .list-item:first').click();
                }, 500);
            }.bind(this);

            $.get(setting[this.config.type()].list.url, callback);

        }.bind(this);

        loadData();

        this.typeSubscriber = this.config.type.subscribe(loadData);

        this.add = function () {
            routeConfig.type = this.config.type();
            routeConfig.view('new');
        }.bind(this);

        this.edit = function () {
            routeConfig.idField = this.config.selectedRow().id;
            routeConfig.type = this.config.type();
            routeConfig.view('edit');
        }.bind(this);

        this.remove = function () {

        }.bind(this);

        this.dispose = function () {
            this.typeSubscriber.dispose();
            $(document).off('click', '.list-item');
            $(document).off('dblclick', '.list-item');
        }

        $(document).on('click', '.list-item', function () {
            var $el = $(this);
            $('.list-items .list-item.active').removeClass('active');
            $el.addClass('active');
            _this.config.selectedRow(ko.dataFor(this));
        });
        $(document).on('dblclick', '.list-item', function () {
            _this.edit();
        });
    }

    return ListComponent;

});
