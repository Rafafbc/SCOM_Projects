const express = require("express");
const router = express.Router();
const User = require('../models/UserModel');
const bcrypt = require('bcrypt');

router.post('/', (req, res) => {
    const { Email, Senha } = req.body; // Mantenha a consistência nos nomes

    // Passo 1: Busque o usuário com base no e-mail
    User.findOne({ where: { Email } })
        .then(user => {
            if (user) {
                // Passo 2: Compare a senha fornecida com a senha criptografada no banco de dados
                bcrypt.compare(Senha, user.Senha, (err, result) => { 
                    if (err) {
                        console.error(err);
                        return res.status(500).json({ message: 'Erro no servidor' });
                    }
                    
                    // Removendo a senha antes de enviar a resposta
                    user.Senha = undefined;
                    if (result) {
                        const { dataValues: userData } = user;
                        return res.status(200).json({ user: userData }); // Usuário autenticado
                    } else {
                        return res.status(401).json({ message: 'Credenciais inválidas' }); // Senha incorreta
                    }
                });
            } else {
                return res.status(401).json({ message: 'Credenciais inválidas' }); // Usuário não encontrado
            }
        })
        .catch(error => {
            console.error(error);
            return res.status(500).json({ message: 'Erro no servidor' });
        });
});

module.exports = router;
