<?php
include '00_db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome_usuario = $_POST['nome_usuario'];
    $email = $_POST['email'];
    $senha = password_hash($_POST['senha'], PASSWORD_DEFAULT);  // Hash da senha
    $papel = $_POST['papel'];

    // Verificar se o email já existe
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->rowCount() > 0) {
        echo "Este email já está registrado!";
    } else {
        // Inserir novo usuário
        $stmt = $pdo->prepare("INSERT INTO usuarios (nome_usuario, email, senha, papel) VALUES (?, ?, ?, ?)");
        if ($stmt->execute([$nome_usuario, $email, $senha, $papel])) {
            echo "Registrado com sucesso! <a href='02_login.php'>Clique aqui para fazer login</a>";
        } else {
            echo "Erro ao registrar!";
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