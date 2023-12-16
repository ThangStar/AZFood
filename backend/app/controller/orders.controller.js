const db = require("../models");
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;
const Auth = require('./checkAuth.controller');
const express = require('express');
const app = express();
const server = require('http').createServer(app);
const io = require('socket.io')(server);

const getInvoiceNumber = (min = 0, max = 500000) => {
    min = Math.ceil(min);
    max = Math.floor(max);
    const num = Math.floor(Math.random() * (max - min + 1)) + min;
    return num.toString();
};

exports.updateQuantity = async (req, res) => {
    // [+]: {type: increment, productID: 0, tableID: 0}
    // [-]: {type: decrement, productID: 0, tableID: 0}
    // [set]: {type: set, quantity: 10, productID: 0, tableID: 0}
    try {

        console.log("BODY", req.body);
        const { type, quantity, productID, tableID, idOrderItems } = req.body
        const isIncrement = type == 'increment';
        const isDecrement = type == 'decrement';
        const isSet = type == 'set';
        if (isIncrement) {
            //handle plus
            const query = `UPDATE orderItems as o1 
        INNER JOIN orders as o2 
        ON o1.orderID = o2.id 
        SET o1.quantity = o1.quantity + 1
        WHERE o1.productID = ? AND o2.tableID = ?`;

            const increment = await sequelize.query(query, {
                raw: true,
                logging: false,
                replacements: [productID, tableID],
                type: QueryTypes.UPDATE
            });

            res.status(200).json({ increment });
        } else if (isDecrement) {
            //handle minus
            sequelize.transaction(async t => {

                const queryIsExist = `SELECT * FROM orderItems as oi JOIN orders as ord ON
                 ord.id = oi.orderID WHERE oi.quantity > 1 AND ord.tableID = ? AND oi.productID = ?`;
                const isExist = await sequelize.query(queryIsExist, {
                    raw: true,
                    logging: false,
                    replacements: [tableID, productID],
                    type: QueryTypes.SELECT,
                });

                console.log("is exis", isExist)
                //decrement if > 1
                if (isExist.length > 0) {
                    const query = `UPDATE orderItems as o1 
                    INNER JOIN orders as o2 
                    ON o1.orderID = o2.id 
                    SET o1.quantity = o1.quantity - 1
                    WHERE o1.productID = ? AND o2.tableID = ?`;
                    const decrement = await sequelize.query(query, {
                        raw: true,
                        logging: false,
                        replacements: [productID, tableID],
                        type: QueryTypes.UPDATE,
                    });
                    return res.status(200).json({ decrement });
                } else {

                    const query = `DELETE FROM orderItems where id = ?`;
                    const decrement = await sequelize.query(query, {
                        raw: true,
                        logging: false,
                        replacements: [idOrderItems],
                        type: QueryTypes.DELETE,
                    });
                    return res.status(200).json({ decrement });

                }

            })
        } else if (isSet) {
            //handle set
            console.log("set");

            const query = `UPDATE orderItems as o1 
            INNER JOIN orders as o2 
            ON o1.orderID = o2.id 
            SET o1.quantity = ?
            WHERE o1.productID = ? AND o2.tableID = ?`;
            const set = await sequelize.query(query, {
                raw: true,
                logging: false,
                replacements: [quantity, productID, tableID],
                type: QueryTypes.UPDATE
            });

            res.status(200).json({ set });
        }





    } catch (error) {
        console.error('Error getting orders:', error);
        res.status(500).json({ message: 'Internal server error', error: error.message });
    }
};

exports.createOrder = async (req, res) => {
    console.log('create order');
    let odID
    try {
        const body = req.body;

        const isAuth = await Auth.checkAuth(req);

        if (isAuth) {
            console.log("Insert Order");

            const productID = body.productID;
            const quantityClient = body.quantity;
            const tableID = body.tableID;
            const category = body.category;
            console.log("body", body);
            if (category !== 1 && category !== 2) {
                //check quantity
                const quantityCheckQuery = 'SELECT quantity FROM kho WHERE productID = ?';
                const quantityCheck = await sequelize.query(quantityCheckQuery, {
                    raw: true,
                    logging: false,
                    replacements: [productID],
                    type: QueryTypes.SELECT
                });

                const isEnoughQuantity = quantityCheck[0].quantity;
                console.log("isEnoughQuantity ", isEnoughQuantity);
                if (isEnoughQuantity > 0) {
                    // Trừ số lượng trong kho
                    const updateQuantityQuery = 'UPDATE kho SET quantity = quantity - ? WHERE productID = ?';

                    await sequelize.query(updateQuantityQuery, {
                        logging: false,
                        replacements: [quantityClient, productID],
                        type: QueryTypes.UPDATE
                    });

                } else {
                    return res.status(500).json({ message: 'Quantity not enough' });
                }
            }
            const existingOrderItemQuery = 'SELECT id, quantity, subTotal ,orderID FROM orderItems WHERE orderID IN (SELECT id FROM orders WHERE tableID = ?) AND productID = ?';

            const existingOrderItemResult = await sequelize.query(existingOrderItemQuery, {
                raw: true,
                logging: false,
                replacements: [tableID, productID],
                type: QueryTypes.SELECT
            });

            const _price = body.price;
            if (existingOrderItemResult.length > 0 && _price != 0) {
                // Update existing orderItem
                var item;
                for (let i = 0; i < existingOrderItemResult.length; i++) {
                    const _check = existingOrderItemResult[i].subTotal / existingOrderItemResult[i].quantity;
                    console.log('check order', existingOrderItemResult);
                    if (existingOrderItemResult[i].subTotal == _price || _check == _price || existingOrderItemResult[i].price == _price) {
                        item = existingOrderItemResult[i];
                    }
                }
                const existingOrderItemId = item.id;
                const existingQuantity = item.quantity;
                odID = item.orderID
                const orderID = item.orderID;
                const newQuantity = existingQuantity + quantityClient;
                const newSubTotal = _price * newQuantity;

                if (newQuantity < 0) {
                    res.status(201).json({ message: 'Sản phẩm erorr' });
                    return
                } else {
                    const updateOrderItemQuery = 'UPDATE orderItems SET quantity = ?, subTotal = ? WHERE id = ?';
                    await sequelize.query(updateOrderItemQuery, {
                        raw: true,
                        logging: false,
                        replacements: [newQuantity, newSubTotal, existingOrderItemId],
                        type: QueryTypes.UPDATE
                    });
                    const updateOrderQuery = 'UPDATE orders SET totalAmount = ? WHERE id = ?';
                    await sequelize.query(updateOrderQuery, {
                        raw: true,
                        logging: false,
                        replacements: [newSubTotal, orderID],
                        type: QueryTypes.UPDATE
                    });
                }
            } else {
                // Insert a new orderItem
                console.log("order; insẻtc");
                const orderId = await sequelize.transaction(async transaction => {
                    const orderData = {
                        userID: body.userID,
                        tableID: tableID,
                        orderDate: new Date(),
                        totalAmount: body.price,
                    };

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
                    odID = resultRaw[0]
                    const orderId = resultRaw[0];

                    const queryRaw2 = 'INSERT INTO orderItems (orderID, productID, quantity, subTotal) VALUES (?, ?, ?, ?)';
                    await sequelize.query(queryRaw2, {
                        raw: true,
                        logging: false,
                        replacements: [orderId, productID, quantityClient, body.price],
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
                    return orderId;
                });
                // res.status(200).json({ message: 'Order created successfully', orderId });
            }
            console.log("ORRRRRRRDER Uid la", odID)
            res.status(200).json({ message: 'Order created successfully', oid: odID });

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
            console.log("body ::: ", body);
            const priceQuery = 'SELECT price FROM products WHERE id = ?';
            try {

                const updateQuantityQuery = 'UPDATE kho SET quantity = quantity + 1 WHERE productID = ?';

                await sequelize.query(updateQuantityQuery, {
                    logging: false,
                    replacements: [productID],
                    type: QueryTypes.UPDATE
                });
                const queryOrderItem = 'Select * from orderItems where orderID = ? ';
                const orderItemResult = await sequelize.query(queryOrderItem, {
                    raw: true,
                    logging: false,
                    replacements: [id],
                    type: QueryTypes.SELECT
                });
                const price = orderItemResult[0].subTotal / orderItemResult[0]?.quantity;
                const newQuantity = orderItemResult[0]?.quantity - 1;
                const newTotal = newQuantity * price;
                try {
                    const updateOrderQuery = `UPDATE orders SET totalAmount = ? WHERE id = ?;`;
                    await sequelize.query(updateOrderQuery, {
                        raw: true,
                        logging: false,
                        replacements: [newTotal, id],
                        type: QueryTypes.UPDATE,
                    });

                    const updateOrderItemsQuery = `UPDATE orderItems SET  quantity = ?, subTotal = ?  WHERE orderID = ?;`;
                    await sequelize.query(updateOrderItemsQuery, {
                        raw: true,
                        logging: false,
                        replacements: [newQuantity, newTotal, id],
                        type: QueryTypes.UPDATE,
                    });

                } catch (error) {
                    console.log({ error });
                }



                res.status(200).json({ message: 'Order updated successfully' });
            } catch (error) {
                res.status(500).json({ message: 'Error updating order', error: error });
            }
        } else {
            res.status(403).json({ message: 'Unauthorized' });
        }

    } catch (error) {
        console.error('Error updating order:', error);
        res.status(500).json({ message: 'Internal server error', error: error });
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
            let transaction;
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
            SELECT o.id AS orderID, o.orderDate,o.price AS price_produc , o.totalAmount,p.id AS productID,o.orderDate , p.name AS productName, p.dvtID AS dvt ,
             oi.quantity, oi.subTotal , p.category , p.price , u.name As userName ,u.id As userID
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
    const body = req.body;
    console.log("bodsssssssssssy", body);
    if (isAuth) {
        const tableID = req.body.id;
        try {
            // Lấy thông tin tổng số tiền và chi tiết hoá đơn
            const getBillDetailsQuery = `
                SELECT p.name AS productName,p.id AS productID, oi.quantity, p.price, u.name AS userName, u.id AS userID, oi.subTotal as totalAmount, o.id
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

            INSERT INTO invoice (tableID,total, createAt, userName, userID, invoiceNumber ,payMethod )
            VALUES (?, ?, ?, ?, ?, ?, ?)

            `;
            const invoiceNumber = getInvoiceNumber();
            console.log(tableID, totalInvoiceAmount, new Date(), billDetails[0].userName, billDetails[0].userID, invoiceNumber, body.payMethod);
            const invoiceResult = await sequelize.query(createInvoiceQuery, {
                raw: true,
                logging: false,
                replacements: [tableID, totalInvoiceAmount, new Date(), billDetails[0].userName, billDetails[0].userID, invoiceNumber, body.payMethod],
                type: QueryTypes.INSERT
            });

            const invoiceID = invoiceResult[0];

            // Lưu chi tiết hoá đơn vào bảng invoiceDetails
            for (const detail of billDetails) {
                const createInvoiceDetailsQuery = `
                    INSERT INTO invoiceDetails (invoiceID, poductName, quantity, totalAmount , productID)
                    VALUES (?, ?, ?, ?, ?)
                `;

                await sequelize.query(createInvoiceDetailsQuery, {
                    raw: true,
                    logging: false,
                    replacements: [invoiceID, detail.productName, detail.quantity, detail.totalAmount, detail.productID],
                    type: QueryTypes.INSERT
                });

                // Trừ số lượng sản phẩm từ kho
                const updateProductQuantityQuery = `
                 UPDATE kho
                 SET quantity = quantity - ?
                 WHERE productID = ?
             `;
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
                replacements: [2, tableID],
                type: QueryTypes.UPDATE
            });
            io.emit('table');
            await sequelize.transaction(async transaction => {
                const deleteOrderItemsQuery = `DELETE FROM orderItems WHERE orderID = ?;`;

                await sequelize.query(deleteOrderItemsQuery, { raw: true, logging: false, replacements: [idOder], type: QueryTypes.DELETE, transaction });
                const deleteOrderQuery = `DELETE FROM orders WHERE tableID = ?;`;
                await sequelize.query(deleteOrderQuery, { raw: true, logging: false, replacements: [tableID], type: QueryTypes.DELETE, transaction });
            });
            res.status(200).json({ message: 'Bill paid successfully', invoiceID });
        } catch (error) {
            res.status(500).json({ message: 'Error paying bill', error: error.message });
            console.log(" lỗi : ", error);
        }
    } else {
        res.status(403).json({ message: 'Unauthorized' });
    }
};

exports.updatePriceOrder = async (req, res) => {
    try {
        const body = req.body;
        console.log(body)
        const isAuth = await Auth.checkAuth(req);
        let quantyti = 0;
        const price = body.subTotal;


        if (isAuth) {
            if (body.portion === 5) {
                quantyti = 24;

            } else if (body.portion === 6) {
                quantyti = 6;
            } else {
                quantyti = 1;
            }



            let subTotal = quantyti * price;
            const queryRaw = 'UPDATE orderItems SET subTotal = ? ,quantity = ? WHERE orderID = ?;'
            const queryRaw_ = 'UPDATE orders SET totalAmount = ? , price=? WHERE id = ?;'

            console.log('body::', body);
            const resultRaw = await sequelize.query(queryRaw, {
                raw: true,
                logging: false,
                replacements: [subTotal, quantyti, body.id],
                type: QueryTypes.UPDATE,
            });
            const resultRaw_ = await sequelize.query(queryRaw_, {
                raw: true,
                logging: false,
                replacements: [subTotal, price, body.id],
                type: QueryTypes.UPDATE,
            });
            res.status(200).json({ message: 'Order updated successfully' });
        }
    } catch (error) {
        console.log(" error::", error);
    }
}

// exports.updatePriceOrder = async (req, res) => {
//     const body = req.body;

//     try {
//         const isAuth = await Auth.checkAuth(req);
//         let quantyti = 0;
//         const price = body.subTotal;
//         if (isAuth) {
//             const queryOrder = 'SELECT * FROM orderItems';
//             const resultOrder = await sequelize.query(queryOrder, {
//                 raw: true,
//                 logging: false,
//                 replacements: [body.id],
//                 type: QueryTypes.SELECT,
//             });

//             const queryOrderItem = 'SELECT * FROM orders';
//             const resultOrderItem = await sequelize.query(queryOrderItem, {
//                 raw: true,
//                 logging: false,
//                 replacements: [body.id],
//                 type: QueryTypes.SELECT,
//             });

//             const orderItems = resultOrder.map((item) => ({ ...item, type: 'orderItems' }));
//             const orders = resultOrderItem.map((item) => ({ ...item, type: 'orders' }));

//             const consolidatedData = [...orderItems, ...orders];
//             const groupedData = {};
//             consolidatedData.forEach((item) => {
//                 const key = `${item.productID}-${item.price}`;
//                 if (!groupedData[key]) {
//                     groupedData[key] = { ...item };
//                 } else {
//                     groupedData[key].quantity += item.quantity || 0;
//                     groupedData[key].subTotal += item.subTotal || 0;
//                 }
//             });

//             // Update orderItems and orders
//             for (const key in groupedData) {
//                 const item = groupedData[key];
//                 const { type, id, quantity, subTotal } = item;
//                 console.log({ item });
//                 if (type === 'orderItems') {
//                     const queryRawOrderItem = 'UPDATE orderItems SET quantity = ?, subTotal = ? WHERE id = ?';
//                     await sequelize.query(queryRawOrderItem, {
//                         raw: true,
//                         logging: false,
//                         replacements: [quantity, subTotal, id],
//                         type: QueryTypes.UPDATE,
//                     });
//                 } else if (type === 'orders') {
//                     const queryRawOrder = 'UPDATE orders SET totalAmount = ? WHERE id = ?';
//                     await sequelize.query(queryRawOrder, {
//                         raw: true,
//                         logging: false,
//                         replacements: [subTotal, id],
//                         type: QueryTypes.UPDATE,
//                     });
//                 }
//             }

//             res.status(200).json({ message: 'Orders updated successfully' });
//         }
//     } catch (error) {
//         console.log('error::', error);
//         res.status(500).json({ error: 'Internal Server Error' });
//     }
// }
