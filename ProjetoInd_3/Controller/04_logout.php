<?php
session_start();

// Exclue os cookies
setcookie("usuario_id", "", time() - 3600, "/"); // Expira o cookie
setcookie("usuario_nome", "", time() - 3600, "/"); // Expira o cookie

// Destroi a sessão
session_unset();
session_destroy();

// Redireciona para a página de Login
header("Location: 02_login.php");
exit;
?>