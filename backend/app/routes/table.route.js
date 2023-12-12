module.exports = app => {
  const jwt = require('../config/checkJwt.js')
  const table = require('../controller/table.controller.js')

  var router = require("express").Router();
  router.use([jwt.checkJwt],)

  router.post("/create", table.ceateTable);
  router.post("/update", table.updateTable);
  router.post("/updateStatus", table.updateStatusTable);
  router.post("/delete", table.delete);
  router.get("/list", table.getList);
  router.get("/listStatus", table.getStatusList);


  app.use('/api/table', router);
};