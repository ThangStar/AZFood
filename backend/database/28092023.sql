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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `date` datetime NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `userID_idx` (`userID`),
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (7,4,'2023-09-28 14:59:59','đi làm '),(8,4,'2023-09-28 15:15:23','đi làm '),(9,4,'2023-09-28 00:00:00','đi làm '),(10,7,'2023-09-28 00:00:00','đi làm ');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Table structure for table `donvitinh`
--

DROP TABLE IF EXISTS `donvitinh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `donvitinh` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tenDVT` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` double NOT NULL,
  `createAt` datetime NOT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `tableID` int DEFAULT NULL,
  `invoiceNumber` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (6,930000,'2023-08-13 12:20:50','Hoàng Quốc Huy',NULL,''),(7,323000,'2023-08-13 12:28:04','Hoàng Quốc Huy',5,''),(8,1233000,'2023-08-15 21:37:17','Hoàng Quốc Huy',4,''),(9,1233000,'2023-08-15 21:38:15','Hoàng Quốc Huy',4,''),(10,1233000,'2023-08-15 21:38:27','Hoàng Quốc Huy',4,''),(11,1233000,'2023-08-15 21:39:54','Hoàng Quốc Huy',4,''),(12,1233000,'2023-08-15 21:43:00','Hoàng Quốc Huy',4,''),(13,1593000,'2023-08-29 20:26:06','Hoàng Quốc Huy',5,''),(14,5680000,'2023-09-07 09:52:14','Hoàng Quốc Huy',2,''),(15,310000,'2023-09-07 10:16:02','Hoàng Quốc Huy',2,''),(16,310000,'2023-09-07 10:16:56','Hoàng Quốc Huy',2,''),(17,310000,'2023-09-07 10:17:45','Hoàng Quốc Huy',2,''),(20,460000,'2023-09-07 16:44:16','Hoàng Quốc Huy',2,'216644');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoicedetails`
--

DROP TABLE IF EXISTS `invoicedetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoicedetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceID` int NOT NULL,
  `poductName` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  `totalAmount` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `invoice_idx` (`invoiceID`),
  CONSTRAINT `invoice` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoicedetails`
--

LOCK TABLES `invoicedetails` WRITE;
/*!40000 ALTER TABLE `invoicedetails` DISABLE KEYS */;
INSERT INTO `invoicedetails` VALUES (7,6,'Dê hấp thố',3,930000),(8,7,'Bia Saigon ',1,13000),(9,7,'Dê hấp thố',1,310000),(10,10,'Lẩu gà lá giang',2,600000),(11,10,'Dê hấp thố',1,310000),(12,10,'Dê hấp thố',1,310000),(13,10,'Bia Saigon ',1,13000),(14,11,'Lẩu gà lá giang',2,600000),(15,11,'Dê hấp thố',1,310000),(16,11,'Dê hấp thố',1,310000),(17,11,'Bia Saigon ',1,13000),(18,12,'Lẩu gà lá giang',2,600000),(19,12,'Dê hấp thố',1,310000),(20,12,'Dê hấp thố',1,310000),(21,12,'Bia Saigon ',1,13000),(22,13,'Bia Saigon ',1,13000),(23,13,'Lâủ cá lănng',3,930000),(24,13,'Bia Saigon ',50,650000),(25,14,'Dúi Xáoo Măng',5,4000000),(26,14,'Lâủ cá lănng',2,620000),(27,14,'revice',50,750000),(28,14,'Lòng xào dưa',10,310000),(29,15,'Lâủ cá lănng',1,310000),(30,16,'Lâủ cá lănng',1,310000),(31,17,'Lâủ cá lănng',1,310000),(32,20,'revice',10,150000),(33,20,'Lòng xào dưa',10,310000);
/*!40000 ALTER TABLE `invoicedetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kho`
--

DROP TABLE IF EXISTS `kho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `kho` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productID` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `kho_prrod_idx` (`productID`),
  CONSTRAINT `kho_prrod` FOREIGN KEY (`productID`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kho`
--

LOCK TABLES `kho` WRITE;
/*!40000 ALTER TABLE `kho` DISABLE KEYS */;
INSERT INTO `kho` VALUES (4,2,400),(5,19,540);
/*!40000 ALTER TABLE `kho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (2,1,'i love u',NULL,NULL,3,'2023-09-23 12:29:53'),(3,1,'hgf',NULL,NULL,7,'2023-09-28 04:46:01');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhaphang`
--

DROP TABLE IF EXISTS `nhaphang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `nhaphang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productID` int NOT NULL,
  `soLuong` int DEFAULT NULL,
  `donGia` double NOT NULL,
  `ngayNhap` datetime NOT NULL,
  `dvtID` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `nh_product_idx` (`productID`),
  KEY `nh_donViTinh_idx` (`dvtID`),
  CONSTRAINT `nh_donViTinh` FOREIGN KEY (`dvtID`) REFERENCES `donvitinh` (`id`),
  CONSTRAINT `nh_product` FOREIGN KEY (`productID`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhaphang`
--

LOCK TABLES `nhaphang` WRITE;
/*!40000 ALTER TABLE `nhaphang` DISABLE KEYS */;
INSERT INTO `nhaphang` VALUES (19,2,200,9000,'2023-08-29 21:23:15',1),(20,2,200,9000,'2023-08-29 21:23:26',1),(21,19,500,10000,'2023-08-30 09:28:55',5),(22,19,100,10000,'2023-08-30 09:29:17',5);
/*!40000 ALTER TABLE `nhaphang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (45,59,17,1,31000),(48,62,2,1,13000),(49,63,2,1,13000);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (59,4,1,'2023-09-07 11:14:33',31000),(62,4,1,'2023-09-23 11:55:43',13000),(63,7,2,'2023-09-28 10:57:48',13000);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'Bia Saigon ',13000,2,NULL,1,''),(6,'Lâủ cá lănng',310000,1,1,1,''),(7,'Dúi Xáoo Măng',800000,1,2,3,''),(16,'Heo rừng xào xả ớt',200000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1693046324358_headphone.jpeg?alt=media&token=54245a5e-b83d-42ae-8c1f-a405a2cbf16b'),(17,'Lòng xào dưa',31000,1,1,3,'https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2F1693222508566_macbookPro2.jpeg?alt=media&token=f0fe055d-5f14-4130-a69e-a286c2d91374'),(18,'cocacola',15000,2,NULL,1,NULL),(19,'revice',15000,2,NULL,5,NULL),(31,'ewewewew',3232,1,NULL,1,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusproduct`
--

DROP TABLE IF EXISTS `statusproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
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
INSERT INTO `statustable` VALUES (2,'Đang bận'),(1,'Đang chờ'),(3,'Trống');
/*!40000 ALTER TABLE `statustable` ENABLE KEYS */;
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
  CONSTRAINT `status_table` FOREIGN KEY (`status`) REFERENCES `statustable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,'Bàn số 2',1),(2,'Bàn số 1',2),(4,'Bàn số 3',3),(5,'bàn số 4',3),(6,'bàn 6',3),(8,'bàn 5',3),(9,'bàn 7',3),(10,'bàn 8',3);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_message`
--

DROP TABLE IF EXISTS `type_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phoneNumber` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `imgUrl` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'huyhuy123','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Huy','user','1234567890','huy123@gmail.com',NULL,NULL),(4,'huy123','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Quốc Huy','admin','1234567890','huy123@gmail.com',NULL,NULL),(6,'huy12345','7c4a8d09ca3762af61e59520943dc26494f8941b','Hoàng Quốc Huy','admin','1234567890','huy123@gmail.com',NULL,NULL),(7,'trung123','7c4a8d09ca3762af61e59520943dc26494f8941b','Tấn Trung','user','1234567890','trung@gmail.com','hà huy tập','https://firebasestorage.googleapis.com/v0/b/restaurant-manager-b9f86.appspot.com/o/files%2Fusersss%2F1693224688545_headphone2.jpeg?alt=media&token=69e73bc2-3af5-4877-879a-e0655c4237fc');
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

-- Dump completed on 2023-09-28 15:24:32
