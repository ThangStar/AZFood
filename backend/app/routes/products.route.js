module.exports = app => {
  const multer = require('multer');
  const jwt = require('../config/checkJwt.js')
  const products = require('../controller/products.controller.js')
  const upload = multer();
  var router = require("express").Router();
  router.use([jwt.checkJwt])

  router.post("/createPrice", products.addPriceProduct);
  router.post("/updatePrice", products.updatePriceProduct);
  router.post("/create", [upload.single('file')], products.createProduct);
  router.post("/updateStatus", products.updateStatus);
  router.post("/delete", products.delete);
  router.get("/list", products.getList);
  router.get("/listAll", products.getListAll);
  router.get("/category", products.getListCategory);
  router.get("/details", products.getDetails);
  router.get("/listStatus", products.getListStatus);
  router.get("/filterData", products.filterCategory);
  router.get("/searchProducts", products.searchProduct);
  router.get("/listDVT", products.getListDVT);
  router.get("/listProductSize", products.getProductSize);
  router.get("/listTopProduct", products.getListTop);
  router.post("/deletePrice", products.deletePriceProduct);
  router.get("/listPriceProduct", products.getPriceProduct);
  router.get("/getSizePrice", products.getSizePrice);
  router.get("/getPriceBySizeAndIdProduct", products.getPriceBySizeAndIdProduct);

  app.use('/api/products', router);
};
