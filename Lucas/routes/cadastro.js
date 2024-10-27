const express = require("express");
const router = express.Router();
const User = require('../models/UserModel');
const jwt = require('jsonwebtoken');
const authConfig = require('../config/auth.json');

router.post('/', async (req, res) => {
    console.log("Requisição recebida em /cadastro");
    console.log("Dados recebidos no corpo da requisição:", req.body);

    const { Nome, nickname, Email, Senha } = req.body;

    try {
        // Verifica se o email já está cadastrado
        const user = await User.findOne({
            where: { Email: Email }
        });

        if (user) {
            console.log("Erro: Email já cadastrado.");
            return res.status(400).send({ erro: "Email já cadastrado" });
        }

        const novoUsuario = await User.create({
            Nome: Nome,
            nickname: nickname,
            Email: Email,
            Senha: Senha
        });

        console.log("Novo usuário criado:", novoUsuario);

        novoUsuario.Senha = undefined; // Não retorna a senha no JSON de resposta

        // Gera um token JWT
        const token = jwt.sign({ id: novoUsuario.id }, authConfig.secret, {
            expiresIn: 86400, // Expira em 24 horas
        });

        // Retorna a resposta com o novo usuário e o token
        res.status(200).send({ usuario: novoUsuario, token: token });
        console.log("Resposta enviada com sucesso.");
    } catch (err) {
        console.error("Erro ao cadastrar o usuário:", err);
        res.status(400).json({ erro: 'Erro ao cadastrar o usuário.' });
    }
});

module.exports = router;
