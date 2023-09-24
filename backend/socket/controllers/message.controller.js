const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../app/models");

exports.getMessages = async (socket, io, data) => {
    console.log("OK! REFRESH msg");
    try {
        const queryRaw = `SELECT message.*, JSON_OBJECT('id', users.id, 'name', users.name) as profile
        FROM message
        JOIN users ON message.sendBy = users.id;`;
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [],
            type: QueryTypes.SELECT
        });
        io.to(socket.id).emit('sever-msg-init-group', resultRaw);
    } catch (error) {
        console.error('Error getting messages:', error);
        io.to(socket.id).emit('sever-msg-init-group', "error")
    }
};

exports.insertMessage = async (socket, io, data) => {
    // BUG: cant emit sever to sever
    io.emit("client-msg-init-group", "");
    console.log("OKL");
    // const { type, message, raw, imageUrl, sendBy } = data
    // try {
    //     const queryRaw = `INSERT INTO MESSAGE(type, message, raw, imageUrl, sendBy) VALUES (?,?,?,?,?)`;
    //     const resultRaw = await sequelize.query(queryRaw, {
    //         raw: true,
    //         logging: false,
    //         replacements: [type, message, raw, imageUrl, sendBy],
    //         type: QueryTypes.INSERT
    //     });
    //     console.log('OK! insert msg',resultRaw);
    //     socket.emit('client-msg-init-group', {});
    // } catch (error) {
    //     console.error('Error insert messages:', error);
    //     io.to(socket.id).emit('sever-msg-group', "error")
    // }
};
