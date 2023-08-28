module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const table = require('../controller/table.controller.js')
  
    var router = require("express").Router();
  
    
    router.post("/create",[jwt.checkJwt] , table.ceateTable );
    router.post("/update",[jwt.checkJwt] , table.updateTable );
    router.post("/updateStatus",[jwt.checkJwt] , table.updateStatusTable );
    router.post("/delete",[jwt.checkJwt] , table.delete );
    router.get("/list",[jwt.checkJwt] , table.getList );
    router.get("/listStatus",[jwt.checkJwt] , table.getStatusList );
    
  
    app.use('/api/table', router);
  };