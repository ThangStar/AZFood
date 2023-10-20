'use strict';
const sha1 = require('sha1');
const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')
const Jwt = require("../config/checkJwt");
const { initializeApp } = require('firebase/app')
const { getStorage, ref, getDownloadURL, uploadBytes } = require('firebase/storage');
const config = require('../fireStoreConfig/config');
const nodemailer = require("nodemailer");
const { emit } = require('nodemon');
initializeApp(config.firebaseConfig);

let transporter = nodemailer.createTransport({
    service: "Gmail",
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD
    }
});

async function sendOtpToEmail(email, otp) {
    let mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: "Mã OTP đặt lại mật khẩu cho ứng dụng AZFood của bạn",
        text: `Mã OTP của bạn là: ${otp}`
    };

    try {
        await transporter.sendMail(mailOptions);
    } catch (error) {
        console.error("Error sending OTP email:", error);
    }
}

exports.checkAndSendOtpToEmail = async (req, res) => {
    const email = req.body.email;

    try {
        const queryRaw = "SELECT COUNT(*) as count FROM users WHERE email = ?;";
        const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false, replacements: [email], type: QueryTypes.SELECT });

        if (resultRaw[0].count === 0) {
            return res.status(404).json({ message: "Email không tồn tại" });
        }

        const otp = Math.floor(100000 + Math.random() * 900000);
        await sendOtpToEmail(email, otp);

        res.status(200).json({ message: "Đã gửi OTP đến email", email });
    } catch (error) {
        console.error("Error in forgotPassword function:", error);
        return res.status(500).json({ message: "Internal Server Error" });
    }
};

// Create and Save a new member
exports.createMember = async (req, res) => {
    const storage = getStorage();
    try {
        const body = req.body;
        body.password = sha1(body.password);
        const isAdmin = await Auth.checkAdmin(req);
        if (isAdmin) {
            if (body.idUser) {
                if (req.file) {
                    const image = req.file;
                    const imageFileName = `${Date.now()}_${image.originalname}`;

                    const storageRef = ref(storage, `files/usersss/${imageFileName}`);
                    const metadata = {
                        contentType: req.file.mimetype,
                    };
                    const snapshot = await uploadBytes(storageRef, req.file.buffer, metadata);
                    const imgUrl = await getDownloadURL(snapshot.ref);
                    console.log("imgUrl", imgUrl);

                    const queryRaw = "UPDATE users SET username = ?, password = ?, name = ?, role = ?, phoneNumber = ?, email = ?, address = ?, imgUrl = ?, birtDay = ? WHERE id = ?";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.username, body.password, body.name, body.role, body.phoneNumber, body.email, body.address, imgUrl, body.birtDay, body.idUser],
                        type: QueryTypes.UPDATE
                    });
                    res.status(200).json({ message: 'Member updated successfully' });


                } else {
                    console.log("insert");
                    const queryRaw = "UPDATE users SET username = ?, password = ?, name = ?, role = ?, phoneNumber = ?,  email = ?, address = ?,  birtDay = ? WHERE id = ?";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.username, body.password, body.name, body.role, body.phoneNumber, body.email, body.address, body.birtDay, body.idUser],
                        type: QueryTypes.INSERT
                    });
                    res.status(200).json({ message: 'Member created successfully' });

                }
            } else {
                if (req.file && req.file.originalname) {
                    const image = req.file;
                    const imageFileName = `${Date.now()}_${image.originalname}`;

                    const storageRef = ref(storage, `files/usersss/${imageFileName}`);
                    const metadata = {
                        contentType: req.file.mimetype,
                    };
                    const snapshot = await uploadBytes(storageRef, req.file.buffer, metadata);
                    const imgUrl = await getDownloadURL(snapshot.ref);
                    const queryRaw = "INSERT INTO users (username, password, name, role, phoneNumber,  imgUrl, createAt) VALUES (?, ?, ?, ?, ?, ?, ?);";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.username, body.password, body.name, body.role, body.phoneNumber, imgUrl, new Date()],
                        type: QueryTypes.INSERT
                    });
                    console.log("resultRaw ", resultRaw);
                    res.status(200).json({ message: 'Member created successfully' });



                } else {
                    console.log("insert");
                    const queryRaw = "INSERT INTO users (username, password, name, role, phoneNumber , createAt) VALUES (?, ?, ?, ?, ? , ?);";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.username, body.password, body.name, body.role, body.phoneNumber, new Date(),],
                        type: QueryTypes.INSERT
                    });
                    console.log("resultRaw ", resultRaw);
                    res.status(200).json({ message: 'Member created successfully' });

                }


            }

        } else {
            res.status(401).send('member is not admin');
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }

};

exports.changePassUser = async (req, res) => {

    try {
        const body = req.body;
        body.password = sha1(body.password);
        const user = Jwt.getCurrentLogin(req);
        const userID = user.userId;
        if (userID) {
            const userInDb = await getUserById(userID);
            if (userInDb.password === sha1(body.oldPassword)) {
                const queryRaw = "UPDATE users SET password = ? WHERE id = ?";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.password, userID],
                    type: QueryTypes.UPDATE
                });
                console.log("resultRaw ", resultRaw);
                res.status(200).json({ message: 'Password updated successfully' });
            } else {
                res.status(400).json({ message: 'Old password is incorrect' });
            }
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
};

exports.updateUserInfo = async (req, res) => {
    const storage = getStorage();

    try {
        const body = req.body;
        const user = Jwt.getCurrentLogin(req);
        const userID = user.userId;

        if (userID) {
            const image = req.file;
            const imageFileName = `${Date.now()}_${image.originalname}`;

            const storageRef = ref(storage, `files/usersss/${imageFileName}`);
            const metadata = {
                contentType: req.file.mimetype,
            };
            const snapshot = await uploadBytes(storageRef, req.file.buffer, metadata);
            const imgUrl = await getDownloadURL(snapshot.ref);

            const queryRaw = "UPDATE users SET email = ?, phoneNumber = ?, imgUrl = ? WHERE id = ?";
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.email, body.phoneNumber, imgUrl, userID],
                type: QueryTypes.UPDATE
            });

            console.log("resultRaw ", resultRaw);
            res.status(200).json({ message: 'User information updated successfully' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
};

const getUserById = async (id) => {
    try {
        const query = "SELECT * FROM users WHERE id = :id;";
        const replacements = { id };

        const user = await sequelize.query(query, {
            replacements,
            type: QueryTypes.SELECT
        });

        return user[0];
    } catch (error) {
        console.error('Error getting user by ID:', error);
        throw new Error('Could not retrieve user by ID');
    }
};

exports.getListPage = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        try {
            const PAGE_SIZE = 4
            const currentPage = parseInt(req.query.page) || 1
            const offset = (currentPage - 1) * PAGE_SIZE

            const totalCountQuery = `SELECT COUNT(*) AS total FROM users`
            const totalCountResult = await sequelize.query(totalCountQuery, {
                raw: true,
                logging: false,
                type: QueryTypes.SELECT
            })
            const queryRaw = "SELECT * FROM users LIMIT :limit OFFSET :offset;"
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: {
                    limit: PAGE_SIZE,
                    offset: offset
                },
                type: QueryTypes.SELECT
            })
            const totalPages = Math.ceil(totalCountResult[0].total / PAGE_SIZE)

            res.status(200).json({
                data: resultRaw,
                currentPage: currentPage,
                totalPages: totalPages,
                totalItems: totalCountResult[0].total
            })
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
            console.log("error", error)
        }
    } else {
        res.status(401).send('User is not admin');
    }
}

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
                replacements: { name: `%${name}%` },
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
        console.log("body.id ", body.id);
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

