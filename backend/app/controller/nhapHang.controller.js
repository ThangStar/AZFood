const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.nhapHang = async (req, res) => {
    try {
        const body = req.body;
        const isAdmin = await Auth.checkAdmin(req);

        if (isAdmin) {
            console.log("id ", body.id);
            if (body.id) {
                console.log("Update");
                const queryRaw = "UPDATE nhapHang SET tenHang = ?, soLuong = ?, donGia = ? WHERE id = ?";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.name, body.price, body.category, body.status, body.quantity, body.dvtID, body.id],
                    type: QueryTypes.UPDATE
                });
                res.status(200).json({ message: 'sửa phiếu nhập hàng thành công' });
            } else {
                console.log("Insert");
                const queryRaw = "INSERT INTO nhapHang (tenHang, soLuong, donGia) VALUES (?, ?, ?);";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.tenHang, body.soLuong, body.donGia],
                    type: QueryTypes.INSERT
                });
                res.status(200).json({ message: 'thêm phiếu nhập hàng thành công' });
            }
        }else {
            res.status(401).send('member is not admin');
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }

}