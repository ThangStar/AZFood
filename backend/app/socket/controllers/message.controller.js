const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../models");

exports.getMessages = async (socket, io, data) => {
    console.log("OK! refresh msg");
    try {
        const queryRaw =
            `SELECT message.*, 
            JSON_OBJECT('id', users.id, 'name', users.name, 'imgUrl', users.imgUrl) as profile
            FROM message
            JOIN users 
            ON message.sendBy = users.id 
            order by dateTime ;`;
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [],
            type: QueryTypes.SELECT
        });
        io.emit('sever-msg-init-group', resultRaw); //send to all user
        io.emit('sever-msg-noti', resultRaw[resultRaw.length-1]); // noti to all user
    } catch (error) {
        console.error('Error getting messages:', error);
        io.to(socket.id).emit('sever-msg-init-group', "error")
    }
};

exports.insertMessage = async (socket, io, data) => {
    // if(data.img){
    console.log(data);
    // }
    const { type, message, raw, imageUrl, sendBy } = data
    try {
        const queryRaw = `INSERT INTO message(type, message, raw, imageUrl, sendBy) VALUES (?,?,?,?,?)`;
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [type, message, raw, imageUrl, sendBy],
            type: QueryTypes.INSERT
        });
        console.log('OK! insert msg', resultRaw);
        socket.emit('client-msg-init-group', {});
        //reload new msg callback
        this.getMessages(socket, io, data)
    } catch (error) {
        console.error('Error insert messages:', error);
        io.to(socket.id).emit('sever-msg-group', "error")
    }
};


exports.typing = async (socket, io, data) => {
    const { id } = data
    //get username by id
    try {
        const queryRaw = `SELECT id, name, imgUrl FROM USERS WHERE ID = ?`;
        const resultRaw = await sequelize.query(queryRaw, {
            raw: true,
            logging: false,
            replacements: [id],
            type: QueryTypes.SELECT
        });
        io.emit('sever-msg-typing-group', resultRaw[0])
        console.log(resultRaw[0]);
    } catch (error) {
        console.error('Error getting name:', error);
        io.to(socket.id).emit('status-msg', "error")
    }
}

exports.typed = async (socket, io, data) => {
    try {
        const { id } = data
        console.log("OK! Typed msg");
        io.emit('sever-msg-typed-group', id)
    } catch (error) {
        console.error('Error typed:', error);
        io.to(socket.id).emit('status-msg', "error")
    }
}