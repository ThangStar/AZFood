
module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const invoice = require('../controller/invoice.controller.js')
  
    var router = require("express").Router();
  
    router.get("/list",[jwt.checkJwt] , invoice.getList );
    router.get("/details",[jwt.checkJwt] , invoice.getDetails );
  
    app.use('/api/invoice', router);
  };
  