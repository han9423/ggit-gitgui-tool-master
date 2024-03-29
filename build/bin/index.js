// Generated by CoffeeScript 2.3.2
(function() {

  /*
  @param {Object} server
  */
  var app, blue, fs, green, handle_inuse, http, https, opBrowser, red, srv;

  require('source-map-support').install();

  https = require('https');

  http = require('http');

  fs = require('fs');

  opBrowser = require('../utils/opBrowser');

  ({red, green, blue} = require('chalk'));

  app = require('../app');

  srv = http.createServer(app);

  handle_inuse = function() {
    console.log(red('port 1031 in use, change 5s later...'));
    return setTimeout((function() {
      return srv.listen(1033, 'localhost', function() {
        console.log(blue('port change to 1033'));
        return opBrowser(1033);
      });
    }), 5000);
  };

  srv.on('error', function(err) {
    switch (err.code) {
      case 'EADDRINUSE':
        return handle_inuse();
      case 'ACCESS':
        return console.log(red('no access'));
    }
  });

  srv.listen(1031, 'localhost', function() {
    var address;
    if (srv != null) {
      address = srv.address();
    }
    console.log(green(`App running on ${address.address} ${address.port}`));
    console.log('3s 后跳转到浏览器...');
    return setTimeout(function() {
      return opBrowser(address.port);
    }, 3000);
  });

}).call(this);

//# sourceMappingURL=index.js.map
