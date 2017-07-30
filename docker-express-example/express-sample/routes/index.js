var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Docker/Node example application', envVars : process.env });
});

module.exports = router;
