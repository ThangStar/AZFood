module.exports = app => {
  const multer = require('multer');
  const jwt = require('../config/checkJwt.js')
  const login = require("../controller/login.controller");
  const member = require('../controller/members.controller.js')
  const Auth = require("../controller/checkAuth.controller.js");
  const upload = multer();
  var router = require("express").Router();
  // Login
  router.post("/login", login.login);
  router.post("/checkAndSendOtpToEmail", member.checkAndSendOtpToEmail);

  router.use([jwt.checkJwt]);
  router.post("/create", [upload.single('file')], member.createMember);
  router.post("/change", member.changePassUser);
  router.post("/updateinfo", [upload.single('file')], member.updateUserInfo);
  router.post("/delete", member.delete);
  router.get("/list", member.getListPage);
  router.get("/listAll", member.getList);
  router.get("/details", member.getDetails);
  router.get("/account", login.account);
  router.get("/checkAuth", Auth.getUserLogin);
  router.get("/search", member.searchUser);

  app.use('/api/user', router);

};
