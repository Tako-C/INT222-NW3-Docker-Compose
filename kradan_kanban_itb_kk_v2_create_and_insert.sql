-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


SET NAMES utf8mb4;
-- SET time_zone = '+00:00';
SET GLOBAL time_zone = '+00:00';

-- CREATE USER 'user'@'%' IDENTIFIED BY 'mysql';
-- GRANT ALL ON *.* TO 'user'@'%';
-- -----------------------------------------------------
-- Schema kradan_kanban_itb_kk_v2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kradan_kanban_itb_kk_v2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `kradan_kanban_itb_kk_v2` ;


-- -----------------------------------------------------
-- Table `kradan_kanban_itb_kk_v2`.`boards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kradan_kanban_itb_kk_v2`.`boards` (
  `board_id` VARCHAR(10) NOT NULL UNIQUE,
  `oid` VARCHAR(36) NOT NULL,
  `board_name` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`board_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kradan_kanban_itb_kk_v2`.`statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kradan_kanban_itb_kk_v2`.`statuses` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `board_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_statuss_board_id`
    FOREIGN KEY (`board_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`boards` (`board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kradan_kanban_itb_kk_v2`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kradan_kanban_itb_kk_v2`.`tasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `description` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `assignees` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `createdOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status_id` INT NOT NULL,
  `board_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`, `status_id`, `board_id`),
  INDEX `fk_mytasks_board_id_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_mytasks_status_id`
    FOREIGN KEY (`status_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`statuses` (`status_id`),
  CONSTRAINT `fk_mytasks_board_id`
    FOREIGN KEY (`board_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`boards` (`board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use kradan_kanban_itb_kk_v2;
SET NAMES utf8mb4;
SET character_set_results = 'utf8mb4';


INSERT INTO boards (board_id, oid, board_name) VALUES
('JzTmVqCnyT', '550e8400-e29b-41d4-a716-446655440000','job list'),
('9hZkPj2sBw', '550e8400-e29b-41d4-a716-446655440001','home work');

insert into statuses (name, description, board_id) values
("No Status","The default status",'JzTmVqCnyT'),
("To Do","This is To Do",'JzTmVqCnyT'),
("Doing","Being worked on",'9hZkPj2sBw'),
("Done","Finished",'9hZkPj2sBw');



INSERT INTO tasks (title, description, assignees, createdOn, updatedOn, status_id, board_id) VALUES
('TaskTitle1TaskTitle2TaskTitle3TaskTitle4TaskTitle5TaskTitle6TaskTitle7TaskTitle8TaskTitle9TaskTitle0',
 'Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti1Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti2Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti3Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti4Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti5',
 'Assignees1Assignees2Assignees3', 
 '2024-04-22 09:00:00', 
 '2024-04-22 09:00:00', 
 1, 
 'JzTmVqCnyT'),
('Repository', null, null, '2024-04-22 09:05:00', '2024-04-22 14:00:00', 2, 'JzTmVqCnyT'),
('ดาต้าเบส', 'ສ້າງຖານຂໍ້ມູນ', 'あなた、彼、彼女 (私ではありません)', '2024-04-22 09:10:00', '2024-04-25 00:00:00', 3, 'JzTmVqCnyT'),
(' _Infrastructure_ ', ' _Setup containers_ ', 'ไก่งวง กับ เพนกวิน', '2024-04-22 09:15:00', '2024-04-22 10:00:00', 4, '9hZkPj2sBw'),
('Test Application', 'Perform end-to-end testing of the application', 'Chris,White', '2024-08-05 14:00:00', '2024-08-05 20:00:00', 2, '9hZkPj2sBw');

