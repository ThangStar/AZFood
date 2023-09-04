const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../app/models");

exports.getList = async (socket, io) => {

    const queryRaw = "SELECT t.id, t.name, t.status, s.name AS status_name FROM tables t JOIN statusTable s ON t.status = s.id;";
    try {
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [],
            type: QueryTypes.SELECT
        });
        io.to(socket.id).emit('response', resultRaw)
    } catch (error) {
        console.log("response", error);
        io.to(socket.id).emit('response',error)
    }


}