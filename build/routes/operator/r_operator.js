// Generated by CoffeeScript 2.3.2
(function() {
  var addCommit, addRemote, addTemp, express, router;

  express = require('express');

  ({addTemp, addCommit, addRemote} = require('../../controller/operator/operator'));

  router = express.Router();

  router.post('/addtemp', addTemp);

  router.post('/addCommit', addCommit);

  router.post('/addRemote', addRemote);

  module.exports = router;

}).call(this);

//# sourceMappingURL=r_operator.js.map
