define(['jquery', 'knockout', 'setting'], function($, ko, Setting) {

  return function(params) {

    var config = params.config,
        type = ko.unwrap(config.type),
       _this = this;

    this.type = type;
    this.selectedField = ko.observable(null);
    this.keyword = "";
    this.currentIndex = 0;
    this.rows = ko.observable(null);

    this.availableFields = Setting[type].lookup.fields;

    this.afterRender = function() {
      $('input.keyword').focus();
    };

    $('input.keyword').on('blur', function(){
      this.focus();
    });

    $('input.keyword').on('blur', function(){
      this.focus();
    });

    $(document).on('click', '.lookup-rows tr', function(){
      var data = ko.dataFor(this);
      config.key(data.id);
      config.value(data);
    });

    this.select = function(vm, e) {
      if(e.keyCode === 27) {
        config.show(false);
      }
      if (e.keyCode === 38 || e.keyCode === 40) {
        if (e.keyCode === 40 && this.currentIndex < (ko.unwrap(this.rows).length - 1)) {
          this.currentIndex++;
        } else if (e.keyCode === 38 && this.currentIndex > 0) {
          this.currentIndex--;
        }
        $('.lookup-rows tr').removeClass('active info');
        $('.lookup-rows tr:eq(' + this.currentIndex + ')').addClass('active info');
        $('.lookup-rows').scrollTop(this.currentIndex * 37);
      }
      return true;
    }

    this.search = function(vm, e) {
      if (e && e.keyCode === 13) {
        var data = ko.dataFor($('.lookup-rows tr.active').get(0));
        config.key(data.id);
        config.value(data);
      } else if (!(e && e.keyCode >= 38 && e.keyCode <= 41)) {
        var v = ko.unwrap(this.selectedField);
        if (v) loadData(v.value, this.keyword);
        else loadData();
      }
    }.bind(this);

    function loadData(key, value) {
      var q = key && value ? '?' + key + '=' + value : '';
      $.get(Setting[type].lookup.url + q, function(data) {
        _this.rows(data.rows);
        this.currentIndex = 0;
        $('.lookup-rows tr:eq(0)').addClass('active info');
        $('.lookup-rows').scrollTop(0);
      });
    }

    loadData('', '');

    var selectedFieldSubscriber = this.selectedField.subscribe(this.search);

    this.dispose = function() {
      selectedFieldSubscriber.dispose();
      $(document).off('click', '.lookup-rows tr');
    }

    this.close = function(){
      config.show(false);
    }

  };
});
