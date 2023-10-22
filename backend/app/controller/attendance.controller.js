const checkAddressWifi = require('../config/wifiHelper')
const Jwt = require("../config/checkJwt");
const Auth = require('./checkAuth.controller')
const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;

exports.attendance = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    const user = Jwt.getCurrentLogin(req);
    const isWifi = checkAddressWifi();
    const userID = user.userId;

    if (checkAuth) {
        try {
            if (isWifi) {
                const currentDate = new Date().toISOString().split('T')[0];
                const existingAttendance = await sequelize.query(
                    'SELECT * FROM attendance WHERE userID = ? AND date = ?',
                    {
                        replacements: [userID, currentDate],
                        type: QueryTypes.SELECT
                    }
                );

                if (existingAttendance.length === 0) {
                    const queryRaw = "INSERT INTO attendance (userID , date, status ) VALUES (?, ?, ?);";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [userID, currentDate, "đi làm "],
                        type: QueryTypes.INSERT
                    });
                    console.log("Điểm danh thành công.");
                } else {
                    console.log("Đã điểm danh cho ngày hôm nay.");
                }

            } else {
                console.log("Sai địa chỉ wifi ");
            }
            res.status(200).json({ isWifi });
        } catch (error) {
            res.status(500).json({ message: 'Internal server error', error });
        }
    } else {
        res.status(401).send('member is not login');
    }
};

const getCurrentMonthYear = () => {
    const currentDate = new Date();
    const year = currentDate.getFullYear();
    const month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // Lấy tháng hiện tại và định dạng thành "MM"
    return `${year}-${month}`;
};

exports.getListAttendance = async (req, res) => {

    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        const month = req.query.month || getCurrentMonthYear()
        const queryRaw = `SELECT d.id, d.date, d.status, u.name, u.imgUrl 
        FROM attendance AS d
        INNER JOIN users AS u ON u.id = d.userID
        WHERE DATE_FORMAT(d.date, '%Y-%m') = ?; `;
        console.log(month)
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [month],
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
exports.getAttendance = async (req, res) => {

    const user = Jwt.getCurrentLogin(req);
    const userID = user.userId;
    if (userID) {
        const queryRaw = "SELECT * FROM attendance WHERE userID = ? ";
        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [userID],
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