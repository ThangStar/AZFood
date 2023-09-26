const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../app/models");

exports.getMessagesForUser = async (socket, io, data) => {
    try {
        const queryRaw = `SELECT * FROM MESSAGE`;
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [],
            type: QueryTypes.SELECT
        });
        io.emit('client-msg-init-group', resultRaw);
    } catch (error) {
        console.error('Error getting messages:', error);
        io.to(socket.id).emit('client-msg-init-group', "error")
    }
};

exports.insertMessage = async (socket, io, data) => {
    const { type, message, raw, imageUrl, sendBy } = data
    try {
        const queryRaw = `INSERT INTO MESSAGE(type, message, raw, imageUrl, sendBy) VALUES(?,?,?,?,?)`;
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [type, message, raw, imageUrl, sendBy],
            type: QueryTypes.SELECT
        });
        io.emit('sever-msg-group', resultRaw);
    } catch (error) {
        console.error('Error getting messages:', error);
        io.to(socket.id).emit('sever-msg-group', "error")
    }
};
