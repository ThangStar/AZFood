module.exports = app => {
  const jwt = require('../config/checkJwt.js')
  const nhapHang = require('../controller/nhapHang.controller.js')

  var router = require("express").Router();


  router.post("/create", [jwt.checkJwt], nhapHang.nhapHang);
  router.get("/list", [jwt.checkJwt], nhapHang.getList);
  router.get("/products", [jwt.checkJwt], nhapHang.getProductNhapHang);


  app.use('/api/kho', router);
};
