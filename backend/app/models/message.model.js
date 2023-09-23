module.exports = (sequelize, Sequelize) => {
    const Messages = sequelize.define("messages", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      userID: {
        type: Sequelize.INTEGER
      },
      content: {
        type: Sequelize.TEXT
      }
    });
  
    return Messages;
};
