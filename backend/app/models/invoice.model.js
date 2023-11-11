module.exports = (sequelize, Sequelize) => {
  const Invoice = sequelize.define("invoice", {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    total: {
      type: Sequelize.DOUBLE
    },
    createAt: {
      type: Sequelize.DATE,
      defaultValue: Sequelize.NOW
    },
    userName: {
      type: Sequelize.STRING
    },
    tableID: {
      type: Sequelize.INTEGER
    }
  });

  return Invoice;
};