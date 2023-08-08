const dbConfig = require("../config/db.config.js");


const { Sequelize } = require('sequelize');
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  define: {
    timestamps: false
  }
});

async function a() {
  try {
    await sequelize.authenticate();
  } catch (error) {
    console.log("ERROR - Unable to connect to the database:", error);
  }
}
a();

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.member = require("./member.model.js")(sequelize, Sequelize);

module.exports = db;