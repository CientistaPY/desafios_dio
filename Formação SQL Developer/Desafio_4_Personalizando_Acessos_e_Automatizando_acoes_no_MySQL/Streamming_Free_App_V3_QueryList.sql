### Formação SQL Database Specialist
### Desafio 4 - Personalizando o Banco de Dados com Índices e Procedures
### arquivo 4 - Lista de INDEX e VIEW para consultas com base nas necessidades do cenário.
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

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



#### Recuperações simples:
-- Recupera todos os usuários utilizando a view de usuários
SELECT * FROM v_users;

-- Recupera todas as mídias utilizando a view de mídias
SELECT * FROM v_media;

-- Recupera todas as visualizações utilizando a view de visualizações
SELECT * FROM v_views;

-- Recupera todos os favoritos utilizando a view de favoritos
SELECT * FROM v_favorites;

-- Recupera todo o histórico utilizando a view de histórico
SELECT * FROM v_history;



#### Recuperações Complexas:
-- Recupera as mídias com o gênero 'Drama' utilizando a view de mídias com WHERE Statement
 SELECT * FROM v_favorites_Drama;

-- Lista Ordena as usuários pelo nome em ordem alfabética decrescente
SELECT * FROM v_username;

-- Recupera o histórico com mais de 1 registro utilizando a view de histórico
 SELECT * FROM v_Filter_history;
 
 -- Recupera os favoritos com detalhes da mídia
 SELECT * FROM v_favorites_Media;



