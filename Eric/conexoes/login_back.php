<?php
if (isset($_POST['email']) && !empty($_POST['email']) && isset($_POST['senha']) && !empty($_POST['senha'])) {

    require 'conexao2.php';
    require 'usuario.class.php';

    $u = new usuario();

    $email = addslashes($_POST['email']);
    $senha = addslashes($_POST['senha']);

    if ($u->login($email, $senha)) {
        if (isset($_SESSION['id'])) {
            header("Location: cozinha.php");
        }
    } else {
        header("Location: login.html");
    }

} else {
    header("Location: login.html");
}
?>
