module.exports = app => {
  const jwt = require('../config/checkJwt.js')
  const orders = require('../controller/orders.controller.js')

  var router = require("express").Router();


  router.post("/create", [jwt.checkJwt], orders.createOrder);
  router.post("/updateQuantity", [jwt.checkJwt], orders.updateQuantity);
  router.post("/updatePriceItem", [jwt.checkJwt], orders.updatePriceOrder);
  router.post("/update", [jwt.checkJwt], orders.updateOrder);
  router.post("/delete", [jwt.checkJwt], orders.deleteOrder);
  router.post("/deleteAll", [jwt.checkJwt], orders.deleteAllOrder);
  router.post("/payBill", [jwt.checkJwt], orders.payBill);
  router.get("/getOrder", [jwt.checkJwt], orders.getOrdersForTable);
  router.get("/list", [jwt.checkJwt], orders.getList);


  app.use('/api/orders', router);
};

