module.exports = app => {
    const multer = require('multer');
      const forgotPass = require("../controller/forgotPass.controller.js")
      var router = require("express").Router();

      router.post("/checkAndSendOtpToEmail", forgotPass.checkAndSendOtpToEmail );
      router.post("/resetPassword", forgotPass.resetPassword );

      app.use('/api/auth', router);
      
    };