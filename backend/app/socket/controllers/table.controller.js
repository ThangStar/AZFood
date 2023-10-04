const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../models");

exports.getList = async (socket, io) => {

    const queryRaw = `SELECT t.id, t.name, t.status, s.name AS status_name, SUM(od.totalAmount) total_amount,
    (
        SELECT o.orderDate FROM orders as o
        WHERE o.tableID = t.id 
        ORDER BY o.orderDate LIMIT 1
    ) first_time
        FROM tables t 
        JOIN statusTable s 
        ON t.status = s.id
        LEFT JOIN orders od 
        ON t.id = od.tableID
        group by t.name`;
    try {
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [],
            type: QueryTypes.SELECT
        });
        io.emit("response", resultRaw)

        // io.to(socket.id).emit('response', resultRaw)
        console.log("OK! refresh tables");
    } catch (error) {
        console.log("response", error);
        io.to(socket.id).emit('response', error)
    }
}