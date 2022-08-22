'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Clients extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.belongsTo(models.User,{foreignKey:'username'})
      this.hasMany(models.SavaPackage,{targetKey:'username'})
      this.hasMany(models.WarehousePackage,{targetKey:'username'})
    }
  }
  Clients.init({
    username: DataTypes.INTEGER,
    sentPackages: DataTypes.INTEGER,
    email:DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Client',
  });
  return Clients;
};