document.getElementById('login-form').addEventListener('submit', async function (event) {
    event.preventDefault(); // Evita o envio padrão do formulário

    const email = document.getElementById('email').value;
    const senha = document.getElementById('senha').value;

    const data = { email, senha };

    try {
        const response = await fetch('http://localhost:5000/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });

        if (response.ok) {
            const result = await response.json();
            alert('Login realizado com sucesso!');
            window.location.href = "teste_registro.html"; // Redireciona para a página principal após o login
        } else {
            const error = await response.json();
            document.getElementById('login-error-message').textContent = error.message;
            document.getElementById('login-error-message').style.display = 'block';
        }
    } catch (err) {
        document.getElementById('login-error-message').textContent = 'Erro ao conectar com o servidor.';
        document.getElementById('login-error-message').style.display = 'block';
    }
});
