module.exports = (sequelize, Sequelize) => {
    const OrderItems = sequelize.define("orderItems", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      orderID: {
        type: Sequelize.INTEGER
      },
      productID: {
        type: Sequelize.INTEGER
      },
      quantity: {
        type: Sequelize.INTEGER
    },
      subTotal: {
        type: Sequelize.DOUBLE
      },
      
    });
  
    return OrderItems;
  };