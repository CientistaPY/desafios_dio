### Formação SQL Database Specialist
### Desafio 4 - Parte 2 – Criando gatilhos para cenário de e-commerce 
### arquivo 5 - Arquivo de Criação de Usuários e suas permissões
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

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

