// const { getMessagesForUser, insertMessage } = require('../controllers/message.controller')

const messageGroup = (socket, io) => {
    socket.on('client-msg-text-group', (data) => {
        if (data.body) data = data.body
        console.log('data messages', data.message);
        io.emit('sever-msg-text-group', data.message);
    });

    socket.on('client-msg-voice-group', (data) => {
        console.log('inserting message', data);
        if (data.body) data = data.body
        io.emit('sever-msg-voice-group', data.sound);
    });

    socket.on('client-msg-typing-group', (data) => {
        io.emit('sever-msg-typing-group');
    });
    socket.on('client-msg-typed-group', (data) => {
        io.emit('sever-msg-typed-group');
    });
}

module.exports = messageGroup;
