const jwt = require('jsonwebtoken');
const constant = require("../config/constant");
const sha1 = require('sha1');
const db = require("../models");
const Jwt = require('../config/checkJWT')
const { QueryTypes } = require('sequelize');
const sequelize = db.sequelize;

//login
exports.login = async (req, res) => {
  const username = req.body.username;
  let userPwd = req.body.password;

  userPwd = sha1(userPwd);

  const queryRaw = "SELECT * FROM users WHERE username=? AND password = ?";
    
  const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false, 
    replacements: [username, userPwd], type: QueryTypes.SELECT })
    console.log("Result : " , resultRaw);
  const checkMember = resultRaw && resultRaw.length && resultRaw.length > 0 ? resultRaw[0] : null;

  if (checkMember) {
    //Sing JWT, valid for 1 hour
    const token = jwt.sign({ userId: checkMember.id, username: checkMember.username },constant.jwtSecret,
      { expiresIn: constant.jwtSecretExp }
    );
    //Send the jwt in the response

    res.send({
      "connexion": true,
      "jwtToken": token,
      "id": checkMember.id,
      "username": checkMember.username
    });
    return;
  } else {
    console.log("ERROR - function login can not find member with username", username);
    res.send({
      "connexion": false
    });
  }
};

exports.account = async (req, res) => {

  const curentLogin = Jwt.getCurrentLogin(req);
  // Check member exists?
  const queryRaw = "SELECT * FROM users WHERE id = ?";
    
  const resultRaw = await sequelize.query(queryRaw, { raw: true, logging: false,
     replacements: [curentLogin.userId], type: QueryTypes.SELECT })

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

