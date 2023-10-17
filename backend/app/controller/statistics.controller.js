// statistics.controller.js

const Auth = require('./checkAuth.controller')
const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;

exports.getInvoiceDailyStats = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        const body = req.body;
        console.log("body.date ", body.date);
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

exports.getRevenueCurrentYear = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);

    if (checkAuth) {
        try {
            const currentTime = new Date();
            const currentYear = currentTime.getFullYear();

            const query = `
                SELECT 
                    YEAR(createAt) AS year,
                    MONTH(createAt) AS month,
                    SUM(total) AS total_amount
                FROM 
                    invoice
                WHERE 
                    YEAR(createAt) = :currentYear
                GROUP BY 
                    YEAR(createAt), MONTH(createAt)
                ORDER BY 
                    YEAR(createAt), MONTH(createAt);
            `;

            const result = await sequelize.query(query, {
                replacements: { currentYear },
                type: QueryTypes.SELECT
            });

            if (result.length > 0) {
                res.status(200).json({ result });
            } else {
                res.status(204).send('No data');
            }
        } catch (error) {
            res.status(500).send(error);
        }
    } else {
        res.status(401).send('You are not logged in');
    }
};
exports.getRevenueMonth = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);

    if (!checkAuth) {
        return res.status(401).send('You are not logged in');
    }

    const month = req.query.month;
    console.log("month ", month);
    try {
        const queryRaw = `
        SELECT 
            YEAR(createAt) AS year,
            MONTH(createAt) AS month,
            DAY(createAt) AS day,
            SUM(total) AS total_amount
        FROM 
            invoice
        WHERE 
            MONTH(createAt) = ?
            AND YEAR(createAt) = ?
        GROUP BY 
            YEAR(createAt), MONTH(createAt), DAY(createAt)
            ORDER BY
                DAY(createAt);
    `;

        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [month, 2023],
            type: QueryTypes.SELECT
        });

        if (resultRaw.length > 0) {
            return res.status(200).json({ result: resultRaw });
        } else {
            return res.status(204).send('No data');
        }
    } catch (error) {
        console.log("Lỗi ", error);
        return res.status(500).send(error.message);
    }
};

