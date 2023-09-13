module.exports = (sequelize, Sequelize) => {
    const NhapHang = sequelize.define("nhapHang", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      tenHang: {
        type: Sequelize.STRING
      },
      soLuong: {
        type: Sequelize.INTEGER
      },
      donGia: {
        type: Sequelize.DOUBLE
      },
      ngayNhap: {
        type: Sequelize.DATE, 
        defaultValue: Sequelize.NOW 
      },
      
    });
  
    return NhapHang;
  };