module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const table = require('../controller/table.controller.js')
  
    var router = require("express").Router();
  
    
    router.post("/create",[jwt.checkJwt] , table.ceateTable );
    router.post("/update",[jwt.checkJwt] , table.updateTable );
    router.post("/delete",[jwt.checkJwt] , table.delete );
    router.get("/list",[jwt.checkJwt] , table.getList );
    
  
    app.use('/api/table', router);
  };