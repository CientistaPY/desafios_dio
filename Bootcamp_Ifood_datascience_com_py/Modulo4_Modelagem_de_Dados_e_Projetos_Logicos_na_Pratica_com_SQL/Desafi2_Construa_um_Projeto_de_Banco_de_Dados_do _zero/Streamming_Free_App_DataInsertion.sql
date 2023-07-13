### Potência Tech powered by iFood | Ciências de Dados com Python
### Desafio 2 - Construa um Projeto Lógico de Banco de Dados do Zero
### PARTE 3 -  Criação de Arquivo para Inserção de Dados para um aplicativo gratuito de Streaminng
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]



#### Inserindo dados na tabela "users"
INSERT INTO users (username, email, password)
VALUES
    ('JohnDoe', 'johndoe@example.com', 'asx123123'), 							-- Usuário 1
    ('JaneSmith', 'janesmith@example.com', 'aaaabbb333'), 						-- Usuário 2
    ('RobertJohnson', 'robertjohnson@example.com', '456123asd'); 				-- Usuário 3


#### Inserindo dados na tabela "media"
INSERT INTO media (title, genre, releaseYear, author)
VALUES
    ('Aventura Espacial', 'Ação', 2020, 'John Smith'), 							-- Filme 1
    ('Segredos do Passado', 'Drama', 2018, 'Emily Johnson'), 					-- Filme 2
    ('Loucuras de Verão', 'Comédia', 2019, 'Michael Brown'), 					-- Filme 3
    ('Os Mistérios de Paris', 'Drama', 2021, 'Sophia Davis'), 					-- Série 1
    ('No Limite da Escuridão', 'Suspense', 2022, 'John Smith'), 				-- Série 2
    ('Viagem Interdimensional', 'Ficção Científica', 2020, 'Olivia Thompson'); 	-- Série 3



#### Inserindo dados na tabela "views"
INSERT INTO views (idUser, idMedia, progress)
VALUES
    (1, 1, 30), 																-- Visualização 1 do Usuário 1
    (1, 4, 50), 																-- Visualização 2 do Usuário 1
    (2, 2, 80), 																-- Visualização 1 do Usuário 2
    (2, 5, 10), 																-- Visualização 2 do Usuário 2
    (3, 3, 90), 																-- Visualização 1 do Usuário 3
    (3, 6, 20),  																-- Visualização 2 do Usuário 3
	(3, 2, 99);  																-- Visualização 3 do Usuário 4
#### Inserindo dados na tabela "favorites"
INSERT INTO favorites (idUser, idMedia)
VALUES
    (1, 1),  																	-- Favorito 1 do Usuário 1
    (1, 3),  																	-- Favorito 2 do Usuário 1
    (2, 2),   																	-- Favorito 1 do Usuário 2
	(2, 1),   																	-- Favorito 1 do Usuário 2
    (3, 1),   																	-- Favorito 1 do Usuário 3
    (3, 6);   																	-- Favorito 2 do Usuário 3

#### Inserindo dados na tabela "history"
INSERT INTO history (idUser, idMedia)
VALUES
    (1, 2),   																	-- Histórico 1 do Usuário 1
    (1, 1),   																	-- Histórico 2 do Usuário 2
    (2, 3),   																	-- Histórico 1 do Usuário 2
    (2, 4),   																	-- Histórico 2 do Usuário 2
    (3, 5),   																	-- Histórico 1 do Usuário 3
    (3, 1),   																	-- Histórico 1 do Usuário 3
	(1, 3),   																	-- Histórico 2 do Usuário 3
    (1, 3);   																	-- Histórico 3 do Usuário 3