CREATE DATABASE  IF NOT EXISTS `resource_sharing` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `resource_sharing`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: resource_sharing
-- ------------------------------------------------------
-- Server version	8.0.21

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add session',4,'add_session'),(14,'Can change session',4,'change_session'),(15,'Can delete session',4,'delete_session'),(16,'Can view session',4,'view_session'),(17,'Can add user',5,'add_customuser'),(18,'Can change user',5,'change_customuser'),(19,'Can delete user',5,'delete_customuser'),(20,'Can view user',5,'view_customuser'),(21,'Can add log entry',6,'add_logentry'),(22,'Can change log entry',6,'change_logentry'),(23,'Can delete log entry',6,'delete_logentry'),(24,'Can view log entry',6,'view_logentry'),(25,'Can add products',7,'add_products'),(26,'Can change products',7,'change_products'),(27,'Can delete products',7,'delete_products'),(28,'Can view products',7,'view_products'),(29,'Can add wishlist',8,'add_wishlist'),(30,'Can change wishlist',8,'change_wishlist'),(31,'Can delete wishlist',8,'delete_wishlist'),(32,'Can view wishlist',8,'view_wishlist'),(33,'Can add requests',9,'add_requests'),(34,'Can change requests',9,'change_requests'),(35,'Can delete requests',9,'delete_requests'),(36,'Can view requests',9,'view_requests'),(37,'Can add transaction',10,'add_transaction'),(38,'Can change transaction',10,'change_transaction'),(39,'Can delete transaction',10,'delete_transaction'),(40,'Can view transaction',10,'view_transaction');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authen_customuser`
--

DROP TABLE IF EXISTS `authen_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authen_customuser` (
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
  `full_name` varchar(100) NOT NULL,
  `phone_no` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authen_customuser`
--

LOCK TABLES `authen_customuser` WRITE;
/*!40000 ALTER TABLE `authen_customuser` DISABLE KEYS */;
INSERT INTO `authen_customuser` VALUES (1,'pbkdf2_sha256$216000$UBoHXRfvpQID$y+1IZTF30CQx5/X+4OJZ3AXRPuzZpIrxQm3GaEL6iLc=','2020-11-15 18:53:19.893030',0,'rishabh','','','rishabh.rs.001@gmail.com',0,1,'2020-10-19 18:27:43.364083','Rishabh Soni','8824222286'),(2,'pbkdf2_sha256$216000$rPgMPlTdEbqE$6lBg4kLVv0tZuKRXynJeKehllQq68vyZ+gg3rPK0UH4=','2020-10-20 17:46:34.098708',0,'abc','','','abc@xyz.com',0,1,'2020-10-20 17:46:33.323937','abcd','12345'),(3,'pbkdf2_sha256$216000$LV1MlYSLcS10$F3fKxjW2tVLJXYHGe81Y5GB5qmKfGdOu6yHtfJ4oK/8=','2020-10-20 18:13:36.507590',0,'xyz','','','abs@abs.com',0,1,'2020-10-20 18:13:35.428561','xyz','12345'),(4,'pbkdf2_sha256$216000$oTNEPfjgc36k$e0kR3kYE0uc+MS4EuKtgyjWpZlUTm6W4zvuxNKtEXso=','2020-11-13 18:17:19.832723',1,'admin','','','admin@admin.com',1,1,'2020-10-22 14:44:17.239378','',''),(5,'pbkdf2_sha256$216000$00THkwDhLLV5$iREp9Rg0uBUcJaDVSz/FRWcH7iLDsFokMjuD/GPe8sU=','2020-11-15 13:07:49.036847',0,'abhishek01','','','abc@xyz.com',0,1,'2020-11-12 11:56:25.714820','Abhishek Singh','1234567890');
/*!40000 ALTER TABLE `authen_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authen_customuser_groups`
--

DROP TABLE IF EXISTS `authen_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authen_customuser_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customuser_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authen_customuser_groups_customuser_id_group_id_f9133fda_uniq` (`customuser_id`,`group_id`),
  KEY `authen_customuser_groups_group_id_250d0d2d_fk_auth_group_id` (`group_id`),
  CONSTRAINT `authen_customuser_gr_customuser_id_b6718b6f_fk_authen_cu` FOREIGN KEY (`customuser_id`) REFERENCES `authen_customuser` (`id`),
  CONSTRAINT `authen_customuser_groups_group_id_250d0d2d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authen_customuser_groups`
--

LOCK TABLES `authen_customuser_groups` WRITE;
/*!40000 ALTER TABLE `authen_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `authen_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authen_customuser_user_permissions`
--

DROP TABLE IF EXISTS `authen_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authen_customuser_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customuser_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authen_customuser_user_p_customuser_id_permission_88fbc546_uniq` (`customuser_id`,`permission_id`),
  KEY `authen_customuser_us_permission_id_3eec1faf_fk_auth_perm` (`permission_id`),
  CONSTRAINT `authen_customuser_us_customuser_id_aee4d22d_fk_authen_cu` FOREIGN KEY (`customuser_id`) REFERENCES `authen_customuser` (`id`),
  CONSTRAINT `authen_customuser_us_permission_id_3eec1faf_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authen_customuser_user_permissions`
--

LOCK TABLES `authen_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `authen_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `authen_customuser_user_permissions` ENABLE KEYS */;
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
  KEY `django_admin_log_user_id_c564eba6_fk_authen_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_authen_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `authen_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-10-22 14:46:08.594195','1','Products object (1)',1,'[{\"added\": {}}]',7,4),(2,'2020-10-22 14:47:02.231419','2','Products object (2)',1,'[{\"added\": {}}]',7,4),(3,'2020-10-22 14:47:50.072355','3','Products object (3)',1,'[{\"added\": {}}]',7,4),(4,'2020-10-22 14:50:27.794353','4','Products object (4)',1,'[{\"added\": {}}]',7,4),(5,'2020-10-22 14:52:04.417016','5','Products object (5)',1,'[{\"added\": {}}]',7,4),(6,'2020-10-29 10:18:01.089816','1','Products object (1)',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',7,4),(7,'2020-10-29 10:18:33.848915','3','Products object (3)',3,'',7,4),(8,'2020-10-29 10:19:11.733788','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',7,4),(9,'2020-10-29 10:19:26.777403','5','Products object (5)',2,'[{\"changed\": {\"fields\": [\"Category\", \"Img2\", \"Img3\"]}}]',7,4),(10,'2020-10-29 10:21:30.601426','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Img2\", \"Img3\"]}}]',7,4),(11,'2020-10-29 10:22:04.421943','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Img1\"]}}]',7,4),(12,'2020-10-29 10:24:06.248146','5','Products object (5)',2,'[{\"changed\": {\"fields\": [\"Img1\"]}}]',7,4),(13,'2020-10-29 10:25:03.971566','1','Products object (1)',2,'[{\"changed\": {\"fields\": [\"Img1\", \"Img2\"]}}]',7,4),(14,'2020-10-29 10:26:53.434517','2','Products object (2)',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',7,4),(15,'2020-10-29 10:27:31.108402','2','Products object (2)',2,'[{\"changed\": {\"fields\": [\"Img1\"]}}]',7,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'admin','logentry'),(2,'auth','group'),(1,'auth','permission'),(5,'authen','customuser'),(3,'contenttypes','contenttype'),(7,'products','products'),(9,'products','requests'),(10,'products','transaction'),(8,'products','wishlist'),(4,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-10-19 17:45:00.593548'),(2,'contenttypes','0002_remove_content_type_name','2020-10-19 17:45:00.693282'),(3,'auth','0001_initial','2020-10-19 17:45:00.788993'),(4,'auth','0002_alter_permission_name_max_length','2020-10-19 17:45:01.159003'),(5,'auth','0003_alter_user_email_max_length','2020-10-19 17:45:01.179948'),(6,'auth','0004_alter_user_username_opts','2020-10-19 17:45:01.188923'),(7,'auth','0005_alter_user_last_login_null','2020-10-19 17:45:01.196934'),(8,'auth','0006_require_contenttypes_0002','2020-10-19 17:45:01.201889'),(9,'auth','0007_alter_validators_add_error_messages','2020-10-19 17:45:01.210893'),(10,'auth','0008_alter_user_username_max_length','2020-10-19 17:45:01.220838'),(11,'auth','0009_alter_user_last_name_max_length','2020-10-19 17:45:01.229818'),(12,'auth','0010_alter_group_name_max_length','2020-10-19 17:45:01.247795'),(13,'auth','0011_update_proxy_permissions','2020-10-19 17:45:01.256742'),(14,'auth','0012_alter_user_first_name_max_length','2020-10-19 17:45:01.265721'),(15,'authen','0001_initial','2020-10-19 17:45:01.377419'),(16,'sessions','0001_initial','2020-10-19 17:45:01.731967'),(17,'admin','0001_initial','2020-10-19 17:47:12.408811'),(18,'admin','0002_logentry_remove_auto_add','2020-10-19 17:47:12.550433'),(19,'admin','0003_logentry_add_action_flag_choices','2020-10-19 17:47:12.563398'),(20,'authen','0002_auto_20201019_2357','2020-10-19 18:27:29.463538'),(21,'products','0001_initial','2020-10-22 14:43:48.787936'),(22,'products','0002_wishlist','2020-10-26 20:05:34.224767'),(23,'products','0003_auto_20201029_0136','2020-10-28 20:38:20.435125'),(24,'products','0004_auto_20201029_0208','2020-10-28 20:38:20.456067'),(25,'products','0005_remove_products_image_url','2020-10-28 20:51:03.133681'),(26,'products','0006_auto_20201029_1534','2020-10-29 10:04:40.700666'),(27,'products','0007_auto_20201105_1923','2020-11-05 13:54:06.491659'),(28,'products','0008_requests','2020-11-11 20:04:58.653500'),(29,'products','0009_auto_20201112_0205','2020-11-11 20:35:50.923226'),(30,'products','0010_auto_20201112_0338','2020-11-11 22:08:27.105894');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('cry453l7axfyqvltjl6a0o713lpxmrub','.eJxVjEsOAiEQRO_C2pDmIzAu3XsG0k2jjBpIhpmV8e5KMgtdVVLvVb1ExG0tcet5iTOLk1Di8NsRpkeuA_Ad663J1Oq6zCSHInfa5aVxfp539--gYC_fddYhpGtgC44TTdp7y4jBgQGtzDGrQIDO-skhOMvGGlI4ErImQifeH9M6N1o:1keN9L:xWmgb8jSvB42dUjNFMm05cnuDZpnZCnqAxn3kyFDVTA','2020-11-29 18:53:19.901610'),('yl28mfpqtxfq7dlwnc75ulikg2pj9geo','.eJxVjDkOwjAUBe_iGll2Isc_lPScIforCSBbylIh7g6RUkD7Zua93IDbOg7bovMwiTu76E6_GyE_tOxA7lhu1XMt6zyR3xV_0MVfq-jzcrh_ByMu47dOLNSgEII1WdqOFTEqGFOIKWQz6CWYdoDAoeMYIWG20KaYoScl9_4AH2847w:1kYEBR:aQt8DphKPZ0d8TicAyHJdInCem2JTUoPM4Z617WnMns','2020-11-12 20:06:05.941036');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_products`
--

DROP TABLE IF EXISTS `products_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `seller` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `category` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `Img1` varchar(100) NOT NULL,
  `Img2` varchar(100) NOT NULL,
  `Img3` varchar(100) NOT NULL,
  `sell` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_products`
--

LOCK TABLES `products_products` WRITE;
/*!40000 ALTER TABLE `products_products` DISABLE KEYS */;
INSERT INTO `products_products` VALUES (1,'Speakers','Good Condition.','rishabh',1000,'Electronics',0,'images/Untitled-design-6-400x400_J9E2bL5.png','images/black1-1-400x400_gEwPvnY.png','images/no-image.jpg','sell'),(2,'Old Lamp','Fairly good condition, working, very good.','rishabh',200,'Electronics',0,'images/31tdGRFXbCL._AC_SS350_.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(4,'CS 203 Notes','Written in a fairly good handwriting, easily understandable.','rishabh',0,'Books/Notes',0,'images/1431384870-notes.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(5,'Cycle','In a nice condition, only some lubrication is required.','rishabh',1000,'Sports, Fitness and Outdoors',0,'images/deadpool-black1.png','images/no-image.jpg','images/no-image.jpg','sell'),(6,'iPhone 12','Good as new.','rishabh',100000,'Electronics',0,'images/iphone-12-pro-family-hero.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(7,'Drafter','Not much used, good quality.','rishabh',100,'Stationery/Equipments',0,'images/MIni-Drafter-Professional.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(22,'Griffiths','Almost new.','rishabh',100,'Books/Notes',1,'images/41SmJRCkGYL._SX383_BO1204203200_.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(23,'HC Verma','The book is of no use for me now, might be of some help for someone.','rishabh',50,'Books/Notes',1,'images/concepts-of-physics-vol-1-book-500x500.png','images/no-image.jpg','images/no-image.jpg','sell'),(24,'Metallurgy Notes','Written in a neat and good handwriting.','rishabh',0,'Books/Notes',0,'images/zoe_whitelines-screendump.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(25,'BSA Cycle','Old cycle with a basket at the front.','rishabh',800,'Sports, Fitness and Outdoors',0,'images/Diana_Classic_2017_05.png','images/no-image.jpg','images/no-image.jpg','sell'),(26,'BSA Super Deluxe','BSA Super Super deluxe cycle','rishabh',500,'Sports, Fitness and Outdoors',0,'images/bsa_super_deluxe_jr_male_bicycle_black_23574579_0.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(27,'Lab Coat','Used lab coat, just needs a dryclean.','rishabh',150,'Stationery/Equipments',0,'images/whites-girl-power-at-work-lab-coats-82523-64_1000.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(28,'Lab files','I am having extra lab files that I don\'t need anymore. So whoever needs can purchase them.','rishabh',20,'Stationery/Equipments',0,'images/51dejGGQznL._SX355_.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(29,'Square Sets','Not even unboxed yet.','rishabh',50,'Stationery/Equipments',0,'images/45-500x500.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(30,'Relaxwell Mattress','Not much used. Only slept twice on it.','rishabh',1000,'Household',0,'images/RelaxwellGalaxy1450792394.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(31,'Electric Kettle','In working condition.','rishabh',500,'Household',0,'images/713Jf1cFWDL._SL1500_.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(32,'Metal Bucket','Good Quality.','rishabh',100,'Household',0,'images/metal-and-wood-childrens-beach-bucket-.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(33,'Wall clock','nice condition.','rishabh',500,'Others',0,'images/71Q7VeAsGRL._SL1200_.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(34,'Paint Brush','Good for cleaning keyboards, etc.','rishabh',50,'Others',1,'images/HTB1BMuej3vD8KJjSsplq6yIEFXaa.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(35,'The Alchemist','A must read.','rishabh',50,'Books/Notes',1,'images/the-alchemist-500x500.png','images/no-image.jpg','images/no-image.jpg','rent_weekly'),(36,'BasketBall','Good condition','rishabh',50,'Sports, Fitness and Outdoors',1,'images/91fFYnTtMzL._SX425_.jpg','images/no-image.jpg','images/no-image.jpg','sell'),(37,'Football','Anyone who wants to play can rent.','rishabh',20,'Sports, Fitness and Outdoors',0,'images/TELEMMGLPICT000206110274_trans_NvBQzQNjv4BqrS8Z1b0ZQjNoViJZ3HnGQ4NS1YurETCFkeLSh1IwB7c.webp','images/no-image.jpg','images/no-image.jpg','rent_weekly'),(38,'Wings of Fire- Biography','If anyone wants to read it can rent.','rishabh',40,'Books/Notes',0,'images/download.jpg','images/no-image.jpg','images/no-image.jpg','rent_monthly');
/*!40000 ALTER TABLE `products_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_requests`
--

DROP TABLE IF EXISTS `products_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buyer` varchar(255) NOT NULL,
  `seller` varchar(255) NOT NULL,
  `pid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_requests`
--

LOCK TABLES `products_requests` WRITE;
/*!40000 ALTER TABLE `products_requests` DISABLE KEYS */;
INSERT INTO `products_requests` VALUES (4,'rishabh','rishabh',30),(6,'abhishek01','rishabh',37),(7,'abhishek01','rishabh',29),(9,'rishabh','rishabh',1),(10,'rishabh','rishabh',1),(11,'abhishek01','rishabh',1),(12,'rishabh','rishabh',1),(13,'abhishek01','rishabh',4);
/*!40000 ALTER TABLE `products_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_transaction`
--

DROP TABLE IF EXISTS `products_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buyer` varchar(255) NOT NULL,
  `seller` varchar(255) NOT NULL,
  `pid` int NOT NULL,
  `pname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_transaction`
--

LOCK TABLES `products_transaction` WRITE;
/*!40000 ALTER TABLE `products_transaction` DISABLE KEYS */;
INSERT INTO `products_transaction` VALUES (1,'rishabh','rishabh',36,'BasketBall'),(2,'rishabh','rishabh',35,'The Alchemist'),(3,'rishabh','rishabh',23,'HC Verma'),(4,'abhishek01','rishabh',22,'Griffiths'),(5,'abhishek01','rishabh',34,'Paint Brush');
/*!40000 ALTER TABLE `products_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_wishlist`
--

DROP TABLE IF EXISTS `products_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `pid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_wishlist`
--

LOCK TABLES `products_wishlist` WRITE;
/*!40000 ALTER TABLE `products_wishlist` DISABLE KEYS */;
INSERT INTO `products_wishlist` VALUES (62,'rishabh',8),(69,'rishabh',34),(72,'abhishek01',33),(73,'abhishek01',31),(74,'abhishek01',32),(77,'rishabh',31),(78,'rishabh',37),(79,'rishabh',33);
/*!40000 ALTER TABLE `products_wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-16  1:50:56
