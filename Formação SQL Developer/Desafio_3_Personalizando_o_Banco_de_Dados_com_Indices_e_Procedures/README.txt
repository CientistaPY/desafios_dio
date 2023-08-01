### Formação SQL Database Specialist
### Desafio 3 - Personalizando o Banco de Dados com Índices e Procedures
### PARTE 1 - Criação de índices para consultas com base nas necessidades do cenário.
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]


Projeto feito em 4 Partes: 

Parte 1 - O Arquivo README.txt explicando sobre o Projeto.

Parte 2 - O Arquivo "Streamming_Free_App_DataBase.sql" contendo o Banco de Dados E-Commerce, com comentários detalhados "SEM MODIFICAÇÕES DESDE O DESAFIO 2".

Parte 3 - O Arquivo "Streamming_Free_App_DataInsertionV2.sql" contendo a insercção dos dados, com comentários detalhados "UTLIZANDO PROCEDURES".*

Parte 4 - O Arquivo "Streamming_Free_App_QueryListV2.sql" contendo a Lista de Queries proposta no desafio "UTLIZANDO INDEX".** ***


OBSERVAÇÕES:

*O requisito de usar "PROCEDURE" para modificar e excluir dados da tabela exige Desabilitar o modo de atualização segura temporariamente, pois o "safe update mode" no MySQL,  é habilitado por padrão em algumas ferramentas de Gerenciamento do MySQL, como o MySQL Workbench. Pore ese motivo temos a linha "SET SQL_SAFE_UPDATES = 0" no após o BEGIN e "SET SQL_SAFE_UPDATES = 0" antes do END//

**Neste código, foi reanalisado o uso dos índices e criado índices do tipo BTREE apenas nas colunas que são mais relevantes para as consultas frequentes em cada tabela. Toda essa implementação foi feita em arquivo a parte do script de criação do Bamco de Dados, mantendo o código dele inalterado.

***Foi rquisitado o uso de um INDEX HASH, porém no cenário de E-commerce não se enquadra. Infelizmente, o MySQL não suporta índices do tipo HASH para todas as colunas. Os índices HASH só são suportados para colunas do tipo CHAR, VARCHAR, BINARY e VARBINARY. e não temos tabela nesse squema que atenda esse requisito. pra especificar melhor, o primeiro INDEX da lista de queries foi especificado como HASH, mas o Workbench gera um Warning, conforme está comentado no código, afirmando que será tratado com um INDEX normal, desprezando o tipo HASH.