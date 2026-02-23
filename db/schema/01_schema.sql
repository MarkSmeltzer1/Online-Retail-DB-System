-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema `online_retail`
-- -----------------------------------------------------

-- ----------------------------------------------------- 
-- Schema `online_retail`
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `online_retail` DEFAULT CHARACTER SET utf8 ;
USE `online_retail` ;

-- -----------------------------------------------------
-- Table `online_retail`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `CustomerEmail` VARCHAR(100) NOT NULL,
  `CustomerPhoneNumber` VARCHAR(20) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `AccountCreationDate` DATETIME NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerEmail_UNIQUE` (`CustomerEmail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Cart` (
  `CartID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `CartCreationDate` DATETIME NOT NULL,
  PRIMARY KEY (`CartID`),
  INDEX `fk_cart_customer_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_cart_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`PaymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`PaymentMethod` (
  `PaymentMethodID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `MethodType` VARCHAR(50) NOT NULL,
  `Brand` VARCHAR(50) NOT NULL,
  `Last4` CHAR(4) NOT NULL,
  `ExpMonth` TINYINT NOT NULL,
  `ExpYear` SMALLINT NOT NULL,
  `CVV` CHAR(3) NOT NULL,
  `IsDefault` TINYINT NOT NULL,
  `CreatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`PaymentMethodID`),
  INDEX `fk_paymentmethod_customer_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_paymentmethod_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `PaymentMethodID` INT NOT NULL,
  `PaymentDate` DATETIME NOT NULL,
  `AmountPaid` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `fk_payment_customer_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_payment_paymentmethod_idx` (`PaymentMethodID` ASC) VISIBLE,
  CONSTRAINT `fk_payment_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_paymentmethod`
    FOREIGN KEY (`PaymentMethodID`)
    REFERENCES `online_retail`.`PaymentMethod` (`PaymentMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Order` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `SubTotal` DECIMAL(10,2) NOT NULL,
  `TaxAmount` DECIMAL(10,2) NOT NULL,
  `ShippingCost` DECIMAL(10,2) NOT NULL,
  `OrderStatus` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_order_customer_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`OrderItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`OrderItem` (
  `OrderItemID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `ProductPrice` DECIMAL(10,2) NOT NULL,
  `Discount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`OrderItemID`),
  INDEX `fk_orderitem_order_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_orderitem_order`
    FOREIGN KEY (`OrderID`)
    REFERENCES `online_retail`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`ProductCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`ProductCategory` (
  `CategoryID` INT NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(100) NOT NULL,
  `CategoryDescription` TEXT NULL,
  PRIMARY KEY (`CategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Product` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `CategoryID` INT NOT NULL,
  `ProductName` VARCHAR(150) NOT NULL,
  `ProductDescription` TEXT NOT NULL,
  `SKU` VARCHAR(50) NOT NULL,
  `ProductPrice` DECIMAL(10,2) NOT NULL,
  `StockQuantity` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE INDEX `SKU_UNIQUE` (`SKU` ASC) VISIBLE,
  INDEX `fk_product_productcategory_idx` (`CategoryID` ASC) VISIBLE,
  CONSTRAINT `fk_product_productcategory`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `online_retail`.`ProductCategory` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`WatchList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`WatchList` (
  `WatchListID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `DateAdded` DATETIME NOT NULL,
  PRIMARY KEY (`WatchListID`),
  INDEX `fk_watchlist_customer_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_watchlist_product_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_watchlist_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_watchlist_product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `online_retail`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `Line1` VARCHAR(255) NOT NULL,
  `Line2` VARCHAR(255) NULL,
  `City` VARCHAR(100) NOT NULL,
  `State` VARCHAR(100) NOT NULL,
  `Zip` VARCHAR(20) NOT NULL,
  `Country` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Shipment` (
  `ShipmentID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  `ShipmentType` VARCHAR(50) NOT NULL,
  `ShipmentDate` DATETIME NOT NULL,
  `EstimatedDelivery` DATETIME NOT NULL,
  PRIMARY KEY (`ShipmentID`),
  INDEX `fk_shipment_order_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_shipment_address_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `fk_shipment_order`
    FOREIGN KEY (`OrderID`)
    REFERENCES `online_retail`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_address`
    FOREIGN KEY (`AddressID`)
    REFERENCES `online_retail`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Review` (
  `ReviewID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `Rating` TINYINT NOT NULL,
  `Comment` TEXT NULL,
  `ReviewDate` DATETIME NOT NULL,
  PRIMARY KEY (`ReviewID`),
  INDEX `fk_review_customer_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_review_product_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_review_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `online_retail`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Promotion` (
  `PromotionID` INT NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(50) NOT NULL,
  `PromotionDiscription` TEXT NULL,
  `DiscountAmount` DECIMAL(10,2) NOT NULL,
  `StartDate` DATETIME NOT NULL,
  `EndDate` DATETIME NOT NULL,
  PRIMARY KEY (`PromotionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`PromotionProduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`PromotionProduct` (
  `PromotionID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  PRIMARY KEY (`PromotionID`, `ProductID`),
  INDEX `fk_promotionproduct_product_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_promotionproduct_promotion`
    FOREIGN KEY (`PromotionID`)
    REFERENCES `online_retail`.`Promotion` (`PromotionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_promotionproduct_product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `online_retail`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`Notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`Notification` (
  `NotificationID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `Message` TEXT NOT NULL,
  `SentDate` DATETIME NOT NULL,
  `ReadStatus` TINYINT NOT NULL,
  PRIMARY KEY (`NotificationID`),
  INDEX `fk_notification_customer_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_notification_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail`.`ReturnRefund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail`.`ReturnRefund` (
  `ReturnID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  `ReturnDate` DATETIME NOT NULL,
  `ReturnReason` TEXT NULL,
  `RefundAmount` DECIMAL(10,2) NOT NULL,
  `RefundStatus` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ReturnID`),
  INDEX `fk_returnrefund_customer_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_returnrefund_order_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_returnrefund_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `online_retail`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_returnrefund_order`
    FOREIGN KEY (`OrderID`)
    REFERENCES `online_retail`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
