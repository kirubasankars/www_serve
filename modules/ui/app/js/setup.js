require.config({
  baseUrl: "js",
  paths: {
    'jquery': '../libs/jquery',
    'jquery-private': '../libs/jquery-private',
    'knockout': '../libs/knockout-3.4.0.debug',
    'knockout.mapping': '../libs/knockout.mapping-latest.debug',
    'bootstrap': '../libs/bootstrap.min',
    'highlight': '../libs/highlight.min',
    'text': '../libs/text',
    'domReady': '../libs/domready',
    'sammy': '../libs/sammy'
  },
  map: {
    '*': {
      'jquery': 'jquery-private'
    },
    'jquery-private': {
      'jquery': 'jquery'
    }
  },
  shim: {
    'underscore': {
      exports: '_'
    },
    'bootstrap': {
      deps: ['jquery']
    }
  }
});

define(['jquery', 'knockout', 'application', 'sammy', 'setting', 'domReady!'],
  function($, ko, Application, Sammy, Setting) {

    routeConfig = {
      view: ko.observable('new'),
      type: '',
      idField: ''
    };

    routeConfig.view.subscribe(function(newView) {
      var type = routeConfig.type,
        id = routeConfig.idField;

      if (newView === "new" || newView === "list") {
        if (Setting[type].ui === "NW" && newView !== "list") {
          window.open('#/' + type + '/' + newView);
        }
        if (Setting[type].ui === "SW") {
          window.location.href = '#/' + type + '/' + newView;
        }
        if (newView === "new" && Setting[type].ui === "PW") {
          config.outlets[1].type(type);
          config.outlets[1].view(newView);
          config.outlets[1].show(true);
        }
      }

      if (newView === "edit" || newView === "view") {
        if (Setting[type].ui === "NW") {
          window.open('#/' + type + '/' + id + '/' + newView);
        }
        if (Setting[type].ui === "SW") {
          window.location.href = '#/' + type + '/' + id + '/' + newView;
        }
        if (Setting[type].ui === "PW") {
          config.outlets[1].idField(id);
          config.outlets[1].type(type);
          config.outlets[1].view(newView);
          config.outlets[1].show(true);
        }
      }
    });

    routeConfig.view.extend({
      notify: 'always'
    });

    var config = {
      outlets: [{
        name: 'main',
        view: ko.observable('list'),
        type: ko.observable('contact'),
        idField: ko.observable(null)
      }, {
        name: 'modal',
        show: ko.observable(false),
        view: ko.observable('new'),
        type: ko.observable('contact'),
        idField: ko.observable(null)
      }, {
        name: 'lookup',
        show: ko.observable(false),
        type: ko.observable('contact')
      }]
    };

    $(document).on("show:lookup", {}, function(event, type, key, value) {
      config.outlets[2].show(true);
      config.outlets[2].type(type);
      config.outlets[2].key = key;
      config.outlets[2].value = value;
    });

    $(document).on("hide:lookup", {}, function(event) {
      config.outlets[2].show(false);
    });

    Sammy(function() {
      this.get('#/:type/list', function() {
        config.outlets[0].type(this.params["type"]);
        config.outlets[0].view("list");
      });
      this.get('#/:type/new', function() {
        config.outlets[0].type(this.params["type"]);
        config.outlets[0].view("new");
      });
      this.get('#/:type/:id/edit', function() {
        config.outlets[0].idField(this.params["id"]);
        config.outlets[0].type(this.params["type"]);
        config.outlets[0].view("edit");
      });
      this.get('#/:type/:id/view', function() {
        config.outlets[0].idField(this.params["id"]);
        config.outlets[0].type(this.params["type"]);
        config.outlets[0].view("view");
      });
    }).run();

    var App = new Application();
    App.Start(config);

  });
