module.exports = app => {
  const multer = require('multer');
    const jwt = require('../config/checkJwt.js')
    const products = require('../controller/products.controller.js')
    const upload = multer();
    var router = require("express").Router();
    
    router.post("/create",[jwt.checkJwt ,upload.single('file')] , products.createProduct );
    router.post("/updateStatus",[jwt.checkJwt] , products.updateStatus );
    router.post("/delete",[jwt.checkJwt] , products.delete );
    router.get("/list" , [jwt.checkJwt] , products.getList);
    router.get("/listAll" , [jwt.checkJwt] , products.getList);
    router.get("/category" , [jwt.checkJwt] , products.getListCategory);
    router.get("/details" , [jwt.checkJwt] , products.getDetails);
    router.get("/listStatus" , [jwt.checkJwt] , products.getListStatus);
    router.get("/filterData" , [jwt.checkJwt] , products.filterCategory);
    router.get("/searchProducts/" , [jwt.checkJwt] , products.searchProduct);
    router.get("/listDVT" , [jwt.checkJwt] , products.getListDVT);
  
    app.use('/api/products', router);
  };
  