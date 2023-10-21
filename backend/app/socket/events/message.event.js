// const { getMessagesForUser, insertMessage } = require('../controllers/message.controller')
// const { sequelize } = require("../../app/models");
// const { QueryTypes } = require("sequelize");
const messageController = require('../controllers/message.controller')

//ROLE:
// Type 
// 1: Text
// 2: Image
// 3: Voice
const messageGroup = async (socket, io) => {
    socket.on('client-msg-init-group', (data) => messageController.getMessages(socket, io, data))

    socket.on('client-msg-group', (data) => messageController.insertMessage(socket, io, data));

    socket.on('client-msg-typing-group', (data) => messageController.typing(socket, io, data));
    socket.on('client-msg-typed-group', (data) => messageController.typed(socket, io, data));

}

module.exports = messageGroup;
