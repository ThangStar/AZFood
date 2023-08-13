-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: localhost    Database: finallapp
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
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
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` double NOT NULL,
  `createAt` datetime NOT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `tableID` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (6,930000,'2023-08-13 12:20:50','Hoàng Quốc Huy',NULL),(7,323000,'2023-08-13 12:28:04','Hoàng Quốc Huy',5);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoiceDetials`
--

DROP TABLE IF EXISTS `invoiceDetials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoiceDetials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceID` int NOT NULL,
  `poductName` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  `totalAmount` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `invoice_idx` (`invoiceID`),
  CONSTRAINT `invoice` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoiceDetials`
--

LOCK TABLES `invoiceDetials` WRITE;
/*!40000 ALTER TABLE `invoiceDetials` DISABLE KEYS */;
INSERT INTO `invoiceDetials` VALUES (7,6,'Dê hấp thố',3,930000),(8,7,'Bia Saigon ',1,13000),(9,7,'Dê hấp thố',1,310000);
/*!40000 ALTER TABLE `invoiceDetials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderItems`
--

DROP TABLE IF EXISTS `orderItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orderItems` (
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderItems`
--

LOCK TABLES `orderItems` WRITE;
/*!40000 ALTER TABLE `orderItems` DISABLE KEYS */;
INSERT INTO `orderItems` VALUES (9,23,1,2,600000),(10,24,3,1,310000),(12,26,3,1,310000),(13,27,2,1,13000);
/*!40000 ALTER TABLE `orderItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (23,6,4,'2023-08-13 12:18:42',600000),(24,6,4,'2023-08-13 12:18:53',310000),(26,6,4,'2023-08-13 12:26:14',310000),(27,6,4,'2023-08-13 12:26:23',13000);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `category` int NOT NULL,
  `status` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `category_idx` (`category`),
  KEY `status_idx` (`status`),
  CONSTRAINT `category` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  CONSTRAINT `status` FOREIGN KEY (`status`) REFERENCES `statusProduct` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Lẩu gà lá giang',300000,1,1,NULL),(2,'Bia Saigon ',13000,2,NULL,100),(3,'Dê hấp thố',310000,1,1,0),(5,'cocacola',310000,2,NULL,120);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusProduct`
--

DROP TABLE IF EXISTS `statusProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `statusProduct` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusProduct`
--

LOCK TABLES `statusProduct` WRITE;
/*!40000 ALTER TABLE `statusProduct` DISABLE KEYS */;
INSERT INTO `statusProduct` VALUES (1,'Còn món'),(2,'Hết món');
/*!40000 ALTER TABLE `statusProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusTable`
--

DROP TABLE IF EXISTS `statusTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `statusTable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusTable`
--

LOCK TABLES `statusTable` WRITE;
/*!40000 ALTER TABLE `statusTable` DISABLE KEYS */;
INSERT INTO `statusTable` VALUES (2,'Đang bận'),(1,'Đang chờ'),(3,'Trống');
/*!40000 ALTER TABLE `statusTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `status_table_idx` (`status`),
  CONSTRAINT `status_table` FOREIGN KEY (`status`) REFERENCES `statusTable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,'Bàn số 2',2),(2,'Bàn số 1',1),(4,'Bàn số 3',2),(5,'bàn số 4',1);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phoneNumber` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'huyhuy123','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Huy','user','1234567890','huy123@gmail.com'),(4,'huy123','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Quốc Huy','admin','1234567890','huy123@gmail.com'),(6,'huy12345','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Quốc Huy','admin','1234567890','huy123@gmail.com');
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

-- Dump completed on 2023-08-13 12:30:03
