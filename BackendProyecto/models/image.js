'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Images extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.belongsTo(models.WarehousePackage,{foreignKey:'tracking_number'})
    }
  }
  Images.init({
    tracking_number:DataTypes.STRING,
    source: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Image',
  });
  return Images;
};