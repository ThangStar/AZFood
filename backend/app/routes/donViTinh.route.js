module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const dvt = require('../controller/dvt.controller.js')
  
    var router = require("express").Router();
  
    
    router.post("/create",[jwt.checkJwt] , dvt.createDVT );
    // router.post("/update",[jwt.checkJwt] , orders.updateOrder );
    router.post("/delete",[jwt.checkJwt] , dvt.delete);
    // router.post("/deleteAll",[jwt.checkJwt] , orders.deleteAllOrder );
    // router.post("/payBill",[jwt.checkJwt] , orders.payBill );
    router.get("/list",[jwt.checkJwt] , dvt.getList );
    
  
    app.use('/api/donViTinh', router);
  };