### Formação SQL Database Specialist
### Desafio 4 - Parte 2 – Criando gatilhos para cenário de e-commerce 
### arquivo 2 - Arquivo de Procedures e Triggers
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

-- PROCEDURES:					
											
### Procedure para inserir, atualizar ou excluir dados na tabela "users"
DELIMITER //	
CREATE PROCEDURE ManipularUsers(
    IN acao VARCHAR(10),
    IN userID INT,
    IN nameuser VARCHAR(20),
    IN newemail VARCHAR(255),
    IN npassword VARCHAR(10)
)
BEGIN
    IF acao = 'INSERT' THEN															 -- Verifica a ação desejada
        
        INSERT INTO users (idUser, username, email, password) 						-- Insere novo registro na tabela "users"
        VALUES (userID, nameuser, newemail, npassword);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE users SET username = nameuser, email = newemail, 					-- Atualiza informações de um usuário existente na tabela "users"
        password = npassword WHERE idUser = userID;
    ELSEIF acao = 'DELETE' THEN														 -- Deleta um usuário da tabela "users"
        DELETE FROM users WHERE idUser = userID;
    ELSE
        SELECT 'Ação inválida!';													-- Retorna mensagem de ação inválida
    END IF;
END;
//


###Procedure para inserir, atualizar ou excluir dados na tabela "media"
CREATE PROCEDURE ManipularMedia(
    IN acao VARCHAR(10),
    IN idMedia INT,
    IN title VARCHAR(255),
    IN genre VARCHAR(255),
    IN releaseYear INT,
    IN author VARCHAR(100)
)
BEGIN
    
    -- Verifica ação a ser executada
    IF acao = 'INSERT' THEN
        INSERT INTO media (idMedia, title, genre, releaseYear, author) VALUES (idMedia, title, genre, releaseYear, author);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE media SET title = NEW.title, genre = NEW.genre, releaseYear = NEW.releaseYear, author = NEW.author WHERE idMedia = idMedia;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM media WHERE idMedia = idMedia;
    ELSE
        SELECT 'Ação inválida!';
    END IF;
    
END;
//

### Procedure para inserir, atualizar ou excluir dados na tabela "views"
CREATE PROCEDURE ManipularViews(
    IN acao VARCHAR(10),
    IN idView INT,
    IN idUser INT,
    IN idMedia INT,
    IN progress INT
)
BEGIN
    
    -- Verifica ação a ser executada
    IF acao = 'INSERT' THEN
        INSERT INTO views (idView, idUser, idMedia, progress) VALUES (idView, idUser, idMedia, progress);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE views SET idUser = NEW.idUser, idMedia = NEW.idMedia, progress = NEW.progress WHERE idView = idView;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM views WHERE idView = idView;
    ELSE
        SELECT 'Ação inválida!';
    END IF;
    
END;
//

###Procedure para inserir, atualizar ou excluir dados na tabela "favorites"
CREATE PROCEDURE ManipularFavorites(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN nidFavorite INT,
    IN nidUser INT,
    IN nidMedia INT
)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    -- Verifica ação a ser executada
    IF acao = 'INSERT' THEN
        INSERT INTO favorites (idFavorite, idUser, idMedia) VALUES (nidFavorite, nidUser, nidMedia);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE favorites SET idUser = nidUser, idMedia = nidMedia WHERE idFavorite = nidFavorite;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM favorites WHERE idFavorite = nidFavorite;
    ELSE
        SELECT 'Ação inválida!';
    END IF;
    SET SQL_SAFE_UPDATES = 1;
END;
//

###Procedure para inserir, atualizar ou excluir dados na tabela "history"
CREATE PROCEDURE ManipularHistory(
    IN acao VARCHAR(10), -- 'INSERT', 'UPDATE' ou 'DELETE'
    IN nidHistory INT,
    IN nidUser INT,
    IN nidMedia INT
)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    -- Verifica ação a ser executada
    IF acao = 'INSERT' THEN
        INSERT INTO history (idHistory, idUser, idMedia) VALUES (nidHistory, nidUser, nidMedia);
    ELSEIF acao = 'UPDATE' THEN
        UPDATE history SET idUser = nidUser, idMedia = nidMedia WHERE idHistory = nidHistory;
    ELSEIF acao = 'DELETE' THEN
        DELETE FROM history WHERE idHistory = nidHistory;
    ELSE
        SELECT 'Ação inválida!';
    END IF;
    SET SQL_SAFE_UPDATES = 1;
END;
//
DELIMITER ;



-- TRIGGERS:	

###Trigger de segurança (before update) na tabela "users"
DELIMITER //
CREATE TRIGGER before_users_update		
-- Esta trigger é acionada antes de uma operação de atualização (UPDATE) na tabela "users".
-- Ela é usada para registrar a ação de atualização na tabela de log de auditoria.
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Quando a trigger é acionada, a ação de atualização, o ID do usuário antigo (OLD.idUser),
    -- o nome de usuário antigo (OLD.username) e o carimbo de data/hora atual (NOW()) são inseridos na tabela de log.
    INSERT INTO users_audit_log (action, user_id, username, timestamp)
    VALUES ('UPDATE', OLD.idUser, OLD.username, NOW());
END;
//
DELIMITER ;


### Trigger de remoção (before delete) na tabela "users"
DELIMITER //
CREATE TRIGGER before_users_delete
-- Esta trigger é acionada antes de uma operação de exclusão (DELETE) na tabela "users".
-- Ela é usada para registrar a ação de exclusão na tabela de log de auditoria.
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    -- Quando a trigger é acionada, a ação de exclusão, o ID do usuário antigo (OLD.idUser),
    -- o nome de usuário antigo (OLD.username) e o carimbo de data/hora atual (NOW()) são inseridos na tabela de log.
    INSERT INTO users_audit_log (action, user_id, username, timestamp)
    VALUES ('delete', OLD.idUser, OLD.username, NOW());
END;
//
DELIMITER ;
