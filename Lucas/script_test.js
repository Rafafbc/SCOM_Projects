document.getElementById('register-form').addEventListener('submit', async function (event) {
    event.preventDefault();

    // Captura os valores do formulário
    const Nome = document.getElementById('nome').value;
    const Nickname = document.getElementById('nick').value;
    const Email = document.getElementById('email').value;
    const Senha = document.getElementById('senha').value;
    const confirmarSenha = document.getElementById('confirmar_senha').value;

    // Verifica se as senhas coincidem
    if (Senha !== confirmarSenha) {
        alert("As senhas não coincidem. Por favor, tente novamente.");
        return;
    }

    // Monta o objeto com os dados do formulário
    const data = { Nome, Nickname, Email, Senha };

    try {
        // Faz a requisição para o servidor
        const response = await fetch('http://localhost:5000/cadastro', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });

        // Verifica a resposta do servidor
        if (response.ok) {
            alert('Conta criada com sucesso!');
           // window.location.href = "teste_login.html"; // Redireciona para a página principal
        } else {
            const error = await response.json();
            document.getElementById('register-error-message').textContent = error.erro;
            document.getElementById('register-error-message').style.display = 'block';
        }
    } catch (err) {
        console.error('Erro:', err);
        document.getElementById('register-error-message').textContent = 'Erro ao conectar com o servidor.';
        document.getElementById('register-error-message').style.display = 'block';
    }
});
