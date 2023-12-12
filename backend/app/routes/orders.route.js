module.exports = app => {
  const jwt = require('../config/checkJwt.js')
  const orders = require('../controller/orders.controller.js')

  var router = require("express").Router();
  router.use([jwt.checkJwt])

  router.post("/create", orders.createOrder);
  router.post("/updateQuantity", orders.updateQuantity);
  router.post("/updatePriceItem", orders.updatePriceOrder);
  router.post("/update", orders.updateOrder);
  router.post("/delete", orders.deleteOrder);
  router.post("/deleteAll", orders.deleteAllOrder);
  router.post("/payBill", orders.payBill);
  router.get("/getOrder", orders.getOrdersForTable);
  router.get("/list", orders.getList);


  app.use('/api/orders', router);
};

