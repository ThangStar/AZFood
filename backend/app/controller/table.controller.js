const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')
exports.ceateTable = async (req, res) => {
    try {
        const body = req.body;
        const isAdmin = await Auth.checkAdmin(req);

        if (isAdmin) {
                console.log("Insert");
                const queryRaw = "INSERT INTO tables (name,status) VALUES (?, 3);";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.name],
                    type: QueryTypes.INSERT
                });
                res.status(200).json({ message: 'tables created successfully' });
        }else {
            res.status(401).send('You are not admin');
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }
}
exports.updateTable = async (req, res) => {
    try {
        const body = req.body;
        const isAuth = await Auth.checkAuth(req);
        if (isAuth) {
            console.log("Update");
            console.log("id ", body.id);
            const queryRaw = "UPDATE tables SET name = ?, status = ? WHERE id = ?";
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.name, body.status, body.id],
                type: QueryTypes.UPDATE
            });
            res.status(200).json({ message: 'tables updated successfully' });
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }
}

exports.updateStatusTable = async (req, res) => {
    try {
        const body = req.body;
        console.log(body);
        const isAuth = await Auth.checkAuth(req);
        if (isAuth) {
            console.log("id ", body.id);
            const queryRaw = "UPDATE tables SET status = 3 WHERE id = ?";
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [ body.id],
                type: QueryTypes.UPDATE
            });
            res.status(200).json({ message: 'tables updated successfully' });
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }
}
exports.getList = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const queryRaw = "SELECT t.id, t.name, t.status, s.name AS status_name FROM tables t JOIN statusTable s ON t.status = s.id;";
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
        res.status(401).send('You are not logged in');
    }

}
exports.getStatusList = async (req, res) => {

    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const queryRaw = "SELECT * FROM statusTable";
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
        res.status(401).send('You are not logged in');
    }

}
exports.delete = async (req, res) => {
    const isAdmin = await Auth.checkAdmin(req);
    const body = req.body;
    if (isAdmin) {
        const queryRaw = "DELETE FROM tables WHERE id=? ";
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
        res.status(401).send('You are not admin');
    }

}