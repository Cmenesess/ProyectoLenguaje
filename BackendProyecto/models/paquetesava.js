'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class SavaPackage extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.hasMany(models.WarehousePackage,{foreignKey:'sava_code',sourceKey:'sava_code'})
      this.belongsTo(models.Client,{foreignKey:'ClientId',targetKey:"username"})
    }
  }
  SavaPackage.init({
    sava_code: DataTypes.STRING,
    status: DataTypes.STRING,
    price: DataTypes.FLOAT,
    weight: DataTypes.FLOAT,
    departureDate: DataTypes.DATE,
    arrival_date_destiny: DataTypes.DATE,
    ClientId:DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'SavaPackage',
  });
  return SavaPackage;
};