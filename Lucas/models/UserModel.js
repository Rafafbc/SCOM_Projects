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
  nickname: {
    type: db.Sequelize.STRING,
    allowNull: false, // Pode ser alterado conforme a necessidade
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
}, {
  timestamps: false,
  freezeTableName: true
});

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
User.createUser = (Nome, nickname, Email, Senha, callback) => {
  User.create({ Nome, nickname, Email, Senha })
    .then(() => callback(null))
    .catch(err => callback(err));
};

// Função para atualizar usuário
User.updateUser = (id, Nome, nickname, Email, callback) => {
  User.update({ Nome, nickname, Email }, { where: { id } })
    .then(() => callback(null))
    .catch(err => callback(err));
};

// Função para deletar usuário
User.deleteUser = (id, callback) => {
  User.destroy({ where: { id } })
    .then(() => callback(null))
    .catch(err => callback(err));
};

//User.sync({force: true}) // Descomente esta linha se precisar criar a tabela, execute e depois comente de novo
module.exports = User;
