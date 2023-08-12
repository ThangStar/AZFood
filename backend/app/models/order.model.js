module.exports = (sequelize, Sequelize) => {
    const Orders = sequelize.define("products", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      userID: {
        type: Sequelize.INTEGER
      },
      tableID: {
        type: Sequelize.INTEGER
      },
      orderDate: {
        type: Sequelize.DATE, 
        defaultValue: Sequelize.NOW 
    },
      totalAmount: {
        type: Sequelize.DOUBLE
      },
      
    });
  
    return Orders;
  };