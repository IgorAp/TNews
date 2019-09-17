CREATE DATABASE  IF NOT EXISTS `tnews` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `tnews`;
-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tnews
-- ------------------------------------------------------
-- Server version	8.0.12

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Ciência'),(2,'Cultura'),(3,'Ecônomia'),(4,'Educação'),(5,'Entretenimento'),(6,'Esporte'),(7,'Política'),(8,'Tecnologia');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_has_user`
--

DROP TABLE IF EXISTS `categoria_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categoria_has_user` (
  `user_id` int(11) NOT NULL,
  `categoria_idcategoria` int(11) NOT NULL,
  KEY `fk_categoria_has_user_user1_idx` (`user_id`),
  KEY `fk_categoria_has_user_categoria1_idx` (`categoria_idcategoria`),
  CONSTRAINT `fk_categoria_has_user_categoria1` FOREIGN KEY (`categoria_idcategoria`) REFERENCES `categoria` (`idcategoria`),
  CONSTRAINT `fk_categoria_has_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_has_user`
--

LOCK TABLES `categoria_has_user` WRITE;
/*!40000 ALTER TABLE `categoria_has_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria_has_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `comentario` (
  `idcomentario` int(11) NOT NULL AUTO_INCREMENT,
  `user_iduser` int(11) NOT NULL,
  `comentario_idcomentario` int(11) DEFAULT NULL,
  `noticia_idnoticia` int(11) NOT NULL,
  `nivel` int(11) DEFAULT NULL,
  `corpo` varchar(255) NOT NULL,
  PRIMARY KEY (`idcomentario`),
  KEY `fk_comentario_user1_idx` (`user_iduser`),
  KEY `fk_comentario_comentario1_idx` (`comentario_idcomentario`),
  KEY `fk_comentario_noticia1_idx` (`noticia_idnoticia`),
  CONSTRAINT `fk_comentario_comentario1` FOREIGN KEY (`comentario_idcomentario`) REFERENCES `comentario` (`idcomentario`),
  CONSTRAINT `fk_comentario_noticia1` FOREIGN KEY (`noticia_idnoticia`) REFERENCES `noticia` (`idnoticia`),
  CONSTRAINT `fk_comentario_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `denuncia`
--

DROP TABLE IF EXISTS `denuncia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `denuncia` (
  `idDenuncia` int(11) NOT NULL AUTO_INCREMENT,
  `detalhes` varchar(255) DEFAULT NULL,
  `flag` varchar(45) DEFAULT NULL,
  `noticia_idnoticia` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cota` int(11) DEFAULT '0',
  `pros` int(11) DEFAULT '0',
  `contras` int(11) DEFAULT '0',
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`idDenuncia`),
  KEY `fk_denuncia_noticia_idx` (`noticia_idnoticia`),
  KEY `fk_denuncia_user1_idx` (`user_id`),
  CONSTRAINT `fk_denuncia_noticia` FOREIGN KEY (`noticia_idnoticia`) REFERENCES `noticia` (`idnoticia`),
  CONSTRAINT `fk_denuncia_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noticia`
--

DROP TABLE IF EXISTS `noticia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `noticia` (
  `idnoticia` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(128) DEFAULT NULL,
  `corpo` text,
  `estado` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `capa` varchar(255) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `visualizacoes` int(11) DEFAULT '0',
  `denunciada` tinyint(4) DEFAULT '0',
  `concluida` int(11) DEFAULT '0',
  PRIMARY KEY (`idnoticia`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noticia_has_categoria`
--

DROP TABLE IF EXISTS `noticia_has_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `noticia_has_categoria` (
  `noticia_idnoticia` int(11) NOT NULL,
  `categoria_idcategoria` int(11) NOT NULL,
  PRIMARY KEY (`noticia_idnoticia`,`categoria_idcategoria`),
  KEY `fk_noticia_has_categoria_categoria1_idx` (`categoria_idcategoria`),
  KEY `fk_noticia_has_categoria_noticia1_idx` (`noticia_idnoticia`),
  CONSTRAINT `fk_noticia_has_categoria_categoria1` FOREIGN KEY (`categoria_idcategoria`) REFERENCES `categoria` (`idcategoria`),
  CONSTRAINT `fk_noticia_has_categoria_noticia1` FOREIGN KEY (`noticia_idnoticia`) REFERENCES `noticia` (`idnoticia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noticia_has_user`
--

DROP TABLE IF EXISTS `noticia_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `noticia_has_user` (
  `idNoticia` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `dataEdicao` date DEFAULT NULL,
  `relacao` varchar(255) DEFAULT NULL,
  KEY `idNoticia_idx` (`idNoticia`),
  KEY `idUser_idx` (`idUser`),
  CONSTRAINT `idNoticia` FOREIGN KEY (`idNoticia`) REFERENCES `noticia` (`idnoticia`),
  CONSTRAINT `idUser` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noticias_marcadas`
--

DROP TABLE IF EXISTS `noticias_marcadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `noticias_marcadas` (
  `idnoticia` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL,
  KEY `idNoticia_idx` (`idnoticia`),
  KEY `fk_idUser_idx` (`idUser`),
  CONSTRAINT `fk_idNoticia` FOREIGN KEY (`idnoticia`) REFERENCES `noticia` (`idnoticia`),
  CONSTRAINT `fk_idUser` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `sobrenome` varchar(45) NOT NULL,
  `senha` varchar(128) NOT NULL,
  `email` varchar(64) NOT NULL,
  `cep` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `votosusuarios`
--

DROP TABLE IF EXISTS `votosusuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `votosusuarios` (
  `idUsuario` int(11) DEFAULT NULL,
  `id_Denuncia` int(11) DEFAULT NULL,
  KEY `fk_idUsuario_idx` (`idUsuario`),
  KEY `fk_idDenuncia_idx` (`id_Denuncia`),
  CONSTRAINT `fk_idDenuncia` FOREIGN KEY (`id_Denuncia`) REFERENCES `denuncia` (`iddenuncia`),
  CONSTRAINT `fk_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-22 17:08:39
