-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`Suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Suppliers` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Suppliers` (
  `Suppliers_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Street_Address` VARCHAR(45) NULL,
  `Street_Number_Address` VARCHAR(5) NULL,
  `Floor_Number_Address` VARCHAR(3) NULL,
  `Door_Number_Address` VARCHAR(5) NULL,
  `City_Address` VARCHAR(15) NULL,
  `Postal_Code_Address` VARCHAR(8) NULL,
  `Country_Address` VARCHAR(20) NULL,
  `Phone` VARCHAR(12) NULL,
  `Fax` VARCHAR(12) NULL,
  `NIF` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Suppliers_id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Brand` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Brand` (
  `Brand_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Suppliers_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Brand_id`),
  INDEX `fk_Brand_Suppliers1_idx` (`Suppliers_id` ASC) VISIBLE,
  CONSTRAINT `fk_Brand_Suppliers1`
    FOREIGN KEY (`Suppliers_id`)
    REFERENCES `Optica`.`Suppliers` (`Suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Glasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Glasses` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Glasses` (
  `Glasses_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Graduation_Left` DECIMAL(5,2) NOT NULL,
  `Graduation_Right` DECIMAL(5,2) NOT NULL,
  `Frame` VARCHAR(1) NOT NULL COMMENT 'F for ‘Flotante’\nP for ‘Pasta’\nM for ‘Metálica’',
  `Frame_Color` VARCHAR(10) NOT NULL,
  `Left_Glass_Color` VARCHAR(20) NOT NULL COMMENT 'Left/ Right',
  `Right_Glass_Color` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(6,2) NULL,
  `Brand_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Glasses_id`),
  INDEX `fk_Glasses_Brand1_idx` (`Brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_Glasses_Brand1`
    FOREIGN KEY (`Brand_id`)
    REFERENCES `Optica`.`Brand` (`Brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Clients` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Clients` (
  `Clients_id` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(13) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Date_of_Registry` DATETIME NULL,
  `Referral_Client_id` INT UNSIGNED NULL,
  PRIMARY KEY (`Clients_id`),
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `fk_Clients_Clients1_idx` (`Referral_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Clients1`
    FOREIGN KEY (`Referral_Client_id`)
    REFERENCES `Optica`.`Clients` (`Clients_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Employees` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Employees` (
  `Employees_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employees_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Sales` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Sales` (
  `Sales_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `Clients_id` INT UNSIGNED NOT NULL,
  `Employees_id` INT UNSIGNED NOT NULL,
  `Glasses_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Sales_id`),
  INDEX `fk_Sales_Employees1_idx` (`Employees_id` ASC) VISIBLE,
  INDEX `fk_Sales_Glasses1_idx` (`Glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_Sales_Employees1`
    FOREIGN KEY (`Employees_id`)
    REFERENCES `Optica`.`Employees` (`Employees_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sales_Glasses1`
    FOREIGN KEY (`Glasses_id`)
    REFERENCES `Optica`.`Glasses` (`Glasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
