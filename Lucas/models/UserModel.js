const db = require('../config/db');
const bcrypt = require('bcrypt');

const User = db.sequelize.define('user', {
  id: {
    type: db.Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  Nome: {
    type: db.Sequelize.STRING,
    allowNull: false,
  },
  Email: {
    type: db.Sequelize.STRING,
    allowNull: false,
    unique: true,
  },
  Senha: {
    type: db.Sequelize.STRING,
    allowNull: false,
  },
  Cargo: {
    type: db.Sequelize.STRING,
    allowNull: false,
  },
},
  { timestamps: false, freezeTableName: true });

// Hash da senha antes de criar o usuário
User.beforeCreate(async (user, options) => {
  const saltRounds = 10;
  user.Senha = await bcrypt.hash(user.Senha, saltRounds);
});

// Função para buscar todos os usuários
User.getAllUsers = (callback) => {
  User.findAll()
    .then(users => callback(null, users))
    .catch(err => callback(err));
};

// Função para criar usuário
User.createUser = (Nome, Email, Senha, Cargo, callback) => {
  User.create({ Nome, Email, Senha, Cargo })
    .then(() => callback(null))
    .catch(err => callback(err));
};

// Função para atualizar usuário
User.updateUser = (id, Nome, Email, Cargo, callback) => {
  User.update({ Nome, Email, Cargo }, { where: { id } })
    .then(() => callback(null))
    .catch(err => callback(err));
};

// Função para deletar usuário
User.deleteUser = (id, callback) => {
  User.destroy({ where: { id } })
    .then(() => callback(null))
    .catch(err => callback(err));
};

//User.sync({force: true})
module.exports = User;
