module.exports = (sequelize, Sequelize) => {
  const Messages = sequelize.define("messages", {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    type: {
      type: Sequelize.INTEGER
    },
    message: {
      type: Sequelize.TEXT
    },
    raw: {
      type: Sequelize.TEXT
    },
    imageUrl: {
      type: Sequelize.TEXT
    },
    sendBy: {
      type: Sequelize.INTEGER
    },
    dateTime: {
      type: Sequelize.TEXT
    }
  });
  return Messages;
};
