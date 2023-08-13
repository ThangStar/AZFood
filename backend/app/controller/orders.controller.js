const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller');
const { Server } = require('socket.io');
const io = new Server();

exports.createOrder = async (req, res) => {
    try {
        const body = req.body;
        const isAuth = await Auth.checkAuth(req);

        if (isAuth) {
            console.log("Insert Order");

            const productID = body.productID;
            const quantity = body.quantity;

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
                        replacements: [2, orderData.tableID],
                        type: QueryTypes.UPDATE,
                        transaction
                    });
                    io.emit('tableStatusChanged', { tableID: orderData.tableID, status: 2 });
                    return orderId;
                });

                res.status(200).json({ message: 'Order created successfully', orderId });
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
    console.log("Update Order");
    try {

        const body = req.body;
        const isAuth = await Auth.checkAuth(req);

        if (isAuth) {

            const productID = body.productID;
            const quantity = body.quantity;
            const id = body.id; //Hoặc là lấy id từ body.
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
        const orderId = req.body.id; // Lấy orderId từ URL parameter
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
        var idOrder = 0 ;
        if (isAuth) {
            console.log("Delete All Order in Table");
            // Lấy id của orderID từ bàn
            const deleteOrderItemsQuery = `SELECT * FROM orders WHERE tableID = ?;`;
            const idOrders = await sequelize.query(deleteOrderItemsQuery, {raw: true,logging: false,replacements: [tableID],type: QueryTypes.SELECT});
           
            for (const order of idOrders) {
                idOrder = order.id
            }
            await sequelize.transaction(async transaction => {
                const deleteOrderItemsQuery = `DELETE FROM orderItems WHERE orderID = ?;`;

                await sequelize.query(deleteOrderItemsQuery, {raw: true,logging: false,replacements: [idOrder],type: QueryTypes.DELETE,transaction});
                const deleteOrderQuery = `DELETE FROM orders WHERE tableID = ?;`;
                await sequelize.query(deleteOrderQuery, {raw: true,logging: false,replacements: [tableID],type: QueryTypes.DELETE,transaction});
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
        const tableID = req.body.id;
        const isAuth = await Auth.checkAuth(req);
        if (isAuth) {
            const getOrdersQuery = `
            SELECT o.id AS orderID, o.orderDate, o.totalAmount, p.name AS productName, oi.quantity, oi.subTotal
            FROM orders o
            INNER JOIN orderItems oi ON o.id = oi.orderID
            INNER JOIN products p ON oi.productID = p.id
            WHERE o.tableID = ?
        `;

            const orders = await sequelize.query(getOrdersQuery, {
                raw: true,
                logging: false,
                replacements: [tableID],
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

exports.payBill = async (req, res) => {
    const isAuth = await Auth.checkAuth(req);
    if (isAuth) {
        const tableID = req.body.id;
        try {
            // Lấy thông tin tổng số tiền và chi tiết hoá đơn
            const getBillDetailsQuery = `
                SELECT p.name AS productName, oi.quantity, p.price, u.name AS userName, o.totalAmount , o.id
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
                INSERT INTO invoice (tableID,total, createAt, userName )
                VALUES (?, ?, ? , ?)
            `;

            const invoiceResult = await sequelize.query(createInvoiceQuery, {
                raw: true,
                logging: false,
                replacements: [tableID , totalInvoiceAmount, new Date(), billDetails[0].userName ],
                type: QueryTypes.INSERT
            });

            const invoiceID = invoiceResult[0];

            // Lưu chi tiết hoá đơn vào bảng invoiceDetails
            for (const detail of billDetails) {
                const createInvoiceDetailsQuery = `
                    INSERT INTO invoiceDetials (invoiceID, poductName, quantity, totalAmount)
                    VALUES (?, ?, ?, ?)
                `;

                await sequelize.query(createInvoiceDetailsQuery, {
                    raw: true,
                    logging: false,
                    replacements: [invoiceID, detail.productName, detail.quantity, detail.totalAmount],
                    type: QueryTypes.INSERT
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
            io.emit('tableStatusChanged', { tableID: orderData.tableID, newStatus: 1 });
            console.log("idOder" , idOder);
            await sequelize.transaction(async transaction => {
                const deleteOrderItemsQuery = `DELETE FROM orderItems WHERE orderID = ?;`;

                await sequelize.query(deleteOrderItemsQuery, {raw: true,logging: false,replacements: [idOder],type: QueryTypes.DELETE,transaction});
                const deleteOrderQuery = `DELETE FROM orders WHERE tableID = ?;`;
                await sequelize.query(deleteOrderQuery, {raw: true,logging: false,replacements: [tableID],type: QueryTypes.DELETE,transaction});
            });
            res.status(200).json({ message: 'Bill paid successfully', invoiceID });
        } catch (error) {
            res.status(500).json({ message: 'Error paying bill', error: error.message });
        }
    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};

