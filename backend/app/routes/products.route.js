module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const products = require('../controller/products.controller.js')
  
    var router = require("express").Router();
  
    
    router.post("/create",[jwt.checkJwt] , products.createProduct );
    router.post("/delete",[jwt.checkJwt] , products.delete );
    router.get("/list" , [jwt.checkJwt] , products.getList);
    router.get("/category" , [jwt.checkJwt] , products.getListCategory);
    router.get("/details" , [jwt.checkJwt] , products.getDetails);
    router.get("/status" , [jwt.checkJwt] , products.getListStatus);
  
    app.use('/api/products', router);
  };