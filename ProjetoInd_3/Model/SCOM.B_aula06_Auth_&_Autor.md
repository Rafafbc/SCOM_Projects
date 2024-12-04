# Criação de um Database para Adicione autorização no exemplo de autenticação
```SQL
CREATE DATABASE IF NOT EXISTS autho_and_authen;

USE autho_and_authen;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    papel ENUM('admin', 'usuario') DEFAULT 'usuario', -- campo de autorização
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```