const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller');;
const { initializeApp } = require('firebase/app')
const { getStorage, ref, getDownloadURL, uploadBytes } = require('firebase/storage');
const config = require('../fireStoreConfig/config');
initializeApp(config.firebaseConfig);


exports.createProduct = async (req, res) => {
    const storage = getStorage();

    const body = req.body;
    const isAdmin = await Auth.checkAdmin(req);
    try {
        if (isAdmin) {
            if (body.id) {

                if (req.file) {
                    console.log(" body ", body);
                    try {
                        const image = req.file;
                        const imageFileName = `${Date.now()}_${image.originalname}`;

                        const storageRef = ref(storage, `files/${imageFileName}`);
                        const metadata = {
                            contentType: req.file.mimetype,
                        };
                        const snapshot = await uploadBytes(storageRef, req.file.buffer, metadata);
                        const imgUrl = await getDownloadURL(snapshot.ref);

                        console.log(" imgUrl", imgUrl);
                        // Tiếp tục xử lý và lưu dữ liệu vào MySQL
                        const queryRaw = "UPDATE products SET name = ? , price =? , category =? ,  dvtID =? , imgUrl =?  WHERE id = ?";
                        const resultRaw = await sequelize.query(queryRaw, {
                            raw: true,
                            logging: false,
                            replacements: [body.name, body.price, body.category, body.dvtID, imgUrl, body.id],
                            type: QueryTypes.UPDATE
                        });

                        res.status(200).json({ message: 'Product created successfully' });
                    } catch (error) {
                        console.log("error", error);
                    }

                }
                else {
                    try {
                        console.log("Update");
                        console.log("body", body);
                        const queryRaw = "UPDATE products SET name = ?, price = ?, category = ?, status = CASE WHEN category = 1 THEN 1 ELSE null END, dvtID = ? WHERE id = ?";
                        const [rowCount] = await sequelize.query(queryRaw, {
                            replacements: [body.name, body.price, body.category, body.dvtID, body.id],
                            type: QueryTypes.UPDATE
                        });
                        console.log("Số hàng bị ảnh hưởng: ", rowCount);
                        if (rowCount > 0) {
                            res.status(200).json({ message: 'Sản phẩm được cập nhật thành công' });
                        } else {
                            res.status(404).json({ message: 'Không tìm thấy sản phẩm để cập nhật' });
                        }
                    } catch (error) {
                        console.log("Lỗi: ", error);
                    }

                }

            } else {
                if (req.file) {
                    console.log("  có file");
                    try {
                        const image = req.file;
                        const imageFileName = `${Date.now()}_${image.originalname}`;

                        const storageRef = ref(storage, `files/${imageFileName}`);
                        const metadata = {
                            contentType: req.file.mimetype,
                        };
                        const snapshot = await uploadBytes(storageRef, req.file.buffer, metadata);
                        const imgUrl = await getDownloadURL(snapshot.ref);

                        // Tiếp tục xử lý và lưu dữ liệu vào MySQL
                        const queryRaw = "INSERT INTO products (name, price, category, status, dvtID, imgUrl) VALUES (?, ?, ?, CASE WHEN ? = 1 THEN 1 ELSE null END, ?, ?);";
                        const resultRaw = await sequelize.query(queryRaw, {
                            raw: true,
                            logging: false,
                            replacements: [body.name, body.price, body.category, body.status, body.dvtID, imgUrl],
                            type: QueryTypes.INSERT
                        });

                        res.status(200).json({ message: 'Product created successfully' });
                    } catch (error) {
                        console.log("error", error);
                    }

                }
                else {
                    console.log("khong  có file");
                    const queryRaw = "INSERT INTO products (name, price, category, status , dvtID) VALUES (?, ?, ?, CASE WHEN ? = 1 THEN 1 ELSE null END ,?);";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.name, body.price, body.category, body.status, body.dvtID],
                        type: QueryTypes.INSERT
                    });
                    res.status(200).json({ message: 'products created successfully' });
                }



            }
        } else {
            console.log("Bạn chưa đăng nhập");
        }
    } catch (error) {
        console.log("error", error);
    }



}
exports.updateStatus = async (req, res) => {
    try {
        const body = req.body;
        const isAdmin = await Auth.checkAdmin(req);
        if (isAdmin) {
            console.log("Update status");
            const queryRaw = "UPDATE products SET status = ? WHERE id = ?";
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [body.status, body.id],
                type: QueryTypes.UPDATE
            });
            res.status(200).json({ message: 'product status updated successfully' });
        }
    } catch (error) {

    }

}
exports.getList = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        try {
            const PAGE_SIZE = 4;
            const currentPage = parseInt(req.query.page) || 1;
            const offset = (currentPage - 1) * PAGE_SIZE;

            const totalCountQuery = `SELECT COUNT(*) AS total FROM products`;
            const totalCountResult = await sequelize.query(totalCountQuery, {
                raw: true,
                logging: false,
                type: QueryTypes.SELECT
            });

            const queryRaw = `SELECT
            p.id,
            p.name ,
            p.price,
            p.category,
            p.status,
            k.quantity,
            p.dvtID,
            p.imgUrl,
            c.name AS category_name,
            d.tenDVT AS dvt_name
        FROM
            products p
        JOIN
            category c ON p.category = c.id
        JOIN
            donViTinh d ON p.dvtID = d.id
            LEFT JOIN
            kho k ON p.id = k.productID
            
        LIMIT :limit OFFSET :offset;`;

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
                data: resultRaw,
                currentPage: currentPage,
                totalPages: totalPages,
                totalItems: totalCountResult[0].total
            });
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
            console.log("error", error)
        }
    } else {
        res.status(401).send('User is not admin');
    }
};



exports.getListAll = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        try {
            const queryRaw = `SELECT
            p.id,
            p.name ,
            p.price,
            p.category,
            p.status,
            k.quantity,
            p.dvtID,
            p.imgUrl,
            c.name AS category_name,
            d.tenDVT AS dvt_name
        FROM
            products p
        JOIN
            category c ON p.category = c.id
        JOIN
            donViTinh d ON p.dvtID = d.id
            LEFT JOIN
            kho k ON p.id = k.productID`;

            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [],
                type: QueryTypes.SELECT
            });


            res.status(200).json({ data: resultRaw });
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
            console.log("error", error)
        }
    } else {
        res.status(401).send('User is not admin');
    }
};
exports.getListCategory = async (req, res) => {

    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        const queryRaw = "SELECT * FROM category";
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
        res.status(401).send('user is not admin');
    }

}
exports.getListStatus = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);

    if (checkAuth) {
        const queryRaw = "SELECT * FROM products WHERE quantity = 0 OR status = 2";

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
        res.status(401).send('User is not logged in');
    }
};
exports.getListDVT = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);

    if (checkAuth) {
        const queryRaw = "SELECT * FROM donViTinh";

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
        res.status(401).send('User is not logged in');
    }
};
exports.getDetails = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    const id = req.body.id;
    if (checkAuth) {
        const queryRaw = "SELECT * FROM products WHERE id = ?;";
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
    console.log("body ", body);

    if (isAdmin) {
        console.log("body.id ", body.id);
        const queryRaw = "DELETE FROM products WHERE id = ? ";
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

exports.filterCategory = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    const categoryID = req.query.category;
    if (checkAuth) {
        const queryRaw = `SELECT
        p.id,
        p.name ,
        p.price,
        p.category,
        p.status,
        k.quantity,
        p.dvtID,
        p.imgUrl,
        c.name AS category_name,
        d.tenDVT AS dvt_name
    FROM
        products p
    JOIN
        category c ON p.category = c.id
    JOIN
        donViTinh d ON p.dvtID = d.id
    LEFT JOIN
        kho k ON p.id = k.productID
    WHERE p.category = ?`;
        const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false, replacements: [categoryID], type: QueryTypes.SELECT });
        res.status(200);
        res.send({ data: resultRaw });
    } else {
        res.status(401);
    }
};

exports.searchProduct = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        try {
            const name = req.query.name;
            console.log(req.query.name);
            const queryRaw = `SELECT *FROM products where name LIKE :name`;

            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: {
                    name: `%${name}%`
                },
                type: QueryTypes.SELECT
            });
            res.status(200).json({
                data: resultRaw,

            });
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
            console.log("error", error)
        }
    } else {
        res.status(401).send('User is not admin');
    }
};
exports.getListTop = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (!checkAuth) {
        return res.status(401).send('User is not admin');
    }

    try {
        const topSellingProductsQuery = `
            SELECT
                p.id,
                p.name,
                p.price,
                p.category,
                p.status,
                SUM(id.quantity) AS totalQuantity,
                p.dvtID,
                p.imgUrl,
                c.name AS category_name,
                d.tenDVT AS dvt_name
            FROM
                products p
            JOIN
                category c ON p.category = c.id
            JOIN
                donViTinh d ON p.dvtID = d.id
            LEFT JOIN
                invoicedetails id ON p.id = id.productID
            GROUP BY
                p.id
            ORDER BY
                totalQuantity DESC
            LIMIT 2;`;

        const topSellingProducts = await sequelize.query(topSellingProductsQuery, {
            type: QueryTypes.SELECT
        });

        res.status(200).json(topSellingProducts);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
        console.log("error", error);
    }
};
