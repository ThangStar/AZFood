const db = require("../models");
const { QueryTypes } = require("sequelize");
const sequelize = db.sequelize;
const Jwt = require("../config/checkJwt");

exports.checkAuth = async (req, res) => {

  const curentLogin = Jwt.getCurrentLogin(req);
  if (!curentLogin) {
    res.status(401).send({ message: 'Unauthorized' });
    return;
  }
  // Check member exists?
  try {
    const queryUserRaw = "SELECT * FROM users WHERE id = ?";
    const resultUserRaw = await sequelize.query(queryUserRaw, { raw: true, logging: false, replacements: [curentLogin.userId], type: QueryTypes.SELECT, });
    const checkMember = resultUserRaw && resultUserRaw.length && resultUserRaw.length > 0 ? resultUserRaw[0] : null;

    if (checkMember) {

      return checkMember;
    } else {
      return false;
    }
  } catch (error) {
    console.error("Error checking auth:", error);
  }

};
exports.checkAdmin = async (req) => {

  const curentLogin = Jwt.getCurrentLogin(req);
  try {
    const queryUserRaw = "SELECT role FROM users WHERE id = ?";
    const resultUserRaw = await sequelize.query(queryUserRaw, {
      replacements: [curentLogin.userId],
      type: QueryTypes.SELECT,
    });

    const isAdmin = resultUserRaw.length > 0 ? resultUserRaw[0].role === 'admin' : null;

    return isAdmin;
  } catch (error) {
    console.error("Error checking admin:", error);
    return false;
  }
};
exports.getUserLogin = async (req, res) => {

  const curentLogin = Jwt.getCurrentLogin(req);
  try {
    const queryUserRaw = "SELECT * FROM users WHERE id = ?";
    const resultUserRaw = await sequelize.query(queryUserRaw, { raw: true, logging: false, replacements: [curentLogin.userId], type: QueryTypes.SELECT, });
    const checkMember = resultUserRaw && resultUserRaw.length && resultUserRaw.length > 0 ? resultUserRaw[0] : null;

    if (checkMember) {
      res.send({ checkMember });

    }
    return;
  } catch (error) {
    console.error("Error checking admin:", error);
    return false;
  }
};