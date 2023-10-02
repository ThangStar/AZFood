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
    router.post("/checkAndSendOtpToEmail", member.checkAndSendOtpToEmail );
    router.post("/create",[jwt.checkJwt ,upload.single('file')] , member.createMember );
    router.post("/delete",[jwt.checkJwt] , member.delete );
    router.get("/list", [jwt.checkJwt],member.getList);
    router.get("/details", [jwt.checkJwt],member.getDetails);
    router.get("/account", [jwt.checkJwt],login.account);
    router.get("/checkAuth", [jwt.checkJwt] , Auth.getUserLogin);
    router.get("/search", [jwt.checkJwt] , member.searchUser);
  
  
    app.use('/api/user', router);
    
  };
  
