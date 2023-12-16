
module.exports = app => {

  const jwt = require('../config/checkJwt.js')
  const invoice = require('../controller/invoice.controller.js')

  var router = require("express").Router();

  router.use([jwt.checkJwt])

  router.get("/list", invoice.getList);
  router.get("/listbyiduser", invoice.getListByIdUser);
  router.get("/detailbyid", invoice.getDetailsById);
  router.get("/details", invoice.getDetails);
  router.get("/search", invoice.searchByDate);
  router.post("/report-day", invoice.reportByDay);

  app.use('/api/invoice', router);
};




