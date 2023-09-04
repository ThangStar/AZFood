// statistics.controller.js

const Auth = require('./checkAuth.controller')
const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;

exports.getInvoiceDailyStats = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        const body = req.body;
        const queryRaw = `SELECT DATE_FORMAT(createAt, '%Y-%m-%d') AS ngay, COUNT(id) AS so_hoa_don, SUM(total) AS tong_tien
        FROM invoice  
        WHERE DATE_FORMAT(createAt, '%Y-%m') = ?
        GROUP BY DATE_FORMAT(createAt, '%Y-%m-%d')
        ORDER BY ngay desc;`
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.date],
                type: QueryTypes.SELECT
            });
            if (resultRaw.length > 0) {
                res.send({ resultRaw })
                res.status(200);
            } else {
                res.send('No data');
                res.status(204);
            }

        } catch (error) {
            res.status(500);
            res.send(error)
        }
    } else {
        res.status(401).send('You are not logged in');
    }
}