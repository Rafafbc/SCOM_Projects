const UserModel = require('../models/UserModel');

// Buscar todos os usuários
exports.getUsers = (req, res) => {
    UserModel.getAllUsers((err, users) => {
        if (err) return res.status(500).json({ message: 'Erro ao buscar usuários' });
        res.json(users);
    });
};

// Criar novo usuário
exports.createUser = (req, res) => {
    const { Nome, Email, Senha, Cargo } = req.body;
    UserModel.createUser(Nome, Email, Senha, Cargo, (err) => {
        if (err) return res.status(500).json({ message: 'Erro ao criar usuário' });
        res.json({ message: 'Usuário criado com sucesso' });
    });
};

// Excluir usuário
exports.deleteUser = (req, res) => {
    const { id } = req.params;
    UserModel.deleteUser(id, (err) => {
        if (err) return res.status(500).json({ message: 'Erro ao excluir usuário' });
        res.json({ message: 'Usuário excluído com sucesso' });
    });
};
