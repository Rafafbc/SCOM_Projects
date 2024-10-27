const express = require("express");
const router = express.Router();
const User = require('../models/UserModel');
const bcrypt = require('bcrypt');

router.post('/', (req, res) => {
    console.log("Requisição recebida em /login");
    console.log("Dados recebidos no corpo da requisição:", req.body);

    const { email, senha } = req.body; // Ajuste para minúsculas, igual ao frontend

    // Verifica se o e-mail foi recebido corretamente
    if (!email || !senha) {
        console.warn("Email ou senha não fornecidos na requisição.");
        return res.status(400).json({ message: 'Email e senha são obrigatórios.' });
    }

    // Passo 1: Busque o usuário com base no e-mail
    User.findOne({ where: { Email: email } }) // Certifique-se de que o campo no modelo de usuário está correto
        .then(user => {
            if (user) {
                console.log("Usuário encontrado:", user.dataValues);

                // Passo 2: Compare a senha fornecida com a senha criptografada no banco de dados
                bcrypt.compare(senha, user.Senha, (err, result) => { 
                    if (err) {
                        console.error("Erro ao comparar senha:", err);
                        return res.status(500).json({ message: 'Erro no servidor' });
                    }

                    if (result) {
                        console.log("Autenticação bem-sucedida.");

                        // Removendo a senha antes de enviar a resposta
                        user.Senha = undefined;
                        const { dataValues: userData } = user;
                        return res.status(200).json({ user: userData }); // Usuário autenticado
                    } else {
                        console.warn("Senha incorreta fornecida.");
                        return res.status(401).json({ message: 'Credenciais inválidas' }); // Senha incorreta
                    }
                });
            } else {
                console.warn("Usuário não encontrado para o email:", email);
                return res.status(401).json({ message: 'Credenciais inválidas' }); // Usuário não encontrado
            }
        })
        .catch(error => {
            console.error("Erro ao buscar usuário no banco de dados:", error);
            return res.status(500).json({ message: 'Erro no servidor' });
        });
});

module.exports = router;
