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
                    user.Senha = undefined; // Corrigido para user.Senha
                    if (result) {
                        // Adicione o cargo à resposta
                        const { Cargo, ...userData } = user.dataValues; // Supondo que você esteja usando Sequelize
                        return res.status(200).json({ user: userData, Cargo }); // Usuário autenticado com cargo
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
