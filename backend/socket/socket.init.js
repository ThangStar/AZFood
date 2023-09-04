const table = require('./events/table.event')
const socketInit = (io) => {
    init(io)
}

init = (io) => {
    io.on('connection', (socket) => {
        console.log(`User ${socket.id} connected to socket`);
        table(socket, io)
        socket.on('disconnect', () => {
            console.log('User disconnected from socket');
        });
    });
}

module.exports = socketInit
