### Formação SQL Database Specialist
### Desafio 4 - Parte 2 – Criando gatilhos para cenário de e-commerce 
### arquivo 3 - Arquivo de Inserção de dados
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

-- Inserção de dados
USE streaming;

### Inserindo dados na tabela "users"
CALL ManipularUsers('INSERT', 1, 'JohnDoe', 'johndoe@example.com', 'asx123123');
CALL ManipularUsers('INSERT', 2, 'JaneSmith', 'janesmith@example.com', 'aaaabbb333');
CALL ManipularUsers('INSERT', 3, 'RobertJohnson', 'robertjohnson@example.com', '456123asd');
CALL ManipularUsers('INSERT', 4, 'BobLazar', 'BobLazar@example.com', '123123asd');
CALL ManipularUsers('INSERT', 5, 'LaizaC', 'LaizaC@example.com', '123123QWE');
### Modificando dados na tabela "users"
CALL ManipularUsers('UPDATE', 1, 'John Doe', 'johndoe@example.com', 'asx123123');
CALL ManipularUsers('UPDATE', 2, 'Jane Smith', 'janesmith@example.com', 'aaaabbb333');
CALL ManipularUsers('UPDATE', 3, 'Robert Johnson', 'robertjohnson@example.com', '456123asd');
### Excluindo dados na tabela "views"
CALL ManipularUsers('DELETE', 4, 'BobLazar', 'BobLazar@example.com', '123123asd');

### Inserindo dados na tabela "media"
CALL ManipularMedia('INSERT', 1, 'Aventura Espacial', 'Ação', 2020, 'John Smith');
CALL ManipularMedia('INSERT', 2, 'Segredos do Passado', 'Drama', 2018, 'Emily Johnson');
CALL ManipularMedia('INSERT', 3, 'Loucuras de Verão', 'Comédia', 2019, 'Michael Brown');
CALL ManipularMedia('INSERT', 4, 'Os Mistérios de Paris', 'Drama', 2021, 'Sophia Davis');
CALL ManipularMedia('INSERT', 5, 'No Limite da Escuridão', 'Suspense', 2022, 'John Smith');
CALL ManipularMedia('INSERT', 6, 'Viagem Interdimensional', 'Ficção Científica', 2020, 'Olivia Thompson');

### Inserindo dados na tabela "views"
CALL ManipularViews('INSERT', 1, 1, 1, 30);
CALL ManipularViews('INSERT', 2, 1, 4, 50);
CALL ManipularViews('INSERT', 3, 2, 2, 80);
CALL ManipularViews('INSERT', 4, 2, 5, 10);
CALL ManipularViews('INSERT', 5, 3, 3, 90);
CALL ManipularViews('INSERT', 6, 3, 6, 20);

### Inserindo dados na tabela "favorites"
CALL ManipularFavorites('INSERT', 1, 1, 1);
CALL ManipularFavorites('INSERT', 2, 1, 3);
CALL ManipularFavorites('INSERT', 3, 2, 2);
CALL ManipularFavorites('INSERT', 4, 2, 1);
CALL ManipularFavorites('INSERT', 5, 3, 1);
CALL ManipularFavorites('INSERT', 6, 3, 6);

### Inserindo dados na tabela "history"
CALL ManipularHistory('INSERT', 1, 1, 2);
CALL ManipularHistory('INSERT', 2, 1, 1);
CALL ManipularHistory('INSERT', 3, 2, 3);
CALL ManipularHistory('INSERT', 4, 2, 4);
CALL ManipularHistory('INSERT', 5, 3, 5);
CALL ManipularHistory('INSERT', 6, 3, 1);
CALL ManipularHistory('INSERT', 7, 1, 3);
CALL ManipularHistory('INSERT', 8, 1, 3);