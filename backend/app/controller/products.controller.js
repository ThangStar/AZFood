const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller');;
const { initializeApp } = require('firebase/app')
const { getStorage, ref, getDownloadURL, uploadBytes } = require('firebase/storage');
const config = require('../../fireStoreConfig/config');
initializeApp(config.firebaseConfig);


exports.createProduct = async (req, res) => {
    const storage = getStorage();

    try {
        const body = req.body;
        const isAdmin = await Auth.checkAdmin(req);

        if (isAdmin) {
            console.log("id ", body.id);
            if (body.id) {
                console.log("Update");
                const queryRaw = "UPDATE products SET name = ?, price = ?, category = ?, status = CASE WHEN category = 1 THEN 1 ELSE ? END, quantity = ? , dvtID=? WHERE id = ?";
                const resultRaw = await sequelize.query(queryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.name, body.price, body.category, body.status, body.quantity, body.dvtID, body.id],
                    type: QueryTypes.UPDATE
                });
                res.status(200).json({ message: 'products updated successfully' });
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
                        const queryRaw = "INSERT INTO products (name, price, category, status, quantity, dvtID, imgUrl) VALUES (?, ?, ?, CASE WHEN ? = 1 THEN 1 ELSE ? END, ?, ?, ?);";
                        const resultRaw = await sequelize.query(queryRaw, {
                            raw: true,
                            logging: false,
                            replacements: [body.name, body.price, body.category, body.category, body.status, body.quantity, body.dvtID, imgUrl],
                            type: QueryTypes.INSERT
                        });

                        res.status(200).json({ message: 'Product created successfully' });
                    } catch (error) {
                        console.log("error", error);
                    }

                }
                else {
                    console.log("khong  có file");
                    const queryRaw = "INSERT INTO products (name, price, category, status, quantity , dvtID) VALUES (?, ?, ?, CASE WHEN ? = 1 THEN 1 ELSE ? END, ? ,?);";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.name, body.price, body.category, body.category, body.status, body.quantity, body.dvtID],
                        type: QueryTypes.INSERT
                    });
                    res.status(200).json({ message: 'products created successfully' });
                }



            }
        }

    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
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
            const PAGE_SIZE = 10;
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
            p.quantity,
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
    if (isAdmin) {
        const queryRaw = "DELETE FROM products WHERE id=? ";
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
    const categoryID = req.body.category;
    if (checkAuth) {
        const queryRaw = "SELECT * FROM products WHERE category = ?;";
        const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false, replacements: [categoryID], type: QueryTypes.SELECT });
        res.status(200);
        res.send(resultRaw);
    } else {
        res.status(401);
    }
};

exports.searchProduct = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (checkAuth) {
        try {
            const name = req.body.name;

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