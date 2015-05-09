-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: carrera
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add profesor',7,'add_profesor'),(20,'Can change profesor',7,'change_profesor'),(21,'Can delete profesor',7,'delete_profesor'),(22,'Can add materia',8,'add_materia'),(23,'Can change materia',8,'change_materia'),(24,'Can delete materia',8,'delete_materia'),(25,'Can add examen',9,'add_examen'),(26,'Can change examen',9,'change_examen'),(27,'Can delete examen',9,'delete_examen'),(28,'Can add estado materia',10,'add_estadomateria'),(29,'Can change estado materia',10,'change_estadomateria'),(30,'Can delete estado materia',10,'delete_estadomateria');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$0IMeHnEn8zoC$OJnHNJSQPMn0Cq/F7WdQMAXgmx3E2jCbHHXwGzys3hQ=','2015-05-09 01:17:32',1,'admin','','','a@a.com',1,1,'2015-04-04 16:24:33');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2015-04-04 16:26:13','1','Vazquez, Jose',1,'',7,1),(2,'2015-04-04 16:26:31','1','Matematica 1',1,'',8,1),(3,'2015-04-12 17:31:30','1','PA, Matematica 1: Sebas, 7',1,'',9,1),(4,'2015-04-12 18:04:34','2','FI, Matematica 1: Sebas, 6',1,'',9,1),(5,'2015-04-12 19:13:15','2','FI, Matematica 1: Sebas, 6.0',3,'',9,1),(6,'2015-04-12 19:13:15','1','PA, Matematica 1: Sebas, 7.0',3,'',9,1),(7,'2015-04-12 19:21:19','3','PA, Matematica 1: Sebas, 7',1,'',9,1),(8,'2015-04-12 19:21:34','4','PA, Matematica 1: Sebas, 6',1,'',9,1),(9,'2015-04-12 19:21:51','5','PA, Matematica 1: Sebas, 8',1,'',9,1),(10,'2015-04-12 19:22:11','6','FI, Matematica 1: Sebas, 6',1,'',9,1),(11,'2015-04-12 19:51:46','7','PA, Matematica 1: ana, 9.5',1,'',9,1),(12,'2015-04-12 19:54:47','1','Matematica 1, Sebas: FI',2,'Changed estado.',10,1),(13,'2015-04-12 21:19:01','8','PA, Matematica 1: Sebas, 7.5',1,'',9,1),(14,'2015-04-12 21:28:18','2','Montes, Oscar',1,'',7,1),(15,'2015-04-12 21:30:29','2','Matematica 2',1,'',8,1),(16,'2015-04-12 21:30:52','2','Matematica 2',2,'Changed correlativas.',8,1),(17,'2015-04-12 21:31:33','3','Organizacion de PC',1,'',8,1),(18,'2015-04-12 21:32:05','3','Carballo, Hector',1,'',7,1),(19,'2015-04-12 21:32:12','4','Programacion',1,'',8,1),(20,'2015-04-12 21:32:29','5','Arquitectura de PC',1,'',8,1),(21,'2015-04-12 21:35:17','6','Matematica 3',1,'',8,1),(22,'2015-04-12 21:36:15','4','Vranic, Ivana',1,'',7,1),(23,'2015-04-12 21:36:51','5','Vranic, Alejandra',1,'',7,1),(24,'2015-04-12 21:37:22','7','Orientacion a Objetos 1',1,'',8,1),(25,'2015-04-12 21:38:05','9','PA, Matematica 2: Sebas, 3',1,'',9,1),(26,'2015-04-12 21:40:49','10','PA, Programacion: Sebas, 4.5',1,'',9,1),(27,'2015-04-12 21:41:25','11','PA, Arquitectura de PC: Sebas, 3',1,'',9,1),(28,'2015-04-12 21:42:02','12','FI, Programacion: Sebas, 7',1,'',9,1),(29,'2015-04-12 21:42:42','13','PA, Orientacion a Objetos 1: Sebas, 5',1,'',9,1),(30,'2015-04-25 21:24:13','1','Matematica 1',2,'Changed info.',8,1),(31,'2015-05-02 14:42:26','7','Orientacion a Objetos 1',3,'',8,1),(32,'2015-05-02 14:42:26','6','Matematica 3',3,'',8,1),(33,'2015-05-02 14:42:26','5','Arquitectura de PC',3,'',8,1),(34,'2015-05-02 14:42:26','4','Programacion',3,'',8,1),(35,'2015-05-02 14:42:26','3','Organizacion de PC',3,'',8,1),(36,'2015-05-02 14:42:26','2','Matematica 2',3,'',8,1),(37,'2015-05-02 14:42:26','1','Matematica 1',3,'',8,1),(38,'2015-05-02 14:42:45','5','Vranic, Alejandra',3,'',7,1),(39,'2015-05-02 14:42:45','4','Vranic, Ivana',3,'',7,1),(40,'2015-05-02 14:42:45','3','Carballo, Hector',3,'',7,1),(41,'2015-05-02 14:42:45','2','Montes, Oscar',3,'',7,1),(42,'2015-05-02 14:42:45','1','Vazquez, Jose',3,'',7,1),(43,'2015-05-02 15:02:12','1','Héctor Carballo',1,'',7,1),(44,'2015-05-02 15:03:56','1','Héctor Carballo',3,'',7,1),(45,'2015-05-02 15:05:02','2','Cdor. Héctor Carballo',1,'',7,1),(46,'2015-05-02 15:06:06','2','Cdor. Héctor Carballo',3,'',7,1),(47,'2015-05-02 15:06:51','3','Cdor. Héctor Carballo',1,'',7,1),(48,'2015-05-02 15:09:41','3','Cdor. Héctor Carballo',3,'',7,1),(49,'2015-05-02 15:11:59','4','Cdor. Héctor Carballo',1,'',7,1),(50,'2015-05-02 15:13:54','1','Matematica 1',1,'',8,1),(51,'2015-05-02 15:16:05','4','Cdor. Héctor Carballo',3,'',7,1),(52,'2015-05-02 15:16:23','1','Matematica 1',3,'',8,1),(53,'2015-05-02 15:21:49','1','Cdor. Héctor Carballo',1,'',7,1),(54,'2015-05-02 15:22:34','2','Ing. Oscar Montes',1,'',7,1),(55,'2015-05-02 15:23:11','3','Lic. José Vázquez',1,'',7,1),(56,'2015-05-02 15:23:45','4','Lic. Luis Cornacchia',1,'',7,1),(57,'2015-05-02 15:28:36','5','Lic. Andrés Mombrú',1,'',7,1),(58,'2015-05-02 15:35:30','6','Dr. Ramón Garcia-Martinez',1,'',7,1),(59,'2015-05-02 15:36:44','7','Mg. Ing. Diego Azcurra',1,'',7,1),(60,'2015-05-02 15:37:19','8','Lic. Alejandra Vranic',1,'',7,1),(61,'2015-05-02 15:37:47','9','Dr. Hernán Merlino',1,'',7,1),(62,'2015-05-02 15:38:53','10','M.Ing. Eduardo Diez',1,'',7,1),(63,'2015-05-02 15:39:21','11','Lic. Ricardo Lelli',1,'',7,1),(64,'2015-05-02 15:41:26','12','Dr. Antonio Martino',1,'',7,1),(65,'2015-05-02 15:41:48','13','Dr. Oscar Tangelson',1,'',7,1),(66,'2015-05-02 15:42:24','14','Mg. Hernán Amatriain',1,'',7,1),(67,'2015-05-02 15:45:50','2','Programación de Computadoras',1,'',8,1),(68,'2015-05-02 15:46:05','3','Organización de Computadoras',1,'',8,1),(69,'2015-05-02 15:46:56','4','Arquitectura de Computadoras',1,'',8,1),(70,'2015-05-02 15:47:13','5','Matemática 1',1,'',8,1),(71,'2015-05-02 15:47:49','5','Matemática 1',3,'',8,1),(72,'2015-05-02 15:47:49','4','Arquitectura de Computadoras',3,'',8,1),(73,'2015-05-02 15:47:49','3','Organización de Computadoras',3,'',8,1),(74,'2015-05-02 15:47:49','2','Programación de Computadoras',3,'',8,1),(75,'2015-05-02 16:19:14','1','Programación de Computadoras',1,'',8,1),(76,'2015-05-02 16:19:28','2','Organización de Computadoras',1,'',8,1),(77,'2015-05-02 16:19:41','3','Arquitectura de Computadoras',1,'',8,1),(78,'2015-05-02 16:19:54','4','Matemática 1',1,'',8,1),(79,'2015-05-02 16:20:06','5','Matemática 2',1,'',8,1),(80,'2015-05-02 16:20:19','6','Expresión de Problemas y Algoritmos',1,'',8,1),(81,'2015-05-02 16:20:57','7','Introducción al Pensamiento Científico',1,'',8,1),(82,'2015-05-02 16:21:21','8','Ingeniería de Software 1',1,'',8,1),(83,'2015-05-02 16:21:37','9','Introducción a las Bases de Datos',1,'',8,1),(84,'2015-05-02 16:21:49','10','Algoritmos y Estructuras de Datos',1,'',8,1),(85,'2015-05-02 16:22:07','11','Orientación a Objetos 1',1,'',8,1),(86,'2015-05-02 16:22:22','12','Seminario de Lenguajes',1,'',8,1),(87,'2015-05-02 16:22:39','13','Introducción a los Sistemas Operativos',1,'',8,1),(88,'2015-05-02 16:22:53','14','Matemática 3',1,'',8,1),(89,'2015-05-02 16:23:08','15','Probabilidades y Estadística',1,'',8,1),(90,'2015-05-02 16:23:25','16','Programación Concurrente',1,'',8,1),(91,'2015-05-02 16:23:42','17','Ingeniería de Software 2',1,'',8,1),(92,'2015-05-02 16:23:59','18','Orientación a Objetos 2',1,'',8,1),(93,'2015-05-02 16:24:12','19','Sistemas y Organizaciones',1,'',8,1),(94,'2015-05-02 16:24:26','20','Bases de Datos 1',1,'',8,1),(95,'2015-05-02 16:24:38','21','Proyecto de Software',1,'',8,1),(96,'2015-05-02 16:24:53','22','Conceptos y Paradigmas de Lenguajes de Programacion',1,'',8,1),(97,'2015-05-02 16:25:19','23','Redes y Comunicaciones',1,'',8,1),(98,'2015-05-02 16:25:32','24','Ingeniería de Software 3',1,'',8,1),(99,'2015-05-02 16:25:44','25','Bases de Datos 2',1,'',8,1),(100,'2015-05-02 16:25:58','26','Fundamentos de Teoría de la Computación',1,'',8,1),(101,'2015-05-02 16:26:11','27','Sistemas Operativos',1,'',8,1),(102,'2015-05-02 16:26:29','28','Desarrollo de Software en Sistemas Distribuidos',1,'',8,1),(103,'2015-05-02 16:26:44','29','Matemática Discreta',1,'',8,1),(104,'2015-05-02 16:36:45','30','Disenos de Sistemas Embebidos',1,'',8,1),(105,'2015-05-02 16:37:05','31','Pruebas de Software',1,'',8,1),(106,'2015-05-02 16:37:24','32','Espacios Virtuales de Trabajo Colaborativo',1,'',8,1),(107,'2015-05-02 16:37:39','33','Política y Gestión de la Ciencia',1,'',8,1),(108,'2015-05-02 16:37:54','34','Aspectos legales y Profesionales de Informática',1,'',8,1),(109,'2015-05-02 16:38:11','35','Nuevos Escenarios',1,'',8,1),(110,'2015-05-02 16:38:24','36','Tecnologías de Explotación de Información',1,'',8,1),(111,'2015-05-02 16:38:37','37','Ingeniería de Software Empírica',1,'',8,1),(112,'2015-05-02 16:38:49','38','Seminario de Trabajo Final de Licenciatura en Sistemas',1,'',8,1),(113,'2015-05-02 16:42:28','1','Programación de Computadoras',2,'Changed info.',8,1),(114,'2015-05-02 17:38:31','2','Organización de Computadoras',2,'Changed profesor and info.',8,1),(115,'2015-05-02 17:39:13','3','Arquitectura de Computadoras',2,'Changed cuatrimestre, profesor, correlativas and info.',8,1),(116,'2015-05-02 17:39:57','4','Matemática 1',2,'Changed profesor and info.',8,1),(117,'2015-05-02 17:40:46','5','Matemática 2',2,'Changed cuatrimestre, profesor, correlativas and info.',8,1),(118,'2015-05-02 17:42:40','6','Expresión de Problemas y Algoritmos',2,'Changed profesor and info.',8,1),(119,'2015-05-02 17:43:32','7','Introducción al Pensamiento Científico',2,'Changed cuatrimestre and profesor.',8,1),(120,'2015-05-02 17:54:20','7','Introducción al Pensamiento Científico',2,'Changed info.',8,1),(121,'2015-05-02 17:56:08','8','Ingeniería de Software 1',2,'Changed profesor, correlativas and info.',8,1),(122,'2015-05-02 20:05:46','8','Ingeniería de Software 1',2,'Changed anio.',8,1),(123,'2015-05-02 20:07:06','9','Introducción a las Bases de Datos',2,'Changed anio, correlativas and info.',8,1),(124,'2015-05-02 20:08:45','10','Algoritmos y Estructuras de Datos',2,'Changed profesor, correlativas and info.',8,1),(125,'2015-05-02 20:09:44','11','Orientación a Objetos 1',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(126,'2015-05-02 20:09:59','10','Algoritmos y Estructuras de Datos',2,'Changed anio.',8,1),(127,'2015-05-02 20:10:09','8','Ingeniería de Software 1',2,'No fields changed.',8,1),(128,'2015-05-02 20:10:20','9','Introducción a las Bases de Datos',2,'No fields changed.',8,1),(129,'2015-05-02 20:11:04','12','Seminario de Lenguajes',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(130,'2015-05-02 20:14:15','13','Introducción a los Sistemas Operativos',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(131,'2015-05-02 20:16:03','14','Matemática 3',2,'Changed anio, profesor, correlativas and info.',8,1),(132,'2015-05-02 20:17:29','15','Probabilidades y Estadística',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(133,'2015-05-02 20:18:58','16','Programación Concurrente',2,'Changed anio, profesor, correlativas and info.',8,1),(134,'2015-05-02 20:20:34','14','Matemática 3',2,'Changed correlativas.',8,1),(135,'2015-05-02 20:21:18','15','Probabilidades y Estadística',2,'Changed correlativas.',8,1),(136,'2015-05-02 20:22:46','16','Programación Concurrente',2,'No fields changed.',8,1),(137,'2015-05-02 20:23:44','17','Ingeniería de Software 2',2,'Changed anio, profesor, correlativas and info.',8,1),(138,'2015-05-02 21:31:30','18','Orientación a Objetos 2',2,'Changed anio, profesor, correlativas and info.',8,1),(139,'2015-05-02 21:36:12','19','Sistemas y Organizaciones',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(140,'2015-05-02 21:38:04','20','Bases de Datos 1',2,'Changed cuatrimestre, anio, correlativas and info.',8,1),(141,'2015-05-02 21:41:29','21','Proyecto de Software',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(142,'2015-05-02 21:41:56','1','Programación de Computadoras',2,'Changed cuatrimestre.',8,1),(143,'2015-05-02 21:42:12','9','Introducción a las Bases de Datos',2,'Changed cuatrimestre.',8,1),(144,'2015-05-02 22:14:51','22','Conceptos y Paradigmas de Lenguajes de Programacion',2,'Changed anio, profesor, correlativas and info.',8,1),(145,'2015-05-02 22:16:59','23','Redes y Comunicaciones',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(146,'2015-05-02 22:17:40','23','Redes y Comunicaciones',2,'No fields changed.',8,1),(147,'2015-05-02 22:19:57','24','Ingeniería de Software 3',2,'Changed anio, profesor, correlativas and info.',8,1),(148,'2015-05-03 14:18:42','25','Bases de Datos 2',2,'Changed anio, correlativas and info.',8,1),(149,'2015-05-03 14:21:32','26','Fundamentos de Teoría de la Computación',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(150,'2015-05-03 14:22:54','27','Sistemas Operativos',2,'Changed anio, profesor, correlativas and info.',8,1),(151,'2015-05-03 14:24:43','28','Desarrollo de Software en Sistemas Distribuidos',2,'Changed cuatrimestre, anio, correlativas and info.',8,1),(152,'2015-05-03 14:28:31','28','Desarrollo de Software en Sistemas Distribuidos',2,'Changed profesor.',8,1),(153,'2015-05-03 14:30:08','29','Matemática Discreta',2,'Changed anio, profesor, correlativas and info.',8,1),(154,'2015-05-03 14:32:52','30','Disenos de Sistemas Embebidos',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(155,'2015-05-03 15:29:17','30','Disenos de Sistemas Embebidos',2,'No fields changed.',8,1),(156,'2015-05-03 15:32:37','31','Pruebas de Software',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(157,'2015-05-03 15:36:46','15','Mg. Dario Rodriguez',1,'',7,1),(158,'2015-05-03 15:40:21','32','Espacios Virtuales de Trabajo Colaborativo',2,'Changed cuatrimestre, anio, profesor and info.',8,1),(159,'2015-05-03 15:43:39','33','Política y Gestión de la Ciencia',2,'Changed anio, profesor and info.',8,1),(160,'2015-05-03 15:45:37','34','Aspectos legales y Profesionales de Informática',2,'Changed anio, profesor, correlativas and info.',8,1),(161,'2015-05-03 15:47:30','35','Nuevos Escenarios',2,'Changed cuatrimestre, anio, profesor and info.',8,1),(162,'2015-05-03 16:29:31','36','Tecnologías de Explotación de Información',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(163,'2015-05-03 16:30:15','37','Ingeniería de Software Empírica',2,'Changed cuatrimestre, anio, profesor and info.',8,1),(164,'2015-05-03 16:33:00','38','Seminario de Trabajo Final de Licenciatura en Sistemas',2,'Changed cuatrimestre, anio, profesor, correlativas and info.',8,1),(165,'2015-05-03 16:36:25','4','Arquitectura de Computadoras, Sebas: CU',1,'',10,1),(166,'2015-05-08 13:56:13','1','Programacion de Computadoras',2,'Changed nombre.',8,1),(167,'2015-05-08 13:59:04','1','PA, Programacion de Computadoras: Sebas, 10.0',1,'',9,1),(168,'2015-05-08 13:59:37','2','PA, Programacion de Computadoras: Sebas, 10',1,'',9,1),(169,'2015-05-08 14:05:05','1','Programación de Computadoras',2,'Changed nombre.',8,1),(170,'2015-05-08 14:05:37','3','PA, Programación de Computadoras: Sebas, 10',1,'',9,1),(171,'2015-05-08 14:12:33','4','123',3,'',4,1),(172,'2015-05-08 14:12:33','5','1234',3,'',4,1),(173,'2015-05-08 14:12:33','6','1234512',3,'',4,1),(174,'2015-05-08 14:12:33','7','54321',3,'',4,1),(175,'2015-05-08 23:23:29','3','ana',3,'',4,1),(176,'2015-05-08 23:24:32','1','Programacion de Computadoras',2,'Changed nombre.',8,1),(177,'2015-05-09 01:17:49','2','Sebas',3,'',4,1),(178,'2015-05-09 01:19:08','1','Cdor. Hector Carballo',2,'Changed nombre.',7,1),(179,'2015-05-09 01:19:20','3','Lic. Jose Vazquez',2,'Changed nombre.',7,1),(180,'2015-05-09 01:19:33','5','Mg. Andres Mombru',2,'Changed nombre.',7,1),(181,'2015-05-09 01:19:42','6','Dr. Ramon Garcia-Martinez',2,'Changed nombre.',7,1),(182,'2015-05-09 01:20:14','9','Dr. Hernan Merlino',2,'Changed nombre.',7,1),(183,'2015-05-09 01:20:36','14','Mg. Hernan Amatriain',2,'Changed nombre.',7,1),(184,'2015-05-09 01:22:04','2','Organizacion de Computadoras',2,'Changed nombre.',8,1),(185,'2015-05-09 01:22:19','4','Matematica 1',2,'Changed nombre.',8,1),(186,'2015-05-09 01:22:32','5','Matematica 2',2,'Changed nombre.',8,1),(187,'2015-05-09 01:22:53','6','Expresion de Problemas y Algoritmos',2,'Changed nombre.',8,1),(188,'2015-05-09 01:23:09','7','Introduccion al Pensamiento Cientifico',2,'Changed nombre.',8,1),(189,'2015-05-09 01:23:35','8','Ingenieria de Software 1',2,'Changed nombre.',8,1),(190,'2015-05-09 01:23:48','9','Introduccion a las Bases de Datos',2,'Changed nombre.',8,1),(191,'2015-05-09 01:23:59','11','Orientacion a Objetos 1',2,'Changed nombre.',8,1),(192,'2015-05-09 01:24:12','13','Introduccion a los Sistemas Operativos',2,'Changed nombre.',8,1),(193,'2015-05-09 01:24:25','14','Matematica 3',2,'Changed nombre.',8,1),(194,'2015-05-09 01:24:38','15','Probabilidades y Estadistica',2,'Changed nombre.',8,1),(195,'2015-05-09 01:25:00','16','Programacion Concurrente',2,'Changed nombre.',8,1),(196,'2015-05-09 01:25:13','17','Ingenieria de Software 2',2,'Changed nombre.',8,1),(197,'2015-05-09 01:25:26','18','Orientacion a Objetos 2',2,'Changed nombre.',8,1),(198,'2015-05-09 01:25:48','22','Conceptos y Paradigmas de Lenguajes de Programacion',2,'No fields changed.',8,1),(199,'2015-05-09 01:26:04','24','Ingenieria de Software 3',2,'Changed nombre.',8,1),(200,'2015-05-09 01:26:26','26','Fundamentos de Teoria de la Computacion',2,'Changed nombre.',8,1),(201,'2015-05-09 01:26:37','29','Matematica Discreta',2,'Changed nombre.',8,1),(202,'2015-05-09 01:26:53','33','Politica y Gestion de la Ciencia',2,'Changed nombre.',8,1),(203,'2015-05-09 01:27:10','34','Aspectos legales y Profesionales de Informatica',2,'Changed nombre.',8,1),(204,'2015-05-09 01:27:25','36','Tecnologias de Explotacion de Informacion',2,'Changed nombre.',8,1),(205,'2015-05-09 01:27:35','37','Ingeniería de Software Empirica',2,'Changed nombre.',8,1),(206,'2015-05-09 01:28:25','37','Ingenieria de Software Empirica',2,'Changed nombre.',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'profesor','plan','profesor'),(8,'materia','plan','materia'),(9,'examen','plan','examen'),(10,'estado materia','plan','estadomateria');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2015-04-04 16:24:00'),(2,'auth','0001_initial','2015-04-04 16:24:04'),(3,'admin','0001_initial','2015-04-04 16:24:04'),(4,'sessions','0001_initial','2015-04-04 16:24:05');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3bniw2l849e2zijditql2f9dxfyekkcc','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-11 15:11:04'),('3q4b4y13bx7jnwdge2v0eqw46udyk0ra','NzMzN2Q4NjhiYzlkZTA2N2I2ODQ5NmVhZmVhNTUwNzIyNzMyODU2Zjp7Il9hdXRoX3VzZXJfaGFzaCI6ImUzZjFiY2MzZDgwOGQ2YzQ4YmZkMjQ1NmNjZWMyMDhjNzVjMjgwNGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9','2015-04-26 19:55:14'),('6tz6vdb9nbxm2s859ipxxrisd2libpy8','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-09 17:04:27'),('72eu0ry665knvjrktixgbv9wnojsf0fg','NzMzN2Q4NjhiYzlkZTA2N2I2ODQ5NmVhZmVhNTUwNzIyNzMyODU2Zjp7Il9hdXRoX3VzZXJfaGFzaCI6ImUzZjFiY2MzZDgwOGQ2YzQ4YmZkMjQ1NmNjZWMyMDhjNzVjMjgwNGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9','2015-05-17 19:45:03'),('7jkup0sjjhtfqsma6mv0j5u2939fkca9','MDc4ZTY3YTEyNjYxNDg1ZDY3NjhiNTIwNjE1NWEzMGZhNTZhNDk1Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMzZDVjOTY4NjAwYTZlYjUwYmY5ZjVhMzNjN2RkYzM3Mjg4ODc2MTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-05-22 23:22:22'),('94t09tm6qsyuyytxz3bvxoma60zc0edp','NzMzN2Q4NjhiYzlkZTA2N2I2ODQ5NmVhZmVhNTUwNzIyNzMyODU2Zjp7Il9hdXRoX3VzZXJfaGFzaCI6ImUzZjFiY2MzZDgwOGQ2YzQ4YmZkMjQ1NmNjZWMyMDhjNzVjMjgwNGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9','2015-05-21 23:37:42'),('abmwvp37wxhzhwuhhqm8w1wy4fluexc1','NzMzN2Q4NjhiYzlkZTA2N2I2ODQ5NmVhZmVhNTUwNzIyNzMyODU2Zjp7Il9hdXRoX3VzZXJfaGFzaCI6ImUzZjFiY2MzZDgwOGQ2YzQ4YmZkMjQ1NmNjZWMyMDhjNzVjMjgwNGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9','2015-05-06 15:12:40'),('cfehn9d48yjk33vzoiwj67m7hrcbx9en','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-16 17:57:03'),('ecu9vvq2pi81zzkeedbep8dd3l1h4jgl','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-16 15:10:16'),('ffa69o839a8nwne299ercgahw1lua179','MDc4ZTY3YTEyNjYxNDg1ZDY3NjhiNTIwNjE1NWEzMGZhNTZhNDk1Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMzZDVjOTY4NjAwYTZlYjUwYmY5ZjVhMzNjN2RkYzM3Mjg4ODc2MTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-05-16 22:09:23'),('i5koohldjdhsjk468gi8mgff47b5xruo','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-04-26 21:45:08'),('i62t95zxs03690fxrvi0f4nkn24ylkux','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-17 19:42:36'),('l5zmc1vpuhalqyn6ivo2qb4yvexatwsb','NzMzN2Q4NjhiYzlkZTA2N2I2ODQ5NmVhZmVhNTUwNzIyNzMyODU2Zjp7Il9hdXRoX3VzZXJfaGFzaCI6ImUzZjFiY2MzZDgwOGQ2YzQ4YmZkMjQ1NmNjZWMyMDhjNzVjMjgwNGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9','2015-05-22 14:19:47'),('lzfsur95px09p0ju42jhc021dre5qwnc','MDc4ZTY3YTEyNjYxNDg1ZDY3NjhiNTIwNjE1NWEzMGZhNTZhNDk1Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMzZDVjOTY4NjAwYTZlYjUwYmY5ZjVhMzNjN2RkYzM3Mjg4ODc2MTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-05-16 14:40:23'),('o6gzyi89v1306vqmfy6aiv64rsyaxrw9','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-16 20:30:07'),('obcq10xu5kl3txuylahr3k2v6sbrj3uf','NzMzN2Q4NjhiYzlkZTA2N2I2ODQ5NmVhZmVhNTUwNzIyNzMyODU2Zjp7Il9hdXRoX3VzZXJfaGFzaCI6ImUzZjFiY2MzZDgwOGQ2YzQ4YmZkMjQ1NmNjZWMyMDhjNzVjMjgwNGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9','2015-04-18 16:27:47'),('pfgiwhcvkomkwjihdj00opvhaijuyuog','MDc4ZTY3YTEyNjYxNDg1ZDY3NjhiNTIwNjE1NWEzMGZhNTZhNDk1Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMzZDVjOTY4NjAwYTZlYjUwYmY5ZjVhMzNjN2RkYzM3Mjg4ODc2MTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-05-23 01:17:32'),('uw7163itz09dimp3p94bq441jbmm8e3m','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-10 04:20:37'),('vbse01scryqbvydif9moap1py93h42nc','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-03 05:20:21'),('xz0cd1itsonmxmhf939ksoqwxncb6uf3','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-04-26 18:04:40'),('ybbq3ud4zpgwg71h4f3xiuxquux84k97','NWYxMGQ4ZjhiNTE1MzNjNzk3MDY0ZGJmOWM2ZmNlZTE1MjA0MDRhNjp7fQ==','2015-05-15 23:09:39');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_estadomateria`
--

DROP TABLE IF EXISTS `plan_estadomateria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_estadomateria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `materia_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `estado` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `materia_id` (`materia_id`,`alumno_id`),
  KEY `plan_estadomateria_ce3d2f7b` (`materia_id`),
  KEY `plan_estadomateria_fcd07de9` (`alumno_id`),
  CONSTRAINT `materia_id_refs_id_49b6f66e` FOREIGN KEY (`materia_id`) REFERENCES `plan_materia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_estadomateria`
--

LOCK TABLES `plan_estadomateria` WRITE;
/*!40000 ALTER TABLE `plan_estadomateria` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_estadomateria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_examen`
--

DROP TABLE IF EXISTS `plan_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_examen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nota` decimal(3,1) NOT NULL,
  `fecha` date NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `materia_id` int(11) NOT NULL,
  `opcion` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_examen_fcd07de9` (`alumno_id`),
  KEY `plan_examen_ce3d2f7b` (`materia_id`),
  CONSTRAINT `materia_id_refs_id_e9361620` FOREIGN KEY (`materia_id`) REFERENCES `plan_materia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_examen`
--

LOCK TABLES `plan_examen` WRITE;
/*!40000 ALTER TABLE `plan_examen` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_examen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_materia`
--

DROP TABLE IF EXISTS `plan_materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_materia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `cuatrimestre` varchar(2) NOT NULL,
  `anio` varchar(2) NOT NULL,
  `info` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_materia`
--

LOCK TABLES `plan_materia` WRITE;
/*!40000 ALTER TABLE `plan_materia` DISABLE KEYS */;
INSERT INTO `plan_materia` VALUES (1,'Programacion de Computadoras','AN','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-programacion-de-computadoras/ls-1-Programacion-de-Computadora.htm'),(2,'Organizacion de Computadoras','PR','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-organizacion-de-computadoras/ls-1-Organizacion-de-Computadoras.htm'),(3,'Arquitectura de Computadoras','SE','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-arquitectura-de-computadoras/ls-1-arquitectura-de-computadoras.htm'),(4,'Matematica 1','PR','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-matematica-I/ls-1-matematica-I.htm'),(5,'Matematica 2','SE','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-matematica-II/ls-1-matematica-II.htm'),(6,'Expresion de Problemas y Algoritmos','PR','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-expresion-de-problemas-y-algoritmos/ls-1-expresion-de-problemas-y-algoritmos.htm'),(7,'Introduccion al Pensamiento Cientifico','SE','PR','http://sistemas.unla.edu.ar/sistemas/sls/ls-1-introduccion-al-pensamiento-cientifico/ls-1-introduccion-al-pensamiento-cientifico.htm'),(8,'Ingenieria de Software 1','PR','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-Ingenieria-de-Software-I/ls-2-Ingenieria-de-Software-I.htm'),(9,'Introduccion a las Bases de Datos','AN','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-introduccion-bases-de-datos/ls-2-introduccion-bases-de-datos.htm'),(10,'Algoritmos y Estructuras de Datos','PR','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-algoritmos-y-estructuras-de-datos/ls-2-algoritmos-y-estructuras-de-datos.htm'),(11,'Orientacion a Objetos 1','SE','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-orientacion-a-objetos-I/ls-2-orientacion-a-objetos-I.htm'),(12,'Seminario de Lenguajes','SE','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-seminario-de-lenguajes/ls-2-seminario-de-lenguajes.htm'),(13,'Introduccion a los Sistemas Operativos','SE','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-introd-a-los-sistemas-operativos/ls-2-introduccion-a-los-sistemas-operativos.htm'),(14,'Matematica 3','PR','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-matematica-III/ls-2-matematica-III.htm'),(15,'Probabilidades y Estadistica','SE','SE','http://sistemas.unla.edu.ar/sistemas/sls/ls-2-probabilidades-y-estadistica/ls-2-probabilidades-y-estadistica.htm'),(16,'Programacion Concurrente','PR','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-programacion-concurrente/ls-3-programacion-concurrente.htm'),(17,'Ingenieria de Software 2','PR','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-Ingenieria-de-Software-II/ls-3-ingenieria-de-software-II.htm'),(18,'Orientacion a Objetos 2','PR','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-orientacion-a-objetos-II/ls-3-orientacion-a-objetos-II.htm'),(19,'Sistemas y Organizaciones','SE','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-sistemas-y-organizaciones/ls-3-sistemas-y-organizaciones.htm'),(20,'Bases de Datos 1','SE','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-bases-de-datos-I/ls-3-bases-de-datos-I.htm'),(21,'Proyecto de Software','SE','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-Proyecto-de-Software/ls-3-Proyecto-de-Software.htm'),(22,'Conceptos y Paradigmas de Lenguajes de Programacion','PR','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-conceptos-y-paradigmas-de-lenguajes-de-prog/ls-3-conceptos-y-paradigmas-de-lenguajes-de-programacion.htm'),(23,'Redes y Comunicaciones','SE','TE','http://sistemas.unla.edu.ar/sistemas/sls/ls-3-redes-y-comunicaciones/ls-3-redes-y-comunicaciones.htm'),(24,'Ingenieria de Software 3','PR','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-Ingenieria-de-Software-III/ls-4-Ingenieria-de-Software-III.htm'),(25,'Bases de Datos 2','PR','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-bases-de-datos-II/ls-4-bases-de-datos-II.htm'),(26,'Fundamentos de Teoria de la Computacion','SE','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-fundamentos-teoria-computacion/ls-4-fundamentos-teoria-computacion.htm'),(27,'Sistemas Operativos','PR','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-sistemas-operativos/ls-4-sistemas-operativos.htm'),(28,'Desarrollo de Software en Sistemas Distribuidos','SE','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-desarrollo-software-en-sistemas-distribuidos/ls-4-desarrollo-software-en-sistemas-distribuidos.htm'),(29,'Matematica Discreta','PR','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-matematica-discreta/ls-4-matematica-discreta.htm'),(30,'Disenos de Sistemas Embebidos','SE','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-optativa-arquitectura-diseno-de-sistemas-embebidos/ls-4-optativa-arquitectura-diseno-de-sistemas-embebidos.htm'),(31,'Pruebas de Software','SE','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-optativa-algoritmos-y-lenguajes-prueba-del-software/ls-4-optativa-algoritmos-y-lenguajes-prueba-del-software.htm'),(32,'Espacios Virtuales de Trabajo Colaborativo','SE','CU','http://sistemas.unla.edu.ar/sistemas/sls/ls-4-optativa-evtc/ls-4-optativa-evtc.htm'),(33,'Politica y Gestion de la Ciencia','PR','QU','http://sistemas.unla.edu.ar/sistemas/sls/ls-5-politica-y-gestion-de-la-ciencia/ls-5-politica-y-gestion-de-la-ciencia.htm'),(34,'Aspectos legales y Profesionales de Informatica','PR','QU','http://sistemas.unla.edu.ar/sistemas/sls/ls-5-aspectos-legales-y-profesionales-de-Informatica/ls-5-aspectos-legales-y-profesionales-de-Informatica.htm'),(35,'Nuevos Escenarios','SE','QU','http://sistemas.unla.edu.ar/sistemas/sls/ls-5-nuevos-escenarios/ls-5-nuevos-escenarios.htm'),(36,'Tecnologias de Explotacion de Informacion','SE','QU','http://sistemas.unla.edu.ar/sistemas/sls/ls-5-optativa-tecnologias-de-explotacion-de-info/ls-5-tecnologias-de-explotacion-de-info.htm'),(37,'Ingenieria de Software Empirica','SE','QU','http://sistemas.unla.edu.ar/sistemas/sls/ls-5-optativa-IS-empirica/ls-5-optativa-IS-empirica.htm'),(38,'Seminario de Trabajo Final de Licenciatura en Sistemas','AN','QU','http://sistemas.unla.edu.ar/sistemas/sls/ls-5-seminario-de-trab-final-de-lic-en-sis/ls-5-seminario-de-trab-final-de-lic-en-sis.htm');
/*!40000 ALTER TABLE `plan_materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_materia_correlativas`
--

DROP TABLE IF EXISTS `plan_materia_correlativas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_materia_correlativas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_materia_id` int(11) NOT NULL,
  `to_materia_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `from_materia_id` (`from_materia_id`,`to_materia_id`),
  KEY `plan_materia_correlativas_355b3561` (`from_materia_id`),
  KEY `plan_materia_correlativas_0208e0b8` (`to_materia_id`),
  CONSTRAINT `from_materia_id_refs_id_e2722377` FOREIGN KEY (`from_materia_id`) REFERENCES `plan_materia` (`id`),
  CONSTRAINT `to_materia_id_refs_id_e2722377` FOREIGN KEY (`to_materia_id`) REFERENCES `plan_materia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_materia_correlativas`
--

LOCK TABLES `plan_materia_correlativas` WRITE;
/*!40000 ALTER TABLE `plan_materia_correlativas` DISABLE KEYS */;
INSERT INTO `plan_materia_correlativas` VALUES (1,3,2),(72,5,4),(73,8,1),(74,9,1),(10,10,1),(11,10,5),(12,10,6),(75,11,1),(15,12,1),(76,13,1),(77,13,3),(78,14,5),(79,15,14),(80,16,12),(81,16,13),(82,17,8),(83,18,11),(31,19,8),(32,19,9),(33,20,9),(34,21,8),(35,21,9),(36,21,10),(37,21,12),(84,22,10),(85,22,12),(43,23,5),(44,23,13),(88,24,14),(86,24,17),(87,24,19),(48,25,20),(89,26,14),(90,26,22),(51,27,23),(55,28,16),(56,28,20),(57,28,23),(91,29,15),(60,30,23),(61,31,22),(92,34,21),(93,36,24),(64,38,16),(65,38,17),(66,38,18),(67,38,19),(68,38,20),(69,38,21),(70,38,22),(71,38,23);
/*!40000 ALTER TABLE `plan_materia_correlativas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_materia_profesor`
--

DROP TABLE IF EXISTS `plan_materia_profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_materia_profesor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `materia_id` int(11) NOT NULL,
  `profesor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `materia_id` (`materia_id`,`profesor_id`),
  KEY `plan_materia_profesor_ce3d2f7b` (`materia_id`),
  KEY `plan_materia_profesor_56d46bd1` (`profesor_id`),
  CONSTRAINT `materia_id_refs_id_22d899dd` FOREIGN KEY (`materia_id`) REFERENCES `plan_materia` (`id`),
  CONSTRAINT `profesor_id_refs_id_13214f92` FOREIGN KEY (`profesor_id`) REFERENCES `plan_profesor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_materia_profesor`
--

LOCK TABLES `plan_materia_profesor` WRITE;
/*!40000 ALTER TABLE `plan_materia_profesor` DISABLE KEYS */;
INSERT INTO `plan_materia_profesor` VALUES (97,1,1),(98,2,2),(46,3,2),(99,4,3),(100,5,3),(101,6,4),(102,7,5),(103,8,6),(104,9,1),(57,10,7),(105,11,8),(60,12,9),(106,13,9),(107,14,3),(108,15,3),(109,16,9),(110,17,6),(111,18,8),(70,19,11),(71,20,1),(72,21,6),(112,22,9),(77,23,7),(113,24,6),(79,25,1),(114,26,6),(81,27,9),(83,28,7),(115,29,8),(86,30,7),(87,31,10),(88,32,15),(116,33,11),(117,34,12),(91,35,13),(118,36,6),(120,37,14),(94,38,11);
/*!40000 ALTER TABLE `plan_materia_profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_profesor`
--

DROP TABLE IF EXISTS `plan_profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_profesor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_profesor`
--

LOCK TABLES `plan_profesor` WRITE;
/*!40000 ALTER TABLE `plan_profesor` DISABLE KEYS */;
INSERT INTO `plan_profesor` VALUES (1,'Cdor. Hector Carballo'),(2,'Ing. Oscar Montes'),(3,'Lic. Jose Vazquez'),(4,'Lic. Luis Cornacchia'),(5,'Mg. Andres Mombru'),(6,'Dr. Ramon Garcia-Martinez'),(7,'Mg. Ing. Diego Azcurra'),(8,'Lic. Alejandra Vranic'),(9,'Dr. Hernan Merlino'),(10,'M.Ing. Eduardo Diez'),(11,'Lic. Ricardo Lelli'),(12,'Dr. Antonio Martino'),(13,'Dr. Oscar Tangelson'),(14,'Mg. Hernan Amatriain'),(15,'Mg. Dario Rodriguez');
/*!40000 ALTER TABLE `plan_profesor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-08 22:38:00
