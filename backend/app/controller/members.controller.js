
const sha1 = require('sha1');
const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

// Create and Save a new member
exports.createMember = async (req, res) => {
    try {
        const body = req.body;
        body.password = sha1(body.password);

        const isAdmin = await Auth.checkAdmin(req);
        if (isAdmin) {
            if (body.id) {
                console.log("Update");
                const queryRaw = "UPDATE users SET username = ?, password = ?, name = ?, role = ?, phoneNumber = ?, email = ? WHERE id = ?;";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.username, body.password, body.name, body.role, body.phoneNumber, body.email, body.id],
                    type: QueryTypes.UPDATE
                });
                res.status(200).json({ message: 'Member updated successfully' });
            } else {
                console.log("Insert");
                const queryRaw = "INSERT INTO users (username, password, name, role, phoneNumber, email) VALUES (?, ?, ?, ?, ?, ?);";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.username, body.password, body.name, body.role, body.phoneNumber, body.email],
                    type: QueryTypes.INSERT
                });
                res.status(200).json({ message: 'Member created successfully' });
            }

        } else {
            res.status(401).send('member is not admin');
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }

};
exports.getList = async (req, res) => {

    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        const queryRaw = "SELECT * FROM users";
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
        res.status(401).send('member is not admin');
    }

}

exports.searchUser = async (req, res) => {

    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        const name = req.body.name;
        const queryRaw = "SELECT * FROM users where name LIKE :name";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements:  {name: `%${name}%`},
                type: QueryTypes.SELECT
            });
            res.send({ resultRaw })
            res.status(200);
        } catch (error) {
            res.status(500);
            res.send(error)
        }

    } else {
        res.status(401).send('member is not admin');
    }

}
exports.getDetails = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    const id = req.body.id;
    if (checkAuth) {
        const queryRaw = "SELECT * FROM users WHERE id = ?;";
        const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false, replacements: [id], type: QueryTypes.SELECT });
        res.status(200);
        res.send(resultRaw[0]);
    } else {
        res.status(401);
    }
};

exports.delete = async (req, res) => {
    const isAdmin = await Auth.checkAdmin(req);
    const body = req.body;
    if (isAdmin) {
        const queryRaw = "DELETE FROM users WHERE id=? ";
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
