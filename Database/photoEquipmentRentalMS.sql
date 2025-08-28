
-- =====================================
-- إنشاء قاعدة البيانات
-- =====================================
CREATE DATABASE IF NOT EXISTS photoEquipmentRentalMS;
USE photoEquipmentRentalMS;

-- =====================================
-- 1. Employees
-- =====================================
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    HireDate DATE NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Role ENUM('Admin','Staff','Delivery') DEFAULT 'Staff'
);

-- =====================================
-- 2. Users
-- =====================================
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- =====================================
-- 3. Customers
-- =====================================
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    PasswordHash VARCHAR(255),
    Address TEXT,
    CustomerType ENUM('Online','WalkIn') DEFAULT 'WalkIn'
);

-- =====================================
-- 4. Categories
-- =====================================
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- =====================================
-- 5. Equipment
-- =====================================
CREATE TABLE Equipment (
    EquipmentID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID INT NOT NULL,
    EquipmentName VARCHAR(100) NOT NULL,
    Description TEXT,
    Quantity INT NOT NULL DEFAULT 1,
    DailyRate DECIMAL(10,2) NOT NULL,
    Status ENUM('Available','Rented','Maintenance') DEFAULT 'Available',
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- =====================================
-- 6. Photographers
-- =====================================
CREATE TABLE Photographers (
    PhotographerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female') NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    DailyRate DECIMAL(10,2) NOT NULL
);

-- =====================================
-- 7. Guarantees
-- =====================================
CREATE TABLE Guarantees (
    GuaranteeID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    GuaranteeType ENUM('ID Card','Passport','Deposit','Other') NOT NULL,
    GuaranteeDetails TEXT,
    DateProvided DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- =====================================
-- 8. Rentals
-- =====================================
CREATE TABLE Rentals (
    RentalID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PhotographerID INT NULL,
    GuaranteeID INT NOT NULL,
    RentalDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) DEFAULT 0,
    Status ENUM('Pending','Approved','Delivered','Returned','Cancelled') DEFAULT 'Pending',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PhotographerID) REFERENCES Photographers(PhotographerID),
    FOREIGN KEY (GuaranteeID) REFERENCES Guarantees(GuaranteeID),
    CHECK (ReturnDate >= RentalDate)
);

-- =====================================
-- 9. RentalDetails
-- =====================================
CREATE TABLE RentalDetails (
    RentalDetailID INT AUTO_INCREMENT PRIMARY KEY,
    RentalID INT NOT NULL,
    EquipmentID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    DailyRate DECIMAL(10,2) NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID) ON DELETE CASCADE,
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

-- =====================================
-- 10. Delivery
-- =====================================
CREATE TABLE Delivery (
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    RentalID INT NOT NULL,
    EmployeeID INT NOT NULL,
    DeliveryDate DATE NOT NULL,
    Status ENUM('Pending','In Transit','Delivered') DEFAULT 'Pending',
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- =====================================
-- 11. Maintenance
-- =====================================
CREATE TABLE Maintenance (
    MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,
    EquipmentID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Cost DECIMAL(10,2),
    Description TEXT,
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

-- =====================================
-- 12. Payments
-- =====================================
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    RentalID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    Method ENUM('Cash','Card','Online') NOT NULL,
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);

-- =====================================
-- 13. Notifications (Modified with RentalID FK)
-- =====================================
CREATE TABLE Notifications (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    RentalID INT NOT NULL,
    Message TEXT NOT NULL,
    Type ENUM('NewOrder','Delivery','Payment','General') DEFAULT 'NewOrder',
    IsRead TINYINT(1) DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);
