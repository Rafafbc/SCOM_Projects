<?php
    // Dados da conexão com o banco de dados
    $localhost = "localhost";
    $user = "root";
    $passw = "";
    $banco = "micro_receitas";

    // Estabelecendo a conexão
    $conecta = mysqli_connect($localhost, $user, $passw, $banco);

    // Verificando se a conexão foi bem-sucedida
    if (!$conecta) {
        die("Falha na conexão: " . mysqli_connect_error());
    }

    // Verificando se o formulário foi submetido
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Capturando os dados do formulário
        $nome = mysqli_real_escape_string($conecta, $_POST['nome']);
        $email = mysqli_real_escape_string($conecta, $_POST['email']);
        $senha = mysqli_real_escape_string($conecta, $_POST['senha']);
        $confirmar_senha = $_POST['confirmar_senha'];
        $conhecimentos = isset($_POST['conhecimentos']) ? implode(", ", $_POST['conhecimentos']) : "";
        $sobre_voce = mysqli_real_escape_string($conecta, $_POST['sobre_voce']);
        $termos = isset($_POST['termos']) ? 1 : 0;  // Se aceitou os termos, define como 1, senão 0

        // Verificando se as senhas coincidem
        if ($senha !== $confirmar_senha) {
            echo "As senhas não coincidem!";
            exit;
        }

        // Criptografando a senha para armazená-la de forma segura
        $senha_hash = password_hash($senha, PASSWORD_DEFAULT);

        // SQL para inserir os dados na tabela
        $sql = "INSERT INTO usuarios (nome, email, senha, conhecimentos, sobre_voce, termos)
                VALUES ('$nome', '$email', '$senha_hash', '$conhecimentos', '$sobre_voce', '$termos')";

        // Executando o comando SQL
        if (mysqli_query($conecta, $sql)) {
            echo "Novo registro criado com sucesso!";
            header("Location: login.html");
        } else {
            echo "Erro: " . $sql . "<br>" . mysqli_error($conecta);
        }
    }

    // Fechando a conexão com o banco de dados
    mysqli_close($conecta);
?>
