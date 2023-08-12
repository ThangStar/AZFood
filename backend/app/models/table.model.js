module.exports = (sequelize, Sequelize) => {
    const Table = sequelize.define("table", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      name: {
        type: Sequelize.STRING
      },
      status: {
        type: Sequelize.INTEGER
      },
    });
  
    return Table;
  };