module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const attendance = require("../controller/attendance.controller.js");
    var router = require("express").Router();

    router.use([jwt.checkJwt])
    router.post("/attendance", attendance.attendance);
    router.get("/list", attendance.getListAttendance);
    router.get("/details", attendance.getAttendance);

    app.use('/api/attendance', router);

};
