const express = require("express");
const router = express.Router();
const User = require('../models/UserModel');

// Rota para deletar um usuário
router.delete('/:id', async (req, res) => {
    const { id } = req.params;

    try {
        // Busca o usuário pelo ID
        const user = await User.findByPk(id);

        // Se o usuário não for encontrado, retorna um erro
        if (!user) {
            return res.status(404).json({ erro: 'Usuário não encontrado.' });
        }

        // Exclui o usuário
        await user.destroy();

        // Retorna uma mensagem de sucesso
        res.status(200).json({ mensagem: 'Usuário excluído com sucesso.' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ erro: 'Erro ao excluir o usuário.' });
    }
});

module.exports = router;
