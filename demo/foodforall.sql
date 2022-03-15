-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: foodforall
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add user',7,'add_user'),(26,'Can change user',7,'change_user'),(27,'Can delete user',7,'delete_user'),(28,'Can view user',7,'view_user'),(29,'Can add param',8,'add_param'),(30,'Can change param',8,'change_param'),(31,'Can delete param',8,'delete_param'),(32,'Can view param',8,'view_param'),(33,'Can add project',9,'add_project'),(34,'Can change project',9,'change_project'),(35,'Can delete project',9,'delete_project'),(36,'Can view project',9,'view_project');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$320000$retkp6B7Bg2dz4m2a20iEr$vAlontg08KJXy4nDhQ1OeRIiqmS5RGDMmHzlxPp5q0Q=','2022-03-11 17:05:49.689325',1,'apex','','','team08.apex@gmail.com',1,1,'2022-03-11 17:05:29.796040');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_param`
--

DROP TABLE IF EXISTS `database_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_param` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_param`
--

LOCK TABLES `database_param` WRITE;
/*!40000 ALTER TABLE `database_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_project`
--

DROP TABLE IF EXISTS `database_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pid` varchar(64) NOT NULL,
  `uid` varchar(64) NOT NULL,
  `title` varchar(256) NOT NULL,
  `intro` varchar(256) NOT NULL,
  `region` varchar(256) NOT NULL,
  `background_image` varchar(256) NOT NULL,
  `total_num` int NOT NULL,
  `current_num` int NOT NULL,
  `start_time` int NOT NULL,
  `end_time` int NOT NULL,
  `details` longtext NOT NULL,
  `price` double NOT NULL,
  `donate_history` longtext NOT NULL,
  `charity` varchar(256) NOT NULL,
  `charity_avatar` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_project`
--

LOCK TABLES `database_project` WRITE;
/*!40000 ALTER TABLE `database_project` DISABLE KEYS */;
INSERT INTO `database_project` VALUES (150,'3b73efd9f72e1d059e1cb541203aed68','73cf3acd12610691720ccd9fd97b0377','1','1','CN','',100,0,1647355500,1678891600,'1',1,'','a','static/default.jpg'),(151,'f368ba2a05c8b736fb7df49a94474d73','73cf3acd12610691720ccd9fd97b0377','2','2','CN','',100,0,1647355500,1678891600,'2',2,'','a','static/default.jpg'),(152,'09d713144a491706ac15dd42506c8247','73cf3acd12610691720ccd9fd97b0377','3','3','CN','',100,0,1647355500,1678891600,'3',3,'','a','static/default.jpg'),(153,'c5f34ae43d36ac320c14a70d11c5c6c7','73cf3acd12610691720ccd9fd97b0377','4','4','CN','',100,0,1647355500,1678891600,'4',4,'','a','static/default.jpg'),(154,'818dd78e180bba2ad4e3fc0e5cc69a1e','73cf3acd12610691720ccd9fd97b0377','5','5','CN','',100,0,1647355500,1678891600,'5',5,'','a','static/default.jpg'),(155,'79060ecafa96e23bc2d8fbae9c7d9069','73cf3acd12610691720ccd9fd97b0377','6','6','CN','',100,0,1647355500,1678891600,'6',6,'','a','static/default.jpg'),(156,'69d839269ea2f790d7509c7220ce0d89','73cf3acd12610691720ccd9fd97b0377','7','7','CN','',100,0,1647355500,1678891600,'7',7,'','a','static/default.jpg'),(157,'019ac3acb36e57a70dc6678d3c194004','73cf3acd12610691720ccd9fd97b0377','8','8','CN','',100,0,1647355500,1678891600,'8',8,'','a','static/default.jpg'),(158,'8e8744e1218656110df368f182a8fc4c','73cf3acd12610691720ccd9fd97b0377','9','9','CN','',100,0,1647355500,1678891600,'9',9,'','a','static/default.jpg'),(159,'7dbeda72fe0fb76aa7e011a60d554b6e','73cf3acd12610691720ccd9fd97b0377','10','10','CN','',100,0,1647355500,1678891600,'10',10,'','a','static/default.jpg'),(160,'f457f473913a304e0fc23e0826e863c4','73cf3acd12610691720ccd9fd97b0377','11','11','CN','',100,0,1647355500,1678891600,'11',11,'','a','static/default.jpg'),(161,'70119fb83dea46fb4b0458c6df213036','73cf3acd12610691720ccd9fd97b0377','12','12','CN','',100,0,1647355500,1678891600,'12',12,'','a','static/default.jpg'),(162,'444691b2fe0fe45bf50edf1c82512d98','73cf3acd12610691720ccd9fd97b0377','13','13','CN','',100,0,1647355500,1678891600,'13',13,'','a','static/default.jpg'),(163,'50bea281eefadd3dc4d0e08ef9355537','73cf3acd12610691720ccd9fd97b0377','14','14','CN','',100,0,1647355500,1678891600,'14',14,'','a','static/default.jpg'),(164,'cb7a27ed59cfb8787706cb141c24b464','73cf3acd12610691720ccd9fd97b0377','15','15','CN','',100,0,1647355500,1678891600,'15',15,'','a','static/default.jpg'),(165,'c2ede63f9f038c898efca8bc89454ff1','73cf3acd12610691720ccd9fd97b0377','16','16','CN','',100,0,1647355500,1678891600,'16',16,'','a','static/default.jpg'),(166,'b17e107d73d5ac7458baa97c2595ceea','73cf3acd12610691720ccd9fd97b0377','17','17','CN','',100,0,1647355500,1678891600,'17',17,'','a','static/default.jpg'),(167,'a800b596d59d5a38cec7d57a164b5e09','73cf3acd12610691720ccd9fd97b0377','18','18','CN','',100,0,1647355501,1678891601,'18',18,'','a','static/default.jpg'),(168,'4c33f4d6718689336ee1be1e7c9b2713','73cf3acd12610691720ccd9fd97b0377','19','19','CN','',100,0,1647355501,1678891601,'19',19,'','a','static/default.jpg'),(169,'3956e6efd7cbfdabd8017b78ec238986','73cf3acd12610691720ccd9fd97b0377','20','20','CN','',100,0,1647355501,1678891601,'20',20,'','a','static/default.jpg'),(170,'e3c57f292d25840fe7d4bca75650ebe0','73cf3acd12610691720ccd9fd97b0377','21','21','CN','',100,0,1647355501,1678891601,'21',21,'','a','static/default.jpg'),(171,'32ff3fac44ed4a82c8a4a1b8f359ba5b','73cf3acd12610691720ccd9fd97b0377','22','22','CN','',100,0,1647355501,1678891601,'22',22,'','a','static/default.jpg'),(172,'a8dac3f2cf1aa54091c99c78f3d5e256','73cf3acd12610691720ccd9fd97b0377','23','23','CN','',100,0,1647355501,1678891601,'23',23,'','a','static/default.jpg'),(173,'5a2dd4d0f99dd80d234b7d284fb8b8c8','73cf3acd12610691720ccd9fd97b0377','24','24','CN','',100,0,1647355501,1678891601,'24',24,'','a','static/default.jpg'),(174,'fc030fd1b93207c606453931bb898e01','73cf3acd12610691720ccd9fd97b0377','25','25','CN','',100,0,1647355501,1678891601,'25',25,'','a','static/default.jpg'),(175,'5fcb3ab7e34596c4166fff848df99f90','73cf3acd12610691720ccd9fd97b0377','26','26','CN','',100,0,1647355501,1678891601,'26',26,'','a','static/default.jpg'),(176,'ee748f65c975d54e6031382c99f9b8f7','73cf3acd12610691720ccd9fd97b0377','27','27','CN','',100,0,1647355501,1678891601,'27',27,'','a','static/default.jpg'),(177,'052610f3435f1bef9c15ed6318e93e3b','73cf3acd12610691720ccd9fd97b0377','28','28','CN','',100,0,1647355501,1678891601,'28',28,'','a','static/default.jpg'),(178,'8da0e0032e7e4d361cff2ef718302536','73cf3acd12610691720ccd9fd97b0377','29','29','CN','',100,0,1647355501,1678891601,'29',29,'','a','static/default.jpg'),(179,'d46df2af93b0291a5e83ef37891998c8','73cf3acd12610691720ccd9fd97b0377','30','30','CN','',100,0,1647355501,1678891601,'30',30,'','a','static/default.jpg'),(180,'16e828340360569792395b8062798e8c','73cf3acd12610691720ccd9fd97b0377','31','31','CN','',100,0,1647355501,1678891601,'31',31,'','a','static/default.jpg'),(181,'efc30c9f2e1c76e8cb6382ddf6d70cde','73cf3acd12610691720ccd9fd97b0377','32','32','CN','',100,0,1647355501,1678891601,'32',32,'','a','static/default.jpg'),(182,'cbe2538a318d6af33ce857f5b86ad9ee','73cf3acd12610691720ccd9fd97b0377','33','33','CN','',100,0,1647355501,1678891601,'33',33,'','a','static/default.jpg'),(183,'1887b1043a8f03ce97cab720c10f790d','73cf3acd12610691720ccd9fd97b0377','34','34','CN','',100,0,1647355501,1678891601,'34',34,'','a','static/default.jpg'),(184,'c62893cb60c8f80f9558ed3f40b2be39','73cf3acd12610691720ccd9fd97b0377','35','35','CN','',100,0,1647355501,1678891601,'35',35,'','a','static/default.jpg'),(185,'d0aff11c2e00da315da6de1515b6071a','73cf3acd12610691720ccd9fd97b0377','36','36','CN','',100,0,1647355501,1678891601,'36',36,'','a','static/default.jpg'),(186,'b06063988585f97070fa81bb54efb89a','73cf3acd12610691720ccd9fd97b0377','37','37','CN','',100,0,1647355501,1678891601,'37',37,'','a','static/default.jpg'),(187,'d30ef29bf54f9b80716da9ad3e8009ac','73cf3acd12610691720ccd9fd97b0377','38','38','CN','',100,0,1647355501,1678891601,'38',38,'','a','static/default.jpg'),(188,'5bfdb416e3f7521c04f91565b7ebf9ca','73cf3acd12610691720ccd9fd97b0377','39','39','CN','',100,0,1647355501,1678891601,'39',39,'','a','static/default.jpg'),(189,'5be312f5ccc1b213c93fd3f14afb5802','73cf3acd12610691720ccd9fd97b0377','40','40','CN','',100,0,1647355501,1678891601,'40',40,'','a','static/default.jpg'),(190,'a9484fb10af5667fa36d3192860e3dc0','73cf3acd12610691720ccd9fd97b0377','41','41','CN','',100,0,1647355501,1678891601,'41',41,'','a','static/default.jpg'),(191,'2019b699267a316b61327baab5a67f0a','73cf3acd12610691720ccd9fd97b0377','42','42','CN','',100,0,1647355501,1678891601,'42',42,'','a','static/default.jpg'),(192,'f80404f42fdc0c34f063a7bbd1df1f04','73cf3acd12610691720ccd9fd97b0377','43','43','CN','',100,0,1647355501,1678891601,'43',43,'','a','static/default.jpg'),(193,'ce0ef6cbd550624412687c406213911a','73cf3acd12610691720ccd9fd97b0377','44','44','CN','',100,0,1647355501,1678891601,'44',44,'','a','static/default.jpg'),(194,'aef19501e8f3062b8ad5fa2811e5e5f5','73cf3acd12610691720ccd9fd97b0377','45','45','CN','',100,0,1647355501,1678891601,'45',45,'','a','static/default.jpg'),(195,'ded8687b2f6f6a173657d6b80d319d91','73cf3acd12610691720ccd9fd97b0377','46','46','CN','',100,0,1647355501,1678891601,'46',46,'','a','static/default.jpg'),(196,'1745cadc900c218dfc47ad2278b58449','73cf3acd12610691720ccd9fd97b0377','47','47','CN','',100,0,1647355501,1678891601,'47',47,'','a','static/default.jpg'),(197,'70f0b9a9775a37d84ebc6c0421ba83e7','73cf3acd12610691720ccd9fd97b0377','48','48','CN','',100,0,1647355501,1678891601,'48',48,'','a','static/default.jpg'),(198,'6055150a339e27969cec8e468785fc12','73cf3acd12610691720ccd9fd97b0377','49','49','CN','',100,0,1647355501,1678891601,'49',49,'','a','static/default.jpg');
/*!40000 ALTER TABLE `database_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_user`
--

DROP TABLE IF EXISTS `database_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `mail` varchar(254) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `avatar` varchar(256) NOT NULL,
  `type` int NOT NULL,
  `region` varchar(256) NOT NULL,
  `project` longtext NOT NULL,
  `regis_time` int NOT NULL,
  `last_login_time` int NOT NULL,
  `donate_history` longtext NOT NULL,
  `share_mail_history` varchar(512) NOT NULL,
  `currency_type` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `email` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_user`
--

LOCK TABLES `database_user` WRITE;
/*!40000 ALTER TABLE `database_user` DISABLE KEYS */;
INSERT INTO `database_user` VALUES (19,'73cf3acd12610691720ccd9fd97b0377','ty_liang@foxmail.com','123456','qwer','static/default.jpg',1,'CN','[\'3b73efd9f72e1d059e1cb541203aed68\', \'f368ba2a05c8b736fb7df49a94474d73\', \'09d713144a491706ac15dd42506c8247\', \'c5f34ae43d36ac320c14a70d11c5c6c7\', \'818dd78e180bba2ad4e3fc0e5cc69a1e\', \'79060ecafa96e23bc2d8fbae9c7d9069\', \'69d839269ea2f790d7509c7220ce0d89\', \'019ac3acb36e57a70dc6678d3c194004\', \'8e8744e1218656110df368f182a8fc4c\', \'7dbeda72fe0fb76aa7e011a60d554b6e\', \'f457f473913a304e0fc23e0826e863c4\', \'70119fb83dea46fb4b0458c6df213036\', \'444691b2fe0fe45bf50edf1c82512d98\', \'50bea281eefadd3dc4d0e08ef9355537\', \'cb7a27ed59cfb8787706cb141c24b464\', \'c2ede63f9f038c898efca8bc89454ff1\', \'b17e107d73d5ac7458baa97c2595ceea\', \'a800b596d59d5a38cec7d57a164b5e09\', \'4c33f4d6718689336ee1be1e7c9b2713\', \'3956e6efd7cbfdabd8017b78ec238986\', \'e3c57f292d25840fe7d4bca75650ebe0\', \'32ff3fac44ed4a82c8a4a1b8f359ba5b\', \'a8dac3f2cf1aa54091c99c78f3d5e256\', \'5a2dd4d0f99dd80d234b7d284fb8b8c8\', \'fc030fd1b93207c606453931bb898e01\', \'5fcb3ab7e34596c4166fff848df99f90\', \'ee748f65c975d54e6031382c99f9b8f7\', \'052610f3435f1bef9c15ed6318e93e3b\', \'8da0e0032e7e4d361cff2ef718302536\', \'d46df2af93b0291a5e83ef37891998c8\', \'16e828340360569792395b8062798e8c\', \'efc30c9f2e1c76e8cb6382ddf6d70cde\', \'cbe2538a318d6af33ce857f5b86ad9ee\', \'1887b1043a8f03ce97cab720c10f790d\', \'c62893cb60c8f80f9558ed3f40b2be39\', \'d0aff11c2e00da315da6de1515b6071a\', \'b06063988585f97070fa81bb54efb89a\', \'d30ef29bf54f9b80716da9ad3e8009ac\', \'5bfdb416e3f7521c04f91565b7ebf9ca\', \'5be312f5ccc1b213c93fd3f14afb5802\', \'a9484fb10af5667fa36d3192860e3dc0\', \'2019b699267a316b61327baab5a67f0a\', \'f80404f42fdc0c34f063a7bbd1df1f04\', \'ce0ef6cbd550624412687c406213911a\', \'aef19501e8f3062b8ad5fa2811e5e5f5\', \'ded8687b2f6f6a173657d6b80d319d91\', \'1745cadc900c218dfc47ad2278b58449\', \'70f0b9a9775a37d84ebc6c0421ba83e7\', \'6055150a339e27969cec8e468785fc12\']',1647355500,1647374983,'','','GBP'),(20,'53b587ba4369447e7f63918f3cb364a1','531273646@qq.com','123456','2','static/default.jpg',2,'CN','',1647355500,1647355500,'','','CNY');
/*!40000 ALTER TABLE `database_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'DataBase','param'),(9,'DataBase','project'),(7,'DataBase','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-03-10 16:46:03.772803'),(2,'auth','0001_initial','2022-03-10 16:46:04.149887'),(3,'admin','0001_initial','2022-03-10 16:46:04.235906'),(4,'admin','0002_logentry_remove_auto_add','2022-03-10 16:46:04.243908'),(5,'admin','0003_logentry_add_action_flag_choices','2022-03-10 16:46:04.250910'),(6,'contenttypes','0002_remove_content_type_name','2022-03-10 16:46:04.321925'),(7,'auth','0002_alter_permission_name_max_length','2022-03-10 16:46:04.362935'),(8,'auth','0003_alter_user_email_max_length','2022-03-10 16:46:04.417948'),(9,'auth','0004_alter_user_username_opts','2022-03-10 16:46:04.431950'),(10,'auth','0005_alter_user_last_login_null','2022-03-10 16:46:04.506968'),(11,'auth','0006_require_contenttypes_0002','2022-03-10 16:46:04.521971'),(12,'auth','0007_alter_validators_add_error_messages','2022-03-10 16:46:04.535974'),(13,'auth','0008_alter_user_username_max_length','2022-03-10 16:46:04.613991'),(14,'auth','0009_alter_user_last_name_max_length','2022-03-10 16:46:04.684007'),(15,'auth','0010_alter_group_name_max_length','2022-03-10 16:46:04.759024'),(16,'auth','0011_update_proxy_permissions','2022-03-10 16:46:04.776027'),(17,'auth','0012_alter_user_first_name_max_length','2022-03-10 16:46:04.852044'),(18,'sessions','0001_initial','2022-03-10 16:46:04.888052'),(19,'DataBase','0001_initial','2022-03-10 18:45:41.725540'),(20,'DataBase','0002_param_project','2022-03-10 18:52:11.785178'),(21,'DataBase','0003_alter_project_end_time_alter_project_start_time_and_more','2022-03-11 00:26:27.073180'),(22,'DataBase','0004_rename_email_user_mail','2022-03-11 03:29:04.733502'),(23,'DataBase','0005_alter_project_uid','2022-03-11 14:31:28.787222'),(24,'DataBase','0006_rename_passwd_user_password_project_charity','2022-03-12 02:21:38.435603'),(25,'DataBase','0007_project_charity_avatar','2022-03-12 02:24:24.480472'),(26,'DataBase','0008_user_currency_type','2022-03-12 16:39:42.187369'),(27,'DataBase','0009_project_currency_type','2022-03-13 02:03:36.391445'),(28,'DataBase','0010_remove_project_currency_type','2022-03-13 05:21:18.388008');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('mle59l9im5lwtapuw4x5zqoffsin9t3j','.eJxVjMsOwiAQRf-FtSE8WgGX7vsNZJgZpGogKe3K-O_apAvd3nPOfYkI21ri1nmJM4mL0OL0uyXAB9cd0B3qrUlsdV3mJHdFHrTLqRE_r4f7d1Cgl29trKMQEppAZ0OEySMYZ513nBUPGfKQzcierQefwWnm0SkAxRrTwCTeHwOOOS0:1nSii5:TJYQA5OLJTOW02tbP5wo--vzqkN_xys8nWCAnRAIi7U','2022-03-25 17:05:49.692325');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-15 21:11:49
