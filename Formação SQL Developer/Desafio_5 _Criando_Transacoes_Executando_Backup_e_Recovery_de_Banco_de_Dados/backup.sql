CREATE DATABASE  IF NOT EXISTS `streaming` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `streaming`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: streaming
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `idFavorite` int NOT NULL AUTO_INCREMENT,
  `idUser` int DEFAULT NULL,
  `idMedia` int DEFAULT NULL,
  PRIMARY KEY (`idFavorite`),
  KEY `idx_favorites_idUser` (`idUser`) USING BTREE,
  KEY `idx_favorites_idMedia` (`idMedia`) USING BTREE,
  CONSTRAINT `fk_favorites_media` FOREIGN KEY (`idMedia`) REFERENCES `media` (`idMedia`) ON UPDATE CASCADE,
  CONSTRAINT `fk_favorites_user` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,1,1),(2,1,3),(3,2,2),(4,2,1),(5,3,1),(6,3,6);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `idHistory` int NOT NULL AUTO_INCREMENT,
  `idUser` int DEFAULT NULL,
  `idMedia` int DEFAULT NULL,
  PRIMARY KEY (`idHistory`),
  KEY `idx_history_idUser` (`idUser`) USING BTREE,
  KEY `idx_history_idMedia` (`idMedia`) USING BTREE,
  CONSTRAINT `fk_history_media` FOREIGN KEY (`idMedia`) REFERENCES `media` (`idMedia`) ON UPDATE CASCADE,
  CONSTRAINT `fk_history_user` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,1,2),(2,1,1),(3,2,3),(4,2,4),(5,3,5),(6,3,1),(7,1,3),(8,1,3);
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `idMedia` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `releaseYear` int NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idMedia`),
  KEY `idx_media_idMedia` (`idMedia`) USING BTREE,
  KEY `idx_media_title` (`title`) USING BTREE,
  KEY `idx_media_genre` (`genre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'Aventura Espacial','Ação',2020,'John Smith'),(2,'Segredos do Passado','Drama',2018,'Emily Johnson'),(3,'Loucuras de Verão','Comédia',2019,'Michael Brown'),(4,'Os Mistérios de Paris','Drama',2021,'Sophia Davis'),(5,'No Limite da Escuridão','Suspense',2022,'John Smith'),(6,'Viagem Interdimensional','Ficção Científica',2020,'Olivia Thompson');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(10) NOT NULL,
  PRIMARY KEY (`idUser`),
  KEY `idx_users_idUser` (`idUser`) USING BTREE,
  KEY `idx_users_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Doe','johndoe@example.com','asx123123'),(2,'Jane Smith','janesmith@example.com','aaaabbb333'),(3,'Robert Johnson','robertjohnson@example.com','456123asd'),(5,'LaizaC','LaizaC@example.com','123123QWE'),(6,'Lari Silva','Lari@example.com','123123123');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_users_update` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
    -- Quando a trigger é acionada, a ação de atualização, o ID do usuário antigo (OLD.idUser),
    -- o nome de usuário antigo (OLD.username) e o carimbo de data/hora atual (NOW()) são inseridos na tabela de log.
    INSERT INTO users_audit_log (action, user_id, username, timestamp)
    VALUES ('UPDATE', OLD.idUser, OLD.username, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_users_delete` BEFORE DELETE ON `users` FOR EACH ROW BEGIN
    -- Quando a trigger é acionada, a ação de exclusão, o ID do usuário antigo (OLD.idUser),
    -- o nome de usuário antigo (OLD.username) e o carimbo de data/hora atual (NOW()) são inseridos na tabela de log.
    INSERT INTO users_audit_log (action, user_id, username, timestamp)
    VALUES ('delete', OLD.idUser, OLD.username, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users_audit_log`
--

DROP TABLE IF EXISTS `users_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_audit_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(10) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_audit_log`
--

LOCK TABLES `users_audit_log` WRITE;
/*!40000 ALTER TABLE `users_audit_log` DISABLE KEYS */;
INSERT INTO `users_audit_log` VALUES (1,'UPDATE',1,'JohnDoe','2023-08-06 17:30:26'),(2,'UPDATE',2,'JaneSmith','2023-08-06 17:30:26'),(3,'UPDATE',3,'RobertJohnson','2023-08-06 17:30:26'),(4,'delete',4,'BobLazar','2023-08-06 17:30:27'),(5,'UPDATE',6,'LariSilva','2023-08-06 17:50:09'),(6,'delete',7,'LauraPontes','2023-08-06 17:50:17'),(7,'UPDATE',6,'Lari Silva','2023-08-06 17:50:23'),(8,'delete',7,'LauraPontes','2023-08-06 17:52:39'),(9,'delete',7,'LauraPontes','2023-08-06 17:54:58'),(10,'delete',7,'LauraPontes','2023-08-06 23:49:56');
/*!40000 ALTER TABLE `users_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_favorites`
--

DROP TABLE IF EXISTS `v_favorites`;
/*!50001 DROP VIEW IF EXISTS `v_favorites`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_favorites` AS SELECT 
 1 AS `idFavorite`,
 1 AS `idUser`,
 1 AS `idMedia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_favorites_drama`
--

DROP TABLE IF EXISTS `v_favorites_drama`;
/*!50001 DROP VIEW IF EXISTS `v_favorites_drama`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_favorites_drama` AS SELECT 
 1 AS `idMedia`,
 1 AS `title`,
 1 AS `genre`,
 1 AS `releaseYear`,
 1 AS `author`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_favorites_media`
--

DROP TABLE IF EXISTS `v_favorites_media`;
/*!50001 DROP VIEW IF EXISTS `v_favorites_media`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_favorites_media` AS SELECT 
 1 AS `idFavorite`,
 1 AS `idUser`,
 1 AS `title`,
 1 AS `genre`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_filter_history`
--

DROP TABLE IF EXISTS `v_filter_history`;
/*!50001 DROP VIEW IF EXISTS `v_filter_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_filter_history` AS SELECT 
 1 AS `idMedia`,
 1 AS `Number_of_records`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_history`
--

DROP TABLE IF EXISTS `v_history`;
/*!50001 DROP VIEW IF EXISTS `v_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_history` AS SELECT 
 1 AS `idHistory`,
 1 AS `idUser`,
 1 AS `idMedia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_media`
--

DROP TABLE IF EXISTS `v_media`;
/*!50001 DROP VIEW IF EXISTS `v_media`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_media` AS SELECT 
 1 AS `idMedia`,
 1 AS `title`,
 1 AS `genre`,
 1 AS `releaseYear`,
 1 AS `author`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_username`
--

DROP TABLE IF EXISTS `v_username`;
/*!50001 DROP VIEW IF EXISTS `v_username`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_username` AS SELECT 
 1 AS `idUser`,
 1 AS `username`,
 1 AS `email`,
 1 AS `password`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_users`
--

DROP TABLE IF EXISTS `v_users`;
/*!50001 DROP VIEW IF EXISTS `v_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_users` AS SELECT 
 1 AS `idUser`,
 1 AS `username`,
 1 AS `email`,
 1 AS `password`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_views`
--

DROP TABLE IF EXISTS `v_views`;
/*!50001 DROP VIEW IF EXISTS `v_views`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_views` AS SELECT 
 1 AS `idView`,
 1 AS `idUser`,
 1 AS `idMedia`,
 1 AS `progress`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `views`
--

DROP TABLE IF EXISTS `views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `views` (
  `idView` int NOT NULL AUTO_INCREMENT,
  `idUser` int DEFAULT NULL,
  `idMedia` int DEFAULT NULL,
  `progress` int DEFAULT '0',
  PRIMARY KEY (`idView`),
  KEY `idx_views_idUser` (`idUser`) USING BTREE,
  KEY `idx_views_idMedia` (`idMedia`) USING BTREE,
  KEY `idx_views_progress` (`progress`) USING BTREE,
  CONSTRAINT `fk_views_media` FOREIGN KEY (`idMedia`) REFERENCES `media` (`idMedia`),
  CONSTRAINT `fk_views_user` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `views`
--

LOCK TABLES `views` WRITE;
/*!40000 ALTER TABLE `views` DISABLE KEYS */;
INSERT INTO `views` VALUES (1,1,1,30),(2,1,4,50),(3,2,2,80),(4,2,5,10),(5,3,3,90),(6,3,6,20);
/*!40000 ALTER TABLE `views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'streaming'
--

--
-- Dumping routines for database 'streaming'
--
/*!50003 DROP PROCEDURE IF EXISTS `TransactionWithRollback` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TransactionWithRollback`(													-- Procedure para inserir, atualizar ou excluir dados nas tabela
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_favorites`
--

/*!50001 DROP VIEW IF EXISTS `v_favorites`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_favorites` AS select `favorites`.`idFavorite` AS `idFavorite`,`favorites`.`idUser` AS `idUser`,`favorites`.`idMedia` AS `idMedia` from `favorites` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_favorites_drama`
--

/*!50001 DROP VIEW IF EXISTS `v_favorites_drama`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_favorites_drama` AS select `media`.`idMedia` AS `idMedia`,`media`.`title` AS `title`,`media`.`genre` AS `genre`,`media`.`releaseYear` AS `releaseYear`,`media`.`author` AS `author` from `media` USE INDEX (`idx_media_genre`) where (`media`.`genre` = 'Drama') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_favorites_media`
--

/*!50001 DROP VIEW IF EXISTS `v_favorites_media`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_favorites_media` AS select `f`.`idFavorite` AS `idFavorite`,`f`.`idUser` AS `idUser`,`m`.`title` AS `title`,`m`.`genre` AS `genre` from (`favorites` `f` USE INDEX (`idx_favorites_idMedia`) join `media` `m` USE INDEX (`idx_media_idMedia`) on((`f`.`idMedia` = `m`.`idMedia`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_filter_history`
--

/*!50001 DROP VIEW IF EXISTS `v_filter_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_filter_history` AS select `v_history`.`idMedia` AS `idMedia`,count(0) AS `Number_of_records` from `v_history` group by `v_history`.`idMedia` having (`Number_of_records` > 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_history`
--

/*!50001 DROP VIEW IF EXISTS `v_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_history` AS select `history`.`idHistory` AS `idHistory`,`history`.`idUser` AS `idUser`,`history`.`idMedia` AS `idMedia` from `history` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_media`
--

/*!50001 DROP VIEW IF EXISTS `v_media`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_media` AS select `media`.`idMedia` AS `idMedia`,`media`.`title` AS `title`,`media`.`genre` AS `genre`,`media`.`releaseYear` AS `releaseYear`,`media`.`author` AS `author` from `media` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_username`
--

/*!50001 DROP VIEW IF EXISTS `v_username`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_username` AS select `users`.`idUser` AS `idUser`,`users`.`username` AS `username`,`users`.`email` AS `email`,`users`.`password` AS `password` from `users` USE INDEX (`idx_users_username`) order by `users`.`username` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_users`
--

/*!50001 DROP VIEW IF EXISTS `v_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_users` AS select `users`.`idUser` AS `idUser`,`users`.`username` AS `username`,`users`.`email` AS `email`,`users`.`password` AS `password` from `users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_views`
--

/*!50001 DROP VIEW IF EXISTS `v_views`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_views` AS select `views`.`idView` AS `idView`,`views`.`idUser` AS `idUser`,`views`.`idMedia` AS `idMedia`,`views`.`progress` AS `progress` from `views` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-06 21:06:46
