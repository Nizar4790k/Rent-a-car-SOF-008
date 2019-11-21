-- MySQL Script generated by MySQL Workbench
-- Thu 21 Nov 2019 09:03:18 AM -04
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Rent-a-car
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Rent-a-car
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Rent-a-car` DEFAULT CHARACTER SET utf8 ;
USE `Rent-a-car` ;

-- -----------------------------------------------------
-- Table `Rent-a-car`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Persona` (
  `noIdentificacion` CHAR(13) NOT NULL,
  `direccion` VARCHAR(100) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`noIdentificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Usuario` (
  `correoElectronico` VARCHAR(100) NOT NULL,
  `contrasena` VARCHAR(45) NULL,
  `noIdentificacionPersona` CHAR(13) NOT NULL,
  PRIMARY KEY (`correoElectronico`),
  INDEX `fk_Usuario_Persona1_idx` (`noIdentificacionPersona` ASC),
  CONSTRAINT `fk_Usuario_Persona1`
    FOREIGN KEY (`noIdentificacionPersona`)
    REFERENCES `Rent-a-car`.`Persona` (`noIdentificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`TelefonoPersona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`TelefonoPersona` (
  `numero` VARCHAR(15) NOT NULL,
  `noIDentificacionPersona` CHAR(13) NOT NULL,
  PRIMARY KEY (`numero`, `noIDentificacionPersona`),
  INDEX `fk_TelefonoPersona_Persona_idx` (`noIDentificacionPersona` ASC),
  CONSTRAINT `fk_TelefonoPersona_Persona`
    FOREIGN KEY (`noIDentificacionPersona`)
    REFERENCES `Rent-a-car`.`Persona` (`noIdentificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Cliente` (
  `licenciaDeConducir` INT NULL,
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `codigo_postal` VARCHAR(10) NULL,
  `Pais` VARCHAR(20) NULL,
  `noIdentificacionPersona` CHAR(13) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Persona1_idx` (`noIdentificacionPersona` ASC),
  CONSTRAINT `fk_Cliente_Persona1`
    FOREIGN KEY (`noIdentificacionPersona`)
    REFERENCES `Rent-a-car`.`Persona` (`noIdentificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`TipoVehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`TipoVehiculo` (
  `idTipoVehiculo` INT NOT NULL AUTO_INCREMENT,
  `foto` VARCHAR(100) NULL,
  `descripcion` VARCHAR(100) NULL,
  `precioActual` DECIMAL(10,4) NULL,
  `tipoTransmision` VARCHAR(10) NULL,
  `tipoCombustible` VARCHAR(10) NULL,
  `noPuertas` CHAR(1) NULL,
  PRIMARY KEY (`idTipoVehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `sueldo` DECIMAL(10,4) NULL,
  `posicion` VARCHAR(45) NULL,
  `noIdentificacionPersona` CHAR(13) NOT NULL,
  `idSucursal` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_Empleado_Persona1_idx` (`noIdentificacionPersona` ASC),
  INDEX `fk_Empleado_Sucursal1_idx` (`idSucursal` ASC),
  CONSTRAINT `fk_Empleado_Persona1`
    FOREIGN KEY (`noIdentificacionPersona`)
    REFERENCES `Rent-a-car`.`Persona` (`noIdentificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `Rent-a-car`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(100) NULL,
  `idEmpleadoSupervisor` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_Sucursal_Empleado1_idx` (`idEmpleadoSupervisor` ASC),
  CONSTRAINT `fk_Sucursal_Empleado1`
    FOREIGN KEY (`idEmpleadoSupervisor`)
    REFERENCES `Rent-a-car`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Vehiculo` (
  `idVehiculo` INT NOT NULL AUTO_INCREMENT,
  `placa` CHAR(7) NOT NULL,
  `year` INT NULL,
  `color` VARCHAR(20) NULL,
  `modelo` VARCHAR(20) NULL,
  `marca` VARCHAR(20) NULL,
  `noChasis` CHAR(17) NOT NULL,
  `idTipoVehiculo` INT NOT NULL,
  `idSucursal` INT NOT NULL,
  PRIMARY KEY (`idVehiculo`),
  UNIQUE INDEX `no_chasis_UNIQUE` (`noChasis` ASC),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC),
  INDEX `fk_Vehiculo_TipoVehiculo1_idx` (`idTipoVehiculo` ASC),
  INDEX `fk_Vehiculo_Sucursal1_idx` (`idSucursal` ASC),
  CONSTRAINT `fk_Vehiculo_TipoVehiculo1`
    FOREIGN KEY (`idTipoVehiculo`)
    REFERENCES `Rent-a-car`.`TipoVehiculo` (`idTipoVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehiculo_Sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `Rent-a-car`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Reservacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Reservacion` (
  `idReservacion` INT NOT NULL AUTO_INCREMENT,
  `fechaInicio` DATETIME NULL,
  `fechaFin` DATETIME NULL,
  `idCliente` INT NOT NULL,
  `precioVehiculo` DECIMAL(10,4) NULL,
  `idVehiculo` INT NOT NULL,
  PRIMARY KEY (`idReservacion`, `idVehiculo`),
  INDEX `fk_Reservacion_Cliente1_idx` (`idCliente` ASC),
  INDEX `fk_Reservacion_Vehiculo1_idx` (`idVehiculo` ASC),
  CONSTRAINT `fk_Reservacion_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Rent-a-car`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservacion_Vehiculo1`
    FOREIGN KEY (`idVehiculo`)
    REFERENCES `Rent-a-car`.`Vehiculo` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`Extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`Extra` (
  `idExtra` INT NOT NULL AUTO_INCREMENT,
  `precioActual` DECIMAL(10,4) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idExtra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`ResevacionHasExtra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`ResevacionHasExtra` (
  `Reservacion_idReservacion` INT NOT NULL,
  `idExtra` INT NOT NULL,
  `precioExtra` DECIMAL(10,4) NULL,
  PRIMARY KEY (`Reservacion_idReservacion`, `idExtra`),
  INDEX `fk_Reservacion_has_Extra_Extra1_idx` (`idExtra` ASC),
  INDEX `fk_Reservacion_has_Extra_Reservacion1_idx` (`Reservacion_idReservacion` ASC),
  CONSTRAINT `fk_Reservacion_has_Extra_Reservacion1`
    FOREIGN KEY (`Reservacion_idReservacion`)
    REFERENCES `Rent-a-car`.`Reservacion` (`idReservacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservacion_has_Extra_Extra1`
    FOREIGN KEY (`idExtra`)
    REFERENCES `Rent-a-car`.`Extra` (`idExtra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rent-a-car`.`SucursalHasTIpoVehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rent-a-car`.`SucursalHasTIpoVehiculo` (
  `idSucursal` INT NOT NULL,
  `idTipoVehiculo` INT NOT NULL,
  PRIMARY KEY (`idSucursal`, `idTipoVehiculo`),
  INDEX `fk_Sucursal_has_TipoVehiculo_TipoVehiculo1_idx` (`idTipoVehiculo` ASC),
  INDEX `fk_Sucursal_has_TipoVehiculo_Sucursal1_idx` (`idSucursal` ASC),
  CONSTRAINT `fk_Sucursal_has_TipoVehiculo_Sucursal1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `Rent-a-car`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_has_TipoVehiculo_TipoVehiculo1`
    FOREIGN KEY (`idTipoVehiculo`)
    REFERENCES `Rent-a-car`.`TipoVehiculo` (`idTipoVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
