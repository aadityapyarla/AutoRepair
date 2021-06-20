-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema autorepair
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema autorepair
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `autorepair` DEFAULT CHARACTER SET utf8 ;
USE `autorepair` ;

-- -----------------------------------------------------
-- Table `autorepair`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autorepair`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `zip_code` CHAR(6) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autorepair`.`repair_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autorepair`.`repair_orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `service_advisor` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_repair_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_repair_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `autorepair`.`customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autorepair`.`service_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autorepair`.`service_type` (
  `service_code` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `book_rate` DECIMAL(7,2) NOT NULL,
  `book_hour` TINYINT NOT NULL,
  PRIMARY KEY (`service_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autorepair`.`order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autorepair`.`order_line` (
  `order_id` INT NOT NULL,
  `service_code` TINYINT NOT NULL,
  `mechanic_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_id`, `service_code`),
  INDEX `fk_order_line_repair_orders1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_line_service_type1_idx` (`service_code` ASC) VISIBLE,
  CONSTRAINT `fk_order_line_repair_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `autorepair`.`repair_orders` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_line_service_type1`
    FOREIGN KEY (`service_code`)
    REFERENCES `autorepair`.`service_type` (`service_code`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
