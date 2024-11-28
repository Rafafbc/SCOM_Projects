<?php
include '00_db.php';
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $senha = $_POST['senha'];

    // Verificar usuário no banco de dados
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
    $stmt->execute([$email]);
    $usuario = $stmt->fetch();

    // Se o usuário for encontrado e a senha for válida
    if ($usuario && password_verify($senha, $usuario['senha'])) {
        // Criar sessão
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['usuario_nome'] = $usuario['nome_usuario'];
        $_SESSION['usuario_papel'] = $usuario['papel']; // Armazenar papel na sessão

        // Verificar a opção "lembre_me"
        if (isset($_POST['lembre_me'])) {
            // Criar cookies para lembrar o login
            $tempo_expiracao = time() + (86400 * 30); // 30 dias
            setcookie("usuario_id", $usuario['id'], $tempo_expiracao, "/");
            setcookie("usuario_nome", $usuario['nome_usuario'], $tempo_expiracao, "/");
            setcookie("usuario_papel", $usuario['papel'], $tempo_expiracao, "/");
        } else {
            // Caso contrário, apagar cookies
            setcookie("usuario_id", "", time() - 3600, "/");
            setcookie("usuario_nome", "", time() - 3600, "/");
            setcookie("usuario_papel", "", time() - 3600, "/");
        }

        // Redirecionar com base no papel
        if ($usuario['papel'] == 'admin') {
            header("Location: 03_dashboard_admin.php");
            exit;
        } else {
            header("Location: 03_dashboard_usuario.php");
            exit;
        }
    } else {
        echo "Email ou senha inválidos!";
    }
}

// Caso o cookie de usuário exista, fazer login automaticamente
if (isset($_COOKIE['usuario_id'])) {
    $usuario_id = $_COOKIE['usuario_id'];

    // Verificar o usuário no banco de dados
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE id = ?");
    $stmt->execute([$usuario_id]);
    $usuario = $stmt->fetch();

    if ($usuario) {
        // Criar sessão
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['usuario_nome'] = $usuario['nome_usuario'];
        $_SESSION['usuario_papel'] = $usuario['papel'];

        // Redirecionar para o dashboard correto
        if ($_SESSION['usuario_papel'] == 'admin') {
            header("Location: 03_dashboard_admin.php");
            exit;
        } else {
            header("Location: 03_dashboard_usuario.php");
            exit;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form method="POST" action="">
        Email: <input type="email" name="email" required><br><br>
        Senha: <input type="password" name="senha" required><br><br>
        <a href="05_solicitar_recuperacao.php">Esqueci minha senha</a><br><br>
        <input type="checkbox" name="lembre_me" value="1"> Lembre de mim<br><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>