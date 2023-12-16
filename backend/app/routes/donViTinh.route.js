module.exports = app => {
  const jwt = require('../config/checkJwt.js')
  const dvt = require('../controller/dvt.controller.js')

  var router = require("express").Router();
  router.use([jwt.checkJwt])

  router.post("/create", dvt.createDVT);
  router.post("/delete", dvt.delete);
  router.get("/list", dvt.getList);


  app.use('/api/donViTinh', router);
};