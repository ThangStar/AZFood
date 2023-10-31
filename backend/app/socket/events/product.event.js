const {getOrdersForTable} = require('../controllers/product.controller')
// [table]
const listProductByIdTable = (socket, io) => {
    socket.on('decreaseQuantity', (data)=> {
        decreaseQuantity(socket, io, data)
    });
    socket.on('listProductByIdTable', (data) => {
        console.log(data);
        // const authorization = socket.handshake.headers['Authorization'];
        // if (authorization) {
            // const bearerToken = authorization.split(' ')[1];
            // console.log(bearerToken);
            //check jwt

            //passed => send table
 
                getOrdersForTable(socket, io, data)
                
        

        // } else {
        //     io.to(socket.id).emit('response', "Authorization failed!")
        //     console.log('no token');
        // }
    })
}

module.exports = listProductByIdTable