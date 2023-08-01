### Potência Tech powered by iFood | Ciências de Dados com Python
### Desafio 2 - Construa um Projeto Lógico de Banco de Dados do Zero
### PARTE 4 -  Criação do Arquivo de Lista de Queries para um aplicativo gratuito de Streaminng
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]



#### Recuperações simples com SELECT Statement:
-- Recupera todos os usuários
SELECT * FROM users;

-- Recupera todas as mídias
SELECT * FROM media;

-- Recupera todas as visualizações
SELECT * FROM views;

-- Recupera todos os favoritos
SELECT * FROM favorites;

-- Recupera todo o histórico
SELECT * FROM history;



#### Filtros com WHERE Statement:
-- Recupera os usuários com o  Autor específico
SELECT * FROM media WHERE author = 'John Smith';

-- Recupera as mídias com o gênero 'Action'
SELECT * FROM media WHERE genre = 'Drama';

-- Recupera as visualizações com progresso acima de 50%
SELECT * FROM views WHERE progress > 50;



#### Crie expressões para gerar atributos derivados:
-- Cria um atributo derivado 'full_Title' que descreve a mídia
SELECT idMedia, CONCAT(title, ' de ', Author, ' lançado em ', releaseYear ) AS full_Title FROM media;

-- Cria um atributo derivado 'release_decade' que representa a década de lançamento da mídia
SELECT idMedia, title, releaseYear, FLOOR(releaseYear/10)*10 AS release_decade FROM media;



#### Ordenações dos dados com ORDER BY:
-- Ordena os usuários em ordem alfabética do nome de usuário
SELECT * FROM users ORDER BY username;

-- Ordena as mídias pelo título em ordem alfabética decrescente
SELECT * FROM media ORDER BY title DESC;

-- Ordena as visualizações pelo progresso em ordem crescente
SELECT * FROM views ORDER BY progress;

-- Ordena os favoritos pelo ID do usuário em ordem decrescente
SELECT * FROM favorites ORDER BY idUser DESC;

-- Ordena o histórico pelo ID da mídia em ordem crescente
SELECT * FROM history ORDER BY idMedia;



#### Condições de filtros aos grupos - HAVING Statement:
-- Recupera os usuários com mais de 2 visualizações
SELECT idUser, COUNT(*) AS Number_of_views FROM views GROUP BY idUser HAVING Number_of_views > 2;

-- Recupera o histórico com mais de 1 registro
SELECT idmedia, COUNT(*) AS Number_of_records FROM history GROUP BY idmedia HAVING Number_of_records > 1;



#### Junções entre tabelas para fornecer uma perspectiva mais complexa dos dados:
-- Recupera todas as visualizações com detalhes do usuário
SELECT v.idView, v.progress, u.username, u.email
FROM views v
INNER JOIN users u ON v.idUser = u.idUser;

-- Recupera os favoritos com detalhes da mídia
SELECT f.idFavorite, f.idUser, m.title, m.genre
FROM favorites f
INNER JOIN media m ON f.idMedia = m.idMedia;

-- Recupera o histórico com detalhes do usuário e da mídia
SELECT h.idHistory, h.idUser, h.idMedia, u.username, m.title
FROM history h
INNER JOIN users u ON h.idUser = u.idUser
INNER JOIN media m ON h.idMedia = m.idMedia;