const express = require('express');
const bodyParser = require("body-parser");
require('dotenv').config();

const app = express();
app.use(bodyParser.urlencoded({
    limit: "50mb",
    extended: false
  }));
  app.use(bodyParser.json({limit: "50mb"}));
  
  app.use(express.static('public'));

  app.get("/", (req, res) => {
    res.send('helllo');
  });
  app.set('view engine', 'ejs')
app.use(bodyParser.urlencoded({ extended: true }));

require("./app/routes/members.route.js")(app);
require("./app/routes/products.route.js")(app);

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});