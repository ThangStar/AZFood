module.exports = (sequelize, Sequelize) => {
    const Products = sequelize.define("orders", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      name: {
        type: Sequelize.STRING
      },
      price: {
        type: Sequelize.DOUBLE
      },
      status: {
        type: Sequelize.INTEGER
      },
      quantity: {
        type: Sequelize.INTEGER
      },
      category: {
        type: Sequelize.INTEGER
      },
    });
  
    return Products;
  };