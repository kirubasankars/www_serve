define(['jquery', 'knockout'], function($, ko) {
  return function(params) {
    this.model = params.model;
    var dis = {};
    this.dy = function(a, b){
      var key = a + (b || '');
      if(!dis[key]){
        dis[key] = ko.observable(null);
      }
      return dis[key];
    };
  };
});
