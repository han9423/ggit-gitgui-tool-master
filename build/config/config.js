// Generated by CoffeeScript 2.3.2
(function() {
  var Config, consolidate, express, index, resolve;

  express = require('express');

  consolidate = require('consolidate');

  ({resolve} = require('path'));

  index = require('../routes/index');

  Config = class Config {
    setEngine(app) {
      app.set('view engine', 'html');
      app.set('views', 'views');
      return app.engine('html', consolidate.pug);
    }

    setStaticPath(app) {
      var staticPath;
      staticPath = resolve(process.cwd(), './public');
      return app.use(express.static(staticPath));
    }

    setPostData(app) {
      app.use(express.json());
      return app.use(express.urlencoded({
        extended: false,
        limit: 6 * 1024 ** 2
      }));
    }

    setOpenIndex(app) {
      return app.use(index);
    }

  };

  module.exports = new Config();

}).call(this);

//# sourceMappingURL=config.js.map