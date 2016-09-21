define(['jquery','knockout'], function($, ko) {
window.ko = ko;
  function Application() {
    var app = this;


    var namingConventionLoader = {
      getConfig: function(name, callback) {
        var viewModelConfig = null,
            templateConfig = null,
            _name = name.replace(/\$/g, '-');

        if($('#' + _name + '-component').length > 0) {
          if (app[toPascalCase(_name) + 'Component']) {
            viewModelConfig = app[toPascalCase(_name) + 'Component'];
          }
          templateConfig = { element: _name + '-component' };

          callback({ viewModel: viewModelConfig, template: templateConfig });
        } else {
            require(['js/components/' + name.replace(/\$/g, '/') + '/init.js', 'text!components/' + name.replace(/\$/g, '/') + '/template.html'],
            function(viewModelConfig, template) {
                var $template = $('<template/>').attr('id', _name + '-component').html(template);
                $('body').append($template);
                templateConfig = { element: _name + '-component' };
                callback({ viewModel: viewModelConfig, template: templateConfig });
            });
        }
      }
    };

    function toPascalCase(dasherized) {
      return dasherized.replace(/\$/g, '-').replace(/(^|-)([a-z])/g, function(g, m1, m2) {
        return m2.toUpperCase();
      });
    }

    this.componentLoader = namingConventionLoader;

    ko.components.loaders.push(this.componentLoader);

    this.Start = function(config) {
        ko.applyBindings(config, $('body').get(0));
    }
  };

  return Application;

})
