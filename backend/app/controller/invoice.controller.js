const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.getList = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const queryRaw = `SELECT ic.id , ic.invoiceNumber, ic.total ,ic.createAt , ic.userName , ic.tableID , t.name AS table_Name 
        FROM invoice ic 
        JOIN tables t ON t.id = ic.tableID`;

        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [],
                type: QueryTypes.SELECT
            });
            res.send({ resultRaw })
            res.status(200);
        } catch (error) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};

exports.getDetails = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    const invoiceID = req.query.invoiceID;

    if (isAuth) {
        const queryRaw = "SELECT * FROM invoiceDetails where invoiceID=?";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [invoiceID],
                type: QueryTypes.SELECT
            });
            res.send({ resultRaw })
            res.status(200);
        } catch (error) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};

exports.searchByDate = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const startDate = req.query.startDate;
        const endDate = req.query.endDate;
        const queryRaw = "SELECT * FROM invoice WHERE createAt >= :startDate AND createAt <= :endDate ";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: {
                    startDate: startDate,
                    endDate: endDate
                },
                type: QueryTypes.SELECT
            });
            res.send({ resultRaw })
            res.status(200);
        } catch (error) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};