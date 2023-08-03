### Formação SQL Database Specialist
### Desafio 4 - Parte 2 – Criando gatilhos para cenário de e-commerce 
### arquivo 1 - Arquivo de Banco de Dados para um aplicativo gratuito de Streaming
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

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







