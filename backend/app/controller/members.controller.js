
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
exports.getList = async(req , res) => {
    try {
        const isAdmin = await Auth.checkAdmin(req);
        if (isAdmin) {
                const queryRaw = "SELECT * FROM users";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [],
                    type: QueryTypes.SELECT
                });
                res.send({resultRaw})
                res.status(200);
        } else {
            res.status(401).send('member is not admin');
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}
