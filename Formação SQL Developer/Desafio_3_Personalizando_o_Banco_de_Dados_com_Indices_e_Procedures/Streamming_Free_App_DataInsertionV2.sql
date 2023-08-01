### Formação SQL Database Specialist
### Desafio 3 - Personalizando o Banco de Dados com Índices e Procedures
### PARTE 3 -  Criação de Arquivo para Inserção de Dados para um aplicativo gratuito de Streaminng usando Procedure
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

USE streaming;

DELIMITER //

-- Procedure para inserir, atualizar ou excluir dados na tabela "users"
CREATE PROCEDURE ManipularUsers(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN idUser INT,
    IN username VARCHAR(20),
    IN email VARCHAR(255),
    IN password VARCHAR(10)
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    IF acao = 'INSERT' THEN
        INSERT INTO users (idUser, username, email, password) VALUES (idUser, username, email, password);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE users SET username = username, email = email, password = password WHERE idUser = idUser;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM users WHERE idUser = idUser;
    ELSE
        SELECT 'Ação inválida!';
    END IF;
    SET SQL_SAFE_UPDATES = 1;
END;
//

-- Procedure para inserir, atualizar ou excluir dados na tabela "media"
CREATE PROCEDURE ManipularMedia(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN idMedia INT,
    IN title VARCHAR(255),
    IN genre VARCHAR(255),
    IN releaseYear INT,
    IN author VARCHAR(100)
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    IF acao = 'INSERT' THEN
        INSERT INTO media (idMedia, title, genre, releaseYear, author) VALUES (idMedia, title, genre, releaseYear, author);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE media SET title = title, genre = genre, releaseYear = releaseYear, author = author WHERE idMedia = idMedia;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM media WHERE idMedia = idMedia;
    ELSE
        SELECT 'Ação inválida!';
	SET SQL_SAFE_UPDATES = 1;
    END IF;
END;
//

-- Procedure para inserir, atualizar ou excluir dados na tabela "views"
CREATE PROCEDURE ManipularViews(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN idView INT,
    IN idUser INT,
    IN idMedia INT,
    IN progress INT
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    IF acao = 'INSERT' THEN
        INSERT INTO views (idView, idUser, idMedia, progress) VALUES (idView, idUser, idMedia, progress);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE views SET idUser = idUser, idMedia = idMedia, progress = progress WHERE idView = idView;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM views WHERE idView = idView;
    ELSE
        SELECT 'Ação inválida!';
	SET SQL_SAFE_UPDATES = 1;
    END IF;
END;
//

-- Procedure para inserir, atualizar ou excluir dados na tabela "favorites"
CREATE PROCEDURE ManipularFavorites(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN idFavorite INT,
    IN idUser INT,
    IN idMedia INT
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    IF acao = 'INSERT' THEN
        INSERT INTO favorites (idFavorite, idUser, idMedia) VALUES (idFavorite, idUser, idMedia);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE favorites SET idUser = idUser, idMedia = idMedia WHERE idFavorite = idFavorite;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM favorites WHERE idFavorite = idFavorite;
    ELSE
        SELECT 'Ação inválida!';
	SET SQL_SAFE_UPDATES = 1;
    END IF;
END;
//

-- Procedure para inserir, atualizar ou excluir dados na tabela "history"
CREATE PROCEDURE ManipularHistory(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN idHistory INT,
    IN idUser INT,
    IN idMedia INT
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    IF acao = 'INSERT' THEN
        INSERT INTO history (idHistory, idUser, idMedia) VALUES (idHistory, idUser, idMedia);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE history SET idUser = idUser, idMedia = idMedia WHERE idHistory = idHistory;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM history WHERE idHistory = idHistory;
    ELSE
        SELECT 'Ação inválida!';
	SET SQL_SAFE_UPDATES = 1;
    END IF;
END;
//

DELIMITER ;

-- Agora, vamos chamar as novas procedures para inserir, atualizar e excluir os dados do código original:

USE streaming;

-- Inserindo dados na tabela "users"
CALL ManipularUsers('INSERT', 1, 'JohnDoe', 'johndoe@example.com', 'asx123123');
CALL ManipularUsers('INSERT', 2, 'JaneSmith', 'janesmith@example.com', 'aaaabbb333');
CALL ManipularUsers('INSERT', 3, 'RobertJohnson', 'robertjohnson@example.com', '456123asd');

-- Modificando dados na tabela "users"
CALL ManipularUsers('UPDATE', 1, 'John Doe', 'johndoe@example.com', 'asx123123');
CALL ManipularUsers('UPDATE', 2, 'Jane Smith', 'janesmith@example.com', 'aaaabbb333');
CALL ManipularUsers('UPDATE', 3, 'Robert Johnson', 'robertjohnson@example.com', '456123asd');

-- Inserindo dados na tabela "media"
CALL ManipularMedia('INSERT', 1, 'Aventura Espacial', 'Ação', 2020, 'John Smith');
CALL ManipularMedia('INSERT', 2, 'Segredos do Passado', 'Drama', 2018, 'Emily Johnson');
CALL ManipularMedia('INSERT', 3, 'Loucuras de Verão', 'Comédia', 2019, 'Michael Brown');
CALL ManipularMedia('INSERT', 4, 'Os Mistérios de Paris', 'Drama', 2021, 'Sophia Davis');
CALL ManipularMedia('INSERT', 5, 'No Limite da Escuridão', 'Suspense', 2022, 'John Smith');
CALL ManipularMedia('INSERT', 6, 'Viagem Interdimensional', 'Ficção Científica', 2020, 'Olivia Thompson');

-- Inserindo dados na tabela "views"
CALL ManipularViews('INSERT', 1, 1, 1, 30);
CALL ManipularViews('INSERT', 2, 1, 4, 50);
CALL ManipularViews('INSERT', 3, 2, 2, 80);
CALL ManipularViews('INSERT', 4, 2, 5, 10);
CALL ManipularViews('INSERT', 5, 3, 3, 90);
CALL ManipularViews('INSERT', 6, 3, 6, 20);
CALL ManipularViews('INSERT', 7, 3, 2, 99);

-- Excluindo dados na tabela "views"
CALL ManipularViews('DELETE', 7, 3, 2, 99);

-- Inserindo dados na tabela "favorites"
CALL ManipularFavorites('INSERT', 1, 1, 1);
CALL ManipularFavorites('INSERT', 2, 1, 3);
CALL ManipularFavorites('INSERT', 3, 2, 2);
CALL ManipularFavorites('INSERT', 4, 2, 1);
CALL ManipularFavorites('INSERT', 5, 3, 1);
CALL ManipularFavorites('INSERT', 6, 3, 6);

-- Inserindo dados na tabela "history"
CALL ManipularHistory('INSERT', 1, 1, 2);
CALL ManipularHistory('INSERT', 2, 1, 1);
CALL ManipularHistory('INSERT', 3, 2, 3);
CALL ManipularHistory('INSERT', 4, 2, 4);
CALL ManipularHistory('INSERT', 5, 3, 5);
CALL ManipularHistory('INSERT', 6, 3, 1);
CALL ManipularHistory('INSERT', 7, 1, 3);
CALL ManipularHistory('INSERT', 8, 1, 3);


