-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: finallapp
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `date` datetime NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `userID_idx` (`userID`),
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (7,4,'2023-09-24 14:59:59','đi làm '),(8,4,'2023-09-26 15:15:23','đi làm '),(9,4,'2023-09-25 00:00:00','đi làm '),(10,7,'2023-09-25 08:00:00','đi làm '),(13,7,'2023-10-30 00:00:00','đi làm ');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Đồ ăn'),(2,'Đồ uống'),(3,'Khác');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donvitinh`
--

DROP TABLE IF EXISTS `donvitinh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donvitinh` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tenDVT` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `tenDVT_UNIQUE` (`tenDVT`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donvitinh`
--

LOCK TABLES `donvitinh` WRITE;
/*!40000 ALTER TABLE `donvitinh` DISABLE KEYS */;
INSERT INTO `donvitinh` VALUES (5,'chai'),(1,'lon'),(3,'phần'),(4,'Tô'),(2,'xiên');
/*!40000 ALTER TABLE `donvitinh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` double NOT NULL,
  `createAt` datetime NOT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `tableID` int DEFAULT NULL,
  `invoiceNumber` varchar(45) NOT NULL,
  `userID` int DEFAULT NULL,
  `payMethod` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `uID_idx` (`userID`),
  CONSTRAINT `uID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (6,930000,'2023-08-13 12:20:50','Hoàng Quốc Huy',NULL,'',NULL,0),(7,323000,'2023-08-13 12:28:04','Hoàng Quốc Huy',5,'',NULL,0),(8,1233000,'2023-08-15 21:37:17','Hoàng Quốc Huy',4,'',NULL,0),(9,1233000,'2023-08-15 21:38:15','Hoàng Quốc Huy',4,'',NULL,0),(10,1233000,'2023-08-15 21:38:27','Hoàng Quốc Huy',4,'',NULL,0),(11,1233000,'2023-08-15 21:39:54','Hoàng Quốc Huy',4,'',NULL,0),(12,1233000,'2023-08-15 21:43:00','Hoàng Quốc Huy',4,'',NULL,0),(13,1593000,'2023-08-29 20:26:06','Hoàng Quốc Huy',5,'',NULL,0),(14,5680000,'2023-09-07 09:52:14','Hoàng Quốc Huy',2,'',NULL,0),(15,310000,'2023-09-07 10:16:02','Hoàng Quốc Huy',2,'',NULL,0),(16,310000,'2023-09-07 10:16:56','Hoàng Quốc Huy',2,'',NULL,0),(17,310000,'2023-09-07 10:17:45','Hoàng Quốc Huy',2,'',NULL,0),(20,460000,'2023-09-07 16:44:16','Hoàng Quốc Huy',2,'216644',NULL,0),(24,5000000,'2023-07-07 16:44:16','Hoàng Quốc Huy',5,'',NULL,0),(25,6500000,'2023-06-07 16:44:16','Hoàng Quốc Huy',2,'',NULL,0),(26,4500000,'2023-05-07 16:44:16','Hoàng Quốc Huy',3,'',NULL,0),(27,4000000,'2023-04-07 16:44:16','Hoàng Quốc Huy',2,'',NULL,0),(28,45000000,'2023-03-07 16:44:16','Hoàng Quốc Huy',1,'245741',NULL,0),(29,30000000,'2023-10-07 16:44:16','Hoàng Quốc Huy',2,'415475',NULL,0),(30,35000000,'2023-02-07 16:44:16','Hoàng Quốc Huy',2,'554545',NULL,0),(31,20000000,'2023-01-07 16:44:16','Hoàng Quốc Huy',2,'777777',NULL,0),(32,13000,'2023-10-13 20:58:34','Tấn Trung',2,'7',NULL,0),(33,650000,'2023-10-13 21:21:35','Hoàng Quốc Huy',5,'66794',6,0),(34,44000,'2023-10-13 21:22:28','Hoàng Quốc Huy',1,'185695',4,0),(35,44000,'2023-10-13 21:23:08','Hoàng Quốc Huy',1,'264230',4,0),(36,650000,'2023-10-13 21:23:43','Hoàng Quốc Huy',5,'27068',6,0),(37,3000000,'2023-08-20 21:23:43','Hoàng Quốc Huy',2,'234509',4,0),(38,600000,'2023-10-24 21:13:32','Hoàng Quốc Huy',1,'350636',4,0),(39,310000,'2023-10-24 21:16:10','Hoàng Quốc Huy',1,'441793',4,0),(40,336000,'2023-10-24 21:17:35','Hoàng Quốc Huy',1,'21926',4,0),(41,336000,'2023-10-24 21:20:36','Hoàng Quốc Huy',1,'488579',4,0),(42,336000,'2023-10-24 21:21:23','Hoàng Quốc Huy',1,'122248',4,0),(43,1493000,'2023-10-27 12:20:34','Hoàng Quốc Huy',11,'429038',4,0),(44,43000,'2023-10-27 13:09:00','Tấn Trung',2,'220413',7,0),(45,4120000,'2023-10-27 13:43:03','Hoàng Quốc Huy',1,'111286',4,0),(46,28000,'2023-10-27 13:48:21','Tấn Trung',2,'385110',7,0),(47,43000,'2023-10-27 13:48:25','Tấn Trung',4,'135176',7,0),(48,90000,'2023-10-27 13:48:29','Tấn Trung',8,'21290',7,0),(49,30000,'2023-10-27 13:48:33','Tấn Trung',10,'362019',7,0),(50,3720000,'2023-10-29 20:09:22','Hoàng Quốc Huy',2,'317575',4,0),(51,156000,'2023-10-29 20:18:36','Hoàng Quốc Huy',4,'444191',4,0),(52,30000,'2023-10-29 20:19:27','Tấn Trung',10,'190036',7,0),(53,803000,'2023-10-29 20:30:31','Hoàng Quốc Huy',6,'464105',6,0),(54,31517000,'2023-10-30 10:08:20','Hoàng Quốc Huy',8,'26449',6,0),(55,62730000,'2023-10-30 10:08:37','Hoàng Quốc Huy',9,'350094',4,0),(56,43000,'2023-10-30 10:08:44','Tấn Trung',5,'346568',7,0),(57,28000,'2023-10-30 10:13:25','Tấn Trung',9,'329699',7,0),(58,43000,'2023-10-30 10:13:30','Tấn Trung',1,'88996',7,0),(59,43000,'2023-10-30 10:13:58','Tấn Trung',2,'462336',7,0),(60,4120000,'2023-10-30 10:14:01','Hoàng Quốc Huy',4,'318479',4,0),(61,186000,'2023-10-30 10:14:04','Hoàng Quốc Huy',5,'236296',4,0),(62,43000,'2023-10-30 10:24:05','Tấn Trung',4,'332293',7,0),(63,39000,'2023-10-30 10:24:17','Tấn Trung',8,'5917',7,0),(64,156000,'2023-10-30 10:24:24','Hoàng Quốc Huy',1,'301874',4,0),(65,26000,'2023-10-30 10:24:29','Tấn Trung',10,'198343',7,0),(66,39000,'2023-10-30 10:24:32','Tấn Trung',9,'284267',7,0),(67,6120000,'2023-10-30 10:24:35','Hoàng Quốc Huy',6,'409981',4,0),(68,156000,'2023-10-30 10:32:45','Hoàng Quốc Huy',11,'267142',4,0),(69,4120000,'2023-10-30 10:32:48','Hoàng Quốc Huy',1,'199816',4,0),(70,231000,'2023-10-30 10:32:50','Hoàng Quốc Huy',2,'290041',4,0),(71,6510000,'2023-10-30 10:32:52','Hoàng Quốc Huy',4,'462675',4,0),(72,41000,'2023-10-30 10:32:54','Tấn Trung',8,'358277',7,0),(73,26000,'2023-10-30 10:32:57','Tấn Trung',5,'298476',7,0),(74,273000,'2023-10-30 10:32:59','Hoàng Quốc Huy',10,'316036',4,0),(75,56000,'2023-10-30 10:33:02','Hoàng Quốc Huy',9,'125844',4,0),(76,26000,'2023-10-30 10:33:04','Hoàng Quốc Huy',6,'112118',4,0),(77,4120000,'2023-10-30 10:41:14','Hoàng Quốc Huy',2,'423985',4,0),(78,56000,'2023-10-30 10:46:44','Hoàng Quốc Huy',1,'76747',4,0),(79,650000,'2023-10-30 10:46:51','Hoàng Quốc Huy',4,'82341',4,0),(80,28000,'2023-10-30 10:46:53','Tấn Trung',8,'497926',7,0),(81,39000,'2023-10-30 10:46:55','Tấn Trung',5,'488599',7,0),(82,3720000,'2023-10-30 10:46:58','Hoàng Quốc Huy',10,'485602',4,0),(83,41000,'2023-10-30 10:47:00','Tấn Trung',9,'17853',7,0),(84,41000,'2023-10-30 10:47:02','Tấn Trung',6,'308624',7,0),(85,620000,'2023-10-30 10:47:05','Hoàng Quốc Huy',11,'489029',4,0),(86,56000,'2023-10-30 10:47:08','Hoàng Quốc Huy',13,'450439',4,0),(87,273000,'2023-10-30 11:03:06','Hoàng Quốc Huy',2,'24062',4,0),(88,186000,'2023-10-30 11:03:08','Hoàng Quốc Huy',1,'314225',4,0),(89,26000,'2023-10-30 11:03:10','Tấn Trung',4,'463038',7,0),(90,26000,'2023-10-30 11:03:12','Hoàng Quốc Huy',8,'429677',4,0),(91,273000,'2023-10-30 11:03:15','Hoàng Quốc Huy',9,'198474',4,0),(92,26000,'2023-10-30 11:03:17','Hoàng Quốc Huy',10,'196150',4,0),(93,26000,'2023-10-30 11:03:20','Hoàng Quốc Huy',5,'207168',4,0),(94,13000,'2023-10-30 11:03:22','Hoàng Quốc Huy',13,'410070',4,0),(95,156000,'2023-10-30 11:18:24','Hoàng Quốc Huy',2,'179782',4,0),(96,156000,'2023-10-30 11:18:26','Hoàng Quốc Huy',1,'252005',4,0),(97,312000,'2023-10-30 11:18:28','Hoàng Quốc Huy',4,'417206',4,0),(98,336000,'2023-10-30 11:18:31','Hoàng Quốc Huy',8,'367141',4,0),(99,3720000,'2023-10-30 11:18:33','Hoàng Quốc Huy',9,'187166',4,0),(100,99000,'2023-10-30 11:18:37','Hoàng Quốc Huy',5,'376843',4,0),(101,56000,'2023-10-30 11:18:40','Hoàng Quốc Huy',11,'310345',4,0),(102,620000,'2023-10-30 11:26:21','Hoàng Quốc Huy',2,'2425',4,0),(103,116000,'2023-10-30 11:26:31','Hoàng Quốc Huy',1,'447815',4,0),(104,3776000,'2023-10-30 11:27:49','Hoàng Quốc Huy',1,'349431',4,0),(105,26000,'2023-10-30 11:28:57','Tấn Trung',4,'201938',7,0),(106,52000,'2023-10-30 11:32:47','Tấn Trung',8,'360884',7,0),(107,52000,'2023-10-30 11:34:52','Tấn Trung',4,'491508',7,0),(108,56000,'2023-10-30 11:36:05','Hoàng Quốc Huy',1,'132273',4,0),(109,52000,'2023-10-30 11:37:11','Tấn Trung',1,'25746',7,0),(110,39000,'2023-10-30 12:08:21','Tấn Trung',1,'396050',7,0),(111,26000,'2023-10-30 13:01:42','Tấn Trung',2,'411498',7,0),(112,26000,'2023-10-30 13:01:49','Tấn Trung',1,'134137',7,0),(113,26000,'2023-10-30 13:01:52','Tấn Trung',4,'345604',7,0),(114,26000,'2023-10-30 13:01:54','Tấn Trung',8,'111427',7,0),(115,54000,'2023-10-30 13:01:56','Tấn Trung',5,'418551',7,0),(116,26000,'2023-10-30 13:01:59','Tấn Trung',13,'125022',7,0),(117,26000,'2023-10-30 13:20:55','Tấn Trung',2,'276',7,0),(118,26000,'2023-10-30 13:21:01','Tấn Trung',1,'275088',7,0),(119,26000,'2023-10-30 13:21:04','Tấn Trung',4,'314651',7,0),(120,26000,'2023-10-30 13:21:10','Tấn Trung',8,'492493',7,0),(121,26000,'2023-10-30 13:21:13','Tấn Trung',6,'197882',7,0),(122,26000,'2023-10-30 13:21:15','Tấn Trung',9,'425153',7,0),(123,26000,'2023-10-30 13:36:12','Tấn Trung',1,'228808',7,0),(124,26000,'2023-10-30 14:22:01','Tấn Trung',2,'337196',7,0),(125,26000,'2023-10-30 14:22:04','Tấn Trung',1,'439185',7,0),(126,26000,'2023-10-30 14:22:07','Tấn Trung',4,'213676',7,0),(127,13000,'2023-10-30 14:22:10','Tấn Trung',8,'294360',7,0),(128,13000,'2023-10-30 14:22:13','Tấn Trung',6,'443784',7,0),(129,6510000,'2023-10-30 14:22:16','Hoàng Quốc Huy',9,'162718',4,0),(130,13000,'2023-10-30 14:22:18','Tấn Trung',10,'171258',7,0),(131,65000,'2023-10-30 14:25:30','Tấn Trung',2,'213417',7,0),(132,26000,'2023-10-30 16:01:53','Tấn Trung',5,'336166',7,0),(133,71000,'2023-10-30 16:02:01','Tấn Trung',2,'454603',7,0),(134,119000,'2023-10-30 16:02:03','Tấn Trung',1,'309968',7,0),(135,136000,'2023-10-30 16:02:06','Tấn Trung',4,'80758',7,0),(136,54000,'2023-10-30 16:02:08','Tấn Trung',8,'376292',7,0),(137,39000,'2023-10-30 16:02:11','Tấn Trung',9,'478242',7,0),(138,69000,'2023-10-30 16:03:37','Tấn Trung',2,'148331',7,0),(139,26000,'2023-10-30 16:04:01','Tấn Trung',1,'12184',7,0),(140,71000,'2023-10-30 16:04:49','Hoàng Quốc Huy',1,'75157',4,0),(141,39000,'2023-10-30 16:05:28','Tấn Trung',2,'420145',7,0),(142,52000,'2023-10-30 16:08:12','Tấn Trung',1,'109812',7,0),(143,26000,'2023-10-30 16:09:46','Tấn Trung',1,'3701',7,0),(144,303000,'2023-10-30 16:10:09','Hoàng Quốc Huy',2,'100737',4,0),(145,84000,'2023-10-30 16:10:28','Hoàng Quốc Huy',2,'110318',4,0),(146,303000,'2023-10-30 16:11:30','Hoàng Quốc Huy',2,'276577',4,0),(147,39000,'2023-10-30 16:18:18','Tấn Trung',2,'307980',7,0),(148,273000,'2023-10-30 16:18:54','Hoàng Quốc Huy',1,'157967',4,0),(149,39000,'2023-10-30 16:21:05','Tấn Trung',2,'266499',7,0),(150,26000000,'2023-10-30 16:41:06','Hoàng Quốc Huy',8,'308204',4,0),(151,299000,'2023-10-30 16:55:53','Hoàng Quốc Huy',1,'461722',4,0),(152,130000,'2023-10-30 16:55:59','Tấn Trung',2,'189936',7,0),(153,39000,'2023-10-30 16:56:24','Tấn Trung',4,'88814',7,0),(154,65000,'2023-10-30 16:57:10','Tấn Trung',6,'220106',7,0),(155,65000,'2023-10-30 17:29:23','Hoàng Quốc Huy',8,'388585',4,0),(156,33111000,'2023-10-30 17:36:13','Hoàng Quốc Huy',1,'274019',4,0),(157,662000,'2023-10-30 20:49:09','Tấn Trung',2,'144891',7,0),(158,431000,'2023-10-30 20:55:20','Tấn Trung',2,'345645',7,0),(159,231000,'2023-10-30 20:58:24','Tấn Trung',1,'52882',7,0),(160,262000,'2023-10-30 20:58:28','Tấn Trung',4,'192555',7,0),(161,554000,'2023-10-30 20:59:03','Tấn Trung',1,'34488',7,0),(162,2462000,'2023-10-30 21:40:04','Hoàng Quốc Huy',2,'230509',6,0),(163,1700000,'2023-10-30 21:58:26','Hoàng Quốc Huy',1,'82367',6,0),(164,1588000,'2023-10-30 21:59:07','Tấn Trung',2,'138965',7,0),(165,256000,'2023-10-31 10:05:23','Tấn Trung',1,'243885',7,0),(166,259000,'2023-10-31 10:05:34','Tấn Trung',4,'256640',7,0),(167,259000,'2023-10-31 10:05:39','Tấn Trung',2,'176236',7,0),(168,26000,'2023-10-31 10:28:32','Hoàng Quốc Huy',22,'5471',4,0),(169,71000,'2023-10-31 10:31:58','Hoàng Quốc Huy',23,'350778',4,0),(170,2462000,'2023-10-31 10:46:33','Hoàng Quốc Huy',22,'127577',4,0),(171,1599000,'2023-10-31 10:48:05','Hoàng Quốc Huy',22,'386112',4,0),(172,231000,'2023-10-31 10:55:08','Hoàng Quốc Huy',25,'67097',4,0),(173,45000,'2023-10-31 10:57:23','Hoàng Quốc Huy',22,'498509',4,0),(174,244000,'2023-10-31 11:05:37','Tấn Trung',22,'488437',7,0),(175,45000,'2023-10-31 11:10:02','Hoàng Quốc Huy',22,'13220',4,0),(176,84000,'2023-10-31 12:29:03','Hoàng Quốc Huy',23,'163254',4,0),(177,114000,'2023-10-31 12:30:30','Hoàng Quốc Huy',22,'220716',4,0),(178,71000,'2023-10-31 12:31:01','Hoàng Quốc Huy',22,'434764',4,0),(179,10356000,'2023-11-01 16:43:53','Hoàng Quốc Huy',22,'10196',4,1),(180,4500000,'2023-11-01 16:44:09','Hoàng Quốc Huy',34,'443778',4,1),(181,7200000,'2023-11-01 16:44:18','Hoàng Quốc Huy',35,'235519',4,1),(182,6000000,'2023-11-01 16:45:27','Hoàng Quốc Huy',22,'216592',4,1),(183,6000000,'2023-11-01 16:46:07','Hoàng Quốc Huy',22,'358394',4,1),(184,10305000,'2023-11-01 17:54:13','Hoàng Quốc Huy',22,'170405',4,1),(185,6000000,'2023-11-01 17:55:08','Hoàng Quốc Huy',22,'4803',4,1),(186,7200000,'2023-11-01 17:56:56','Hoàng Quốc Huy',22,'33758',4,1),(187,6255000,'2023-11-01 20:02:01','Hoàng Quốc Huy',34,'406258',4,1),(188,10255000,'2023-11-01 20:04:24','Tấn Trung',34,'488657',7,1),(189,7000000,'2023-11-01 20:10:51','Tấn Trung',35,'374647',7,1),(190,7030000,'2023-11-01 20:11:35','Tấn Trung',34,'212648',7,1),(191,7000000,'2023-11-01 20:16:26','Tấn Trung',34,'328814',7,1);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoicedetails`
--

DROP TABLE IF EXISTS `invoicedetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoicedetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceID` int NOT NULL,
  `poductName` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  `totalAmount` double NOT NULL,
  `productID` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `invoice_idx` (`invoiceID`),
  KEY `prod_idx` (`productID`),
  CONSTRAINT `invoice` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`id`),
  CONSTRAINT `prod` FOREIGN KEY (`productID`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=462 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoicedetails`
--

LOCK TABLES `invoicedetails` WRITE;
/*!40000 ALTER TABLE `invoicedetails` DISABLE KEYS */;
INSERT INTO `invoicedetails` VALUES (7,6,'Dê hấp thố',3,930000,NULL),(8,7,'Bia Saigon ',1,13000,NULL),(9,7,'Dê hấp thố',1,310000,NULL),(10,10,'Lẩu gà lá giang',2,600000,NULL),(11,10,'Dê hấp thố',1,310000,NULL),(12,10,'Dê hấp thố',1,310000,NULL),(13,10,'Bia Saigon ',1,13000,NULL),(14,11,'Lẩu gà lá giang',2,600000,NULL),(15,11,'Dê hấp thố',1,310000,NULL),(16,11,'Dê hấp thố',1,310000,NULL),(17,11,'Bia Saigon ',1,13000,NULL),(18,12,'Lẩu gà lá giang',2,600000,NULL),(19,12,'Dê hấp thố',1,310000,NULL),(20,12,'Dê hấp thố',1,310000,NULL),(21,12,'Bia Saigon ',1,13000,NULL),(22,13,'Bia Saigon ',1,13000,NULL),(23,13,'Lâủ cá lănng',3,930000,NULL),(24,13,'Bia Saigon ',50,650000,NULL),(25,14,'Dúi Xáoo Măng',5,4000000,NULL),(26,14,'Lâủ cá lănng',2,620000,NULL),(27,14,'revice',50,750000,NULL),(28,14,'Lòng xào dưa',10,310000,NULL),(29,15,'Lâủ cá lănng',1,310000,NULL),(30,16,'Lâủ cá lănng',1,310000,NULL),(31,17,'Lâủ cá lănng',1,310000,NULL),(32,20,'revice',10,150000,NULL),(33,20,'Lòng xào dưa',10,310000,NULL),(34,32,'Bia Saigon ',1,13000,NULL),(35,35,'Lòng xào dưa',1,31000,NULL),(36,35,'Bia Saigon ',1,13000,NULL),(37,36,'Bia Saigon ',50,650000,NULL),(38,38,'Heo rừng xào xả ớt',3,600000,NULL),(39,42,'Lâủ cá lănng',1,310000,NULL),(40,42,'Bia Saigon ',2,26000,NULL),(41,43,'Heo rừng xào xả ớt',1,200000,NULL),(42,43,'Lòng xào dưa',2,62000,NULL),(43,43,'Lâủ cá lănng',1,310000,NULL),(44,43,'Bia Saigon ',12,156000,NULL),(45,43,'cocacola',51,765000,NULL),(46,44,'Bia Saigon ',1,13000,NULL),(47,44,'cocacola',1,15000,NULL),(48,44,'revice',1,15000,NULL),(49,45,'Lâủ cá lănng',12,3720000,NULL),(50,45,'Heo rừng xào xả ớt',2,400000,NULL),(51,46,'Bia Saigon ',1,13000,NULL),(52,46,'cocacola',1,15000,NULL),(53,47,'Bia Saigon ',1,13000,NULL),(54,47,'cocacola',1,15000,NULL),(55,47,'revice',1,15000,NULL),(56,48,'cocacola',1,15000,NULL),(57,48,'cocacola',1,15000,NULL),(58,48,'revice',1,15000,NULL),(59,48,'revice',1,15000,NULL),(60,48,'revice',1,15000,NULL),(61,48,'cocacola',1,15000,NULL),(62,49,'revice',1,15000,NULL),(63,49,'cocacola',1,15000,NULL),(64,50,'Lâủ cá lănng',12,3720000,NULL),(65,51,'Bia Saigon ',12,156000,NULL),(66,52,'revice',1,15000,NULL),(67,52,'cocacola',1,15000,NULL),(68,53,'Lâủ cá lănng',1,310000,NULL),(69,53,'Heo rừng xào xả ớt',2,400000,NULL),(70,53,'Lòng xào dưa',3,93000,NULL),(71,54,'Bia Saigon ',10,130000,NULL),(72,54,'Bia Saigon ',319,4147000,NULL),(73,54,'cocacola',641,9615000,NULL),(74,54,'revice',533,7995000,NULL),(75,54,'cocacola',641,9615000,NULL),(76,54,'cocacola',1,15000,NULL),(77,55,'Heo rừng xào xả ớt',123,24600000,NULL),(78,55,'Lâủ cá lănng',123,38130000,NULL),(79,56,'cocacola',1,15000,NULL),(80,56,'Bia Saigon ',1,13000,NULL),(81,56,'revice',1,15000,NULL),(82,57,'Bia Saigon ',1,13000,NULL),(83,57,'cocacola',1,15000,NULL),(84,58,'Bia Saigon ',1,13000,NULL),(85,58,'cocacola',1,15000,NULL),(86,58,'revice',1,15000,NULL),(87,59,'Bia Saigon ',1,13000,NULL),(88,59,'cocacola',1,15000,NULL),(89,59,'revice',1,15000,NULL),(90,60,'Lâủ cá lănng',12,3720000,NULL),(91,60,'Heo rừng xào xả ớt',2,400000,NULL),(92,61,'Bia Saigon ',12,156000,NULL),(93,61,'cocacola',2,30000,NULL),(94,62,'cocacola',1,15000,NULL),(95,62,'Bia Saigon ',1,13000,NULL),(96,62,'revice',1,15000,NULL),(97,63,'Bia Saigon ',1,13000,NULL),(98,63,'Bia Saigon ',1,13000,NULL),(99,63,'Bia Saigon ',1,13000,NULL),(100,64,'Bia Saigon ',12,156000,NULL),(101,65,'Bia Saigon ',1,13000,NULL),(102,65,'Bia Saigon ',1,13000,NULL),(103,66,'Bia Saigon ',1,13000,NULL),(104,66,'Bia Saigon ',1,13000,NULL),(105,66,'Bia Saigon ',1,13000,NULL),(106,67,'Lâủ cá lănng',12,3720000,NULL),(107,67,'Heo rừng xào xả ớt',12,2400000,NULL),(108,68,'Bia Saigon ',12,156000,NULL),(109,69,'Lâủ cá lănng',12,3720000,NULL),(110,69,'Heo rừng xào xả ớt',2,400000,NULL),(111,70,'Bia Saigon ',12,156000,NULL),(112,70,'cocacola',2,30000,NULL),(113,70,'revice',3,45000,NULL),(114,71,'Lâủ cá lănng',21,6510000,NULL),(115,72,'Bia Saigon ',1,13000,NULL),(116,72,'Bia Saigon ',1,13000,NULL),(117,72,'cocacola',1,15000,NULL),(118,73,'Bia Saigon ',1,13000,NULL),(119,73,'Bia Saigon ',1,13000,NULL),(120,74,'Bia Saigon ',21,273000,NULL),(121,75,'Bia Saigon ',2,26000,NULL),(122,75,'cocacola',2,30000,NULL),(123,76,'Bia Saigon ',2,26000,NULL),(124,77,'Lâủ cá lănng',12,3720000,NULL),(125,77,'Heo rừng xào xả ớt',2,400000,NULL),(126,78,'Bia Saigon ',2,26000,NULL),(127,78,'cocacola',2,30000,NULL),(128,79,'Lâủ cá lănng',2,620000,NULL),(129,79,'cocacola',2,30000,NULL),(130,80,'Bia Saigon ',1,13000,NULL),(131,80,'cocacola',1,15000,NULL),(132,81,'Bia Saigon ',1,13000,NULL),(133,81,'Bia Saigon ',1,13000,NULL),(134,81,'Bia Saigon ',1,13000,NULL),(135,82,'Lâủ cá lănng',12,3720000,NULL),(136,83,'Bia Saigon ',1,13000,NULL),(137,83,'cocacola',1,15000,NULL),(138,83,'Bia Saigon ',1,13000,NULL),(139,84,'Bia Saigon ',1,13000,NULL),(140,84,'cocacola',1,15000,NULL),(141,84,'Bia Saigon ',1,13000,NULL),(142,85,'Lâủ cá lănng',2,620000,NULL),(143,86,'Bia Saigon ',2,26000,NULL),(144,86,'cocacola',2,30000,NULL),(145,87,'Bia Saigon ',21,273000,NULL),(146,88,'Bia Saigon ',12,156000,NULL),(147,88,'cocacola',2,30000,NULL),(148,89,'Bia Saigon ',1,13000,NULL),(149,89,'Bia Saigon ',1,13000,NULL),(150,90,'Bia Saigon ',2,26000,NULL),(151,91,'Bia Saigon ',21,273000,NULL),(152,92,'Bia Saigon ',2,26000,NULL),(153,93,'Bia Saigon ',2,26000,NULL),(154,94,'Bia Saigon ',1,13000,NULL),(155,95,'Bia Saigon ',12,156000,NULL),(156,96,'Bia Saigon ',12,156000,NULL),(157,97,'Bia Saigon ',12,156000,NULL),(158,97,'Bia Saigon ',12,156000,NULL),(159,98,'Lâủ cá lănng',1,310000,NULL),(160,98,'Bia Saigon ',2,26000,NULL),(161,99,'Lâủ cá lănng',12,3720000,NULL),(162,100,'Bia Saigon ',3,39000,NULL),(163,100,'cocacola',2,30000,NULL),(164,100,'revice',2,30000,NULL),(165,101,'Bia Saigon ',2,26000,NULL),(166,101,'cocacola',2,30000,NULL),(167,102,'Lâủ cá lănng',2,620000,NULL),(168,103,'Bia Saigon ',2,26000,NULL),(169,103,'cocacola',2,30000,NULL),(170,103,'cocacola',2,30000,NULL),(171,103,'revice',2,30000,NULL),(172,104,'Lâủ cá lănng',12,3720000,NULL),(173,104,'Bia Saigon ',2,26000,NULL),(174,104,'cocacola',2,30000,NULL),(175,105,'Bia Saigon ',1,13000,NULL),(176,105,'Bia Saigon ',1,13000,NULL),(177,106,'Bia Saigon ',1,13000,NULL),(178,106,'Bia Saigon ',1,13000,NULL),(179,106,'Bia Saigon ',1,13000,NULL),(180,106,'Bia Saigon ',1,13000,NULL),(181,107,'Bia Saigon ',1,13000,NULL),(182,107,'Bia Saigon ',1,13000,NULL),(183,107,'Bia Saigon ',1,13000,NULL),(184,107,'Bia Saigon ',1,13000,NULL),(185,108,'Bia Saigon ',2,26000,NULL),(186,108,'cocacola',2,30000,NULL),(187,109,'Bia Saigon ',1,13000,NULL),(188,109,'Bia Saigon ',1,13000,NULL),(189,109,'Bia Saigon ',1,13000,NULL),(190,109,'Bia Saigon ',1,13000,NULL),(191,110,'Bia Saigon ',1,13000,NULL),(192,110,'Bia Saigon ',1,13000,NULL),(193,110,'Bia Saigon ',1,13000,NULL),(194,111,'Bia Saigon ',1,13000,NULL),(195,111,'Bia Saigon ',1,13000,NULL),(196,112,'Bia Saigon ',1,13000,NULL),(197,112,'Bia Saigon ',1,13000,NULL),(198,113,'Bia Saigon ',1,13000,NULL),(199,113,'Bia Saigon ',1,13000,NULL),(200,114,'Bia Saigon ',1,13000,NULL),(201,114,'Bia Saigon ',1,13000,NULL),(202,115,'Bia Saigon ',1,13000,NULL),(203,115,'Bia Saigon ',1,13000,NULL),(204,115,'Bia Saigon ',1,13000,NULL),(205,115,'cocacola',1,15000,NULL),(206,116,'Bia Saigon ',1,13000,NULL),(207,116,'Bia Saigon ',1,13000,NULL),(208,117,'Bia Saigon ',1,13000,NULL),(209,117,'Bia Saigon ',1,13000,NULL),(210,118,'Bia Saigon ',1,13000,NULL),(211,118,'Bia Saigon ',1,13000,NULL),(212,119,'Bia Saigon ',1,13000,NULL),(213,119,'Bia Saigon ',1,13000,NULL),(214,120,'Bia Saigon ',1,13000,NULL),(215,120,'Bia Saigon ',1,13000,NULL),(216,121,'Bia Saigon ',1,13000,NULL),(217,121,'Bia Saigon ',1,13000,NULL),(218,122,'Bia Saigon ',1,13000,NULL),(219,122,'Bia Saigon ',1,13000,NULL),(220,123,'Bia Saigon ',1,13000,NULL),(221,123,'Bia Saigon ',1,13000,NULL),(222,124,'Bia Saigon ',1,13000,NULL),(223,124,'Bia Saigon ',1,13000,NULL),(224,125,'Bia Saigon ',1,13000,NULL),(225,125,'Bia Saigon ',1,13000,NULL),(226,126,'Bia Saigon ',1,13000,NULL),(227,126,'Bia Saigon ',1,13000,NULL),(228,127,'Bia Saigon ',1,13000,NULL),(229,128,'Bia Saigon ',1,13000,NULL),(230,129,'Lâủ cá lănng',21,6510000,NULL),(231,130,'Bia Saigon ',1,13000,NULL),(232,131,'Bia Saigon ',1,13000,NULL),(233,131,'Bia Saigon ',1,13000,NULL),(234,131,'Bia Saigon ',1,13000,NULL),(235,131,'Bia Saigon ',1,13000,NULL),(236,131,'Bia Saigon ',1,13000,NULL),(237,132,'Bia Saigon ',1,13000,NULL),(238,132,'Bia Saigon ',1,13000,NULL),(239,133,'Bia Saigon ',1,13000,NULL),(240,133,'Bia Saigon ',1,13000,NULL),(241,133,'cocacola',1,15000,NULL),(242,133,'cocacola',1,15000,NULL),(243,133,'revice',1,15000,NULL),(244,134,'Bia Saigon ',1,13000,NULL),(245,134,'Bia Saigon ',1,13000,NULL),(246,134,'Bia Saigon ',1,13000,NULL),(247,134,'Bia Saigon ',1,13000,NULL),(248,134,'Bia Saigon ',1,13000,NULL),(249,134,'Bia Saigon ',1,13000,NULL),(250,134,'Bia Saigon ',1,13000,NULL),(251,134,'Bia Saigon ',1,13000,NULL),(252,134,'cocacola',1,15000,NULL),(253,135,'Bia Saigon ',1,13000,NULL),(254,135,'Bia Saigon ',1,13000,NULL),(255,135,'Bia Saigon ',1,13000,NULL),(256,135,'Bia Saigon ',1,13000,NULL),(257,135,'Bia Saigon ',1,13000,NULL),(258,135,'Bia Saigon ',1,13000,NULL),(259,135,'Bia Saigon ',1,13000,NULL),(260,135,'cocacola',1,15000,NULL),(261,135,'cocacola',1,15000,NULL),(262,135,'revice',1,15000,NULL),(263,136,'Bia Saigon ',1,13000,NULL),(264,136,'Bia Saigon ',1,13000,NULL),(265,136,'cocacola',1,15000,NULL),(266,136,'Bia Saigon ',1,13000,NULL),(267,137,'Bia Saigon ',1,13000,NULL),(268,137,'Bia Saigon ',1,13000,NULL),(269,137,'Bia Saigon ',1,13000,NULL),(270,138,'Bia Saigon ',1,13000,NULL),(271,138,'Bia Saigon ',1,13000,NULL),(272,138,'Bia Saigon ',1,13000,NULL),(273,138,'cocacola',1,15000,NULL),(274,138,'revice',1,15000,NULL),(275,139,'Bia Saigon ',1,13000,NULL),(276,139,'Bia Saigon ',1,13000,NULL),(277,140,'Bia Saigon ',2,26000,NULL),(278,140,'cocacola',3,45000,NULL),(279,141,'Bia Saigon ',1,13000,NULL),(280,141,'Bia Saigon ',1,13000,NULL),(281,141,'Bia Saigon ',1,13000,NULL),(282,142,'Bia Saigon ',1,13000,NULL),(283,142,'Bia Saigon ',1,13000,NULL),(284,142,'Bia Saigon ',1,13000,NULL),(285,142,'Bia Saigon ',1,13000,NULL),(286,143,'Bia Saigon ',1,13000,NULL),(287,143,'Bia Saigon ',1,13000,NULL),(288,144,'Bia Saigon ',21,273000,NULL),(289,144,'cocacola',2,30000,NULL),(290,145,'Bia Saigon ',3,39000,NULL),(291,145,'cocacola',3,45000,NULL),(292,146,'Bia Saigon ',21,273000,NULL),(293,146,'cocacola',2,30000,NULL),(294,147,'Bia Saigon ',1,13000,NULL),(295,147,'Bia Saigon ',1,13000,NULL),(296,147,'Bia Saigon ',1,13000,NULL),(297,148,'Bia Saigon ',21,273000,NULL),(298,149,'Bia Saigon ',1,13000,NULL),(299,149,'Bia Saigon ',1,13000,NULL),(300,149,'Bia Saigon ',1,13000,NULL),(301,150,'Bia Saigon ',2000,26000000,NULL),(302,151,'Bia Saigon ',23,299000,NULL),(303,152,'Bia Saigon ',1,13000,NULL),(304,152,'Bia Saigon ',1,13000,NULL),(305,152,'Bia Saigon ',1,13000,NULL),(306,152,'Bia Saigon ',1,13000,NULL),(307,152,'Bia Saigon ',1,13000,NULL),(308,152,'Bia Saigon ',1,13000,NULL),(309,152,'Bia Saigon ',1,13000,NULL),(310,152,'Bia Saigon ',1,13000,NULL),(311,152,'Bia Saigon ',1,13000,NULL),(312,152,'Bia Saigon ',1,13000,NULL),(313,153,'Bia Saigon ',1,13000,NULL),(314,153,'Bia Saigon ',1,13000,NULL),(315,153,'Bia Saigon ',1,13000,NULL),(316,154,'Bia Saigon ',1,13000,NULL),(317,154,'Bia Saigon ',1,13000,NULL),(318,154,'Bia Saigon ',1,13000,NULL),(319,154,'Bia Saigon ',1,13000,NULL),(320,154,'Bia Saigon ',1,13000,NULL),(321,155,'Bia Saigon ',2,26000,NULL),(322,155,'Bia Saigon ',3,39000,NULL),(323,156,'Bia Saigon ',2547,33111000,NULL),(324,157,'Heo rừng xào xả ớt',1,200000,NULL),(325,157,'Heo rừng xào xả ớt',1,200000,NULL),(326,157,'Heo rừng xào xả ớt',1,200000,NULL),(327,157,'Lòng xào dưa',1,31000,NULL),(328,157,'Lòng xào dưa',1,31000,NULL),(329,158,'Heo rừng xào xả ớt',1,200000,NULL),(330,158,'Lòng xào dưa',1,31000,NULL),(331,158,'Heo rừng xào xả ớt',1,200000,NULL),(332,159,'Heo rừng xào xả ớt',1,200000,NULL),(333,159,'Lòng xào dưa',1,31000,NULL),(334,160,'Lòng xào dưa',1,31000,NULL),(335,160,'Heo rừng xào xả ớt',1,200000,NULL),(336,160,'Lòng xào dưa',1,31000,NULL),(337,161,'Bia Saigon ',1,13000,NULL),(338,161,'Heo rừng xào xả ớt',1,200000,NULL),(339,161,'Lòng xào dưa',1,31000,NULL),(340,161,'Lâủ cá lănng',1,310000,NULL),(341,162,'Heo rừng xào xả ớt',12,2400000,NULL),(342,162,'Lòng xào dưa',2,62000,NULL),(343,163,'Heo rừng xào xả ớt',2,400000,NULL),(344,163,'Bia Saigon ',100,1300000,NULL),(345,164,'Bia Saigon ',1,13000,NULL),(346,164,'Bia Saigon ',1,13000,NULL),(347,164,'Bia Saigon ',1,13000,NULL),(348,164,'Bia Saigon ',1,13000,NULL),(349,164,'Bia Saigon ',1,13000,NULL),(350,164,'Heo rừng xào xả ớt',1,200000,NULL),(351,164,'Heo rừng xào xả ớt',1,200000,NULL),(352,164,'Heo rừng xào xả ớt',1,200000,NULL),(353,164,'Heo rừng xào xả ớt',1,200000,NULL),(354,164,'Heo rừng xào xả ớt',1,200000,NULL),(355,164,'Heo rừng xào xả ớt',1,200000,NULL),(356,164,'Lòng xào dưa',1,31000,NULL),(357,164,'Lòng xào dưa',1,31000,NULL),(358,164,'Lòng xào dưa',1,31000,NULL),(359,164,'Lòng xào dưa',1,31000,NULL),(360,164,'Lòng xào dưa',1,31000,NULL),(361,164,'Lòng xào dưa',1,31000,NULL),(362,164,'Lòng xào dưa',1,31000,NULL),(363,164,'Lòng xào dưa',1,31000,NULL),(364,164,'cocacola',1,15000,NULL),(365,164,'cocacola',1,15000,NULL),(366,164,'cocacola',1,15000,NULL),(367,164,'cocacola',1,15000,NULL),(368,164,'cocacola',1,15000,NULL),(369,165,'Bia Saigon ',1,13000,NULL),(370,165,'Bia Saigon ',1,13000,NULL),(371,165,'Heo rừng xào xả ớt',1,200000,NULL),(372,165,'cocacola',1,15000,NULL),(373,165,'cocacola',1,15000,NULL),(374,166,'Heo rừng xào xả ớt',1,200000,NULL),(375,166,'Lòng xào dưa',1,31000,NULL),(376,166,'cocacola',1,15000,NULL),(377,166,'Bia Saigon ',1,13000,NULL),(378,167,'Bia Saigon ',1,13000,NULL),(379,167,'Heo rừng xào xả ớt',1,200000,NULL),(380,167,'Lòng xào dưa',1,31000,NULL),(381,167,'cocacola',1,15000,NULL),(382,168,'Bia Saigon ',2,26000,NULL),(383,169,'Bia Saigon ',2,26000,NULL),(384,169,'cocacola',3,45000,NULL),(385,170,'Heo rừng xào xả ớt',12,2400000,NULL),(386,170,'Lòng xào dưa',2,62000,NULL),(387,171,'Bia Saigon ',123,1599000,NULL),(388,172,'Bia Saigon ',12,156000,NULL),(389,172,'cocacola',2,30000,NULL),(390,172,'revice',3,45000,NULL),(391,173,'cocacola',3,45000,NULL),(392,174,'Bia Saigon ',1,13000,NULL),(393,174,'Heo rừng xào xả ớt',1,200000,NULL),(394,174,'Lòng xào dưa',1,31000,NULL),(395,175,'cocacola',3,45000,NULL),(396,176,'Bia Saigon ',3,39000,NULL),(397,176,'cocacola',3,45000,NULL),(398,177,'Bia Saigon ',3,39000,NULL),(399,177,'cocacola',3,45000,NULL),(400,177,'revice',2,30000,NULL),(401,178,'Bia Saigon ',2,26000,NULL),(402,178,'cocacola',3,45000,NULL),(403,179,'Cua hoàng đế hấp',12,5000000,48),(404,179,'Phật nhảy tường',12,1000000,49),(405,179,'Rồng xanh vượt đại dương',7,1000000,50),(406,179,'Sườn nướng',14,200000,51),(407,179,'Whisky',7,3000000,53),(408,179,'Heniken',4,30000,54),(409,179,'Tiger',15,25000,55),(410,179,'Tiger',1,25000,55),(411,179,'Tiger',1,25000,55),(412,179,'Thuốc lá 555',8,50000,56),(413,179,'Khăn giấy',1,1000,57),(414,180,'Sườn nướng',4,200000,51),(415,180,'Rồng xanh vượt đại dương',2,1000000,50),(416,180,'Whisky',1,3000000,53),(417,180,'Beefsteak',1,300000,52),(418,181,'Phật nhảy tường',2,1000000,49),(419,181,'Cua hoàng đế hấp',1,5000000,48),(420,181,'Rồng xanh vượt đại dương',3,1000000,50),(421,181,'Sườn nướng',2,200000,51),(422,182,'Cua hoàng đế hấp',3,5000000,48),(423,182,'Phật nhảy tường',3,1000000,49),(424,183,'Phật nhảy tường',3,1000000,49),(425,183,'Cua hoàng đế hấp',2,5000000,48),(426,184,'Cua hoàng đế hấp',17,5000000,48),(427,184,'Phật nhảy tường',1,1000000,49),(428,184,'Rồng xanh vượt đại dương',2,1000000,50),(429,184,'Sườn nướng',2,200000,51),(430,184,'Whisky',1,3000000,53),(431,184,'Heniken',1,30000,54),(432,184,'Tiger',1,25000,55),(433,184,'Thuốc lá 555',1,50000,56),(434,185,'Phật nhảy tường',4,1000000,49),(435,185,'Cua hoàng đế hấp',2,5000000,48),(436,186,'Phật nhảy tường',2,1000000,49),(437,186,'Cua hoàng đế hấp',2,5000000,48),(438,186,'Rồng xanh vượt đại dương',2,1000000,50),(439,186,'Sườn nướng',2,200000,51),(440,187,'Phật nhảy tường',3,1000000,49),(441,187,'Cua hoàng đế hấp',2,5000000,48),(442,187,'Sườn nướng',4,200000,51),(443,187,'Tiger',2,25000,55),(444,187,'Heniken',2,30000,54),(445,188,'Cua hoàng đế hấp',1,5000000,48),(446,188,'Phật nhảy tường',1,1000000,49),(447,188,'Rồng xanh vượt đại dương',1,1000000,50),(448,188,'Sườn nướng',1,200000,51),(449,188,'Whisky',2,3000000,53),(450,188,'Heniken',1,30000,54),(451,188,'Tiger',1,25000,55),(452,189,'Phật nhảy tường',1,1000000,49),(453,189,'Rồng xanh vượt đại dương',1,1000000,50),(454,189,'Cua hoàng đế hấp',1,5000000,48),(455,190,'Cua hoàng đế hấp',1,5000000,48),(456,190,'Phật nhảy tường',1,1000000,49),(457,190,'Rồng xanh vượt đại dương',1,1000000,50),(458,190,'Heniken',1,30000,54),(459,191,'Cua hoàng đế hấp',1,5000000,48),(460,191,'Phật nhảy tường',1,1000000,49),(461,191,'Rồng xanh vượt đại dương',1,1000000,50);
/*!40000 ALTER TABLE `invoicedetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kho`
--

DROP TABLE IF EXISTS `kho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kho` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productID` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `kho_prrod_idx` (`productID`),
  CONSTRAINT `kho_prrod` FOREIGN KEY (`productID`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kho`
--

LOCK TABLES `kho` WRITE;
/*!40000 ALTER TABLE `kho` DISABLE KEYS */;
INSERT INTO `kho` VALUES (7,53,689),(8,54,491),(9,55,4979);
/*!40000 ALTER TABLE `kho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `message` varchar(500) DEFAULT NULL,
  `raw` varchar(210) DEFAULT NULL,
  `imageUrl` varchar(210) DEFAULT NULL,
  `sendBy` int NOT NULL,
  `dateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FksendBy_idx` (`sendBy`),
  KEY `Fk_type_idx` (`type`),
  CONSTRAINT `Fk_type` FOREIGN KEY (`type`) REFERENCES `type_message` (`id`),
  CONSTRAINT `FksendBy` FOREIGN KEY (`sendBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (2,1,'i love u',NULL,NULL,3,'2023-09-23 12:29:53'),(3,1,'hgf',NULL,NULL,7,'2023-09-28 04:46:01'),(4,1,'fsfsdfsdf',NULL,NULL,4,'2023-10-16 13:01:52'),(5,1,'đasad',NULL,NULL,4,'2023-10-16 13:02:30'),(6,1,'fdsfsdfs',NULL,NULL,7,'2023-10-16 13:03:51'),(7,1,'lllll',NULL,NULL,4,'2023-10-22 10:19:27'),(8,1,'g',NULL,NULL,37,'2023-10-27 06:08:42'),(9,1,'đâsdasdasdas',NULL,NULL,7,'2023-10-27 06:08:50'),(10,1,'vvvv',NULL,NULL,4,'2023-10-27 06:27:49'),(11,1,'ffffff',NULL,NULL,7,'2023-10-30 14:32:30'),(12,1,'đâsdasdasd',NULL,NULL,6,'2023-10-30 14:32:38'),(13,1,'dsdsdddd',NULL,NULL,7,'2023-10-30 14:44:20'),(14,1,'trugn testeerrfttree',NULL,NULL,6,'2023-10-30 14:44:38'),(15,1,'dsdsadas',NULL,NULL,7,'2023-11-01 12:10:15');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhaphang`
--

DROP TABLE IF EXISTS `nhaphang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhaphang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productID` int DEFAULT NULL,
  `soLuong` int DEFAULT NULL,
  `donGia` double NOT NULL,
  `ngayNhap` datetime NOT NULL,
  `dvtID` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `nh_product_idx` (`productID`),
  KEY `nh_donViTinh_idx` (`dvtID`),
  CONSTRAINT `nh_donViTinh` FOREIGN KEY (`dvtID`) REFERENCES `donvitinh` (`id`),
  CONSTRAINT `nh_product` FOREIGN KEY (`productID`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhaphang`
--

LOCK TABLES `nhaphang` WRITE;
/*!40000 ALTER TABLE `nhaphang` DISABLE KEYS */;
INSERT INTO `nhaphang` VALUES (19,NULL,200,9000,'2023-08-29 21:23:15',1),(20,NULL,200,9000,'2023-08-29 21:23:26',1),(21,NULL,500,10000,'2023-08-30 09:28:55',5),(22,NULL,100,10000,'2023-08-30 09:29:17',5),(23,NULL,100,9000,'2023-10-18 20:54:00',1),(24,NULL,100,9000,'2023-10-18 20:54:02',1),(25,NULL,100,9000,'2023-10-18 20:54:02',1),(26,NULL,100,9000,'2023-10-18 20:54:02',1),(27,NULL,100,10000,'2023-10-18 21:16:54',5),(28,NULL,100,10000,'2023-10-18 21:17:13',5),(29,NULL,100,10000,'2023-10-18 21:18:40',5),(30,NULL,5000,10000,'2023-10-30 10:09:40',1),(31,NULL,5000,10000,'2023-10-30 10:09:45',1),(32,NULL,5000,10000,'2023-10-30 10:09:47',1),(33,NULL,5000,12000,'2023-10-30 20:57:26',1),(34,NULL,5000,12000,'2023-10-30 20:57:28',1),(35,53,200,2500000,'2023-10-31 17:08:39',5),(36,54,500,20000,'2023-10-31 17:09:14',1),(37,55,5000,25000,'2023-11-01 09:20:21',1),(38,53,500,500000,'2023-11-01 12:52:05',5);
/*!40000 ALTER TABLE `nhaphang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `productID` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `subTotal` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `order_ID_idx` (`orderID`),
  KEY `product_order_idx` (`productID`),
  CONSTRAINT `order_ID` FOREIGN KEY (`orderID`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_order` FOREIGN KEY (`productID`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (594,640,48,24,30000000),(595,641,50,2,2000000),(597,643,51,7,1400000),(622,668,55,1,25000),(623,669,49,1,1000000),(624,670,48,1,5000000),(625,671,49,1,1000000),(626,672,53,2,6000000),(627,673,52,1,300000);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `tableID` int DEFAULT NULL,
  `orderDate` datetime NOT NULL,
  `totalAmount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_order_idx` (`userID`),
  KEY `table_order_idx` (`tableID`),
  CONSTRAINT `table_order` FOREIGN KEY (`tableID`) REFERENCES `tables` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `user_order` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=674 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (640,4,22,'2023-11-01 17:57:21',5000000),(641,4,22,'2023-11-01 17:57:22',1000000),(643,4,22,'2023-11-01 19:04:43',200000),(668,4,22,'2023-11-01 20:22:40',25000),(669,4,34,'2023-11-01 20:23:49',1000000),(670,4,34,'2023-11-01 20:23:49',5000000),(671,4,22,'2023-11-01 20:23:58',1000000),(672,4,22,'2023-11-01 20:24:04',3000000),(673,4,22,'2023-11-01 20:24:06',300000);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `category` int NOT NULL,
  `status` int DEFAULT NULL,
  `dvtID` int NOT NULL,
  `imgUrl` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `category_idx` (`category`),
  KEY `status_idx` (`status`),
  KEY `donViTinh_idx` (`dvtID`),
  CONSTRAINT `category` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  CONSTRAINT `status` FOREIGN KEY (`status`) REFERENCES `statusproduct` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (48,'Cua hoàng đế hấp',5000000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746262329_16080023019733_cua-hoang-de-lam-mon-gi-ngon-3-1.jpg?alt=media&token=ab5cc14b-e784-46f7-8494-4afa622aa0b4'),(49,'Phật nhảy tường',1000000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746482466_146822291575712-phat4.jpg?alt=media&token=04fc0006-0dc6-4e85-a4e1-0d124ea9553b'),(50,'Rồng xanh vượt đại dương',1000000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746515878_Thanh-pham-1-1-5394-1650361176.jpg?alt=media&token=210b5f67-c752-4695-a731-2ef148a116c0'),(51,'Sườn nướng',200000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746588117_suon-nuong-mat-ong-2.jpg?alt=media&token=d89f80ed-dc09-4c78-abf2-5dfb1cffa1d4'),(52,'Beefsteak',300000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746663586_steak_10_b1b1397477ea4c8ca1f215989632a614_1024x1024.jpg?alt=media&token=abc630c9-472f-4823-96c0-0fda890df7af'),(53,'Whisky',3000000,2,NULL,5,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746794965_Jack-Daniels-No.7-Whiskey-500-ml.jpg?alt=media&token=adabb0e1-1b94-4fc7-94cf-e3d8483f57b3'),(54,'Heniken',30000,2,NULL,1,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698746854677_download.jfif?alt=media&token=55ec845b-cd0a-4bcb-b192-c89cd509d02b'),(55,'Tiger',25000,2,NULL,1,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698747888961_bia-tiger-lon-330ml-2023227.jpg?alt=media&token=cc76e568-0fee-4b6b-b907-951ba39ce900'),(56,'Thuốc lá 555',50000,3,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698748577001_ship-thuoc-la-3-so-555-ha-noi.jpg?alt=media&token=0e1e4f5c-07d0-4a71-86da-a9dc6aeeca91'),(57,'Khăn giấy',1000,3,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1698748615327_khan-giay-mylan-gau-truc-300-to-2.webp?alt=media&token=28e6ec96-e670-4f94-a4f6-6c1648fb796b');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurantName` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bankNumber` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'AZFOOD','BMT','0987654321','123456789');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusproduct`
--

DROP TABLE IF EXISTS `statusproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statusproduct` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusproduct`
--

LOCK TABLES `statusproduct` WRITE;
/*!40000 ALTER TABLE `statusproduct` DISABLE KEYS */;
INSERT INTO `statusproduct` VALUES (1,'Còn món'),(2,'Hết món');
/*!40000 ALTER TABLE `statusproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statustable`
--

DROP TABLE IF EXISTS `statustable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statustable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statustable`
--

LOCK TABLES `statustable` WRITE;
/*!40000 ALTER TABLE `statustable` DISABLE KEYS */;
INSERT INTO `statustable` VALUES (2,'Bàn đã thanh toán'),(1,'Bàn đang có khách'),(3,'Bàn đang trống');
/*!40000 ALTER TABLE `statustable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `status_table_idx` (`status`),
  CONSTRAINT `status_table` FOREIGN KEY (`status`) REFERENCES `statustable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (22,'Bàn số 1',1),(34,'Bàn số 2',1),(35,'Bàn số 3',3),(36,'Bàn số 4',3),(37,'Bàn số 5',3),(38,'Bàn số 6',3),(39,'Bàn số 7',3);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_message`
--

DROP TABLE IF EXISTS `type_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_message`
--

LOCK TABLES `type_message` WRITE;
/*!40000 ALTER TABLE `type_message` DISABLE KEYS */;
INSERT INTO `type_message` VALUES (1,'Văn Bản'),(2,'Hình ảnh'),(3,'Âm thanh');
/*!40000 ALTER TABLE `type_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `role` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `imgUrl` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `createAt` datetime DEFAULT NULL,
  `birtDay` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'huyhuy123','601f1889667efaebb33b8c12572835da3f027f78','Hoàng Huy','user','trungntpk02230@gmail.com','1234567890','229 Y moan, phường Tân An','https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2Fusersss%2F1698674486667_Screenshot%202023-10-22%20175205.png?alt=media&token=12dcd97b-ab9e-4819-ba65-395e1f0e06a4',NULL,'20/09/2002'),(4,'huy123','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Quốc Huy','admin','huy123@gmail.com','1234567890',NULL,NULL,NULL,NULL),(6,'huy12345','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Quốc Huy','admin','huy123@gmail.com','1234567890',NULL,NULL,NULL,NULL),(7,'trung123','7c4a8d09ca3762af61e59520943dc26494f8941b','Tấn Trung','user','trung123123@gmail.com','0987654123','hà huy tập','https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2Fusersss%2F1693224688545_headphone2.jpeg?alt=media&token=69e73bc2-3af5-4877-879a-e0655c4237fc',NULL,'16/10/2002'),(35,'trungtrung2','60149a289a3623cd214943af2892e103f4bddafb','trung 11122','user','trungii@gmail.com','0987654321','ha huy tap','https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2Fusersss%2F1697730632422_camera-icon.png?alt=media&token=1353ddc7-0ef2-496f-bfdf-7581ed08ea7e','2023-10-19 22:31:22','12/09/2000'),(37,'trung111','601f1889667efaebb33b8c12572835da3f027f78','Nguyễn Trung','user',NULL,'0987654321',NULL,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2Fusersss%2F1698386837266_Screenshot%202023-10-22%20175205.png?alt=media&token=2d489f92-accd-4a0f-bea3-177cccd5090d','2023-10-27 13:07:19',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-01 20:38:48
