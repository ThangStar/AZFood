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
            console.log(" body ", body);
            if (body.id) {
                if (req.file) {

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
                        const queryRaw = "UPDATE products SET name = ?, price = ?, category = ?, dvtID = ? WHERE id = ?";
                        const [rowCount] = await sequelize.query(queryRaw, {
                            replacements: [body.name, body.price, body.category, body.dvtID, body.id],
                            type: QueryTypes.UPDATE
                        });
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
                        console.log(imgUrl);
                        // Tiếp tục xử lý và lưu dữ liệu vào MySQL
                        const status = body.category === '1' ? 1 : null
                        const queryRaw = "INSERT INTO products (name, price, category, dvtID, imgUrl, status) VALUES (?, ?, ?, ?, ?, ?);";
                        console.log('tao mon mơi' + body.category + status)
                        const resultRaw = await sequelize.query(queryRaw, {
                            raw: true,
                            logging: false,
                            replacements: [body.name, body.price, body.category, body.dvtID, imgUrl, status],
                            type: QueryTypes.INSERT
                        });

                        res.status(200).json({ message: 'Product created successfully' });
                    } catch (error) {
                        console.log("error", error);
                    }

                }
                else {
                    console.log("khong  có file");
                    const status = body.category === '1' ? 1 : null
                    const queryRaw = "INSERT INTO products (name, price, category, dvtID, status) VALUES (?, ?, ?, ?, ?);";
                    const resultRaw = await sequelize.query(queryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.name, body.price, body.category, body.dvtID, status],
                        type: QueryTypes.INSERT
                    });
                    res.status(200).json({ message: 'products created successfully' });
                }
                if (body.quantity && body.quantity !== 0) {
                    try {
                        const productIDQuery = 'SELECT id FROM products WHERE name = ?;'
                        const _productID = await sequelize.query(productIDQuery, {
                            raw: true,
                            logging: false,
                            replacements: [body.name],
                            type: QueryTypes.SELECT
                        });
                        const productID = _productID[0].id;
                        const queryRaw = "INSERT INTO nhapHang (productID, soLuong, donGia,ngayNhap ,dvtID) VALUES (?, ?, ?,?,?);";
                        const resultRaw = await sequelize.query(queryRaw, {
                            raw: true,
                            logging: false,
                            replacements: [productID, body.quantity, body.price, new Date(), body.dvtID],
                            type: QueryTypes.INSERT
                        });
                        const checkExitsQuery = "SELECT productID FROM kho WHERE productID = ?;";
                        const checkExits = await sequelize.query(checkExitsQuery, {
                            raw: true,
                            logging: false,
                            replacements: [productID],
                            type: QueryTypes.SELECT
                        });
                        if (checkExits.length > 0) {
                            try {
                                const khoQueryRaw = "UPDATE kho SET quantity = quantity + ? WHERE productID = ?;";
                                const khoResultRaw = await sequelize.query(khoQueryRaw, {
                                    raw: true,
                                    logging: false,
                                    replacements: [body.quantity, productID],
                                    type: QueryTypes.UPDATE
                                });
                            } catch (error) {
                                console.log("error", error);
                            }
                        } else {
                            try {
                                const khoQueryRaw = "INSERT INTO kho (productID, quantity) VALUES (?, ?);";
                                const khoResultRaw = await sequelize.query(khoQueryRaw, {
                                    raw: true,
                                    logging: false,
                                    replacements: [productID, body.quantity],
                                    type: QueryTypes.INSERT
                                });
                            } catch (error) {
                                console.log("error", error);
                            }
                        }
                    } catch (error) {
                        console.log(" loi nhap hang : ", error);
                    }
                }
            }


        } else {
            console.log("Bạn chưa đăng nhập");
        }
    } catch (error) {
        console.log("error", error);
    }



}
exports.getSizePrice = async (req, res) => {
    const queryRaw = "SELECT * FROM product_size as ps JOIN product_price as pr ON ps.id = pr.products_size";
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
}
exports.getPriceBySizeAndIdProduct = async (req, res) => {
    const queryRaw = `SELECT product_price FROM product_price WHERE id = ?`;
    try {
        const { id } = req.query
        console.log("transform", req.query)
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [Number(id)],
            type: QueryTypes.SELECT
        });
        console.log("KEY QUA", resultRaw)
        res.status(200).send({ resultRaw })
    } catch (error) {
        res.status(500);
        res.send(error)
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
            const PAGE_SIZE = 21;
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
             where p.name LIKE :name 
             LIMIT 10`;

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
                invoiceDetails id ON p.id = id.productID
            GROUP BY
                p.id
            ORDER BY
                totalQuantity DESC
            LIMIT 10;`;

        const topSellingProducts = await sequelize.query(topSellingProductsQuery, {
            type: QueryTypes.SELECT
        });

        res.status(200).json(topSellingProducts);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
        console.log("error", error);
    }
};

exports.getPriceProduct = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (!checkAuth) {
        return res.status(401).send('User is not admin');
    }

    const queryRaw = `SELECT
            p.id,
            p.product_id,
            p.products_size,
            p.product_price,
            ps.name AS ProductName,
            pz.size_name AS SizeName
        FROM
            product_price p
        JOIN 
            products ps ON p.product_id = ps.id
        JOIN 
            product_size pz ON p.products_size = pz.id;`;
    try {
        const resultRaw = await sequelize.query(queryRaw, {
            type: QueryTypes.SELECT
        });
        res.status(200).json({
            data: resultRaw,

        });
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
        console.log("error", error);
    }
}

exports.deletePriceProduct = async (req, res) => {
    const checkAuth = Auth.checkAuth(req);
    if (!checkAuth) {
        return res.status(401).send('User is not admin');
    }
    const body = req.body;
    const queryRaw = "DELETE FROM product_price WHERE id = ? ";
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

}
exports.getProductSize = async (req, res) => {
    try {
        const querySize = 'SELECT * FROM product_size'
        const response = await sequelize.query(querySize, {
            raw: true, logging: false, replacements: [],
            type: QueryTypes.SELECT
        });
        return res.status(200).json({ data: response });
    } catch (error) {
        res.status(500).json({ message: 'Internal server error', error });
    }
}
exports.addPriceProduct = async (req, res) => {
    const body = req.body;
    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        try {
            console.log("body :: ", body);
            let sizeValue = 0;
            if (body.sizeValue == 0) {
                const sizeQueryRaw = "INSERT INTO product_size (size_name) VALUES (?);";
                try {
                    const sizeResultRaw = await sequelize.query(sizeQueryRaw, {
                        raw: true,
                        logging: false,
                        replacements: [body.size],
                        type: QueryTypes.INSERT
                    });
                    sizeValue = sizeResultRaw[0];
                } catch (error) {
                    console.log("error", error);
                }



            }

            const checkExitsQuery = "SELECT * FROM product_price WHERE product_id = ? AND products_size = ?;";
            const checkExits = await sequelize.query(checkExitsQuery, {
                raw: true,
                logging: false,
                replacements: [body.productID, body.sizeValue],
                type: QueryTypes.SELECT
            });

            if (checkExits.length > 0) {
                return res.status(409).json({ message: 'conflig data' });

            } else {
                const querySize = 'SELECT * FROM product_size'
                const checkExits = await sequelize.query(querySize, {
                    raw: true, logging: false, replacements: [],
                    type: QueryTypes.SELECT
                });
                console.log(" checkExits", checkExits);
                const khoQueryRaw = "INSERT INTO product_price (product_id, products_size , product_price) VALUES (?,?, ?);";

                const khoResultRaw = await sequelize.query(khoQueryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.productID, sizeValue ? sizeValue : body.sizeValue, body.prodPrice],
                    type: QueryTypes.INSERT
                });
            }

            return res.status(200).json({
                message: 'Successs'
            });
        } catch (error) {
            res.status(500).json({ message: 'Internal server error', error });
        }
    } else {
        res.status(401).send('member is not admin');
    }
};

exports.updatePriceProduct = async (req, res) => {
    const body = req.body;
    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        try {
            console.log("body :: ", body);
            const checkExitsQuery = "SELECT * FROM product_price WHERE product_id = ? AND products_size = ?;";
            const checkExits = await sequelize.query(checkExitsQuery, {
                raw: true,
                logging: false,
                replacements: [body.productID, body.sizeValue],
                type: QueryTypes.SELECT
            });
            console.log("checkExits ", checkExits);
            if (checkExits.length > 0 && checkExits[0].product_price === body.prodPrice) {
                return res.status(409).json({ message: 'conflig data' });

            } else {
                const khoQueryRaw = "UPDATE product_price SET product_id=?, products_size=? , product_price=? WHERE id = ?;";

                const khoResultRaw = await sequelize.query(khoQueryRaw, {
                    raw: true,
                    logging: false,
                    replacements: [body.productID, body.sizeValue, body.prodPrice, body.id],
                    type: QueryTypes.UPDATE
                });
            }

            return res.status(200).json({ message: 'Successs' });
        } catch (error) {
            res.status(500).json({ message: 'Internal server error', error });
        }
    } else {
        res.status(401).send('member is not admin');
    }
}