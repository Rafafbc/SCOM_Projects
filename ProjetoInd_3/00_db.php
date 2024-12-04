<?php
$host = 'localhost';
$dbname = 'LINCE_ESC_dash';
$user = 'root';  // Usuário do MySQL
$pass = '';  // Senha do MySQL

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro ao conectar: " . $e->getMessage());
}
?>