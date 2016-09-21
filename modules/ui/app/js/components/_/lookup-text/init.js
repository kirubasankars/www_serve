define(['jquery', 'knockout'], function($, ko) {

  return function(params) {
    var type = ko.unwrap(params.type);
    this.value = ko.observable(null);
    this.key = ko.observable(null);
    this.focused = ko.observable(false);
    this.lookupText = ko.observable(null);
    this.vm = null;
    this.focused.subscribe(function() {
      $(document).trigger("show:lookup", [type, this.key, this.value]);
    }, this);

    this.value.subscribe(function() {
      if (params.value) {
        params.value(ko.unwrap(this.value));
      }
      this.lookupText(ko.unwrap(this.value)[params.text]);
      $(document).trigger("hide:lookup");
    }, this);

    this.key.subscribe(function() {
      if (params.key) {
        params.key(ko.unwrap(this.key));
      }
      $(document).trigger("hide:lookup");
    }, this);

  };

});
