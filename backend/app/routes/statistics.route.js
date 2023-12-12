// statistics.route.js

module.exports = app => {
    const jwt = require('../config/checkJwt.js')
    const stats = require('../controller/statistics.controller.js')
    var router = require("express").Router();


    router.get("/total", stats.getInvoiceDailyStats);
    app.use('/api/stats', [jwt.checkJwt], router);
    app.use('/api/stats/revenue-year', [jwt.checkJwt], stats.getRevenueCurrentYear);
    app.use('/api/stats/revenue-month', [jwt.checkJwt], stats.getRevenueMonth);
};
