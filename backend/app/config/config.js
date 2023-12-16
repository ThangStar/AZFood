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
  HOST: process.env.DB_HOST || 'database-mysql',
  USER: process.env.DB_USER || 'root',
  PORT: process.env.DB_PORT || 3307,
  PASSWORD: process.env.DB_PASSWORD || '12345678',
  DB: process.env.DB || 'finallapp',
  dialect: "mysql",
};