const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();
const session = require('express-session'); 


const app = express();
const server = require('http').createServer(app);
const io = require('socket.io')(server);
app.io = io
app.use(bodyParser.urlencoded({
    limit: "50mb",
    extended: false
  }));
  app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
  });
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
require("./app/routes/nhapHang.route.js")(app);
require("./app/routes/statistics.route.js")(app);

const PORT = process.env.PORT || 8080;
server.listen(PORT, () => {
  console.log(`SOCKET is running on port ${PORT}.`);
});
require("./app/routes/members.route.js")(app);

require('./socket/socket.init.js')(io);


