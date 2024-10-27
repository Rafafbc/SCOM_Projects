const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

// Configuração dos middlewares
app.use(cors());
app.use(bodyParser.json());

console.log("Servidor inicializado e middlewares aplicados.");

// Carregar rotas
const cadastro = require('./Lucas/routes/cadastro');
const login = require('./Lucas/routes/login');
const busca = require('./Lucas/routes/busca');
const deleteUser = require('./Lucas/routes/delete');

// Usar rotas
app.use('/cadastro', cadastro);
app.use('/login', login);
app.use('/busca', busca);
app.use('/delete', deleteUser);

app.listen(PORT, () => {
    console.log(`Servidor Node.js em execução na porta ${PORT}`);
});
