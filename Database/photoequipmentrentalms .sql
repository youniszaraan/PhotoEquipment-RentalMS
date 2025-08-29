-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 28, 2025 at 01:44 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `photoequipmentrentalms`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  `Description` text,
  PRIMARY KEY (`CategoryID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  `Address` text,
  `CustomerType` enum('Online','WalkIn') DEFAULT 'WalkIn',
  PRIMARY KEY (`CustomerID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
CREATE TABLE IF NOT EXISTS `delivery` (
  `DeliveryID` int NOT NULL AUTO_INCREMENT,
  `RentalID` int NOT NULL,
  `EmployeeID` int NOT NULL,
  `DeliveryDate` date NOT NULL,
  `Status` enum('Pending','In Transit','Delivered') DEFAULT 'Pending',
  PRIMARY KEY (`DeliveryID`),
  KEY `RentalID` (`RentalID`),
  KEY `EmployeeID` (`EmployeeID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `HireDate` date NOT NULL,
  `Position` varchar(50) NOT NULL,
  `Role` enum('Admin','Staff','Delivery') DEFAULT 'Staff',
  PRIMARY KEY (`EmployeeID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `FullName`, `Phone`, `Email`, `HireDate`, `Position`, `Role`) VALUES
(1, 'younis Azzi Zaraan', '781999268', 'younesazzi308@gmail.com', '2025-08-27', 'The leader', 'Admin'),
(2, 'Ali Taha', '774042257', 'lyabw6278@gmail.com', '2025-08-27', 'manager', 'Admin'),
(3, 'Mohammed Ahmed Al-Hufashi', '775707007', 'mohamedalhofashe@gmail.com', '2025-08-28', 'manager', 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
CREATE TABLE IF NOT EXISTS `equipment` (
  `EquipmentID` int NOT NULL AUTO_INCREMENT,
  `CategoryID` int NOT NULL,
  `EquipmentName` varchar(100) NOT NULL,
  `Description` text,
  `Quantity` int NOT NULL DEFAULT '1',
  `DailyRate` decimal(10,2) NOT NULL,
  `Status` enum('Available','Rented','Maintenance') DEFAULT 'Available',
  PRIMARY KEY (`EquipmentID`),
  KEY `CategoryID` (`CategoryID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guarantees`
--

DROP TABLE IF EXISTS `guarantees`;
CREATE TABLE IF NOT EXISTS `guarantees` (
  `GuaranteeID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `GuaranteeType` enum('ID Card','Passport','Deposit','Other') NOT NULL,
  `GuaranteeDetails` text,
  `DateProvided` date NOT NULL,
  PRIMARY KEY (`GuaranteeID`),
  KEY `CustomerID` (`CustomerID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE IF NOT EXISTS `maintenance` (
  `MaintenanceID` int NOT NULL AUTO_INCREMENT,
  `EquipmentID` int NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date DEFAULT NULL,
  `Cost` decimal(10,2) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`MaintenanceID`),
  KEY `EquipmentID` (`EquipmentID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `NotificationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `RentalID` int NOT NULL,
  `Message` text NOT NULL,
  `Type` enum('NewOrder','Delivery','Payment','General') DEFAULT 'NewOrder',
  `IsRead` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NotificationID`),
  KEY `UserID` (`UserID`),
  KEY `RentalID` (`RentalID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `RentalID` int NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `PaymentDate` date NOT NULL,
  `Method` enum('Cash','Card','Online') NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `RentalID` (`RentalID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `photographers`
--

DROP TABLE IF EXISTS `photographers`;
CREATE TABLE IF NOT EXISTS `photographers` (
  `PhotographerID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `DailyRate` decimal(10,2) NOT NULL,
  PRIMARY KEY (`PhotographerID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rentaldetails`
--

DROP TABLE IF EXISTS `rentaldetails`;
CREATE TABLE IF NOT EXISTS `rentaldetails` (
  `RentalDetailID` int NOT NULL AUTO_INCREMENT,
  `RentalID` int NOT NULL,
  `EquipmentID` int NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  `DailyRate` decimal(10,2) NOT NULL,
  `SubTotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`RentalDetailID`),
  KEY `RentalID` (`RentalID`),
  KEY `EquipmentID` (`EquipmentID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
CREATE TABLE IF NOT EXISTS `rentals` (
  `RentalID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `PhotographerID` int DEFAULT NULL,
  `GuaranteeID` int NOT NULL,
  `RentalDate` date NOT NULL,
  `ReturnDate` date NOT NULL,
  `TotalAmount` decimal(10,2) DEFAULT '0.00',
  `Status` enum('Pending','Approved','Delivered','Returned','Cancelled') DEFAULT 'Pending',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RentalID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `PhotographerID` (`PhotographerID`),
  KEY `GuaranteeID` (`GuaranteeID`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int NOT NULL,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `EmployeeID` (`EmployeeID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `EmployeeID`, `Username`, `PasswordHash`, `CreatedAt`) VALUES
(1, 1, 'younis', '12345', '2025-08-27 16:02:45'),
(2, 2, 'Ali', '333', '2025-08-27 21:02:01'),
(3, 3, 'Mohammed', '4444', '2025-08-27 21:03:41');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
