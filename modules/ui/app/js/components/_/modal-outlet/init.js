define(['jquery', 'knockout'], function($, ko) {

  return function(params) {
      this.config = params.config;      

      this.close = function() {
        this.config.show(false);
      }
  }

});
