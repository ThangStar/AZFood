const { getList } = require("../controllers/table.controller");

// [table]
const table = (socket, io) => {
    socket.on('table', (data) => {
        console.log("table changed");
        // const authorization = socket.handshake.headers['Authorization'];
        // if (authorization) {
        // const bearerToken = authorization.split(' ')[1];
        // console.log(bearerToken);
        //check jwt

        //passed => send table
        getList(socket, io);

        // } else {
        //     io.to(socket.id).emit('response', "Authorization failed!")
        //     console.log('no token');
        // }
    })
}

module.exports = table