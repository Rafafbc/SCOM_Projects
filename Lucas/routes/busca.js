const express = require("express");
const router = express.Router();
const User = require('../models/UserModel');

// Rota para buscar todos os usuários
router.get('/', async (req, res) => {
    try {
        const users = await User.findAll(); // Busca todos os usuários do banco de dados
        res.status(200).json(users); // Retorna os usuários em formato JSON
    } catch (err) {
        console.log(err);
        res.status(500).json({ erro: 'Erro ao buscar os usuários.' });
    }
});

module.exports = router;
