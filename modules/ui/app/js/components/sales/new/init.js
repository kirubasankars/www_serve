define(['jquery', 'knockout', 'knockout.mapping'], function($, ko, mapping) {
  return function(params) {
    this.model = params.model;
    var newLine = ko.toJSON(params.model.lines()[0]);
    this.addLine = function(vm, e) {
      if (e.keyCode == 13) {
        var l = mapping.fromJSON(newLine);
        l.focused = true;
        params.model.lines.push(l);
      }
    };

    var dis = {};
    this.dy = function(a, b) {
      var key = a + (b || '');
      if (!dis[key]) {
        dis[key] = ko.observable(null);
      }
      return dis[key];
    };

  };
});
