module.exports = app => {
  const jwt = require('../config/checkJwt.js')
  const nhapHang = require('../controller/nhapHang.controller.js')

  var router = require("express").Router();
  router.use([jwt.checkJwt],)

  router.post("/create", nhapHang.nhapHang);
  router.get("/list", nhapHang.getList);
  router.get("/products", nhapHang.getProductNhapHang);


  app.use('/api/kho', router);
};
