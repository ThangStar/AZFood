const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();
const session = require('express-session');
const cors = require('cors');
const app = express();
const server = require('http').createServer(app);
const Domain = [
    'http://localhost:3000',
    'https://manager-az-food.vercel.app',
    'https://manager-az-food-quochuys-projects.vercel.app',
    'https://manager-az-food-git-main-quochuys-projects.vercel.app'
];
const io = require('socket.io')(server, {
    cors: {
        origin: Domain,
        methods: ["GET", "POST"]
    }
});
app.io = io;
const corsOptions = {
    origin: function (origin, callback) {
        if (!origin || Domain.includes(origin)) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    },
    methods: ['GET', 'POST']
};
app.use(cors(corsOptions));
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
app.use(express.static('public'));
app.use(session({
    secret: process.env.SESSION_SECRET || 'LOGIN',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
}));

app.get("/", (req, res) => {
    res.send('helllo');
});

app.set('view engine', 'ejs');

// Routes
require("./app/routes/members.route.js")(app);
require("./app/routes/forgotPass.route.js")(app);
require("./app/routes/products.route.js")(app);
require("./app/routes/table.route.js")(app);
require("./app/routes/orders.route.js")(app);
require("./app/routes/donViTinh.route.js")(app);
require("./app/routes/invoice.route.js")(app);
require("./app/routes/nhapHang.route.js")(app);
require("./app/routes/statistics.route.js")(app);
require("./app/routes/attendance.route.js")(app);
require('./app/socket/socket.init.js')(io);

const PORT = process.env.PORT || 3434;
server.listen(PORT, () => {
    console.log(`SOCKET is running on port11111 ${PORT}.`);
});
