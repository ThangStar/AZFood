
module.exports = app => {

  const jwt = require('../config/checkJwt.js')
  const invoice = require('../controller/invoice.controller.js')

  var router = require("express").Router();

  
  
    router.get("/list",[jwt.checkJwt] , invoice.getList );
    router.get("/listbyiduser",[jwt.checkJwt] , invoice.getListByIdUser );
    router.get("/detailbyid",[jwt.checkJwt] , invoice.getDetailsById );
    router.get("/details",[jwt.checkJwt] , invoice.getDetails );
    router.get("/search",[jwt.checkJwt] , invoice.searchByDate );
  router.get("/report-day", [jwt.checkJwt], invoice.reportByDay);

  app.use('/api/invoice', router);
};


  

