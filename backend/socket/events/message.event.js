// const { getMessagesForUser, insertMessage } = require('../controllers/message.controller')
const { sequelize } = require("../../app/models");
const { QueryTypes } = require("sequelize");

//ROLE:
// Type 
// 1: Text
// 2: Image
// 3: Voice
const messageGroup =  async (socket, io) => {
        socket.on('client-msg-init-group', (data) => {
            console.log(data);
            io.to(socket.id).emit('sever-msg-init-group', [
                {
                    id: 's3',
                    message: "This is chat",
                    createdAt: Date.now().toLocaleString,
                    sendBy: '2',
                },
                {
                    id: 's3',
                    message: "kawaii",
                    createdAt: Date.now(),
                    sendBy: '2',
                },
            ])
        })

        socket.on('client-msg-group', (data) => {
            if (data.body) data = data.body
            console.log('data messages', data.message);
            io.emit('sever-msg-group', data.message);
        });

        socket.on('client-msg-typing-group', (data) => {
            io.emit('sever-msg-typing-group');
        });
        socket.on('client-msg-typed-group', (data) => {
            io.emit('sever-msg-typed-group');
        });
    }

module.exports = messageGroup;
