const express = require('express');
const router = express.Router();
const User = require('../models/UserModel');
const jwt = require('jsonwebtoken');
const authConfig = require('../config/auth.json');

// Rota para criar um novo usuário
router.post('/create', async (req, res) => {
    const { Nome, Email, Senha, Cargo } = req.body;

    try {
        // Verifica se o email já está cadastrado
        const existingUser = await User.findOne({ where: { Email } });

        if (existingUser) {
            return res.status(400).json({ erro: 'Email já cadastrado' });
        }

        const newUser = await User.create({
            Nome,
            Email,
            Senha,
            Cargo
        });

        res.status(201).json(newUser);
    } catch (err) {
        res.status(500).json({ erro: 'Erro ao criar usuário' });
    }
});

// Rota para listar todos os usuários
router.get('/list', async (req, res) => {
    try {
        const users = await User.findAll();
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ erro: 'Erro ao listar usuários' });
    }
});

// Rota para editar um usuário
router.put('/edit/:id', async (req, res) => {
    const { id } = req.params;
    const { Nome, Email, Cargo } = req.body;

    try {
        const user = await User.findByPk(id);

        if (!user) {
            return res.status(404).json({ erro: 'Usuário não encontrado' });
        }

        user.Nome = Nome;
        user.Email = Email;
        user.Cargo = Cargo;

        await user.save();

        res.status(200).json(user);
    } catch (err) {
        res.status(500).json({ erro: 'Erro ao editar usuário' });
    }
});

// Rota para deletar um usuário
router.delete('/delete/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const user = await User.findByPk(id);

        if (!user) {
            return res.status(404).json({ erro: 'Usuário não encontrado' });
        }

        await user.destroy();

        res.status(200).json({ message: 'Usuário deletado com sucesso' });
    } catch (err) {
        res.status(500).json({ erro: 'Erro ao deletar usuário' });
    }
});

module.exports = router;
