-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Clients` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Clients` (
  `Clientes_id` INT NOT NULL,
  `Name` VARCHAR(20) NULL,
  `Surnames` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Post_Code` VARCHAR(10) NULL,
  `City` VARCHAR(15) NULL,
  `Province` VARCHAR(15) NULL,
  `Phone` VARCHAR(12) NULL,
  PRIMARY KEY (`Clientes_id`),
  UNIQUE INDEX `Clients_id_UNIQUE` (`Clientes_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Stores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Stores` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Stores` (
  `Stores_id` INT NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Post_Code` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `Province` VARCHAR(45) NULL,
  PRIMARY KEY (`Stores_id`),
  UNIQUE INDEX `Stores_col_UNIQUE` (`Address` ASC) VISIBLE,
  UNIQUE INDEX `Stores_id_UNIQUE` (`Stores_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Employees` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Employees` (
  `Employees_id` INT NOT NULL,
  `Name` VARCHAR(20) NULL,
  `Surnames` VARCHAR(45) NULL,
  `NIF` VARCHAR(9) NULL,
  `Phone` VARCHAR(12) NULL,
  `Roll` ENUM('cook', 'delivery') NULL,
  `Stores_id` INT NOT NULL,
  PRIMARY KEY (`Employees_id`),
  UNIQUE INDEX `Employees_id_UNIQUE` (`Employees_id` ASC) VISIBLE,
  INDEX `fk_Employees_Stores` (`Stores_id` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Stores1`
    FOREIGN KEY (`Stores_id`)
    REFERENCES `Pizzeria`.`Stores` (`Stores_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Orders` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Orders` (
  `Pedidos_id` INT NOT NULL,
  `Date_Time` DATETIME NOT NULL,
  `Delivery_Pickup` ENUM('reparto', 'recogida') NOT NULL,
  `Total_Price` DECIMAL(6,2) NULL,
  `Clients_id` INT NOT NULL,
  `Stores_id` INT NOT NULL,
  `Delivery_Employees_id` INT NULL,
  `Delivery_Finalized` DATETIME NULL,
  PRIMARY KEY (`Pedidos_id`),
  UNIQUE INDEX `Pedidos_id_UNIQUE` (`Pedidos_id` ASC) VISIBLE,
  INDEX `fk_Orders_Clients` (`Clients_id` ASC) VISIBLE,
  INDEX `fk_Orders_Stores` (`Stores_id` ASC) VISIBLE,
  INDEX `fk_Orders_Employees` (`Delivery_Employees_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Clients1`
    FOREIGN KEY (`Clients_id`)
    REFERENCES `Pizzeria`.`Clients` (`Clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_Stores1`
    FOREIGN KEY (`Stores_id`)
    REFERENCES `Pizzeria`.`Stores` (`Stores_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_Employees1`
    FOREIGN KEY (`Delivery_Employees_id`)
    REFERENCES `Pizzeria`.`Employees` (`Employees_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Categories_Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Categories_Pizza` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categories_Pizza` (
  `Categorías_Pizza_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Categorías_Pizza_id`),
  UNIQUE INDEX `Categorías_Pizza_id_UNIQUE` (`Categorías_Pizza_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Products` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Products` (
  `Productos_id` INT NOT NULL,
  `Type` ENUM('pizzas', 'hamburguesas', 'bebidas') NOT NULL,
  `Name` VARCHAR(20) NULL,
  `Description` VARCHAR(45) NULL,
  `Image` VARCHAR(45) NULL,
  `Price` DECIMAL(5,2) NULL,
  `Categories_Pizza_id` INT NOT NULL,
  PRIMARY KEY (`Productos_id`),
  UNIQUE INDEX `Products_id_UNIQUE` (`Productos_id` ASC) VISIBLE,
  INDEX `fk_Products_Categories_Pizza` (`Categories_Pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Categories_Pizza1`
    FOREIGN KEY (`Categories_Pizza_id`)
    REFERENCES `Pizzeria`.`Categories_Pizza` (`Categorías_Pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Products_has_Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`Products_has_Orders` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`Products_has_Orders` (
  `Products_id` INT NOT NULL,
  `Orders_id` INT NOT NULL,
  `Amount_Of_Each` INT NULL,
  PRIMARY KEY (`Products_id`, `Orders_id`),
  INDEX `fk_Products_has_Orders` (`Orders_id` ASC) VISIBLE,
  INDEX `fk_Products_has_Products` (`Products_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Orders_Products`
    FOREIGN KEY (`Products_id`)
    REFERENCES `Pizzeria`.`Products` (`Productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Products_has_Orders_Orders1`
    FOREIGN KEY (`Orders_id`)
    REFERENCES `Pizzeria`.`Orders` (`Pedidos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
