# Instruções Trabalho Individual 1
> Neste projeto, vocês irão desenvolver um site que inclui funcionalidades de login e autenticação, permitindo a criação, exclusão e alteração de perfis de usuários por administradores. Este trabalho vai desafiar vocês a implementar medidas de segurança robustas e a utilizar tecnologias modernas para desenvolver uma aplicação web segura, eficiente e com uma interface amigável.  
Todo trabalho deve acompanhar um vídeo de 5 min apresentando o sistema desenvolvido e um relatório de 7 páginas (sem contar referências), descrevendo seu processo de desenvolvimento, tecnologias utilizadas e dificuldades encontradas. Caso alguma parte do código tenha sido desenvolvida com IA generativa ou obtido de alguma fonte de terceiros, isso deve estar descrito no relatório, com descrição de como o código foi contextualizado dentro do escopo do trabalho.

## Requisitos:
- Desenvolva um projeto com estrutura clara, separando front-end e back-end. Utilize **padrões como MVC (Model-View-Controller)**.
- Implemente **autenticação de usuários com JWT (JSON Web Tokens)** ou **session-based authentication**. - Garanta **acesso diferenciado para contas de admin e usuário**.
- Permita o cadastro de novos usuários com validação de dados no front-end e back-end, utilizando validação de formulários e sanitização de entrada.
- Desenvolva **funcionalidades para que admins possam criar, excluir e editar perfis de usuários**, com interfaces amigáveis e seguras.
- Utilize **HTTPS para comunicação segura**. *Implemente medidas de segurança como*:
  - validação de entrada; 
  - proteção contra SQL Injection;
  - XSS;
  - CSRF.
- **Use um banco de dados relacional** (MySQL, PostgreSQL) para armazenar informações dos usuários e perfis. *Defina relações e constraints adequadas*.
- Criação de **rotinas de back-end** que garantam a performance do sistema.
- Forneça **feedback claro aos usuários**, com mensagens de erro detalhadas e mensagens de sucesso após operações de cadastro, login e edição de perfil.
- Realize **testes de segurança para identificar e corrigir vulnerabilidades**.
- > Documente o código. Inclua comentários explicativos em todo o código.