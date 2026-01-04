-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer_Details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer_Details` (
  `Guest_ID` INT NOT NULL,
  `Guest_Address` VARCHAR(45) NULL,
  `GuestFullName` VARCHAR(45) NULL,
  `Guest_Contact` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Guest_ID`),
  UNIQUE INDEX `Guest_ID_UNIQUE` (`Guest_ID` ASC) VISIBLE,
  UNIQUE INDEX `Guest_Contact_UNIQUE` (`Guest_Contact` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `Booking_ID` INT NOT NULL AUTO_INCREMENT,
  `BookingTime` DATETIME NULL,
  `Guest_ID` INT NULL,
  `TableNo` INT NULL,
  PRIMARY KEY (`Booking_ID`),
  UNIQUE INDEX `Booking_ID_UNIQUE` (`Booking_ID` ASC) VISIBLE,
  INDEX `Guest_ID_idx` (`Guest_ID` ASC) VISIBLE,
  CONSTRAINT `Guest_ID`
    FOREIGN KEY (`Guest_ID`)
    REFERENCES `mydb`.`Customer_Details` (`Guest_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Menu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `MenuID` INT NOT NULL,
  `Cuisine` VARCHAR(45) NULL,
  `Starters` VARCHAR(45) NULL,
  `Courses` VARCHAR(45) NULL,
  `Drinks` VARCHAR(45) NULL,
  `Desserts` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff_Information`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Staff_Information` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Staff_Information` (
  `Staff_ID` INT NOT NULL,
  `Staff_FirstName` DATETIME NULL,
  `Staff_LastName` VARCHAR(45) NULL,
  PRIMARY KEY (`Staff_ID`),
  UNIQUE INDEX `Staff_ID_UNIQUE` (`Staff_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Orders` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `Order_ID` INT NOT NULL,
  `Order_Date` DATETIME NULL,
  `Quantity` INT NULL,
  `TotalCost` DECIMAL(4,2) NULL,
  `MenuID` INT NULL,
  `Guest_ID` INT NULL,
  `Staff_ID` INT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `GuestID_idx` (`Guest_ID` ASC) VISIBLE,
  INDEX `Staff_ID_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `mydb`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `GuestID`
    FOREIGN KEY (`Guest_ID`)
    REFERENCES `mydb`.`Customer_Details` (`Guest_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Staff_ID`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `mydb`.`Staff_Information` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_Delivery_Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Order_Delivery_Status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Order_Delivery_Status` (
  `Order_ID` INT NOT NULL,
  `Delivery_Date` DATETIME NULL,
  `Status` VARCHAR(45) NULL,
  CONSTRAINT `Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `mydb`.`Orders` (`Order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
