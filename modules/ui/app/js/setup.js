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
    'domReady': '../libs/domReady',
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

    var mainOutlet = config.outlets[0],
        modalOutlet = config.outlets[1],
        lookupOutlet = config.outlets[2];

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
          modalOutlet.type(type);
          modalOutlet.view(newView);
          modalOutlet.show(true);
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
          modalOutlet.idField(id);
          modalOutlet.type(type);
          modalOutlet.view(newView);
          modalOutlet.show(true);
        }
      }
    });

    routeConfig.view.extend({
      notify: 'always'
    });

    $(document).on("show:lookup", {}, function(event, type, key, value) {
      lookupOutlet.show(true);
      lookupOutlet.type(type);
      lookupOutlet.key = key;
      lookupOutlet.value = value;
    });

    $(document).on("hide:lookup", {}, function(event) {
      lookupOutlet.show(false);
    });

    Sammy(function() {
      this.get('#/:type/list', function() {
        mainOutlet.type(this.params["type"]);
        mainOutlet.view("list");
      });
      this.get('#/:type/new', function() {
        mainOutlet.type(this.params["type"]);
        mainOutlet.view("new");
      });
      this.get('#/:type/:id/edit', function() {
        mainOutlet.idField(this.params["id"]);
        mainOutlet.type(this.params["type"]);
        mainOutlet.view("edit");
      });
      this.get('#/:type/:id/view', function() {
        mainOutlet.idField(this.params["id"]);
        mainOutlet.type(this.params["type"]);
        mainOutlet.view("view");
      });
    }).run();

    var App = new Application();
    App.Start(config);

  });
