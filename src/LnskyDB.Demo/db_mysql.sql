/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80018
Source Host           : localhost:3306
Source Database       : LnskyNS_Test

Target Server Type    : MYSQL
Target Server Version : 80018
File Encoding         : 65001

Date: 2019-12-06 14:21:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for Data_Shop
-- ----------------------------
DROP TABLE IF EXISTS `Data_Shop`;
CREATE TABLE `Data_Shop` (
  `SysNo` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ShopCode` varchar(50) DEFAULT NULL,
  `ShopName` varchar(50) DEFAULT NULL,
  `ShopType` int(11) DEFAULT NULL,
  `IsDelete` bit(1) DEFAULT NULL,
  PRIMARY KEY (`SysNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='店铺';

-- ----------------------------
-- Table structure for Purify_ProductSaleByDayNS
-- ----------------------------
DROP TABLE IF EXISTS `Purify_ProductSaleByDayNS`;
CREATE TABLE `Purify_ProductSaleByDayNS` (
  `SysNo` int(50) NOT NULL AUTO_INCREMENT,
  `DataSource` varchar(100) DEFAULT NULL,
  `OutProductID` varchar(100) DEFAULT NULL,
  `BrandID` int(50) DEFAULT NULL,
  `CategoryID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ProductID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ProductName` varchar(100) DEFAULT NULL,
  `ShopID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `StatisticalDate` date NOT NULL,
  `Sales` double NOT NULL DEFAULT '0',
  `NumberOfSales` int(11) NOT NULL DEFAULT '0',
  `AveragePrice` double NOT NULL DEFAULT '0',
  `OrderQuantity` int(11) NOT NULL DEFAULT '0',
  `CreateDate` timestamp NULL DEFAULT NULL,
  `CreateUserID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `UpdateDate` timestamp NULL DEFAULT NULL,
  `UpdateUserID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ImportGroupId` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `IsExclude` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`SysNo`)
) ENGINE=InnoDB AUTO_INCREMENT=28009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
