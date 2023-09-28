module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const attendance = require("../controller/attendance.controller.js");
    var router = require("express").Router();


    router.post("/attendance", [jwt.checkJwt], attendance.attendance);
    router.get("/list", [jwt.checkJwt], attendance.getListAttendance);
    router.get("/details", [jwt.checkJwt], attendance.getAttendance);

    app.use('/api/attendance', router);

};
