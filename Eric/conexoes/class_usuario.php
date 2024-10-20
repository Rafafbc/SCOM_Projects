<?php
class usuario {
    
    public function login($email, $senha) {
        global $pdo;

        $sql = "SELECT * FROM usuarios WHERE email = :email";
        $sql = $pdo->prepare($sql);
        $sql->bindParam(":email", $email);
        $sql->execute();

        if ($sql->rowCount() > 0) {
            $dado = $sql->fetch();
            if (password_verify($senha, $dado['senha'])) {
                $_SESSION['id'] = $dado['id'];
                $_SESSION['nome'] = $dado['nome'];
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}
?>
