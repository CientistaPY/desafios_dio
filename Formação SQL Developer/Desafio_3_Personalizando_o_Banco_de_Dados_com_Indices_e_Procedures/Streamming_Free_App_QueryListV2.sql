### Formação SQL Database Specialist
### Desafio 3 - Personalizando o Banco de Dados com Índices e Procedures
### PARTE 4 - Criação de índices para consultas com base nas necessidades do cenário.
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]


USE streaming;


###Índices para a tabela "users"
CREATE INDEX idx_users_idUser ON users (idUser) USING HASH; -- Índice HASH no ID do usuário para consultas rápidas por ID.
-- 1 warning(s): 3502 This storage engine does not support the HASH index algorithm, storage engine default was used instead.

CREATE INDEX idx_users_username ON users (username) USING BTREE; -- Índice BTREE no nome de usuário para consultas por nome de usuário.

-- Índices para a tabela "media"
CREATE INDEX idx_media_idMedia ON media (idMedia) USING BTREE; -- Índice BTREE no ID da mídia para consultas rápidas por ID.
CREATE INDEX idx_media_title ON media (title) USING BTREE; -- Índice BTREE no título da mídia para consultas por título.
CREATE INDEX idx_media_genre ON media (genre) USING BTREE; -- Índice BTREE no gênero da mídia para consultas exatas por gênero.

-- Índices para a tabela "views"
CREATE INDEX idx_views_idUser ON views (idUser) USING BTREE; -- Índice BTREE no ID do usuário para consultas por ID de usuário.
CREATE INDEX idx_views_idMedia ON views (idMedia) USING BTREE; -- Índice BTREE no ID da mídia para consultas por ID de mídia.
CREATE INDEX idx_views_progress ON views (progress) USING BTREE; -- Índice BTREE no progresso da visualização para consultas exatas por progresso.

-- Índices para a tabela "favorites"
CREATE INDEX idx_favorites_idUser ON favorites (idUser) USING BTREE; -- Índice BTREE no ID do usuário para consultas por ID de usuário.
CREATE INDEX idx_favorites_idMedia ON favorites (idMedia) USING BTREE; -- Índice BTREE no ID da mídia para consultas por ID de mídia.

-- Índices para a tabela "history"
CREATE INDEX idx_history_idUser ON history (idUser) USING BTREE; -- Índice BTREE no ID do usuário para consultas por ID de usuário.
CREATE INDEX idx_history_idMedia ON history (idMedia) USING BTREE; -- Índice BTREE no ID da mídia para consultas por ID de mídia.



####Recuperações simples com SELECT Statement:
-- Recupera todos os usuários utilizando índice no nome de usuário
SELECT * FROM users USE INDEX (idx_users_username);

-- Recupera todas as mídias utilizando índice no título da mídia
SELECT * FROM media USE INDEX (idx_media_title);

-- Recupera todas as visualizações utilizando índice no ID do usuário
SELECT * FROM views USE INDEX (idx_views_idUser);

-- Recupera todos os favoritos utilizando índice no ID do usuário
SELECT * FROM favorites USE INDEX (idx_favorites_idUser);

-- Recupera todo o histórico utilizando índice no ID do usuário
SELECT * FROM history USE INDEX (idx_history_idUser);



#### Filtros com WHERE Statement:
-- Recupera as mídias com o gênero 'Action' utilizando índice no gênero da mídia
SELECT * FROM media USE INDEX (idx_media_genre) WHERE genre = 'Drama';



####Ordenações dos dados com ORDER BY:
-- Ordena as mídias pelo título em ordem alfabética decrescente utilizando índice no título da mídia
SELECT * FROM media USE INDEX (idx_media_title) ORDER BY title DESC;




#### Condições de filtros aos grupos - HAVING Statement utilizando os índices apropriados
-- Recupera o histórico com mais de 1 registro utilizando o índice no ID da mídia
SELECT idMedia, COUNT(*) AS Number_of_records FROM history USE INDEX (idx_history_idMedia) GROUP BY idMedia HAVING Number_of_records > 1;




####Junções entre tabelas utilizando os índices para fornecer uma perspectiva mais complexa dos dados:
-- Recupera os favoritos com detalhes da mídia utilizando o índice no ID do usuário e ID da mídia
SELECT f.idFavorite, f.idUser, m.title, m.genre
FROM favorites f USE INDEX (idx_favorites_idUser)
INNER JOIN media m USE INDEX (idx_media_idMedia) ON f.idMedia = m.idMedia;
