<?php
// Inclui o arquivo '00_db.php' que contém a configuração de conexão com o banco de dados ($pdo)
include '00_db.php';

// Verifica se o método da requisição é POST, garantindo que o código seja executado somente em submissões de formulários
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Coleta os dados enviados pelo formulário
    $nome_usuario = $_POST['nome_usuario']; // Nome do usuário
    $email = $_POST['email'];               // Email do usuário
    $senha = password_hash($_POST['senha'], PASSWORD_DEFAULT);  // Gera um hash seguro da senha
    $papel = $_POST['papel'];               // Papel ou função do usuário

    // Verifica se o email já existe no banco de dados, para evitar duplicidade
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->rowCount() > 0) { // Se o email já está registrado
        echo "Este email já está registrado!";
    } else {
        // Insere um novo usuário na tabela 'usuarios' com os dados fornecidos
        $stmt = $pdo->prepare("INSERT INTO usuarios (nome_usuario, email, senha, papel) VALUES (?, ?, ?, ?)");
        // Executa a inserção e verifica se foi bem-sucedida
        if ($stmt->execute([$nome_usuario, $email, $senha, $papel])) {
            echo "Registrado com sucesso! <a href='02_login.php'>Clique aqui para fazer login</a>";
        } else {
            echo "Erro ao registrar!"; // Exibe uma mensagem de erro se a inserção falhar
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
</head>
<body>
    <h2>Registro</h2>
    <form method="POST" action="">
        Nome de usuário: <input type="text" name="nome_usuario" required><br><br>
        Email: <input type="email" name="email" required><br><br>
        Senha: <input type="password" name="senha" required><br><br>
        Papel: <input type="text" name="papel" placeholder="'admin' ou 'usuario'" required><br><br>
        <input type="submit" value="Registrar">
    </form>
</body>
</html>