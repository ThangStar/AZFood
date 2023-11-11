const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller')

exports.nhapHang = async (req, res) => {
    try {
        const body = req.body;
        const isAdmin = await Auth.checkAdmin(req);

        if (isAdmin) {
            const queryRaw = "INSERT INTO nhapHang (productID, soLuong, donGia,ngayNhap ,dvtID) VALUES (?, ?, ?,?,?);";
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.productID, body.soLuong, body.donGia, new Date(), body.dvtID],
                type: QueryTypes.INSERT
            });


            const checkExitsQuery = "SELECT productID FROM kho WHERE productID = ?;";
            const checkExits = await sequelize.query(checkExitsQuery, {
                raw: true,
                logging: false,
                replacements: [body.productID],
                type: QueryTypes.SELECT
            });
            if (checkExits.length > 0) {
                try {
                    const khoQueryRaw = "UPDATE kho SET quantity = quantity + ? WHERE productID = ?;";
                    const khoResultRaw = await sequelize.query(khoQueryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.soLuong, body.productID],
                        type: QueryTypes.UPDATE
                    });
                    console.log("VÀo đây111111");

                } catch (error) {
                    console.log("error", error);
                }

            } else {

                try {
                    const khoQueryRaw = "INSERT INTO kho (productID, quantity) VALUES (?, ?);";
                    const khoResultRaw = await sequelize.query(khoQueryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.productID, body.soLuong],
                        type: QueryTypes.INSERT
                    });
                } catch (error) {
                    console.log("error", error);
                }
            }

            res.status(200).json({ message: 'thêm phiếu nhập hàng thành công' });

        } else {
            res.status(401).send('member is not admin');
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }
}

exports.getList = async (req, res) => {
    const isAdmin = await Auth.checkAdmin(req);

    if (isAdmin) {
        const queryRaw = `SELECT 
        nh.id,
        nh.productID,
        p.name,
        nh.soLuong,
        d.tenDVT,
        nh.donGia,
        nh.ngayNhap,
        nh.dvtID
    FROM 
        nhapHang nh
    JOIN
        products p ON nh.productID = p.id
    JOIN
        donViTinh d ON d.id = nh.dvtID
    ORDER BY nh.ngayNhap DESC;
    
        `;

        try {
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [],
                type: QueryTypes.SELECT
            });
            res.status(200).send({ resultRaw });
        } catch (error) {
            res.status(500).send(error);
        }
    } else {
        res.status(401).send('Member is not admin');
    }
};
exports.getProductNhapHang = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    const categoryID = req.body.category;
    if (checkAuth) {
        const queryRaw = "SELECT * FROM products WHERE category != 1;";
        const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false, replacements: [], type: QueryTypes.SELECT });
        res.status(200);
        res.send(resultRaw);
    } else {
        res.status(401);
    }
};

