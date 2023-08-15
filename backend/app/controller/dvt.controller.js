const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.createDVT = async (req, res) => {
    try {
        const body = req.body;
        const isAdmin = await Auth.checkAdmin(req);

        if (isAdmin) {
            
            if (body.id) {
                console.log("Update");
                const queryRaw = "UPDATE donViTinh SET tenDVT = ? WHERE id = ?";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.tenDVT, body.id],
                    type: QueryTypes.UPDATE
                });
                res.status(200).json({ message: 'dvt updated successfully' });
            } else {
                console.log("Insert");
                const queryRaw = "INSERT INTO donViTinh (tenDVT) VALUES(?) ;";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.tenDVT],
                    type: QueryTypes.INSERT
                });
                res.status(200).json({ message: 'dvt created successfully' });
            }
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }
};

exports.getList = async (req, res) => {
    
    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        const queryRaw = "SELECT * FROM donViTinh";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [],
                type: QueryTypes.SELECT
            });
            res.send({ resultRaw })
            res.status(200);
        } catch (e) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(401).send('user is not admin');
    }

}

exports.delete = async (req, res) => {
    const isAdmin = await Auth.checkAdmin(req);
    const body = req.body;
    if (isAdmin) {
        const queryRaw = "DELETE FROM donViTinh WHERE id=? ";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.id],
                type: QueryTypes.DELETE
            });
            res.send({})
            res.status(200);
        } catch (e) {
            console.error(e);
            res.status(500).json({ message: 'Internal server error' });
        }
    } else {
        res.status(401).send('member is not admin');
    }

}