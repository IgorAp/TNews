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
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
INSERT INTO `comentario` VALUES (5,16,NULL,71,NULL,'Comentários de teste'),(6,16,NULL,82,NULL,'Comentei como teste'),(7,16,6,82,NULL,'Olá'),(8,16,NULL,78,NULL,'Teste\n'),(9,16,NULL,78,NULL,'Care');
/*!40000 ALTER TABLE `comentario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `denuncia`
--

LOCK TABLES `denuncia` WRITE;
/*!40000 ALTER TABLE `denuncia` DISABLE KEYS */;
INSERT INTO `denuncia` VALUES (15,'Ok\n','nudez',82,16,2,1,1,0),(16,'Teste','noticiaFalsa',81,16,1,2,0,1),(17,'Tds','violencia',84,16,1,0,0,0);
/*!40000 ALTER TABLE `denuncia` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `noticia`
--

LOCK TABLES `noticia` WRITE;
/*!40000 ALTER TABLE `noticia` DISABLE KEYS */;
INSERT INTO `noticia` VALUES (71,'Lorem  laiane','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Olá</p>','Minas Gerais','Abadia dos Dourados','/images/guitar-2635044_1920.jpg','2018-11-13',88,0,1),(72,'Lorem','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet eros luctus, consequat dolor ut, rutrum augue. Integer vehicula erat sit amet eleifend laoreet. Suspendisse sollicitudin, turpis at lobortis mattis, nisi elit facilisis justo, et tempor enim justo vel ex. Mauris dictum erat vitae erat rhoncus iaculis. Ut pulvinar ut mauris sed mattis. Sed consectetur aliquet consectetur. Donec rhoncus hendrerit est eu rutrum. Mauris fermentum tincidunt mauris, ut rhoncus risus fringilla sit amet. Nulla id libero id tortor consequat elementum et a nisl. Mauris dignissim neque est, at ultricies mi fermentum pharetra. Fusce sagittis ex lectus, vitae porta sem imperdiet quis. Donec fringilla eu justo nec consequat. Suspendisse id sollicitudin nunc.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Quisque ut urna sed libero tristique imperdiet ut nec purus. Donec elementum nisl ultrices turpis volutpat, facilisis lobortis eros tincidunt. Donec et ligula libero. Donec finibus tempor orci eu molestie. Praesent malesuada dapibus ante, et convallis lorem tincidunt vel. Donec non egestas mi. Nullam quis risus venenatis, tristique tortor ut, tempus diam. Nullam diam urna, sollicitudin et magna ac, porttitor sollicitudin libero. Nullam odio erat, molestie sed metus ut, facilisis aliquet nulla. Maecenas ut ultricies lacus. Integer semper leo hendrerit nibh semper, sed tempor urna mollis. In sit amet elementum enim. Morbi elementum nec mi vel tempus.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Aliquam erat volutpat. Morbi non vehicula urna, in lacinia sapien. Vestibulum ultricies sagittis nunc, sed auctor nibh ultrices et. Sed at efficitur nisi. Duis blandit nibh mi, at dictum velit ultricies at. Maecenas nec dolor a justo elementum laoreet. Nam sit amet lorem ac odio egestas pulvinar.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Aliquam vestibulum ultricies tincidunt. Curabitur vitae neque sed nulla consectetur semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu sapien interdum, porttitor tortor eu, sodales nisi. Cras et massa eu sem placerat interdum eu ut ante. Phasellus vitae lobortis nisi. Sed lacinia convallis dolor, sit amet tempus urna finibus vitae. Proin sodales suscipit euismod. Duis mollis enim nec nisl auctor tincidunt. Maecenas justo mauris, bibendum quis turpis fermentum, porttitor vestibulum leo. Sed interdum nibh velit.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\">Nam fermentum vehicula pulvinar. Sed commodo velit ut pellentesque posuere. Nam laoreet vestibulum odio. Sed eu aliquet dolor, a fermentum magna. Aliquam ac scelerisque augue. Cras finibus hendrerit turpis, a malesuada leo rhoncus vitae. Nam consectetur elementum viverra.</p><img class=\"img-fluid\" src=\"\"><img class=\"img-fluid\" src=\"/images/porc.jpg\">','Minas Gerais','Abadia dos Dourados','/images/porc.jpg','2018-11-24',44,0,1),(73,'Com saída de cubanos, cerca de 600 cidades podem ficar sem médico, diz entidade','<h2 class=\"content-head__subtitle\" itemprop=\"alternativeHeadline\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px 1.5rem 0px 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 1.75rem; font-family: opensanstitle, helvetica, arial, sans-serif; vertical-align: baseline; color: rgb(85, 85, 85); letter-spacing: -0.03125rem;\">Com a decisão do governo de Cuba de deixar o Mais Médicos, profissionais começam a deixar o Brasil em 25 de novembro, segundo Conselho Nacional de Secretarias Municipais de Saúde.</h2><div class=\"mc-column content-text active-extra-styles active-capital-letter\" data-block-type=\"unstyled\" data-block-weight=\"39\" data-block-id=\"2\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; font-family: opensans, helvetica, arial, sans-serif; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word; color: rgb(51, 51, 51);\"><p class=\"content-text__container theme-color-primary-first-letter\" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Com a saída dos cubanos do programa Mais Médicos, cerca de 600 municípios brasileiros podem ficar sem nenhum médico da rede pública a partir do dia 25 de dezembro, segundo o Conselho Nacional de Secretarias Municipais de Saúde (Conasems).</p></div><div class=\"wall protected-content\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 18px; line-height: inherit; font-family: opensans, helvetica, arial, sans-serif; vertical-align: baseline; color: rgb(51, 51, 51);\"><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"57\" data-block-id=\"3\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">De acordo com o presidente da entidade, Mauro Junqueira, nessas cidades há apenas médicos cubanos, que começam a deixar o programa federal em 25 de novembro –&nbsp;<a href=\"https://g1.globo.com/pr/parana/noticia/2018/11/16/medicos-cubanos-devem-deixar-o-parana-a-partir-do-dia-25-de-novembro.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">a data já constava de um comunicado do governo cubano&nbsp;</a>a médicos que atuam no Paraná, conforme adiantou o&nbsp;<span style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;\">G1</span>. Os últimos cubanos&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/15/conselho-diz-que-foi-avisado-pela-embaixada-de-cuba-que-medicos-deixarao-brasil-ate-fim-do-ano.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">deverão deixar o país até o Natal</a>.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"35\" data-block-id=\"4\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Na última quarta (14), o governo de Cuba&nbsp;<a href=\"https://g1.globo.com/mundo/noticia/2018/11/14/cuba-decide-deixar-programa-mais-medicos-no-brasil.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">anunciou a decisão de deixar o Mais Médicos</a>, citando \"referências diretas, depreciativas e ameaçadoras\" feitas pelo presidente eleito Jair Bolsonaro à presença dos médicos cubanos no Brasil.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"29\" data-block-id=\"5\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Bolsonaro afirma que o governo cubano deixar o programa por&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/14/bolsonaro-diz-que-cuba-nao-aceitou-condicoes-para-continuar-no-programa-mais-medicos.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">não concordar com o teste de capacidade</a>. Para ele, é \"desumano\" dar aos mais pobres&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/16/e-desumano-dar-aos-mais-pobres-atendimento-sem-garantia-diz-bolsonaro-ao-falar-sobre-cubanos.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">atendimento médico \"sem garantia\"</a>.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"36\" data-block-id=\"6\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Cuba enviava profissionais para atuar no Brasil desde 2013, quando o programa foi criado durante o governo da ex-presidente Dilma Rousseff. Pouco mais da&nbsp;<a href=\"https://g1.globo.com/bemestar/noticia/2018/11/15/da-chegada-polemica-a-saida-anunciada-por-havana-veja-como-foram-os-5-anos-da-participacao-cubana-no-mais-medicos.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">metade dos atuais 16 mil participantes</a>&nbsp;do Mais Médicos são de Cuba.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"22\" data-block-id=\"7\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Como medida emergencial para suprir as vagas que serão abertas, o Ministério da Saúde disse que&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/16/selecao-de-medicos-brasileiros-para-substituir-cubanos-sera-ainda-em-novembro-diz-ministerio.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">lançará um edital nos próximos dias</a>.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"43\" data-block-id=\"8\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Na segunda-feira (19), representantes do Conasems e do Ministério da Saúde vão se reunir para discutir detalhes do edital. Junqueira explica que o objetivo é tentar encurtar ao máximo os prazos de convocação dos novos médicos para preencher o quanto antes as vagas.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"39\" data-block-id=\"9\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"text-align: justify; box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">“O ministério se comprometeu a publicar o edital e aí tem os prazos legais para a primeira chamada. Queremos ver se é possível diminuir os prazos para os primeiros médicos já começarem a trabalhar em fevereiro [de 2019]”, afirmou.</p></div></div>','Minas Gerais','Abadia dos Dourados','/images/airadventurelevel1.png','2018-11-08',21,0,1),(74,'Lorem','<div class=\"mc-column content-text active-extra-styles active-capital-letter\" data-block-type=\"unstyled\" data-block-weight=\"39\" data-block-id=\"2\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; font-family: opensans, helvetica, arial, sans-serif; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word; color: rgb(51, 51, 51);\"><p class=\"content-text__container theme-color-primary-first-letter\" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Com a saída dos cubanos do programa Mais Médicos, cerca de 600 municípios brasileiros podem ficar sem nenhum médico da rede pública a partir do dia 25 de dezembro, segundo o Conselho Nacional de Secretarias Municipais de Saúde (Conasems).</p></div><div class=\"wall protected-content\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 18px; line-height: inherit; font-family: opensans, helvetica, arial, sans-serif; vertical-align: baseline; color: rgb(51, 51, 51);\"><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"57\" data-block-id=\"3\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">De acordo com o presidente da entidade, Mauro Junqueira, nessas cidades há apenas médicos cubanos, que começam a deixar o programa federal em 25 de novembro –&nbsp;<a href=\"https://g1.globo.com/pr/parana/noticia/2018/11/16/medicos-cubanos-devem-deixar-o-parana-a-partir-do-dia-25-de-novembro.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">a data já constava de um comunicado do governo cubano&nbsp;</a>a médicos que atuam no Paraná, conforme adiantou o&nbsp;<span style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;\">G1</span>. Os últimos cubanos&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/15/conselho-diz-que-foi-avisado-pela-embaixada-de-cuba-que-medicos-deixarao-brasil-ate-fim-do-ano.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">deverão deixar o país até o Natal</a>.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"35\" data-block-id=\"4\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Na última quarta (14), o governo de Cuba&nbsp;<a href=\"https://g1.globo.com/mundo/noticia/2018/11/14/cuba-decide-deixar-programa-mais-medicos-no-brasil.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">anunciou a decisão de deixar o Mais Médicos</a>, citando \"referências diretas, depreciativas e ameaçadoras\" feitas pelo presidente eleito Jair Bolsonaro à presença dos médicos cubanos no Brasil.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"29\" data-block-id=\"5\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Bolsonaro afirma que o governo cubano deixar o programa por&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/14/bolsonaro-diz-que-cuba-nao-aceitou-condicoes-para-continuar-no-programa-mais-medicos.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">não concordar com o teste de capacidade</a>. Para ele, é \"desumano\" dar aos mais pobres&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/16/e-desumano-dar-aos-mais-pobres-atendimento-sem-garantia-diz-bolsonaro-ao-falar-sobre-cubanos.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">atendimento médico \"sem garantia\"</a>.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"36\" data-block-id=\"6\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Cuba enviava profissionais para atuar no Brasil desde 2013, quando o programa foi criado durante o governo da ex-presidente Dilma Rousseff. Pouco mais da&nbsp;<a href=\"https://g1.globo.com/bemestar/noticia/2018/11/15/da-chegada-polemica-a-saida-anunciada-por-havana-veja-como-foram-os-5-anos-da-participacao-cubana-no-mais-medicos.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">metade dos atuais 16 mil participantes</a>&nbsp;do Mais Médicos são de Cuba.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"22\" data-block-id=\"7\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Como medida emergencial para suprir as vagas que serão abertas, o Ministério da Saúde disse que&nbsp;<a href=\"https://g1.globo.com/politica/noticia/2018/11/16/selecao-de-medicos-brasileiros-para-substituir-cubanos-sera-ainda-em-novembro-diz-ministerio.ghtml\" style=\"box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: 700; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(196, 23, 12);\">lançará um edital nos próximos dias</a>.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"43\" data-block-id=\"8\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">Na segunda-feira (19), representantes do Conasems e do Ministério da Saúde vão se reunir para discutir detalhes do edital. Junqueira explica que o objetivo é tentar encurtar ao máximo os prazos de convocação dos novos médicos para preencher o quanto antes as vagas.</p></div><div class=\"mc-column content-text active-extra-styles \" data-block-type=\"unstyled\" data-block-weight=\"39\" data-block-id=\"9\" style=\"box-sizing: inherit; margin: 0px auto 2rem; padding: 0px 1rem; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 1.25rem; line-height: 2rem; vertical-align: baseline; max-width: 42.5rem; width: 680px; float: none; letter-spacing: -0.03125rem; overflow-wrap: break-word;\"><p class=\"content-text__container \" data-track-category=\"Link no Texto\" data-track-links=\"\" style=\"box-sizing: inherit; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; border: 0px; font: inherit; vertical-align: baseline;\">“O ministério se comprometeu a publicar o edital e aí tem os prazos legais para a primeira chamada. Queremos ver se é possível diminuir os prazos para os primeiros médicos já começarem a trabalhar em fevereiro [de 2019]”, afirmou.</p></div></div>','Minas Gerais','Abadia dos Dourados','/images/airadventurelevel1.png','2018-11-29',4,0,1),(75,'Agora vai','<div style=\"color: rgb(212, 212, 212); background-color: rgb(30, 30, 30); font-family: Consolas, &quot;Courier New&quot;, monospace; font-size: 14px; line-height: 19px; white-space: pre;\">  <span style=\"color: #9cdcfe;\">primeiraVez</span> = <span style=\"color: #569cd6;\">true</span>;</div>','Minas Gerais','Abadia dos Dourados','/images/tumblr_p1ow4cDzIG1qciqqno2_1280.gif','2018-11-17',8,0,1),(76,'BRGANTEC s2','<div style=\"color: rgb(212, 212, 212); background-color: rgb(30, 30, 30); font-family: Consolas, &quot;Courier New&quot;, monospace; font-size: 14px; line-height: 19px; white-space: pre;\">  <span style=\"color: #9cdcfe;\">primeiraVez</span> = <span style=\"color: #569cd6;\">true</span>;</div>','Minas Gerais','Abadia dos Dourados','/images/couro.jpg','2018-11-28',3,0,1),(77,'BRGANTEC s2','<p>ES</p>','Minas Gerais','Abadia dos Dourados','/images/porc.jpg','2018-11-09',10,0,1),(78,'BRGANTEC s2','<p>As</p>','Minas Gerais','Abadia dos Dourados','/images/porc.jpg','2018-11-03',35,0,1),(79,'asdf','<p>Test</p>','Minas Gerais','Abadia dos Dourados','/images/porc.jpg','2018-11-24',1,0,1),(80,'sdaf','<p>ASDAS</p>','Minas Gerais','Abadia dos Dourados','/images/porc.jpg','2018-11-20',11,0,1),(81,'Teste','<p>Teste</p>','Minas Gerais','Abadia dos Dourados','/images/486a7a3aeaecb7f7b4f98806a4156e85.jpg','2018-11-12',10,1,1),(82,'Lorem','<p>1234</p>','Minas Gerais','Abadia dos Dourados','/images/4f2fc3126b133945242380e66695dfc8.png','2018-10-30',72,0,1),(83,'Lorem','<p>31</p>','Minas Gerais','Abadia dos Dourados','/images/4f2fc3126b133945242380e66695dfc8.png','2018-11-23',16,0,1),(84,'Lorem Ipsum','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fringilla tortor vitae velit dictum, at bibendum eros pretium. Mauris facilisis molestie mollis. Mauris consectetur semper facilisis. Sed vel ligula vel orci eleifend viverra. Integer sit amet pharetra tellus. Pellentesque eleifend metus malesuada leo congue, quis fringilla est pulvinar. Donec tempus sit amet urna id pellentesque. Sed ac gravida tortor. Curabitur turpis eros, blandit eu consectetur sit amet, rhoncus eget tortor. In tempus porta condimentum. Mauris ut purus molestie, sodales mi at, maximus ante. Quisque vitae leo eget lorem egestas consectetur. Aenean id scelerisque neque. In sit amet nunc feugiat urna suscipit tincidunt. Suspendisse ullamcorper vel diam ac convallis.</span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\">Ut non iaculis dui. Sed tincidunt facilisis tempor. Donec quis nibh euismod, suscipit nibh id, vehicula neque. In ut ullamcorper leo, nec tempus mi. Nulla facilisi. Nunc sed quam quis magna efficitur consectetur quis et nisl. Duis tempor vestibulum mi et maximus. Proin sapien augue, scelerisque ut nisi a, aliquam faucibus augue. Quisque lacinia felis dui, in blandit diam pulvinar quis. Etiam vel ipsum ut nunc gravida malesuada. Proin nec viverra libero. Proin accumsan venenatis tempor. Cras quis accumsan nunc. Quisque id lacus purus. Sed rhoncus mollis ipsum, sit amet faucibus metus congue at.</span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><img src=\"https://i.ytimg.com/vi/ZYVX0wviSgQ/maxresdefault.jpg\" style=\"width: 1108.01px;\"><span style=\"font-family: Roboto;\"><br></span></p><p style=\"text-align: center; margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\">Foto 1</span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\">Morbi nec euismod enim. Sed fringilla egestas rhoncus. Vivamus efficitur vestibulum tortor, facilisis consectetur urna fermentum in. Nullam erat justo, facilisis non mi sit amet, efficitur pulvinar dui. Suspendisse feugiat pretium mauris, a faucibus elit fringilla sed. Aenean pulvinar, ante non malesuada consequat, elit odio fermentum mi, et vehicula nulla est nec tellus. Integer sit amet nunc sed ligula pellentesque tempus in et ex. Maecenas a nibh quis purus eleifend aliquam non et dolor. Ut urna nisi, ultrices id placerat sit amet, dictum mattis quam. Praesent sagittis, metus a blandit dignissim, nunc odio facilisis massa, quis finibus felis quam in lorem. Nam mattis accumsan leo id euismod.</span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\">Nullam fringilla ipsum eget purus pulvinar, ac iaculis orci semper. Aliquam dictum mi eu ultrices viverra. Phasellus vel lectus leo. Proin vestibulum euismod lacus, in volutpat ante rutrum a. Quisque at accumsan urna, fermentum congue leo. Fusce convallis dui sed semper egestas. Vestibulum convallis diam eget odio iaculis dignissim. Suspendisse potenti. Nunc sit amet commodo lectus. Aenean id dui sapien. Sed placerat magna at eros congue, sed fermentum ex hendrerit. Nam risus est, tempus pulvinar ante eget, dignissim tempor turpis. Nunc arcu quam, lobortis eu ullamcorper eu, tincidunt ac massa. Sed sollicitudin elit in commodo volutpat.</span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><img src=\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRblxPUrE7wkMHnyK_Hfa16oBFC5tmNH19O2A2w6Lq_4RCDViw5\" style=\"width: 281.989px; float: none;\"><span style=\"font-family: Roboto;\"><br></span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\"><br></span></p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px;\"><span style=\"font-family: Roboto;\"><br></span></p>','Minas Gerais','Abadia dos Dourados','/images/POST_BOAS-FESTAS.png','2018-11-20',4,0,1),(85,'Lorem','<p>Teste</p>','Minas Gerais','Acaiaca','/images/4f2fc3126b133945242380e66695dfc8.png','2018-11-15',2,0,1),(86,'Teste','<p><br></p><img class=\"img-fluid\" src=\"\"><img class=\"img-fluid\" src=\"\"><img class=\"img-fluid\" src=\"\"><img class=\"img-fluid\" src=\"\"><img class=\"img-fluid\" src=\"\"><img class=\"img-fluid\" src=\"/images/winter\" background.png=\"\">','Rio de Janeiro','Comendador Levy Gasparian','/images/4f2fc3126b133945242380e66695dfc8.png','2018-11-15',1,0,1);
/*!40000 ALTER TABLE `noticia` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `noticia_has_categoria`
--

LOCK TABLES `noticia_has_categoria` WRITE;
/*!40000 ALTER TABLE `noticia_has_categoria` DISABLE KEYS */;
INSERT INTO `noticia_has_categoria` VALUES (83,1),(85,1),(84,5),(86,6);
/*!40000 ALTER TABLE `noticia_has_categoria` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `noticia_has_user`
--

LOCK TABLES `noticia_has_user` WRITE;
/*!40000 ALTER TABLE `noticia_has_user` DISABLE KEYS */;
INSERT INTO `noticia_has_user` VALUES (71,15,NULL,NULL),(72,15,NULL,'moro lá'),(72,15,NULL,'moro lá'),(72,16,NULL,NULL),(72,16,NULL,NULL),(72,16,'2018-11-01',NULL),(72,16,'2018-11-15',NULL),(72,16,'2018-11-15',NULL),(71,16,'2018-11-17',NULL),(71,16,'2018-11-17',NULL),(72,16,'2018-11-01',NULL),(73,16,'2018-11-17',NULL),(74,16,'2018-11-17',NULL),(75,16,'2018-11-17',NULL),(76,16,'2018-11-17',NULL),(77,16,'2018-11-17',NULL),(78,16,'2018-11-17',NULL),(79,16,'2018-11-17',NULL),(80,16,'2018-11-17','Nenhum'),(71,16,'2018-11-19',NULL),(81,16,'2018-11-19',NULL),(82,16,'2018-11-19',''),(83,16,'2018-11-19',''),(84,16,'2018-11-20','Utilizo bastante'),(85,16,'2018-11-20','Nenhum'),(82,16,'2018-11-21',NULL),(82,16,'2018-11-21',NULL),(86,16,'2018-11-21','Nenhum'),(82,16,'2018-11-21',NULL),(82,16,'2018-11-21',NULL),(82,16,'2018-11-21',NULL),(71,16,'2018-11-21',NULL);
/*!40000 ALTER TABLE `noticia_has_user` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `noticias_marcadas`
--

LOCK TABLES `noticias_marcadas` WRITE;
/*!40000 ALTER TABLE `noticias_marcadas` DISABLE KEYS */;
INSERT INTO `noticias_marcadas` VALUES (82,16),(83,16);
/*!40000 ALTER TABLE `noticias_marcadas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (15,'Viniciius','Apa','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','vini@gmail.com',NULL,'Minas Gerais','Abadia dos Dourados'),(16,'Marcos','António','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','marco@gmail.com',NULL,'Minas Gerais','Abadia dos Dourados');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `votosusuarios`
--

LOCK TABLES `votosusuarios` WRITE;
/*!40000 ALTER TABLE `votosusuarios` DISABLE KEYS */;
INSERT INTO `votosusuarios` VALUES (16,15),(15,15),(15,16),(16,16);
/*!40000 ALTER TABLE `votosusuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-22 17:08:39
