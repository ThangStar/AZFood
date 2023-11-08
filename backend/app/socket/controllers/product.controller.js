const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../models");
const { getList } = require("./table.controller");

exports.getOrdersForTable = async (socket, io, data) => {
    try {
        const tableID = data.id;
        console.log('check');
        const getOrdersQuery = `
            SELECT o.id AS id, o.orderDate, o.totalAmount,p.id AS productID,o.orderDate , p.name AS name ,
             oi.quantity, oi.subTotal , p.category , p.price , u.name As userName, p.imgUrl, d.tenDVT as "dvt_name"
            FROM orders o
            INNER JOIN orderItems oi ON o.id = oi.orderID
            INNER JOIN products p ON oi.productID = p.id
            INNER JOIN users u ON o.userID = u.id
            INNER JOIN donvitinh d ON p.dvtID = d.id
            WHERE o.tableID = ?
        `;

        const orders = await sequelize.query(getOrdersQuery, {
            raw: true,
            logging: false,
            replacements: [tableID || id],
            type: QueryTypes.SELECT
        });
        console.log("OK! refresh orders");
        io.emit('responseOrder', { order: orders, tableID: tableID })
        getList(socket, io)

    } catch (error) {
        console.error('Error getting orders:', error);
        io.to(socket.id).emit('responseOrder', "error")
    }
};

