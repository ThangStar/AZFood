const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();
const session = require('express-session'); 


const app = express();
const server = require('http').createServer(app);
const io = require('socket.io')(server);
app.use(bodyParser.urlencoded({
    limit: "50mb",
    extended: false
  }));
  
  app.use(bodyParser.json({limit: "50mb"}));
  app.use(session({
    secret: process.env.SESSION_SECRET || 'LOGIN',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } 
  }));
  app.use(express.static('public'));

  app.get("/", (req, res) => {
    res.send('helllo');
  });
  app.set('view engine', 'ejs')
app.use(bodyParser.urlencoded({ extended: true }));

require("./app/routes/members.route.js")(app);
require("./app/routes/products.route.js")(app);
require("./app/routes/table.route.js")(app);
require("./app/routes/orders.route.js")(app);
require("./app/routes/donViTinh.route.js")(app);
require("./app/routes/invoice.route.js")(app);

const PORT = process.env.PORT || 8080;
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});

io.on('connection', (socket) => {
  console.log('User connected to socket');
  socket.on('disconnect', () => {
    console.log('User disconnected from socket');
  });
});
