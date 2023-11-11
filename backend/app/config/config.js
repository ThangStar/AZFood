// {
//   "development": {
//     "username": "root",
//     "password": "12345678",
//     "database": "finallapp",
//     "host": "localhost",
//     "dialect": "mysql"
//   },
//   "test": {
//     "username": "root",
//     "password": "12345678",
//     "database": "finallapp",
//     "host": "localhost",
//     "dialect": "mysql"
//   },
//   "production": {
//     "username": "root",
//     "password": "12345678",
//     "database": "finallapp",
//     "host": "localhost",
//     "dialect": "mysql"
//   }
// }
require('dotenv').config();
module.exports = {
  HOST: process.env.DB_HOST,
  // PORT: process.env.DB_HOST,
  USER: process.env.DB_USER,
  PASSWORD: process.env.DB_PASSWORD,
  DB: process.env.DB,
  dialect: "mysql",
};