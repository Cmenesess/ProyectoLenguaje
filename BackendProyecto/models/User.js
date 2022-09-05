'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.belongsTo(models.User,{foreignKey:'username'})
      this.hasMany(models.Client,{foreignKey:'username',sourceKey:'id'})
    }
  }
  User.init({
    username: DataTypes.STRING,
    password: DataTypes.STRING,
    role: DataTypes.STRING,
    token: DataTypes.STRING,
    phoneNumber:DataTypes.STRING
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};
