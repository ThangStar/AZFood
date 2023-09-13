module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const nhapHang = require('../controller/nhapHang.controller.js')
  
    var router = require("express").Router();
  
    
    router.post("/create",[jwt.checkJwt] , nhapHang.nhapHang );
    // router.post("/updateStatus",[jwt.checkJwt] , products.updateStatus );
    // router.post("/delete",[jwt.checkJwt] , products.delete );
    router.get("/list" , [jwt.checkJwt] , nhapHang.getList);
    router.get("/products" , [jwt.checkJwt] , nhapHang.getProductNhapHang);
    // router.get("/category" , [jwt.checkJwt] , products.getListCategory);
    // router.get("/details" , [jwt.checkJwt] , products.getDetails);
    // router.get("/listStatus" , [jwt.checkJwt] , products.getListStatus);
    // router.get("/filterData" , [jwt.checkJwt] , products.filterCategory);
    // router.get("/searchProducts" , [jwt.checkJwt] , products.searchProduct);
  
    app.use('/api/kho', router);
  };
  