// const { getMessagesForUser, insertMessage } = require('../controllers/message.controller')

const messageGroup = (socket, io) => {

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
