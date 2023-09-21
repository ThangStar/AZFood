const { getMessagesForUser, insertMessage } = require('../controllers/message.controller')

const listenForUserMessages = (socket, io) => {
    socket.on('messageFromClient', (data) => {
        console.log('data messages', data);
        getMessagesForUser(socket, io, data);
    });

    socket.on('insertMessage', (data) => {
        console.log('inserting message', data);
        insertMessage(socket, io, data);
    });
}

module.exports = listenForUserMessages;
