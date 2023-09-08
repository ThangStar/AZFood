const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller');
const { Server } = require('socket.io');
const io = new Server();

const getInvoiceNumber = (min = 0, max = 500000) => {
    min = Math.ceil(min);
    max = Math.floor(max);
    const num = Math.floor(Math.random() * (max - min + 1)) + min;
    return num.toString();
};
exports.createOrder = async (req, res) => {
    try {
        const body = req.body;
        const isAuth = await Auth.checkAuth(req);

        if (isAuth) {
            console.log("Insert Order");

            const productID = body.productID;
            const quantity = body.quantity;

            const priceQuery = 'SELECT price  , status FROM products WHERE id = ?';
            const quantityQuery = 'SELECT SUM(quantity) AS quantity  FROM kho WHERE productID = ?';
            try {
                const priceResult = await sequelize.query(priceQuery, {
                    raw: true,
                    logging: false,
                    replacements: [productID],
                    type: QueryTypes.SELECT
                });
                const quantityResult = await sequelize.query(quantityQuery, {
                    raw: true,
                    logging: false,
                    replacements: [productID],
                    type: QueryTypes.SELECT
                });
                const price = priceResult[0].price;
                const _quantity = quantityResult[0].quantity;
                const _status = priceResult[0].status;
                console.log("_quantity ", _quantity);
                console.log("_status ", _status);
                if (_quantity > 0 || _status === 1) {
                    const subTotal = quantity * price;

                    const orderData = {
                        userID: body.userID,
                        tableID: body.tableID,
                        orderDate: new Date(),
                        totalAmount: subTotal,
                    };

                    const orderId = await sequelize.transaction(async transaction => {
                        const queryRaw = 'INSERT INTO orders (userID, tableID, orderDate, totalAmount) VALUES (?, ?, ?, ?)';
                        const resultRaw = await sequelize.query(queryRaw, {
                            raw: true,
                            logging: false,
                            replacements: [
                                orderData.userID,
                                orderData.tableID,
                                orderData.orderDate,
                                orderData.totalAmount
                            ],
                            type: QueryTypes.INSERT,
                            transaction
                        });

                        const orderId = resultRaw[0];

                        const queryRaw2 = 'INSERT INTO orderItems (orderID, productID, quantity, subTotal) VALUES (?, ?, ?, ?)';
                        await sequelize.query(queryRaw2, {
                            raw: true,
                            logging: false,
                            replacements: [orderId, productID, quantity, subTotal],
                            type: QueryTypes.INSERT,
                            transaction
                        });
                        const updateTableStatusQuery = 'UPDATE tables SET status = ? WHERE id = ?';
                        await sequelize.query(updateTableStatusQuery, {
                            raw: true,
                            logging: false,
                            replacements: [1, orderData.tableID],
                            type: QueryTypes.UPDATE,
                            transaction
                        });
                        io.emit('tableStatusChanged', { tableID: orderData.tableID, status: 2 });
                        return orderId;
                    });
                    res.status(200).json({ message: 'Order created successfully', orderId });
                } else {
                    res.status(404).json({ message: 'not found product', orderId });
                }
            } catch (error) {
                res.status(500).json({ message: 'Error creating order', error: error.message });
            }
        } else {
            res.status(403).json({ message: 'Unauthorized' });
        }

    } catch (error) {
        console.error('Error creating order:', error);
        res.status(500).json({ message: 'Internal server error', error: error.message });
    }
};

exports.updateOrder = async (req, res) => {

    try {

        const body = req.body;
        const isAuth = await Auth.checkAuth(req);

        if (isAuth) {
            const productID = body.productID;
            const quantity = body.quantity;
            const id = body.orderID;
            const priceQuery = 'SELECT price FROM products WHERE id = ?';
            try {
                const priceResult = await sequelize.query(priceQuery, {
                    raw: true,
                    logging: false,
                    replacements: [productID],
                    type: QueryTypes.SELECT
                });

                const price = priceResult[0].price;

                const subTotal = quantity * price;
                console.log("subTotal", subTotal);
                const orderData = {
                    totalAmount: subTotal,
                };

                await sequelize.transaction(async transaction => {
                    const updateOrderQuery = `UPDATE orders SET totalAmount = ? WHERE id = ?;`;

                    await sequelize.query(updateOrderQuery, {
                        raw: true,
                        logging: false,
                        replacements: [orderData.totalAmount, id],
                        type: QueryTypes.UPDATE,
                        transaction
                    });

                    const updateOrderItemsQuery = `UPDATE orderItems SET productID = ?, quantity = ?, subTotal = ? WHERE orderID = ?;`;

                    await sequelize.query(updateOrderItemsQuery, {
                        raw: true,
                        logging: false,
                        replacements: [productID, quantity, subTotal, id],
                        type: QueryTypes.UPDATE,
                        transaction
                    });
                });

                res.status(200).json({ message: 'Order updated successfully' });
            } catch (error) {
                res.status(500).json({ message: 'Error updating order', error: error.message });
            }
        } else {
            res.status(403).json({ message: 'Unauthorized' });
        }

    } catch (error) {
        console.error('Error updating order:', error);
        res.status(500).json({ message: 'Internal server error', error: error.message });
    }
};

exports.deleteOrder = async (req, res) => {
    try {
        const orderId = req.body.id;
        const isAuth = await Auth.checkAuth(req);
        console.log("orderId", orderId);
        if (isAuth) {
            console.log("Delete Order");

            await sequelize.transaction(async transaction => {
                const deleteOrderItemsQuery = `DELETE FROM orderItems WHERE orderID = ?;`;

                await sequelize.query(deleteOrderItemsQuery, {
                    raw: true,
                    logging: false,
                    replacements: [orderId],
                    type: QueryTypes.DELETE,
                    transaction
                });

                const deleteOrderQuery = `DELETE FROM orders WHERE id = ?;`;

                await sequelize.query(deleteOrderQuery, {
                    raw: true,
                    logging: false,
                    replacements: [orderId],
                    type: QueryTypes.DELETE,
                    transaction
                });
            });

            res.status(200).json({ message: 'Order deleted successfully' });
        } else {
            res.status(403).json({ message: 'you are not logned in' });
        }

    } catch (error) {
        console.error('Error deleting order:', error);
        res.status(500).json({ message: 'Internal server error', error: error.message });
    }
};

exports.deleteAllOrder = async (req, res) => {
    try {
        const tableID = req.body.id;
        const isAuth = await Auth.checkAuth(req);
        var idOrder = 0;
        if (isAuth) {
            console.log("Delete All Order in Table");
            // Lấy id của orderID từ bàn
            const deleteOrderItemsQuery = `SELECT * FROM orders WHERE tableID = ?;`;
            const idOrders = await sequelize.query(deleteOrderItemsQuery, { raw: true, logging: false, replacements: [tableID], type: QueryTypes.SELECT });

            for (const order of idOrders) {
                idOrder = order.id
            }
            await sequelize.transaction(async transaction => {
                const deleteOrderItemsQuery = `DELETE FROM orderItems WHERE orderID = ?;`;

                await sequelize.query(deleteOrderItemsQuery, { raw: true, logging: false, replacements: [idOrder], type: QueryTypes.DELETE, transaction });
                const deleteOrderQuery = `DELETE FROM orders WHERE tableID = ?;`;
                await sequelize.query(deleteOrderQuery, { raw: true, logging: false, replacements: [tableID], type: QueryTypes.DELETE, transaction });
            });
            //chuyển trạng thái bàn về trôngs
            const updateTableStatusQuery = 'UPDATE tables SET status = ? WHERE id = ?';
            await sequelize.query(updateTableStatusQuery, {
                raw: true,
                logging: false,
                replacements: [3, tableID],
                type: QueryTypes.UPDATE,
                transaction
            });
            io.emit('tableStatusChanged', { tableID: orderData.tableID, newStatus: 3 });
            res.status(200).json({ message: 'Order deleted successfully' });
        } else {
            res.status(403).json({ message: 'you are not logned in' });
        }

    } catch (error) {
        console.error('Error deleting order:', error);
        res.status(500).json({ message: 'Internal server error', error: error.message });
    }
};

exports.getOrdersForTable = async (req, res) => {
    try {

        const tableID = req.query.tableID;
        const isAuth = await Auth.checkAuth(req);
        if (isAuth) {
            const getOrdersQuery = `
            SELECT o.id AS orderID, o.orderDate, o.totalAmount,p.id AS productID,o.orderDate , p.name AS productName, p.dvtID AS dvt ,
             oi.quantity, oi.subTotal , p.category , p.price , u.name As userName
            FROM orders o
            INNER JOIN orderItems oi ON o.id = oi.orderID
            INNER JOIN products p ON oi.productID = p.id
            INNER JOIN users u ON o.userID = u.id
            WHERE o.tableID = ?
        `;

            const orders = await sequelize.query(getOrdersQuery, {
                raw: true,
                logging: false,
                replacements: [tableID || id],
                type: QueryTypes.SELECT
            });

            res.status(200).json({ orders });
        }
        else {
            res.status(403).json({ message: 'you are not logned in' });
        }

    } catch (error) {
        console.error('Error getting orders:', error);
        res.status(500).json({ message: 'Internal server error', error: error.message });
    }
};
exports.getList = async (req, res) => {

    const isAdmin = await Auth.checkAdmin(req);
    if (isAdmin) {
        const queryRaw = "SELECT * FROM orders";
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

exports.payBill = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const tableID = req.body.id;


        try {
            // Lấy thông tin tổng số tiền và chi tiết hoá đơn
            const getBillDetailsQuery = `
                SELECT p.name AS productName,p.id AS productID, oi.quantity, p.price, u.name AS userName, o.totalAmount , o.id
                FROM orders o
                INNER JOIN orderItems oi ON o.id = oi.orderID
                INNER JOIN products p ON oi.productID = p.id
                INNER JOIN users u ON o.userID = u.id
                WHERE o.tableID = ?
            `;

            const billDetails = await sequelize.query(getBillDetailsQuery, {
                raw: true,
                logging: false,
                replacements: [tableID],
                type: QueryTypes.SELECT
            });

            // Tính tổng số tiền của hoá đơn
            let totalInvoiceAmount = 0;
            let idOder;
            for (const detail of billDetails) {
                totalInvoiceAmount += detail.totalAmount;
                idOder = detail.id
            }

            // Lưu thông tin hoá đơn vào bảng invoice

            const createInvoiceQuery = `
                INSERT INTO invoice (tableID,total, createAt, userName, invoiceNumber )
                VALUES (?, ?, ? , ?,?)
            `;
            const invoiceNumber = getInvoiceNumber();
            const invoiceResult = await sequelize.query(createInvoiceQuery, {
                raw: true,
                logging: false,
                replacements: [tableID, totalInvoiceAmount, new Date(), billDetails[0].userName, invoiceNumber],
                type: QueryTypes.INSERT
            });

            const invoiceID = invoiceResult[0];

            // Lưu chi tiết hoá đơn vào bảng invoiceDetails
            for (const detail of billDetails) {
                const createInvoiceDetailsQuery = `
                    INSERT INTO invoiceDetails (invoiceID, poductName, quantity, totalAmount)
                    VALUES (?, ?, ?, ?)
                `;

                await sequelize.query(createInvoiceDetailsQuery, {
                    raw: true,
                    logging: false,
                    replacements: [invoiceID, detail.productName, detail.quantity, detail.totalAmount],
                    type: QueryTypes.INSERT
                });

                // Trừ số lượng sản phẩm từ kho
                const updateProductQuantityQuery = `
                 UPDATE kho
                 SET quantity = quantity - ?
                 WHERE productID = ?
             `;
                console.log("detail.productID ", detail.productID);
                await sequelize.query(updateProductQuantityQuery, {
                    raw: true,
                    logging: false,
                    replacements: [detail.quantity, detail.productID], // Trừ số lượng sản phẩm theo quantity trong chi tiết hoá đơn
                    type: QueryTypes.UPDATE
                });

            }

            // Cập nhật trạng thái của bàn sau khi thanh toán
            const updateTableStatusQuery = 'UPDATE tables SET status = ? WHERE id = ?';
            await sequelize.query(updateTableStatusQuery, {
                raw: true,
                logging: false,
                replacements: [1, tableID],
                type: QueryTypes.UPDATE
            });
            io.emit('tableStatusChanged', { tableID: tableID, newStatus: 1 });
            await sequelize.transaction(async transaction => {
                const deleteOrderItemsQuery = `DELETE FROM orderItems WHERE orderID = ?;`;

                await sequelize.query(deleteOrderItemsQuery, { raw: true, logging: false, replacements: [idOder], type: QueryTypes.DELETE, transaction });
                const deleteOrderQuery = `DELETE FROM orders WHERE tableID = ?;`;
                await sequelize.query(deleteOrderQuery, { raw: true, logging: false, replacements: [tableID], type: QueryTypes.DELETE, transaction });
            });
            res.status(200).json({ message: 'Bill paid successfully', invoiceID });
        } catch (error) {
            res.status(500).json({ message: 'Error paying bill', error: error.message });
        }
    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};

