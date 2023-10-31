const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.getList = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    
    if (isAuth) {

        const PAGE_SIZE = 25;
        const currentPage = parseInt(req.query.page) || 1;
        const offset = (currentPage - 1) * PAGE_SIZE;

        const totalCountQuery = `SELECT COUNT(*) AS total FROM invoice`;
        const totalCountResult = await sequelize.query(totalCountQuery, {
            raw: true,
            logging: false,
            type: QueryTypes.SELECT
        });

        const queryRaw = `SELECT ic.id , ic.invoiceNumber, ic.total ,ic.createAt , ic.userName , ic.tableID , t.name AS table_Name 
        FROM invoice ic 
        JOIN tables t ON t.id = ic.tableID 
        LIMIT :limit OFFSET :offset;`;
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: {
                    limit: PAGE_SIZE,
                    offset: offset
                },
                type: QueryTypes.SELECT
            });
            const totalPages = Math.ceil(totalCountResult[0].total / PAGE_SIZE);

            res.status(200).json({
                resultRaw: resultRaw,
                currentPage: currentPage,
                totalPages: totalPages,
                totalItems: totalCountResult[0].total
            });
        } catch (error) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};

exports.getListByIdUser = async (req, res) => {
    const body = req.body;
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const queryRaw = `SELECT invoice.id, invoice.total, invoice.createAt, invoice.username, invoice.tableID, invoice.invoiceNumber, invoice.userID, tables.name AS table_Name, tables.status
        FROM invoice
        INNER JOIN tables ON invoice.tableID = tables.id
        WHERE invoice.userID = ?;`;
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.id],
                type: QueryTypes.SELECT
            });
            res.status(200).json({
                resultRaw: resultRaw,
            });
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

exports.reportByDay = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const body = req.body;
        console.log("body  ", body);
        const queryRaw = `
        SELECT 
            poductName,
            SUM(quantity) AS totalQuantity,
            SUM(totalAmount) AS totalAmount
        FROM invoicedetails
        INNER JOIN invoice ON invoicedetails.invoiceID = invoice.id
        WHERE  DAY(invoice.createAt) = ?  AND  MONTH(invoice.createAt) = ?
       
        GROUP BY poductName;
    `;
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.day, body.month],
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

    }}
exports.searchIvoiceByName = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        try {
            const keysearch = req.body.keysearch;
            console.log(req.body.keysearch);
            const queryRaw = `SELECT * FROM invoice WHERE name LIKE :name`;

            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: {
                    name: `%${keysearch}%`
                },
                type: QueryTypes.SELECT
            });
            res.status(200).json({
                data: resultRaw,

            });
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
            console.log("error", error)
        }
    } else {
        res.status(401).send('User is not admin');

    }
};