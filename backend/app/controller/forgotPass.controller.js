const nodemailer = require('nodemailer');
const NodeCache = require('node-cache');
const db = require('../models');
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const { initializeApp } = require('firebase/app');
const config = require('../fireStoreConfig/config');

initializeApp(config.firebaseConfig);

let transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD
    }
});

async function sendOtpToEmail(email, otp) {
    let mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: 'Mã OTP đặt lại mật khẩu cho ứng dụng AZFood của bạn',
        text: `Mã OTP của bạn là: ${otp}`
    };

    try {
        await transporter.sendMail(mailOptions);
    } catch (error) {
        console.error('Error sending OTP email:', error);
    }
}

exports.checkAndSendOtpToEmail = async (req, res) => {
    // const email = req.body.email;
    const email = 'tantrung20092002@gmail.com';
    try {
        const queryRaw = 'SELECT COUNT(*) as count FROM users WHERE email = ?;';
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [email],
            type: QueryTypes.SELECT
        });

        if (resultRaw[0].count === 0) {
            return res.status(404).json({ message: 'Email không tồn tại' });
        }

        const otp = Math.floor(100000 + Math.random() * 900000);
        await sendOtpToEmail(email, otp);
        res.status(200).json({ message: 'Đã gửi OTP đến email', email, otp });
    } catch (error) {
        console.error('Error in checkAndSendOtpToEmail function:', error);
        return res.status(500).json({ message: 'Internal Server Error' });
    }
};


