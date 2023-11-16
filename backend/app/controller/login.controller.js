const jwt = require('jsonwebtoken');
const constant = require("../config/constant");
const sha1 = require('sha1');
const db = require("../models");
const Jwt = require('../config/checkJwt')
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;

//login
exports.login = async (req, res) => {
  const username = req.body.username;
  let userPwd = req.body.password;
  console.log("req.body", req.body)

  userPwd = sha1(userPwd);
  try {
    const queryRaw = "SELECT * FROM users WHERE username=? AND password = ?";
    const resultRaw = await sequelize.query(queryRaw, {
      raw: true, logging: false,
      replacements: [username, userPwd], type: QueryTypes.SELECT
    })
    console.log("Result : ", resultRaw);
    const checkMember = resultRaw && resultRaw.length && resultRaw.length > 0 ? resultRaw[0] : null;

    if (checkMember) {
      const token = jwt.sign({ userId: checkMember.id, username: checkMember.username }, constant.jwtSecret,
        { expiresIn: constant.jwtSecretExp }
      );

      //[note]: return data client: type is Json
      res.send({
        "connexion": true,
        "jwtToken": token,
        "id": checkMember.id,
        "username": checkMember.username,
        "role": checkMember.role
      });
      return res.status(200);
    } else {
      console.log("ERROR - function login can not find member with username", username);
      res.status(400).send({
        "connexion": false
      });
    }
  } catch (error) {
    console.log("error", error);
  }

};

exports.account = async (req, res) => {

  const curentLogin = Jwt.getCurrentLogin(req);
  // Check member exists?
  const queryRaw = "SELECT * FROM users WHERE id = ?";

  const resultRaw = await sequelize.query(queryRaw, {
    raw: true, logging: false,
    replacements: [curentLogin.userId], type: QueryTypes.SELECT
  })

  const checkMember = resultRaw && resultRaw.length && resultRaw.length > 0 ? resultRaw[0] : null;

  if (checkMember) {

    // PLAYER
    let member = {};
    member.id = checkMember.id;
    member.username = checkMember.username;


    res.send({
      "member": member,
      "connexion": true,
      "member_id": checkMember.id,
    });
  } else {
    if (curentLogin && curentLogin.userId) {
      console.log(new Date() + ': Check sync data: Member ' + curentLogin.userId + ' exports.account fail');
    } else {
      console.log(new Date() + ': Check sync data: exports.account fail with curentLogin null');
    }
    res.send({
      "connexion": false
    });
  }
};

