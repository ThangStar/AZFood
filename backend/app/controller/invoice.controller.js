const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.getList = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const queryRaw = "SELECT * FROM invoice";
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
    const body = req.body;
    if (isAuth) {
        const queryRaw = "SELECT * FROM invoiceDetails where invoiceID=?";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.invoiceID],
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
        const startDate = req.body.startDate; 
        const endDate = req.body.endDate;
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