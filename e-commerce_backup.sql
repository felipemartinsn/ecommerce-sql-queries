-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

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
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `idClient` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(10) DEFAULT NULL,
  `Minit` char(3) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `CPF` char(11) NOT NULL,
  `adress` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE KEY `unique_cpf_client` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Ana','M','Silva','12345678901','Rua A, 123'),(2,'Bruno','L','Souza','23456789012','Rua B, 456'),(3,'Carlos','F','Olive','34567890123','Rua C, 789');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `idOrders` int NOT NULL AUTO_INCREMENT,
  `idOrdersClient` int DEFAULT NULL,
  `orderStatus` enum('Cancelado','Confirmado','Em processamento') NOT NULL,
  `ordersDescription` varchar(255) DEFAULT NULL,
  `sendValue` float DEFAULT '0',
  `paymentCash` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idOrders`),
  KEY `fk_orders_client` (`idOrdersClient`),
  CONSTRAINT `fk_orders_client` FOREIGN KEY (`idOrdersClient`) REFERENCES `client` (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'Confirmado','Compra de um celular',10,0),(2,2,'Em processamento','Compra de uma camiseta',5,1),(3,3,'Cancelado','Compra de uma boneca',0,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `idProduct` int NOT NULL AUTO_INCREMENT,
  `Pname` varchar(10) NOT NULL,
  `classification_kids` tinyint(1) DEFAULT '0',
  `category` enum('Eletronico','Vestimenta','Brinquedo','Alimento') NOT NULL,
  `avaliacao` float DEFAULT '0',
  `size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idProduct`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Celular',0,'Eletronico',4.5,'Médio'),(2,'Camiseta',0,'Vestimenta',4.8,'G'),(3,'Boneca',1,'Brinquedo',4.9,'Pequeno'),(4,'Chocolate',1,'Alimento',4.7,'Pequeno');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productOrder`
--

DROP TABLE IF EXISTS `productOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productOrder` (
  `idPOproduct` int NOT NULL,
  `idPOoRder` int NOT NULL,
  `poQuantity` int DEFAULT '1',
  `poStatus` enum('Disponivel','Sem estoque') DEFAULT 'Disponivel',
  PRIMARY KEY (`idPOproduct`,`idPOoRder`),
  KEY `fk_productorder_product` (`idPOoRder`),
  CONSTRAINT `fk_productorder_product` FOREIGN KEY (`idPOoRder`) REFERENCES `orders` (`idOrders`),
  CONSTRAINT `fk_productorder_seller` FOREIGN KEY (`idPOproduct`) REFERENCES `product` (`idProduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productOrder`
--

LOCK TABLES `productOrder` WRITE;
/*!40000 ALTER TABLE `productOrder` DISABLE KEYS */;
/*!40000 ALTER TABLE `productOrder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productSeller`
--

DROP TABLE IF EXISTS `productSeller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productSeller` (
  `idPseller` int NOT NULL,
  `idPproduct` int NOT NULL,
  `prodQuantity` int DEFAULT '1',
  PRIMARY KEY (`idPseller`,`idPproduct`),
  KEY `fk_product_product` (`idPproduct`),
  CONSTRAINT `fk_product_product` FOREIGN KEY (`idPproduct`) REFERENCES `product` (`idProduct`),
  CONSTRAINT `fk_product_seller` FOREIGN KEY (`idPseller`) REFERENCES `seller` (`idSeller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productSeller`
--

LOCK TABLES `productSeller` WRITE;
/*!40000 ALTER TABLE `productSeller` DISABLE KEYS */;
/*!40000 ALTER TABLE `productSeller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productStorage`
--

DROP TABLE IF EXISTS `productStorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productStorage` (
  `idProdStorage` int NOT NULL AUTO_INCREMENT,
  `storageLocation` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`idProdStorage`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productStorage`
--

LOCK TABLES `productStorage` WRITE;
/*!40000 ALTER TABLE `productStorage` DISABLE KEYS */;
INSERT INTO `productStorage` VALUES (1,'Depósito A',100),(2,'Depósito B',200),(3,'Depósito C',150);
/*!40000 ALTER TABLE `productStorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productSupplier`
--

DROP TABLE IF EXISTS `productSupplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productSupplier` (
  `idPsSupplier` int NOT NULL,
  `idPsProduct` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`idPsSupplier`,`idPsProduct`),
  KEY `fk_product_supplier_product` (`idPsProduct`),
  CONSTRAINT `fk_product_supplier_product` FOREIGN KEY (`idPsProduct`) REFERENCES `product` (`idProduct`),
  CONSTRAINT `fk_product_supplier_supplier` FOREIGN KEY (`idPsSupplier`) REFERENCES `supplier` (`idSupplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productSupplier`
--

LOCK TABLES `productSupplier` WRITE;
/*!40000 ALTER TABLE `productSupplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `productSupplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `idSeller` int NOT NULL AUTO_INCREMENT,
  `SocialName` varchar(255) NOT NULL,
  `AbstName` varchar(255) DEFAULT NULL,
  `CNPJ` char(15) DEFAULT NULL,
  `CPF` char(9) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact` char(11) NOT NULL,
  PRIMARY KEY (`idSeller`),
  UNIQUE KEY `unique_cnpj_seller` (`CNPJ`),
  UNIQUE KEY `unique_cpf_seller` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'Vendedor A','Vda','12345678000101','987654321','Loja A','11987654321'),(2,'Vendedor B','Vdb','23456789000112','987654322','Loja B','11912345678');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storageLocation`
--

DROP TABLE IF EXISTS `storageLocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storageLocation` (
  `idLproduct` int NOT NULL,
  `idLstorage` int NOT NULL,
  `location` varchar(200) NOT NULL,
  PRIMARY KEY (`idLproduct`,`idLstorage`),
  KEY `fk_productstorage_product` (`idLstorage`),
  CONSTRAINT `fk_productstorage_product` FOREIGN KEY (`idLstorage`) REFERENCES `productStorage` (`idProdStorage`),
  CONSTRAINT `fk_productstorage_seller` FOREIGN KEY (`idLproduct`) REFERENCES `product` (`idProduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storageLocation`
--

LOCK TABLES `storageLocation` WRITE;
/*!40000 ALTER TABLE `storageLocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `storageLocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `idSupplier` int NOT NULL AUTO_INCREMENT,
  `SocialName` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `contact` char(11) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE KEY `unique_supplier` (`CNPJ`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Fornecedor A','12345678000101','11987654321'),(2,'Fornecedor B','23456789000112','11912345678');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-01 14:45:39
