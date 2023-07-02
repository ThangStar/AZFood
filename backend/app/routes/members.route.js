module.exports = app => {
    const jwt = require('../config/checkJWT.js')
    const login = require("../controller/login.controller");
    const member = require('../controller/members.controller.js')
  
    var router = require("express").Router();
  
    // Login
    router.post("/login", login.login);
    router.post("/create",[jwt.checkJwt] , member.createMember );
    router.get("/list", [jwt.checkJwt],member.getList);
    router.get("/account", [jwt.checkJwt],login.account);
  
    app.use('/api/user', router);
  };