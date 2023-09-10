const table = require('./events/table.event')
const listProductByIdTable = require('./events/product.event')
const socketInit = (io) => {
    init(io)
}
const connections = [];
init = (io) => {
    io.on('connection', (socket) => {
        connections.push(socket);
        console.log(`User ${socket.id} connected to socket`);
        console.log(`${connections.length} user online`);

        table(socket, io)
        listProductByIdTable(socket, io)

        socket.on('a', () => {
            io.emit('response', "HELLO")
        });

        // orders(socket, io)

        socket.on('disconnect', () => {
            connections.splice(connections.indexOf(socket), 1);
            console.log('User disconnected from socket');
        });
    });
}

module.exports = socketInit
