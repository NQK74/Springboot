-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: laptopshop
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `cart_details`
--
create database if not exists `laptopshop` default character set utf8mb4 collate utf8mb4_0900_ai_ci;
use `laptopshop`;

DROP TABLE IF EXISTS `cart_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `quantity` bigint NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `selected` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkcochhsa891wv0s9wrtf36wgt` (`cart_id`),
  KEY `FK9rlic3aynl3g75jvedkx84lhv` (`product_id`),
  CONSTRAINT `FK9rlic3aynl3g75jvedkx84lhv` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKkcochhsa891wv0s9wrtf36wgt` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_details`
--

LOCK TABLES `cart_details` WRITE;
/*!40000 ALTER TABLE `cart_details` DISABLE KEYS */;
INSERT INTO `cart_details` VALUES (71,21990000,1,3,7,_binary ''),(72,35990000,1,3,6,_binary ''),(73,18490000,1,3,11,_binary ''),(93,18490000,1,2,11,_binary '');
/*!40000 ALTER TABLE `cart_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sum` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK64t7ox312pqal3p7fg9o503c2` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,0,8),(2,1,7),(3,3,1);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`),
  CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (15490000,1,33,15,2),(17490000,1,35,17,1),(35990000,5,40,21,6),(19500000,1,41,21,3),(15490000,1,42,21,2),(35990000,1,47,25,6),(19500000,1,48,25,3),(19500000,4,50,27,3),(35990000,1,51,27,6),(17490000,3,52,27,1),(14990000,2,53,27,9),(18490000,2,54,27,11),(21990000,1,55,27,7),(19500000,1,56,28,3),(21990000,1,57,28,7),(14990000,1,58,28,9),(35990000,1,59,28,6),(19500000,1,60,29,3),(15490000,1,61,29,2),(19500000,2,62,30,3),(18490000,1,63,31,11),(17990000,1,64,31,10),(18490000,1,65,32,11),(17990000,1,66,32,10),(14990000,1,67,32,9),(15490000,8,68,33,2),(35990000,1,69,33,6),(19500000,1,70,33,3),(19500000,1,71,34,3),(15490000,10,72,35,2),(19500000,1,73,35,3),(15490000,110,74,36,2),(35990000,8,75,37,6),(15490000,3,80,39,2),(17490000,1,81,40,1),(15490000,1,82,40,2),(15490000,1,83,41,2),(17490000,1,84,41,1),(15490000,9,85,42,2),(15490000,10,87,44,2),(21990000,1,88,45,7);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `total_price` double NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `receiver_address` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `receiver_email` varchar(255) DEFAULT NULL,
  `order_date` datetime(6) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (15490000,15,8,'Nguyễn Khánh','0398794461','Nguyễn Khánh','DELIVERED','ỷ','COD','example@gmail.com',NULL,NULL),(17490000,17,7,'Nguyễn Khánh','0398794461','Nguyễn Khánh','DELIVERED','qưfswadfrs','COD','admin@gmail.com',NULL,NULL),(214940000,21,7,'Nguyễn Khánh','0398794461','Nguyễn Khánh','SHIPPED','áđa','COD','admin@gmail.com',NULL,NULL),(55490000,25,8,'Nguyễn Khánh','0398794461','Nguyễn Khánh','CANCELLED','','COD','example@gmail.com',NULL,NULL),(255410000,27,7,'áe','0398794461','ada','DELIVERED','dadad','COD','admin@gmail.com','2025-12-11 22:09:16.004997',NULL),(92470000,28,7,'Nguyễn Khánh','0398794461','âd','DELIVERED','dádssd','COD','admin@gmail.com','2025-12-11 22:11:45.939960',NULL),(34990000,29,7,'Nguyễn Khánh','0398794461','ẻgftr','SHIPPED','','COD','admin@gmail.com','2025-12-11 22:16:44.417212',NULL),(39000000,30,7,'Nguyễn Khánh','0398794461','sđ','SHIPPED','','COD','admin@gmail.com','2025-12-11 22:17:23.325137',NULL),(36480000,31,7,'Nguyễn Khánh','0398794461','dgrgd','CONFIRMED','','COD','admin@gmail.com','2025-12-11 22:17:33.591536',NULL),(51470000,32,7,'Nguyễn Khánh','0398794461','Nguyễn Khánher','DELIVERED','rể','COD','admin@gmail.com','2025-12-11 22:17:45.583021',NULL),(179410000,33,8,'đè','AFDAEFĐSFD','À','DELIVERED','FÁDFAFAAS','COD','example@gmail.com','2025-12-11 22:34:31.837524',NULL),(19500000,34,8,'đè','AFDAEFĐSFD','eqewwq','CONFIRMED','eqwweq','COD','example@gmail.com','2025-12-12 00:09:29.502559',NULL),(174400000,35,8,'Nguyễn Khánh','0398794461','Nguyễn Khánh','CONFIRMED','dsfdff','COD','example@gmail.com','2025-12-12 14:52:19.455713',NULL),(1703900000,36,8,'Nguyễn Khánh','0398794461','Nguyễn Khánh','DELIVERED','fgfgffgfg','COD','example@gmail.com','2025-12-12 14:52:49.653360',NULL),(287920000,37,7,'Nguyễn Khánh','0398794461','Nguyễn Khánh','DELIVERED','vf','COD','admin@gmail.com','2025-12-14 21:59:07.917234',NULL),(46470000,39,7,'Nguyễn Khánh','0398794461','Nguyễn Khánh','CONFIRMED','123','VNPAY','admin@gmail.com','2025-12-16 16:37:25.985241','PAID'),(32980000,40,8,'đè','AFDAEFĐSFD','À','CONFIRMED','ghhj','VNPAY','example@gmail.com','2025-12-17 16:00:09.586597','PAID'),(32980000,41,8,'đè','AFDAEFĐSFD','eqewwq','CONFIRMED','4ew','VNPAY','example@gmail.com','2025-12-17 16:04:55.777155','PAID'),(139410000,42,7,'Admin','0398794461','khánh','CONFIRMED','','COD','admin@gmail.com','2025-12-17 16:12:01.999750','UNPAID'),(154900000,44,7,'Admin','0398794461','khánh','CANCELLED','','COD','admin@gmail.com','2025-12-20 15:43:31.322071','UNPAID'),(21990000,45,7,'Admin','0398794461','xuân quy, triệu độ','CANCELLED','','COD','admin@gmail.com','2025-12-20 15:59:52.406830','UNPAID');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `otp_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKla2ts67g4oh2sreayswhox1i6` (`user_id`),
  CONSTRAINT `FKk3ndxg5xp6v7wd4gjyusp15gq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES (6,'2025-12-14 21:59:26.046990',NULL,4,'296289');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `price` double NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` bigint NOT NULL,
  `so_id` bigint NOT NULL,
  `detail_desc` mediumtext NOT NULL,
  `factory` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `short_desc` varchar(255) NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `products_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (17490000,1,73,0,'Laptop gaming với Intel Core i5 thế hệ 11, card đồ họa RTX 2050, RAM 16GB DDR4. Thiết kế bền bỉ chuẩn quân đội, tản nhiệt Arc Flow Fans, phím RGB.','ASUS','1711078092373-asus-tuf-gaming-f15.webp','ASUS TUF Gaming F15 FX506HF','Laptop gaming ASUS hiệu năng cao','GAMING'),(15490000,2,40,0,'Intel Core i5-1235U, RAM 16GB, SSD 512GB NVMe. Màn hình 15.6 inch Full HD chống chói, bàn phím số tiện lợi, pin 54Wh.','DELL','1711078452562-dell-inspiron-15-3520.png','Dell Inspiron 15 3520','Laptop Dell văn phòng đa năng','SINHVIEN-VANPHONG'),(19500000,3,94,0,'Intel Core i5-12450H, NVIDIA GTX 1650 4GB, RAM 8GB. Màn hình 15.6 inch 120Hz, bàn phím LED trắng, âm thanh Nahimic.','LENOVO','1711079496409-lenovo-ideapad-gaming-3.jpg','Lenovo IdeaPad Gaming 3 15IAH7','Gaming laptop Lenovo giá tốt','GAMING'),(16990000,4,110,0,'Intel Core i5-13500H, Intel Iris Xe Graphics, RAM 16GB. Màn hình OLED 15.6 inch 2.8K, 100% DCI-P3, bảo vệ mắt.','ASUS','1711079954990-asus-vivobook-15-oled.webp','ASUS Vivobook 15 OLED','Laptop ASUS màn hình OLED đẹp','THIET-KE-DO-HOA'),(27490000,5,75,0,'Chip Apple M2 8 nhân CPU 10 nhân GPU, RAM 16GB. Màn hình Liquid Retina 13.6 inch, MagSafe 3, thiết kế 4 màu.','APPLE','1711080286941-macbook-air-13-m2.png','MacBook Air 13 M2 2022','MacBook Air M2 mỏng nhẹ','SINHVIEN-VANPHONG'),(35990000,6,123,0,'Intel Core i7-1360P, Intel Iris Xe, RAM 16GB. Màn hình 17 inch 2K, trọng lượng chỉ 1.35kg, pin 80Wh 19.5 giờ.','LG','1711080707179-lg-gram-17-2023.jpg','LG Gram 17 2023','Laptop LG Gram siêu nhẹ 17 inch','THIET-KE-DO-HOA'),(21990000,7,98,0,'Intel Core i7-12650H, NVIDIA RTX 3050 Ti 4GB, RAM 16GB. Màn hình 15.6 inch 144Hz, bàn phím RGB 4 vùng, NitroSense.','ACER','1711080973171-acer-nitro-5-an515.jpg','Acer Nitro 5 AN515-58','Laptop gaming Acer tản nhiệt tốt','GAMING'),(14990000,9,140,0,'Intel Core i5-1335U, Intel Iris Xe, RAM 16GB. Màn hình 14 inch Full HD, trọng lượng 1.4kg, pin 56Wh, thiết kế mỏng.','MSI','1711082152818-msi-modern-14-c13m.jpg','MSI Modern 14 C13M','Laptop MSI Modern di động nhẹ','SINHVIEN-VANPHONG'),(17990000,10,105,0,'AMD Ryzen 5 5625U, AMD Radeon Graphics, RAM 16GB. Màn hình 14 inch Full HD IPS, bàn phím chống tràn, bảo mật vân tay.','LENOVO','1711083025647-lenovo-thinkbook-14-g4.webp','Lenovo ThinkBook 14 G4','Laptop Lenovo doanh nghiệp','SINHVIEN-VANPHONG'),(18490000,11,130,0,'Intel Core i5-1235U, Intel Iris Xe, RAM 16GB, SSD 512GB. Màn hình 15.6 inch Full HD IPS, loa B&O, vỏ nhôm.','HP','1711081278418-hp-pavilion-15-eg2.webp','HP Pavilion 15-eg2xxx','Laptop HP đa năng cao cấp','SINHVIEN-VANPHONG');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime(6) DEFAULT NULL,
  `helpful_count` int NOT NULL,
  `rating` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpl51cejpw4gy5swfar8br9ngi` (`product_id`),
  KEY `FKcgy7qjc1r99dp117y9en6lxye` (`user_id`),
  CONSTRAINT `FKcgy7qjc1r99dp117y9en6lxye` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKpl51cejpw4gy5swfar8br9ngi` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (7,'ửe','2025-12-09 21:32:09.009801',0,5,'ew',3,7),(9,'ăewwe','2025-12-09 21:40:50.372744',0,4,'ă',2,7),(10,'ửewẻ','2025-12-09 21:44:53.172732',2,5,'khánh',2,8),(11,'ai đẹp giai nhất nào','2025-12-09 22:41:11.680270',0,5,'khánh',1,8),(12,'qưre','2025-12-10 23:49:51.867231',0,5,'khánh',7,7),(13,'gffgbfgb','2025-12-12 00:02:38.905396',1,5,'gffd',11,1),(15,'fđf','2025-12-14 21:54:07.547762',0,5,'fdf',6,7);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator role','ADMIN'),(2,'User role','USER'),(3,'Staff role','STAFF'),(4,'Super Administrator - highest level access','SUPER_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session`
--

LOCK TABLES `spring_session` WRITE;
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
INSERT INTO `spring_session` VALUES ('5816e944-5fd7-4c19-8254-d82cae7741fd','18e371a4-2255-4a4f-a4c0-916961a84d53',1765869667144,1765869699637,2592000,1768461699637,'admin@gmail.com'),('71a7a295-bbec-4025-9015-729e2c7a6efb','69463f1b-cb18-4bee-9c48-6753e7de95ad',1764767777606,1764767808194,2592000,1767359808194,'example@gmail.com'),('80101ac8-4a3d-4928-b030-ef541426ccec','164a1361-6c84-49e8-8b38-7b99c20327bf',1764764313511,1764764956843,2592000,1767356956843,'example@gmail.com'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','8c1aee12-f964-486a-9f1a-c2b47ffe3355',1765961863703,1765962295996,2592000,1768554295996,'example@gmail.com'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','42ffbc82-c2fd-4997-bb96-b27e1539893b',1765870415535,1766843637202,2592000,1769435637202,'admin@gmail.com');
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session_attributes`
--

LOCK TABLES `spring_session_attributes` WRITE;
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
INSERT INTO `spring_session_attributes` VALUES ('5816e944-5fd7-4c19-8254-d82cae7741fd','avatar',_binary '�\�\0t\01765724417315_OUTFIT IDEE.jpg'),('5816e944-5fd7-4c19-8254-d82cae7741fd','email',_binary '�\�\0t\0admin@gmail.com'),('5816e944-5fd7-4c19-8254-d82cae7741fd','fullName',_binary '�\�\0t\0Admin'),('5816e944-5fd7-4c19-8254-d82cae7741fd','id',_binary '�\�\0sr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0'),('5816e944-5fd7-4c19-8254-d82cae7741fd','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('5816e944-5fd7-4c19-8254-d82cae7741fd','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$7c0997f7-b8d8-4501-a4ff-5118e94d4514'),('5816e944-5fd7-4c19-8254-d82cae7741fd','role',_binary '�\�\0t\0ADMIN'),('5816e944-5fd7-4c19-8254-d82cae7741fd','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0\nROLE_ADMINxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\00:0:0:0:0:0:0:1t\0$a0d4afa6-66a5-45df-b5aa-57ac0c5eeda0psr\02org.springframework.security.core.userdetails.User\0\0\0\0\0\0l\0Z\0accountNonExpiredZ\0accountNonLockedZ\0credentialsNonExpiredZ\0enabledL\0authoritiest\0Ljava/util/Set;L\0passwordq\0~\0L\0usernameq\0~\0xpsr\0%java.util.Collections$UnmodifiableSet��я��U\0\0xq\0~\0\nsr\0java.util.TreeSetݘP��\�[\0\0xpsr\0Forg.springframework.security.core.userdetails.User$AuthorityComparator\0\0\0\0\0\0l\0\0xpw\0\0\0q\0~\0xpt\0admin@gmail.com'),('5816e944-5fd7-4c19-8254-d82cae7741fd','sum',_binary '�\�\0sr\0java.lang.Integer⠤���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0'),('71a7a295-bbec-4025-9015-729e2c7a6efb','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('71a7a295-bbec-4025-9015-729e2c7a6efb','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$da9900ad-b01a-486a-8a76-842fe8b29af8'),('71a7a295-bbec-4025-9015-729e2c7a6efb','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0	ROLE_USERxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\00:0:0:0:0:0:0:1t\0$ad3bf7da-6605-4c77-8e51-5ae44e5deaefpsr\02org.springframework.security.core.userdetails.User\0\0\0\0\0\0l\0Z\0accountNonExpiredZ\0accountNonLockedZ\0credentialsNonExpiredZ\0enabledL\0authoritiest\0Ljava/util/Set;L\0passwordq\0~\0L\0usernameq\0~\0xpsr\0%java.util.Collections$UnmodifiableSet��я��U\0\0xq\0~\0\nsr\0java.util.TreeSetݘP��\�[\0\0xpsr\0Forg.springframework.security.core.userdetails.User$AuthorityComparator\0\0\0\0\0\0l\0\0xpw\0\0\0q\0~\0xpt\0example@gmail.com'),('71a7a295-bbec-4025-9015-729e2c7a6efb','SPRING_SECURITY_SAVED_REQUEST',_binary '�\�\0sr\0Aorg.springframework.security.web.savedrequest.DefaultSavedRequest\0\0\0\0\0\0l\0I\0\nserverPortL\0contextPatht\0Ljava/lang/String;L\0cookiest\0Ljava/util/ArrayList;L\0headerst\0Ljava/util/Map;L\0localesq\0~\0L\0matchingRequestParameterNameq\0~\0L\0methodq\0~\0L\0\nparametersq\0~\0L\0pathInfoq\0~\0L\0queryStringq\0~\0L\0\nrequestURIq\0~\0L\0\nrequestURLq\0~\0L\0schemeq\0~\0L\0\nserverNameq\0~\0L\0servletPathq\0~\0xp\0\0�t\0\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\09org.springframework.security.web.savedrequest.SavedCookie\0\0\0\0\0\0l\0I\0maxAgeZ\0secureI\0versionL\0commentq\0~\0L\0domainq\0~\0L\0nameq\0~\0L\0pathq\0~\0L\0valueq\0~\0xp����\0\0\0\0\0ppt\0SESSIONpt\00YWQzYmY3ZGEtNjYwNS00Yzc3LThlNTEtNWFlNDRlNWRlYWVmxsr\0java.util.TreeMap��>-%j\�\0L\0\ncomparatort\0Ljava/util/Comparator;xpsr\0*java.lang.String$CaseInsensitiveComparatorw\\}\\P\�\�\0\0xpw\0\0\0t\0acceptsq\0~\0\0\0\0w\0\0\0t\0@image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8xt\0accept-encodingsq\0~\0\0\0\0w\0\0\0t\0gzip, deflate, br, zstdxt\0accept-languagesq\0~\0\0\0\0w\0\0\0t\0vi-VN,vi;q=0.9xt\0\nconnectionsq\0~\0\0\0\0w\0\0\0t\0\nkeep-alivext\0cookiesq\0~\0\0\0\0w\0\0\0t\08SESSION=YWQzYmY3ZGEtNjYwNS00Yzc3LThlNTEtNWFlNDRlNWRlYWVmxt\0hostsq\0~\0\0\0\0w\0\0\0t\0localhost:8080xt\0referersq\0~\0\0\0\0w\0\0\0t\01http://localhost:8080/client/css/lightbox.min.cssxt\0	sec-ch-uasq\0~\0\0\0\0w\0\0\0t\0A\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"xt\0sec-ch-ua-mobilesq\0~\0\0\0\0w\0\0\0t\0?0xt\0sec-ch-ua-platformsq\0~\0\0\0\0w\0\0\0t\0	\"Windows\"xt\0sec-fetch-destsq\0~\0\0\0\0w\0\0\0t\0imagext\0sec-fetch-modesq\0~\0\0\0\0w\0\0\0t\0no-corsxt\0sec-fetch-sitesq\0~\0\0\0\0w\0\0\0t\0same-originxt\0\nuser-agentsq\0~\0\0\0\0w\0\0\0t\0oMozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36xxsq\0~\0\0\0\0w\0\0\0sr\0java.util.Locale~�`�0�\�\0I\0hashcodeL\0countryq\0~\0L\0\nextensionsq\0~\0L\0languageq\0~\0L\0scriptq\0~\0L\0variantq\0~\0xp����t\0VNt\0\0t\0viq\0~\0?q\0~\0?xsq\0~\0<����q\0~\0?q\0~\0?q\0~\0@q\0~\0?q\0~\0?xxt\0continuet\0GETsq\0~\0pw\0\0\0\0xppt\0/errort\0http://localhost:8080/errort\0httpt\0	localhostt\0/error'),('80101ac8-4a3d-4928-b030-ef541426ccec','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('80101ac8-4a3d-4928-b030-ef541426ccec','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$f702d02b-7fb2-46e7-94fa-3d84a611508a'),('80101ac8-4a3d-4928-b030-ef541426ccec','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0	ROLE_USERxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\00:0:0:0:0:0:0:1t\0$140b7e93-1cb4-4639-be6d-1fb5f875613epsr\02org.springframework.security.core.userdetails.User\0\0\0\0\0\0l\0Z\0accountNonExpiredZ\0accountNonLockedZ\0credentialsNonExpiredZ\0enabledL\0authoritiest\0Ljava/util/Set;L\0passwordq\0~\0L\0usernameq\0~\0xpsr\0%java.util.Collections$UnmodifiableSet��я��U\0\0xq\0~\0\nsr\0java.util.TreeSetݘP��\�[\0\0xpsr\0Forg.springframework.security.core.userdetails.User$AuthorityComparator\0\0\0\0\0\0l\0\0xpw\0\0\0q\0~\0xpt\0example@gmail.com'),('80101ac8-4a3d-4928-b030-ef541426ccec','SPRING_SECURITY_SAVED_REQUEST',_binary '�\�\0sr\0Aorg.springframework.security.web.savedrequest.DefaultSavedRequest\0\0\0\0\0\0l\0I\0\nserverPortL\0contextPatht\0Ljava/lang/String;L\0cookiest\0Ljava/util/ArrayList;L\0headerst\0Ljava/util/Map;L\0localesq\0~\0L\0matchingRequestParameterNameq\0~\0L\0methodq\0~\0L\0\nparametersq\0~\0L\0pathInfoq\0~\0L\0queryStringq\0~\0L\0\nrequestURIq\0~\0L\0\nrequestURLq\0~\0L\0schemeq\0~\0L\0\nserverNameq\0~\0L\0servletPathq\0~\0xp\0\0�t\0\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\09org.springframework.security.web.savedrequest.SavedCookie\0\0\0\0\0\0l\0I\0maxAgeZ\0secureI\0versionL\0commentq\0~\0L\0domainq\0~\0L\0nameq\0~\0L\0pathq\0~\0L\0valueq\0~\0xp����\0\0\0\0\0ppt\0SESSIONpt\00YTIwYWNhNTUtMDJiNC00NDNhLTg1OWEtMjBlOGYyNzNhYTExxsr\0java.util.TreeMap��>-%j\�\0L\0\ncomparatort\0Ljava/util/Comparator;xpsr\0*java.lang.String$CaseInsensitiveComparatorw\\}\\P\�\�\0\0xpw\0\0\0t\0acceptsq\0~\0\0\0\0w\0\0\0t\0@image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8xt\0accept-encodingsq\0~\0\0\0\0w\0\0\0t\0gzip, deflate, br, zstdxt\0accept-languagesq\0~\0\0\0\0w\0\0\0t\0Mvi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5,zh-CN;q=0.4,zh;q=0.3xt\0\nconnectionsq\0~\0\0\0\0w\0\0\0t\0\nkeep-alivext\0cookiesq\0~\0\0\0\0w\0\0\0t\08SESSION=YTIwYWNhNTUtMDJiNC00NDNhLTg1OWEtMjBlOGYyNzNhYTExxt\0hostsq\0~\0\0\0\0w\0\0\0t\0localhost:8080xt\0referersq\0~\0\0\0\0w\0\0\0t\01http://localhost:8080/client/css/lightbox.min.cssxt\0	sec-ch-uasq\0~\0\0\0\0w\0\0\0t\0A\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"xt\0sec-ch-ua-mobilesq\0~\0\0\0\0w\0\0\0t\0?0xt\0sec-ch-ua-platformsq\0~\0\0\0\0w\0\0\0t\0	\"Windows\"xt\0sec-fetch-destsq\0~\0\0\0\0w\0\0\0t\0imagext\0sec-fetch-modesq\0~\0\0\0\0w\0\0\0t\0no-corsxt\0sec-fetch-sitesq\0~\0\0\0\0w\0\0\0t\0same-originxt\0\nuser-agentsq\0~\0\0\0\0w\0\0\0t\0oMozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36xxsq\0~\0\0\0\0w\0\0\0sr\0java.util.Locale~�`�0�\�\0I\0hashcodeL\0countryq\0~\0L\0\nextensionsq\0~\0L\0languageq\0~\0L\0scriptq\0~\0L\0variantq\0~\0xp����t\0VNt\0\0t\0viq\0~\0?q\0~\0?xsq\0~\0<����q\0~\0?q\0~\0?q\0~\0@q\0~\0?q\0~\0?xsq\0~\0<����t\0FRq\0~\0?t\0frq\0~\0?q\0~\0?xsq\0~\0<����q\0~\0?q\0~\0?q\0~\0Dq\0~\0?q\0~\0?xsq\0~\0<����t\0USq\0~\0?t\0enq\0~\0?q\0~\0?xsq\0~\0<����q\0~\0?q\0~\0?q\0~\0Hq\0~\0?q\0~\0?xsq\0~\0<����t\0CNq\0~\0?t\0zhq\0~\0?q\0~\0?xsq\0~\0<����q\0~\0?q\0~\0?q\0~\0Lq\0~\0?q\0~\0?xxt\0continuet\0GETsq\0~\0pw\0\0\0\0xppt\0/errort\0http://localhost:8080/errort\0httpt\0	localhostt\0/error'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','avatar',_binary '�\�\0t\0#1764860921225-tải xuống (2).jpg'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','email',_binary '�\�\0t\0example@gmail.com'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','fullName',_binary '�\�\0t\0Nguyễn Khánh'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','id',_binary '�\�\0sr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$11bdd41b-c7be-44b6-ae7b-168fe15d4e6e'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','role',_binary '�\�\0t\0USER'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0	ROLE_USERxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\00:0:0:0:0:0:0:1t\0$ebf955fe-8b0d-4ec0-8664-b66bf45e763apsr\02org.springframework.security.core.userdetails.User\0\0\0\0\0\0l\0Z\0accountNonExpiredZ\0accountNonLockedZ\0credentialsNonExpiredZ\0enabledL\0authoritiest\0Ljava/util/Set;L\0passwordq\0~\0L\0usernameq\0~\0xpsr\0%java.util.Collections$UnmodifiableSet��я��U\0\0xq\0~\0\nsr\0java.util.TreeSetݘP��\�[\0\0xpsr\0Forg.springframework.security.core.userdetails.User$AuthorityComparator\0\0\0\0\0\0l\0\0xpw\0\0\0q\0~\0xpt\0example@gmail.com'),('b1bb6fa6-77fc-4174-89e4-1822145da5c8','sum',_binary '�\�\0sr\0java.lang.Integer⠤���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','avatar',_binary '�\�\0t\01765724417315_OUTFIT IDEE.jpg'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','email',_binary '�\�\0t\0admin@gmail.com'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','fullName',_binary '�\�\0t\0Admin'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','id',_binary '�\�\0sr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$4cbbda53-2ab1-4a9c-9176-76d23d4b0e4d'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','role',_binary '�\�\0t\0ADMIN'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','selectedCartDetailIds',_binary '�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0]x'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0\nROLE_ADMINxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\00:0:0:0:0:0:0:1t\0$3b04837e-852c-44f3-9165-19e6b2fbde92psr\02org.springframework.security.core.userdetails.User\0\0\0\0\0\0l\0Z\0accountNonExpiredZ\0accountNonLockedZ\0credentialsNonExpiredZ\0enabledL\0authoritiest\0Ljava/util/Set;L\0passwordq\0~\0L\0usernameq\0~\0xpsr\0%java.util.Collections$UnmodifiableSet��я��U\0\0xq\0~\0\nsr\0java.util.TreeSetݘP��\�[\0\0xpsr\0Forg.springframework.security.core.userdetails.User$AuthorityComparator\0\0\0\0\0\0l\0\0xpw\0\0\0q\0~\0xpt\0admin@gmail.com'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','sum',_binary '�\�\0sr\0java.lang.Integer⠤���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_note',_binary '�\�\0t\0\0'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_orderId',_binary '�\�\0t\0\r1766219356096'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_receiverAddress',_binary '�\�\0t\0khánh'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_receiverEmail',_binary '�\�\0t\0admin@gmail.com'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_receiverName',_binary '�\�\0t\0Admin'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_receiverPhone',_binary '�\�\0t\0\n0398794461'),('c578be2e-93ff-4cfa-9e6e-fbc9f993d6ed','vnpay_totalPrice',_binary '�\�\0sr\0java.lang.Double��\�J)k�\0D\0valuexr\0java.lang.Number����\��\0\0xpAm�z\0\0\0\0');
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,4,'Hanoi, Vietnam','1765471483314-OUTFIT IDEE.jpg','nguyenquockhanh02082006@gmail.com','Super Administrator','$2a$10$6S/7NSsCIbaz0cfPH417qOVJ9ndgFuhKiESzh/nSQ.3Uh5GccrCb.','0123456789'),(4,1,'','1764770111562-tải xuống (2).jpg','lolibatbai0204@gmail.com','Nguyễn Khánh','$2a$10$FqMYVIihWuNR0I.68giE2.6rudB4eEdFvrQS4MBhjoOGRDJNEwPN.',''),(7,1,'khánh\r\n','1765724417315_OUTFIT IDEE.jpg','admin@gmail.com','Admin','$2a$10$sDwg2zp8CSnotE5hgVxnSOIV7nDMd7SnOEtl5wwm1FS4c5wBiNfai','0398794461'),(8,2,'99 King Road','1764860921225-tải xuống (2).jpg','example@gmail.com','Nguyễn Khánh','$2a$10$0xNoX3K1xdvbTqq1MbXdhO9gvWju/gvLydP84V.RGw3lVCALPZbGO','0398794461'),(11,2,'',NULL,'khanh@gmail.com','Nguyễn Khánh','$2a$10$xTbjnWzR14vMcPrW7lP09.2Q1.VG6Aj8FxOq74hScwcDiAea1AiM2',''),(12,3,'','1765467002903-tải xuống.jpg','staff@gmail.com','Staff','$2a$10$OvacowfPjPhVgszjZwN77uUZhVTLT0elgIgoHMRdHP.h7MtxNxC6C','');
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

-- Dump completed on 2025-12-27 20:54:30
