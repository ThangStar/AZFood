module.exports = (sequelize, Sequelize) => {
  const Invoice = sequelize.define("invoice", {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true
    }, invoiceID: {
      type: Sequelize.INTEGER
    },
    productName: {
      type: Sequelize.STRING
    },
    quanntity: {
      type: Sequelize.INTEGER
    },
    totalAmount: {
      type: Sequelize.DOUBLE
    },

  });

  return Invoice;
};