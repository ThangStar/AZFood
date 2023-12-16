const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.getList = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);

    if (isAuth) {

        const PAGE_SIZE = 10;
        const currentPage = parseInt(req.query.page) || 1;
        const offset = (currentPage - 1) * PAGE_SIZE;

        const totalCountQuery = `SELECT COUNT(*) AS total FROM invoice`;
        const totalCountResult = await sequelize.query(totalCountQuery, {
            raw: true,
            logging: false,
            type: QueryTypes.SELECT
        });

        const queryRaw = `SELECT ic.id , ic.invoiceNumber, ic.total ,ic.createAt , ic.userName , ic.tableID , t.name AS table_Name , ic.payMethod
        FROM invoice ic 
        LEFT JOIN tables t ON t.id = ic.tableID 
        order by ic.createAt desc
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
        WHERE invoice.userID = :userID AND (invoice.id LIKE :id OR invoice.createAt LIKE :createAt OR tables.name LIKE :name)`;
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: {
                    userID: body.userID,
                    id: `%${body.keysearch}%`,
                    createAt: `%${body.keysearch}%`,
                    name: `%${body.keysearch}%`
                },
                type: QueryTypes.SELECT
            });
            res.status(200).json({
                resultRaw: resultRaw,
            });
            console.log(resultRaw);
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

exports.reportByDay = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const body = req.body;
        console.log("body  ", body);
        const queryRaw = `
        SELECT 
            poductName,
            SUM(quantity) AS totalQuantity,
            SUM(totalAmount) AS totalAmount,
            invoice.userName,
            invoice.userID
        FROM invoiceDetails
        INNER JOIN invoice ON invoiceDetails.invoiceID = invoice.id
        WHERE  DAY(invoice.createAt) = ?  AND  MONTH(invoice.createAt) = ?
       
        GROUP BY invoiceDetails.poductName, invoice.userName, invoice.userID;
    `;
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.day, body.month],
                type: QueryTypes.SELECT
            });
            res.send({ resultRaw })
            console.log("body  ", resultRaw);
            res.status(200);
        } catch (error) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(403).json({ message: 'Unauthorized' });

    }
}

exports.getDetailsById = async (req, res) => {
    const body = req.body;
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const queryRaw = `SELECT invoice.id, invoice.total, invoice.createAt, invoice.username, invoice.tableID, invoice.invoiceNumber, invoice.userID, tables.name AS table_Name, tables.status
        FROM invoice 
        INNER JOIN tables ON invoice.tableID = tables.id 
        WHERE invoice.id = ?`;
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.id],
                type: QueryTypes.SELECT
            });
            res.status(200).send(resultRaw[0]);
        } catch (error) {
            res.status(500).send(error);
        }

    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};
