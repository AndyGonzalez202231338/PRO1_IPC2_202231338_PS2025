CREATE DATABASE  IF NOT EXISTS `laComputadoraFeliz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laComputadoraFeliz`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: laComputadoraFeliz
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.22.04.1

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
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `NIT` varchar(20) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NIT` (`NIT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Computadora`
--

DROP TABLE IF EXISTS `Computadora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Computadora` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Computadora`
--

LOCK TABLES `Computadora` WRITE;
/*!40000 ALTER TABLE `Computadora` DISABLE KEYS */;
/*!40000 ALTER TABLE `Computadora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ensamble_Piezas`
--

DROP TABLE IF EXISTS `Ensamble_Piezas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ensamble_Piezas` (
  `id_piezaEnsamblada` int NOT NULL AUTO_INCREMENT,
  `id_computadora` int NOT NULL,
  `id_pieza` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_piezaEnsamblada`),
  KEY `id_computadora` (`id_computadora`),
  KEY `id_pieza` (`id_pieza`),
  CONSTRAINT `Ensamble_Piezas_ibfk_1` FOREIGN KEY (`id_computadora`) REFERENCES `modeloComputadora` (`id_computadora`) ON DELETE CASCADE,
  CONSTRAINT `Ensamble_Piezas_ibfk_2` FOREIGN KEY (`id_pieza`) REFERENCES `piezas` (`id_pieza`) ON DELETE CASCADE,
  CONSTRAINT `Ensamble_Piezas_chk_1` CHECK ((`Cantidad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ensamble_Piezas`
--

LOCK TABLES `Ensamble_Piezas` WRITE;
/*!40000 ALTER TABLE `Ensamble_Piezas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ensamble_Piezas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pieza`
--

DROP TABLE IF EXISTS `Pieza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pieza` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Costo` decimal(10,2) NOT NULL,
  `CantidadDisponible` int NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Pieza_chk_1` CHECK ((`CantidadDisponible` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pieza`
--

LOCK TABLES `Pieza` WRITE;
/*!40000 ALTER TABLE `Pieza` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pieza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rol`
--

DROP TABLE IF EXISTS `Rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rol` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` enum('Administrador','Ensamblador','Vendedor') NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rol`
--

LOCK TABLES `Rol` WRITE;
/*!40000 ALTER TABLE `Rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `NombreUsuario` varchar(50) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `ID_Rol` int NOT NULL,
  PRIMARY KEY (`NombreUsuario`),
  UNIQUE KEY `NombreUsuario` (`NombreUsuario`),
  KEY `ID_Rol` (`ID_Rol`),
  CONSTRAINT `Usuario_ibfk_1` FOREIGN KEY (`ID_Rol`) REFERENCES `Rol` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(100) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `nit` (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computadora_Ensamblada`
--

DROP TABLE IF EXISTS `computadora_Ensamblada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `computadora_Ensamblada` (
  `id_computadora_Ensamblada` int NOT NULL AUTO_INCREMENT,
  `id_computadora` int NOT NULL,
  `id_usuario` int NOT NULL,
  `fechaEnsamblaje` date NOT NULL,
  `costoTotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_computadora_Ensamblada`),
  KEY `id_computadora` (`id_computadora`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `computadora_Ensamblada_ibfk_1` FOREIGN KEY (`id_computadora`) REFERENCES `modeloComputadora` (`id_computadora`) ON DELETE CASCADE,
  CONSTRAINT `computadora_Ensamblada_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computadora_Ensamblada`
--

LOCK TABLES `computadora_Ensamblada` WRITE;
/*!40000 ALTER TABLE `computadora_Ensamblada` DISABLE KEYS */;
/*!40000 ALTER TABLE `computadora_Ensamblada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_Venta`
--

DROP TABLE IF EXISTS `detalle_Venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_Venta` (
  `id_detalleVenta` int NOT NULL AUTO_INCREMENT,
  `id_enta` int NOT NULL,
  `id_computadora_Ensamblada` int NOT NULL,
  `precioVenta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalleVenta`),
  KEY `id_enta` (`id_enta`),
  KEY `id_computadora_Ensamblada` (`id_computadora_Ensamblada`),
  CONSTRAINT `detalle_Venta_ibfk_1` FOREIGN KEY (`id_enta`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE,
  CONSTRAINT `detalle_Venta_ibfk_2` FOREIGN KEY (`id_computadora_Ensamblada`) REFERENCES `computadora_Ensamblada` (`id_computadora_Ensamblada`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_Venta`
--

LOCK TABLES `detalle_Venta` WRITE;
/*!40000 ALTER TABLE `detalle_Venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_Venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion` (
  `id_devolucion` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `fechaDevolucion` date NOT NULL,
  `montoReembolsado` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_devolucion`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modeloComputadora`
--

DROP TABLE IF EXISTS `modeloComputadora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modeloComputadora` (
  `id_computadora` int NOT NULL AUTO_INCREMENT,
  `nombre_computadora` varchar(100) NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_computadora`),
  UNIQUE KEY `nombre_computadora` (`nombre_computadora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modeloComputadora`
--

LOCK TABLES `modeloComputadora` WRITE;
/*!40000 ALTER TABLE `modeloComputadora` DISABLE KEYS */;
/*!40000 ALTER TABLE `modeloComputadora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piezas`
--

DROP TABLE IF EXISTS `piezas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `piezas` (
  `id_pieza` int NOT NULL AUTO_INCREMENT,
  `nombre_pieza` varchar(250) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `cantidadDisponible` int NOT NULL,
  PRIMARY KEY (`id_pieza`),
  CONSTRAINT `piezas_chk_1` CHECK ((`CantidadDisponible` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piezas`
--

LOCK TABLES `piezas` WRITE;
/*!40000 ALTER TABLE `piezas` DISABLE KEYS */;
/*!40000 ALTER TABLE `piezas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `rol` enum('Ensamblador','Vendedor','Administrador') NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_cliente` int NOT NULL,
  `fechaVenta` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-12 21:27:07
CREATE DATABASE  IF NOT EXISTS `proyecto1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto1`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: proyecto1
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.22.04.1

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
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `NIT` varchar(20) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NIT` (`NIT`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'Andy Fuentes','988333859','San Marcos, San Marcos'),(8,'Gonzalo Ramos','584445168','San Marcos, San Pedro SacatepÃ©quez');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Computadora`
--

DROP TABLE IF EXISTS `Computadora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Computadora` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Computadora`
--

LOCK TABLES `Computadora` WRITE;
/*!40000 ALTER TABLE `Computadora` DISABLE KEYS */;
INSERT INTO `Computadora` VALUES (1,'Gamer Pro',10500.00),(3,'Oficina Plus',6000.00);
/*!40000 ALTER TABLE `Computadora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Computadora_Ensamblada`
--

DROP TABLE IF EXISTS `Computadora_Ensamblada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Computadora_Ensamblada` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Computadora` int NOT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  `FechaEnsamblaje` date NOT NULL,
  `CostoTotal` decimal(10,2) NOT NULL,
  `Estado` enum('Ensamblada','En Venta','Vendida') NOT NULL DEFAULT 'Ensamblada',
  PRIMARY KEY (`ID`),
  KEY `ID_Computadora` (`ID_Computadora`),
  KEY `NombreUsuario` (`NombreUsuario`),
  CONSTRAINT `Computadora_Ensamblada_ibfk_1` FOREIGN KEY (`ID_Computadora`) REFERENCES `Computadora` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Computadora_Ensamblada_ibfk_2` FOREIGN KEY (`NombreUsuario`) REFERENCES `Usuario` (`NombreUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Computadora_Ensamblada`
--

LOCK TABLES `Computadora_Ensamblada` WRITE;
/*!40000 ALTER TABLE `Computadora_Ensamblada` DISABLE KEYS */;
INSERT INTO `Computadora_Ensamblada` VALUES (1,1,'abc','2025-02-21',10000.00,'Vendida'),(2,3,'abc','2025-03-10',10000.00,'En Venta'),(3,3,'abc','2025-03-19',6000.00,'Vendida');
/*!40000 ALTER TABLE `Computadora_Ensamblada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Detalle_Venta`
--

DROP TABLE IF EXISTS `Detalle_Venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Detalle_Venta` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Venta` int NOT NULL,
  `ID_ComputadoraEnsamblada` int NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Venta` (`ID_Venta`),
  KEY `ID_ComputadoraEnsamblada` (`ID_ComputadoraEnsamblada`),
  CONSTRAINT `Detalle_Venta_ibfk_1` FOREIGN KEY (`ID_Venta`) REFERENCES `Venta` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Detalle_Venta_ibfk_2` FOREIGN KEY (`ID_ComputadoraEnsamblada`) REFERENCES `Computadora_Ensamblada` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Detalle_Venta`
--

LOCK TABLES `Detalle_Venta` WRITE;
/*!40000 ALTER TABLE `Detalle_Venta` DISABLE KEYS */;
INSERT INTO `Detalle_Venta` VALUES (3,5,1,10000.00),(4,6,3,6000.00);
/*!40000 ALTER TABLE `Detalle_Venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Devolucion`
--

DROP TABLE IF EXISTS `Devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Devolucion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Venta` int NOT NULL,
  `FechaDevolucion` date NOT NULL,
  `MontoReembolsado` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Venta` (`ID_Venta`),
  CONSTRAINT `Devolucion_ibfk_1` FOREIGN KEY (`ID_Venta`) REFERENCES `Venta` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Devolucion`
--

LOCK TABLES `Devolucion` WRITE;
/*!40000 ALTER TABLE `Devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `Devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ensamble_Piezas`
--

DROP TABLE IF EXISTS `Ensamble_Piezas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ensamble_Piezas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Computadora` int NOT NULL,
  `ID_Pieza` int NOT NULL,
  `Cantidad` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Computadora` (`ID_Computadora`),
  KEY `ID_Pieza` (`ID_Pieza`),
  CONSTRAINT `Ensamble_Piezas_ibfk_1` FOREIGN KEY (`ID_Computadora`) REFERENCES `Computadora` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Ensamble_Piezas_ibfk_2` FOREIGN KEY (`ID_Pieza`) REFERENCES `Pieza` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Ensamble_Piezas_chk_1` CHECK ((`Cantidad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ensamble_Piezas`
--

LOCK TABLES `Ensamble_Piezas` WRITE;
/*!40000 ALTER TABLE `Ensamble_Piezas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ensamble_Piezas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pieza`
--

DROP TABLE IF EXISTS `Pieza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pieza` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Costo` decimal(10,2) NOT NULL,
  `CantidadDisponible` int NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Pieza_chk_1` CHECK ((`CantidadDisponible` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pieza`
--

LOCK TABLES `Pieza` WRITE;
/*!40000 ALTER TABLE `Pieza` DISABLE KEYS */;
INSERT INTO `Pieza` VALUES (1,'AMD Ryzen 5',1800.00,3),(2,'Intel i7',2500.00,7),(3,'SSD de 512GB',600.00,10),(4,'RTX 3060',4500.00,5),(5,'memoria RAM modulo A',200.00,15),(6,'memoria RAM modulo B',220.00,8),(7,'Ryzen 5 4600G',3265.00,7);
/*!40000 ALTER TABLE `Pieza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `NombreUsuario` varchar(50) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `ID_Rol` int NOT NULL,
  PRIMARY KEY (`NombreUsuario`),
  UNIQUE KEY `NombreUsuario` (`NombreUsuario`),
  KEY `ID_Rol` (`ID_Rol`),
  CONSTRAINT `Usuario_ibfk_2` FOREIGN KEY (`ID_Rol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES ('abc','abc',1),('abcd','abcd',1),('abcde','asd',1),('Andy','asdf',1),('Andy2','asd',1),('Andy3','AAAa',2),('dao','dao',1),('ensa','asd',1),('uno','uno',2),('usaurio2','usus',2),('user','user',2),('User123','123',1),('usuario2','usuario',2),('usuarioArchivo','ArchivoBNC',3),('UsuarioDesdeWeb','web',2);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Venta`
--

DROP TABLE IF EXISTS `Venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Venta` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NombreUsuario` varchar(50) NOT NULL,
  `ID_Cliente` int NOT NULL,
  `FechaVenta` date NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `NombreUsuario` (`NombreUsuario`),
  KEY `ID_Cliente` (`ID_Cliente`),
  CONSTRAINT `Venta_ibfk_1` FOREIGN KEY (`NombreUsuario`) REFERENCES `Usuario` (`NombreUsuario`) ON DELETE CASCADE,
  CONSTRAINT `Venta_ibfk_2` FOREIGN KEY (`ID_Cliente`) REFERENCES `Cliente` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venta`
--

LOCK TABLES `Venta` WRITE;
/*!40000 ALTER TABLE `Venta` DISABLE KEYS */;
INSERT INTO `Venta` VALUES (5,'user',8,'2025-03-12',10000.00),(6,'user',1,'2025-03-12',6000.00);
/*!40000 ALTER TABLE `Venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'ENCARGADO DE ENSAMBLAJE','Usuario con acceso a los modelos de computadoras, ensamblaje de piezas'),(2,'ENCARGADO DE VENTA','ususario con acceso a ventas, facturas y devoluciones'),(3,'ADMINISTRADO','Usuario con acceso a todos los roles');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-12 21:27:07
