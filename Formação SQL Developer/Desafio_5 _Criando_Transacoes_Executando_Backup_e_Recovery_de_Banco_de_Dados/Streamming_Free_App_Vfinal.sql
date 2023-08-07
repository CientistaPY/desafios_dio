### Formação SQL Database Specialist
### Desafio 5 - Criando Transações, Executando Backup e Recovery de Banco de Dados
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

### blcoo de Tables e definição o DB Streaming

-- Criação do banco de dados

DROP DATABASE IF EXISTS streaming;
CREATE DATABASE streaming;
USE streaming;

-- Tabela usuário
CREATE TABLE users (
    idUser INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(10) NOT NULL
);

ALTER TABLE users AUTO_INCREMENT = 1;

-- Tabela mídia
CREATE TABLE media (
    idMedia INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(255) NOT NULL,
    releaseYear INT NOT NULL,
    author VARCHAR(100)
);

ALTER TABLE media AUTO_INCREMENT = 1;

-- Tabela visualização
CREATE TABLE views (
    idView INT AUTO_INCREMENT PRIMARY KEY,
    idUser INT,
    idMedia INT,
    progress INT DEFAULT 0,
	CONSTRAINT fk_views_user FOREIGN KEY (idUser) REFERENCES users(idUser) ,
    CONSTRAINT fk_views_media FOREIGN KEY (idMedia) REFERENCES media(idMedia)
);

ALTER TABLE views AUTO_INCREMENT = 1;


#### Tabela de LOG
CREATE TABLE users_audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,				-- O log_id é um campo de chave primária autoincremental para identificar cada registro de log.
    action VARCHAR(10),									-- O campo action armazenará a ação realizada, que pode ser "delete" ou "update"
    user_id INT,										-- O campo user_id armazenará o ID do usuário afetado pela ação.
    username varchar(20),
    timestamp TIMESTAMP									-- O campo timestamp armazenará a data e hora da ação.
);

ALTER TABLE users_audit_log AUTO_INCREMENT = 1;

#### Tabela favoritos
CREATE TABLE favorites (
    idFavorite INT AUTO_INCREMENT PRIMARY KEY, 			-- ID do favorito
    idUser INT, 										-- ID do usuário associado ao favorito
    idMedia INT, 										-- ID da mídia associada ao favorito
    CONSTRAINT fk_favorites_user FOREIGN KEY (idUser)
    REFERENCES users(idUser) ON UPDATE CASCADE, 		-- Chave estrangeira para associar o usuário
    CONSTRAINT fk_favorites_media FOREIGN KEY (idMedia)
    REFERENCES media(idMedia) ON UPDATE CASCADE 		-- Chave estrangeira para associar a mídia
);

ALTER TABLE favorites AUTO_INCREMENT = 1;

#### Tabela histórico
CREATE TABLE history (
    idHistory INT AUTO_INCREMENT PRIMARY KEY, 			-- ID do histórico
    idUser INT,											-- ID do usuário associado ao histórico
    idMedia INT, 										-- ID da mídia associada ao histórico
    CONSTRAINT fk_history_user FOREIGN KEY (idUser)
    REFERENCES users(idUser) ON UPDATE CASCADE, 		-- Chave estrangeira para associar o usuário
    CONSTRAINT fk_history_media FOREIGN KEY (idMedia)
    REFERENCES media(idMedia) ON UPDATE CASCADE 		-- Chave estrangeira para associar a mídia
);

ALTER TABLE history AUTO_INCREMENT = 1;


### Parte 2 - Blocos de Transation, Procedures e Triggers

SAVEPOINT savepoint_part_two																-- Criar um ponto de salvamento (savepoint)

DELIMITER //	
CREATE PROCEDURE TransactionWithRollback(													-- Procedure para inserir, atualizar ou excluir dados nas tabela
    IN acao VARCHAR(10),
	IN tableName VARCHAR(20),
    IN tableUser INT,
    IN valor1 VARCHAR(100),
    IN valor2 VARCHAR(100),
    IN valor3 VARCHAR(100),
	IN valor4 VARCHAR(100)
)
            
BEGIN
	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION													-- Verificar se há erro e executar o ROLLBACK até o savepoint em caso de erro
    BEGIN
        ROLLBACK TO savepoint_part_two;
        SELECT 'Erro detectado. Transação foi desfeita.' AS ErrorMessage;
    END;

    START TRANSACTION; 																		-- Iniciar a transação
	CASE tableName
		WHEN 'users' THEN
			IF acao = 'INSERT' THEN															-- Verifica a ação desejada	
				INSERT INTO users (idUser, username, email, password) 						-- Insere novo registro na tabela "users"
				VALUES (tableUser, valor1, valor2, valor3);
			ELSEIF acao = 'UPDATE' THEN
				UPDATE users SET username = valor1, email = valor2, 						-- Atualiza informações de um usuário existente na tabela
				password = valor3 WHERE idUser = tableUser;
			ELSEIF acao = 'DELETE' THEN														
				DELETE FROM users WHERE idUser = tableUser;									-- Deleta um usuário da tabela 
			ELSE
				SELECT 'Ação inválida!';													-- Retorna mensagem de ação inválida
			END IF;
            
		WHEN 'media' THEN                                                                   -- CASE para inserir, atualizar ou excluir dados na tabela "media"
			IF acao = 'INSERT' THEN
				INSERT INTO media (idMedia, title, genre, releaseYear, author) 
                VALUES (tableUser, valor1, valor2, valor3, valor4);
			ELSEIF acao = 'UPDATE' THEN
				UPDATE media SET title = valor1, genre = valor2, releaseYear = valor3, author = valor4 
                WHERE idMedia = tableUser;
			ELSEIF acao = 'DELETE' THEN
				DELETE FROM media WHERE idMedia = nidMedia;
			ELSE
				SELECT 'Ação inválida!';
			END IF;  
            
		WHEN 'views' THEN                                                                 		-- CASE para inserir, atualizar ou excluir dados na tabela "views"
			IF acao = 'INSERT' THEN
				INSERT INTO views (idView, idUser, idMedia, progress) 
                VALUES (tableUser, valor1, valor2, valor3);
			ELSEIF acao = 'UPDATE' THEN
				UPDATE views SET idUser = valor1, idUser = valor2, 
                progress = valor3
                WHERE idView = tableUser;
			ELSEIF acao = 'DELETE' THEN
				DELETE FROM views WHERE idviews = tableUser;
			ELSE
				SELECT 'Ação inválida!';
			END IF; 
            
		WHEN 'favorites' THEN                                                                 	-- CASE para inserir, atualizar ou excluir dados na tabela "favorites"  
			IF acao = 'INSERT' THEN
				INSERT INTO favorites (idFavorite, idUser, idMedia) 
                VALUES (tableUser, valor1, valor2);
			ELSEIF acao = 'UPDATE' THEN
				UPDATE favorites SET idUser = valor1, idMedia = valor2 
                WHERE idFavorite = tableUser;
			ELSEIF acao = 'DELETE' THEN
				DELETE FROM favorites WHERE idFavorite = tableUser;
			ELSE
				SELECT 'Ação inválida!';
			END IF;
            
		WHEN 'history' THEN                                                            	    	-- CASE para inserir, atualizar ou excluir dados na tabela "history"    
			IF acao = 'INSERT' THEN
				INSERT INTO history (idHistory, idUser, idMedia) 
                VALUES (tableUser, valor1, valor2);
			ELSEIF acao = 'UPDATE' THEN
				UPDATE history SET idUser = valor1, idMedia = valor2 
                WHERE idHistory = tableUser;
			ELSEIF acao = 'DELETE' THEN
				DELETE FROM history WHERE idHistory = tableUser;
			ELSE
				SELECT 'Ação inválida!';
			END IF;
		ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tabela inválida!';
    END CASE;

    COMMIT; -- Confirmar a transação
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


### Parte 3 - Blocos de de Inserção de dados

### Inserindo dados na tabela "users"
CALL TransactionWithRollback('INSERT', 'users', 1, 'JohnDoe', 'johndoe@example.com', 'asx123123', NULL);
CALL TransactionWithRollback('INSERT', 'users', 2, 'JaneSmith', 'janesmith@example.com', 'aaaabbb333', NULL);
CALL TransactionWithRollback('INSERT', 'users', 3, 'RobertJohnson', 'robertjohnson@example.com', '456123asd', NULL);
CALL TransactionWithRollback('INSERT', 'users', 4, 'BobLazar', 'BobLazar@example.com', '123123asd', NULL);
CALL TransactionWithRollback('INSERT', 'users', 5, 'LaizaC', 'LaizaC@example.com', '123123QWE', NULL);
### Modificando dados na tabela "users"
CALL TransactionWithRollback('UPDATE', 'users', 1, 'John Doe', 'johndoe@example.com', 'asx123123',NULL);
CALL TransactionWithRollback('UPDATE', 'users', 2, 'Jane Smith', 'janesmith@example.com', 'aaaabbb333',NULL);
CALL TransactionWithRollback('UPDATE', 'users', 3, 'Robert Johnson', 'robertjohnson@example.com', '456123asd',NULL);
### Excluindo dados na tabela "views"
CALL TransactionWithRollback('DELETE', 'users', 4, 'BobLazar', 'BobLazar@example.com', '123123asd',NULL);

### Inserindo dados na tabela "media"
CALL TransactionWithRollback('INSERT', 'media', 1, 'Aventura Espacial', 'Ação', 2020, 'John Smith');
CALL TransactionWithRollback('INSERT', 'media', 2, 'Segredos do Passado', 'Drama', 2018, 'Emily Johnson');
CALL TransactionWithRollback('INSERT', 'media',3, 'Loucuras de Verão', 'Comédia', 2019, 'Michael Brown');
CALL TransactionWithRollback('INSERT', 'media', 4, 'Os Mistérios de Paris', 'Drama', 2021, 'Sophia Davis');
CALL TransactionWithRollback('INSERT', 'media', 5, 'No Limite da Escuridão', 'Suspense', 2022, 'John Smith');
CALL TransactionWithRollback('INSERT', 'media', 6, 'Viagem Interdimensional', 'Ficção Científica', 2020, 'Olivia Thompson');

### Inserindo dados na tabela "views"
CALL TransactionWithRollback('INSERT', 'views', 1, 1, 1, 30, NULL);
CALL TransactionWithRollback('INSERT', 'views', 2, 1, 4, 50, NULL);
CALL TransactionWithRollback('INSERT', 'views', 3, 2, 2, 80, NULL);
CALL TransactionWithRollback('INSERT', 'views', 4, 2, 5, 10, NULL);
CALL TransactionWithRollback('INSERT', 'views', 5, 3, 3, 90, NULL);
CALL TransactionWithRollback('INSERT', 'views', 6, 3, 6, 20, NULL);

### Inserindo dados na tabela "favorites"
CALL TransactionWithRollback('INSERT', 'favorites', 1, 1, 1, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'favorites', 2, 1, 3, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'favorites', 3, 2, 2, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'favorites', 4, 2, 1, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'favorites', 5, 3, 1, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'favorites', 6, 3, 6, NULL, NULL);

### Inserindo dados na tabela "history"
CALL TransactionWithRollback('INSERT', 'history', 1, 1, 2, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 2, 1, 1, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 3, 2, 3, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 4, 2, 4, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 5, 3, 5, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 6, 3, 1, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 7, 1, 3, NULL, NULL);
CALL TransactionWithRollback('INSERT', 'history', 8, 1, 3, NULL, NULL);


### Parte 4 - Blocos de Lista de INDEX e VIEW

-- Usando o banco de dados "streaming"
USE streaming;	

### CRIAÇÃO DE INDICES:
-- Criação de índices para a tabela "users"
CREATE INDEX idx_users_idUser ON users (idUser) USING BTREE;
CREATE INDEX idx_users_username ON users (username) USING BTREE;

-- Criação de índices para a tabela "media"
CREATE INDEX idx_media_idMedia ON media (idMedia) USING BTREE;
CREATE INDEX idx_media_title ON media (title) USING BTREE;
CREATE INDEX idx_media_genre ON media (genre) USING BTREE;

-- Criação de índices para a tabela "views"
CREATE INDEX idx_views_idUser ON views (idUser) USING BTREE;
CREATE INDEX idx_views_idMedia ON views (idMedia) USING BTREE;
CREATE INDEX idx_views_progress ON views (progress) USING BTREE;

-- Criação de Índices para a tabela "favorites"
CREATE INDEX idx_favorites_idUser ON favorites (idUser) USING BTREE; 
CREATE INDEX idx_favorites_idMedia ON favorites (idMedia) USING BTREE; 

-- Criação de Índices para a tabela "history"
CREATE INDEX idx_history_idUser ON history (idUser) USING BTREE; 
CREATE INDEX idx_history_idMedia ON history (idMedia) USING BTREE; 



### CRIAÇÃO DE VIEWS SIMPLES
CREATE VIEW v_users AS SELECT * FROM users;
CREATE VIEW v_media AS SELECT * FROM media;
CREATE VIEW v_views AS SELECT * FROM views;
CREATE VIEW v_favorites AS SELECT * FROM favorites;
CREATE VIEW v_history AS SELECT * FROM history;



### Criação das views COMPOSTAS:
 -- Criação da VIEW que Ordena os usuários pelo nome decrscente através de INDEX e ORDER BY
CREATE VIEW v_username AS SELECT * FROM users USE INDEX (idx_users_username)
ORDER BY username DESC;

-- Condições de filtros aos grupos (Operando com CONT(*) + VIEW + HAVING Statement )
CREATE VIEW v_Filter_history AS
SELECT idMedia, COUNT(*) AS Number_of_records FROM v_history 
GROUP BY idMedia HAVING Number_of_records > 1;

 -- Criação da view que Filtra a valor utilizando a INDEX de mídias com WHERE Statement
 CREATE VIEW v_favorites_Drama AS SELECT * FROM media USE INDEX (idx_media_genre) WHERE genre = 'Drama';

-- Criação da view com Junções entre tabelas utilizando os índices para fornecer uma perspectiva mais complexa dos dados e VIEW
CREATE VIEW v_favorites_Media AS SELECT  f.idFavorite, f.idUser, m.title, m.genre
FROM favorites f USE INDEX (idx_favorites_idMedia)
INNER JOIN media m USE INDEX (idx_media_idMedia) ON f.idMedia = m.idMedia;



### Parte 5 - Blocos de Criação de Usuários e suas permissões

-- Criação de três usuários com diferentes níveis de permissão

USE mysql;
USE streaming;														-- Definindo o banco de dados a ser utilizado

CREATE USER 'FULL_ACCESS'@localhost IDENTIFIED BY '123456789';		-- Criando o usuário 'FULL_ACCESS' com senha '123456789'
GRANT ALL PRIVILEGES ON streaming.* TO 'FULL_ACCESS'@localhost;		-- Concedendo todas as permissões no banco de dados 'streaming' para esse usuário

CREATE USER 'users'@localhost IDENTIFIED BY '111222333';			-- Criando o usuário 'users' com senha '111222333'
GRANT USAGE ON streaming.* TO 'users'@localhost;					-- Concedendo permissões de uso no banco de dados 'streaming' para esse usuário

CREATE USER 'admin'@localhost IDENTIFIED BY '123123123';			-- Criando o usuário 'admin' com senha '123123123'
GRANT ALL PRIVILEGES ON streaming.* TO 'admin'@localhost;			-- Concedendo todas as permissões no banco de dados 'streaming' para esse usuário
GRANT SELECT ON streaming.* TO 'admin'@localhost;					-- Concedendo permissão de SELECT no banco de dados 'streaming' para o usuário 'geral'

FLUSH PRIVILEGES;													-- Atualizando as permissões após as alterações
SELECT * FROM mysql.user;											-- Exibindo a lista de usuários no sistema MySQL

### FIM


