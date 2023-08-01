### Formação SQL Database Specialist
### Desafio 3 - Personalizando o Banco de Dados com Índices e Procedures
### PARTE 2 Criação do Arquivo de Banco de Dados para um aplicativo gratuito de Streaminng
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]


DROP DATABASE IF EXISTS streaming;
CREATE DATABASE streaming;
USE streaming;

#### Tabela usuário
CREATE TABLE users (
    idUser INT AUTO_INCREMENT PRIMARY KEY, 				-- ID do usuário
    username VARCHAR(20) NOT NULL, 						-- Nome de usuário
    email VARCHAR(255) NOT NULL, 						-- Email do usuário
    password VARCHAR(10) NOT NULL 						-- Senha do usuário
);

ALTER TABLE users AUTO_INCREMENT = 1;

#### Tabela mídia
CREATE TABLE media (
    idMedia INT AUTO_INCREMENT PRIMARY KEY, 			-- ID da mídia
    title VARCHAR(255) NOT NULL, 						-- Título da mídia
    genre VARCHAR(255) NOT NULL, 						-- Gênero da mídia
    releaseYear INT NOT NULL, 							-- Ano de lançamento da mídia
    author VARCHAR(100) 								-- Autor da mídia
);

ALTER TABLE media AUTO_INCREMENT = 1;

#### Tabela visualização parcial
CREATE TABLE views (
    idView INT AUTO_INCREMENT PRIMARY KEY, 				-- ID da visualização
    idUser INT, 										-- ID do usuário associado à visualização
    idMedia INT, 										-- ID da mídia associada à visualização
    progress INT DEFAULT 0, 							-- Progresso da visualização em porcentagem
    CONSTRAINT fk_views_user FOREIGN KEY (idUser)
    REFERENCES users(idUser) ON UPDATE CASCADE, 		-- Chave estrangeira para associar o usuário
    CONSTRAINT fk_views_media FOREIGN KEY (idMedia)
    REFERENCES media(idMedia) ON UPDATE CASCADE 		-- Chave estrangeira para associar a mídia
);

ALTER TABLE views AUTO_INCREMENT = 1;

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

