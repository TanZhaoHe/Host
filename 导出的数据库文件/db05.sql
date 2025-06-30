-- MySQL dump 10.13  Distrib 9.2.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db05
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `apphost_city`
--

DROP TABLE IF EXISTS `apphost_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apphost_city` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apphost_city`
--

LOCK TABLES `apphost_city` WRITE;
/*!40000 ALTER TABLE `apphost_city` DISABLE KEYS */;
INSERT INTO `apphost_city` VALUES (1,'ShangHai','string','string'),(2,'上海','2',''),(3,'string','string','string'),(4,'strin','string','string');
/*!40000 ALTER TABLE `apphost_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apphost_host`
--

DROP TABLE IF EXISTS `apphost_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apphost_host` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hostname` varchar(100) NOT NULL,
  `ip_address` char(39) NOT NULL,
  `status` varchar(20) NOT NULL,
  `cpu_info` varchar(100) DEFAULT NULL,
  `memory` varchar(50) DEFAULT NULL,
  `disk` varchar(100) DEFAULT NULL,
  `os` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `machine_room_id` bigint DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  UNIQUE KEY `ip_address` (`ip_address`),
  KEY `apphost_host_machine_room_id_e1f6f8a0_fk_apphost_machineroom_id` (`machine_room_id`),
  CONSTRAINT `apphost_host_machine_room_id_e1f6f8a0_fk_apphost_machineroom_id` FOREIGN KEY (`machine_room_id`) REFERENCES `apphost_machineroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apphost_host`
--

LOCK TABLES `apphost_host` WRITE;
/*!40000 ALTER TABLE `apphost_host` DISABLE KEYS */;
INSERT INTO `apphost_host` VALUES (1,'1','0.0.0.0','offline','1','1','1','TTT','2025-06-29 12:11:10.401711','2025-06-30 12:52:38.290478',1,'pbkdf2_sha256$1000000$GukHwCZYxVumkJxrJkxj6c$nNIdNOWF5vtXteni6IqT1TFT/kGktUnrsuVprm9xPps='),(2,'2','127.0.0.1','online','1','1','1','TTT','2025-06-29 14:47:04.757152','2025-06-30 12:52:39.074404',1,'pbkdf2_sha256$1000000$O8EPkhOY6oQ73zXMvy9zu8$LBppUsSQ71bN7t9B+/m/w1KNDmT1O1AANRD1k36/4x4='),(3,'02','1.1.1.1','unknown',NULL,NULL,NULL,'TTT','2025-06-30 08:09:54.366471','2025-06-30 12:52:39.770181',1,'pbkdf2_sha256$1000000$PQej13Eq4RSDbGTWJSmVb6$7GuLlnRKjWcXlmCwwFEdCO4madz2ynEo7M7Wz8xMyfM='),(4,'03','2.2.2.2','unknown',NULL,NULL,NULL,'TTT','2025-06-30 08:11:38.697634','2025-06-30 12:52:40.576461',2,'pbkdf2_sha256$1000000$s2sfkXPDc7Oulfz9gfRwGR$b7NQ7uhK+DwJYOzRnlkw806bs2fxE5L728B2E9WMB3U=');
/*!40000 ALTER TABLE `apphost_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apphost_hoststatistics`
--

DROP TABLE IF EXISTS `apphost_hoststatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apphost_hoststatistics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host_count` int NOT NULL,
  `statistic_time` datetime(6) NOT NULL,
  `city_id` bigint NOT NULL,
  `room_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apphost_hoststatistics_city_id_room_id_statisti_a09d9c21_uniq` (`city_id`,`room_id`,`statistic_time`),
  KEY `apphost_hoststatisti_room_id_a3dec0c1_fk_apphost_m` (`room_id`),
  CONSTRAINT `apphost_hoststatisti_room_id_a3dec0c1_fk_apphost_m` FOREIGN KEY (`room_id`) REFERENCES `apphost_machineroom` (`id`),
  CONSTRAINT `apphost_hoststatistics_city_id_ae34b3d8_fk_apphost_city_id` FOREIGN KEY (`city_id`) REFERENCES `apphost_city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apphost_hoststatistics`
--

LOCK TABLES `apphost_hoststatistics` WRITE;
/*!40000 ALTER TABLE `apphost_hoststatistics` DISABLE KEYS */;
INSERT INTO `apphost_hoststatistics` VALUES (1,3,'2025-06-30 00:00:00.000000',1,1),(2,1,'2025-06-30 00:00:00.000000',1,2);
/*!40000 ALTER TABLE `apphost_hoststatistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apphost_machineroom`
--

DROP TABLE IF EXISTS `apphost_machineroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apphost_machineroom` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `address` varchar(200) NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apphost_machineroom_name_city_id_bf92771c_uniq` (`name`,`city_id`),
  KEY `apphost_machineroom_city_id_5e4ccaea_fk_apphost_city_id` (`city_id`),
  CONSTRAINT `apphost_machineroom_city_id_5e4ccaea_fk_apphost_city_id` FOREIGN KEY (`city_id`) REFERENCES `apphost_city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apphost_machineroom`
--

LOCK TABLES `apphost_machineroom` WRITE;
/*!40000 ALTER TABLE `apphost_machineroom` DISABLE KEYS */;
INSERT INTO `apphost_machineroom` VALUES (1,'01','1','1','1',1),(2,'02','1',NULL,NULL,1),(3,'01','1',NULL,NULL,2);
/*!40000 ALTER TABLE `apphost_machineroom` ENABLE KEYS */;
UNLOCK TABLES;

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
  `id` bigint NOT NULL AUTO_INCREMENT,
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
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add 城市',7,'add_city'),(26,'Can change 城市',7,'change_city'),(27,'Can delete 城市',7,'delete_city'),(28,'Can view 城市',7,'view_city'),(29,'Can add 机房',8,'add_machineroom'),(30,'Can change 机房',8,'change_machineroom'),(31,'Can delete 机房',8,'delete_machineroom'),(32,'Can view 机房',8,'view_machineroom'),(33,'Can add 主机',9,'add_host'),(34,'Can change 主机',9,'change_host'),(35,'Can delete 主机',9,'delete_host'),(36,'Can view 主机',9,'view_host'),(37,'Can add 主机统计结果',10,'add_hoststatistics'),(38,'Can change 主机统计结果',10,'change_hoststatistics'),(39,'Can delete 主机统计结果',10,'delete_hoststatistics'),(40,'Can view 主机统计结果',10,'view_hoststatistics');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1000000$xvvJQlptvQOTOnFyvYEx6c$YPQSlNJAGDrneF0jE52wIYrKADNn5nUKs9sDvskJbSs=','2025-06-29 13:46:10.936356',1,'TTT','','','2915323115@qq.com',1,1,'2025-06-29 10:38:48.505750');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-06-29 11:51:42.439646','1','广东',1,'[{\"added\": {}}]',7,1),(2,'2025-06-29 11:52:41.401185','1','广东-01',1,'[{\"added\": {}}]',8,1),(3,'2025-06-29 12:11:10.403227','1','1(0.0.0.0)',1,'[{\"added\": {}}]',9,1),(4,'2025-06-29 14:47:04.762851','2','2(127.0.0.1)',1,'[{\"added\": {}}]',9,1),(5,'2025-06-30 08:08:34.023221','2','上海',1,'[{\"added\": {}}]',7,1),(6,'2025-06-30 08:09:54.367648','3','02(1.1.1.1)',1,'[{\"added\": {}}]',9,1),(7,'2025-06-30 08:11:18.613450','2','广东-02',1,'[{\"added\": {}}]',8,1),(8,'2025-06-30 08:11:38.700590','4','03(2.2.2.2)',1,'[{\"added\": {}}]',9,1),(9,'2025-06-30 08:13:17.767048','3','上海-01',1,'[{\"added\": {}}]',8,1);
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
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'apphost','city'),(9,'apphost','host'),(10,'apphost','hoststatistics'),(8,'apphost','machineroom'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-29 10:26:24.757237'),(2,'auth','0001_initial','2025-06-29 10:26:25.404818'),(3,'admin','0001_initial','2025-06-29 10:26:25.550640'),(4,'admin','0002_logentry_remove_auto_add','2025-06-29 10:26:25.558819'),(5,'admin','0003_logentry_add_action_flag_choices','2025-06-29 10:26:25.568672'),(6,'apphost','0001_initial','2025-06-29 10:26:25.769304'),(7,'contenttypes','0002_remove_content_type_name','2025-06-29 10:26:25.863396'),(8,'auth','0002_alter_permission_name_max_length','2025-06-29 10:26:25.918409'),(9,'auth','0003_alter_user_email_max_length','2025-06-29 10:26:25.943014'),(10,'auth','0004_alter_user_username_opts','2025-06-29 10:26:25.950828'),(11,'auth','0005_alter_user_last_login_null','2025-06-29 10:26:26.001542'),(12,'auth','0006_require_contenttypes_0002','2025-06-29 10:26:26.004318'),(13,'auth','0007_alter_validators_add_error_messages','2025-06-29 10:26:26.011104'),(14,'auth','0008_alter_user_username_max_length','2025-06-29 10:26:26.068898'),(15,'auth','0009_alter_user_last_name_max_length','2025-06-29 10:26:26.137109'),(16,'auth','0010_alter_group_name_max_length','2025-06-29 10:26:26.155743'),(17,'auth','0011_update_proxy_permissions','2025-06-29 10:26:26.170860'),(18,'auth','0012_alter_user_first_name_max_length','2025-06-29 10:26:26.247029'),(19,'sessions','0001_initial','2025-06-29 10:26:26.277791'),(20,'apphost','0002_host_password','2025-06-29 11:57:34.450814'),(21,'apphost','0003_alter_host_password','2025-06-29 12:09:39.870328'),(22,'apphost','0004_hoststatistics','2025-06-30 07:07:18.669508');
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
INSERT INTO `django_session` VALUES ('7vv4cav7blk4w47w2qaqj421bhce80ds','.eJxVjDsOwjAQBe_iGlm7thPHlPQ5Q7Reb3AA2VI-FeLuJFIKaN_Mm7caaFvzsC0yD1NSV4Xq8rtF4qeUA6QHlXvVXMs6T1Efij7povua5HU73b9ApiXvbxsMo7jY2qYZ0cUARK1wxwGxAR4BENrOJecEPNo9zEjowRN5Y4JRny_L_DcY:1uVsME:iAnCjmGmAwHW3Y6XSd4LEyk1wYHvuIxFAvMiWqqCAIQ','2025-07-13 13:46:10.942311'),('8zkjd8i2hla6gya18nwpghj3svoi68gr','.eJxVjDsOwjAQBe_iGlm7thPHlPQ5Q7Reb3AA2VI-FeLuJFIKaN_Mm7caaFvzsC0yD1NSV4Xq8rtF4qeUA6QHlXvVXMs6T1Efij7povua5HU73b9ApiXvbxsMo7jY2qYZ0cUARK1wxwGxAR4BENrOJecEPNo9zEjowRN5Y4JRny_L_DcY:1uVpSS:EYC15fLGQqcabaqoPdT3mllNmk_Yy5no0kGaop-MHdM','2025-07-13 10:40:24.386719'),('sbsoactm1tnssq6bj5j62oz9ang2xp86','.eJxVjDsOwjAQBe_iGlm7thPHlPQ5Q7Reb3AA2VI-FeLuJFIKaN_Mm7caaFvzsC0yD1NSV4Xq8rtF4qeUA6QHlXvVXMs6T1Efij7povua5HU73b9ApiXvbxsMo7jY2qYZ0cUARK1wxwGxAR4BENrOJecEPNo9zEjowRN5Y4JRny_L_DcY:1uVpTX:7B1qmgz1jkJ66AQgTt6y_hqfApI4ptaY9o1ksX255GA','2025-07-13 10:41:31.000942');
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

-- Dump completed on 2025-06-30 20:52:46
