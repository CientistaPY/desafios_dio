

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



