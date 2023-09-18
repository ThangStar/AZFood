const { QueryTypes } = require("sequelize");
const { sequelize } = require("../../app/models");

exports.getMessagesForUser = async (socket, io, data) => {
    try {
        const userId = 2;

        const getMessagesQuery = `
            SELECT id, content
            FROM messages
            WHERE userId = ?
        `;

        const messages = await sequelize.query(getMessagesQuery, {
            raw: true,
            logging: false,
            replacements: [userId],
            type: QueryTypes.SELECT
        });

        io.emit('responseMessages', messages);
        
    } catch (error) {
        console.error('Error getting messages:', error);
        io.to(socket.id).emit('responseMessages', "error")
    }
};

exports.insertMessage = async (socket, io, data) => {
    try {
        const { userId, content } = data;

        const insertQuery = `
            INSERT INTO messages (userId, content)
            VALUES (?, ?)
        `;

        await sequelize.query(insertQuery, {
            replacements: [userId, content],
            type: QueryTypes.INSERT
        });

        // Emit sự kiện cho client biết đã chèn thành công
        io.emit('messageInserted', { success: true });

    } catch (error) {
        console.error('Error inserting message:', error);
        io.to(socket.id).emit('messageError', "Error inserting message");
    }
};
