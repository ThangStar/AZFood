module.exports = (sequelize, Sequelize) => {
    const DVT = sequelize.define("DVT", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      tenDVT: {
        type: Sequelize.STRING
      }
    });
  
    return DVT;
  };