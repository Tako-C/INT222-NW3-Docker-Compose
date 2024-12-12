SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET GLOBAL time_zone = '+00:00';

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- CREATE USER  'user'@'%' IDENTIFIED BY 'mysql';
-- GRANT ALL ON *.* TO 'user'@'%';
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema kradan_kanban_itb_kk_v2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kradan_kanban_itb_kk_v2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kradan_kanban_itb_kk_v2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `kradan_kanban_itb_kk_v2` ;

-- -----------------------------------------------------
-- Table `kradan_kanban_itb_kk_v2`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kradan_kanban_itb_kk_v2`.`users` (
  `oid` VARCHAR(36) NOT NULL,
  `name` TEXT(100) NOT NULL,
  `username` TEXT(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`oid`),
  UNIQUE INDEX `oid_UNIQUE` (`oid` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kradan_kanban_itb_kk_v2`.`boards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kradan_kanban_itb_kk_v2`.`boards` (
  `board_id` VARCHAR(10) NOT NULL,
  -- `oid` VARCHAR(36) NOT NULL,
  `board_name` VARCHAR(120) NOT NULL,
  `createdOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `visibility` VARCHAR(7) NOT NULL,
  `users_oid` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`board_id`),
  UNIQUE INDEX `board_id` (`board_id` ASC) VISIBLE,
  INDEX `fk_boards_users1_idx` (`users_oid` ASC) VISIBLE,
  CONSTRAINT `fk_boards_users1`
    FOREIGN KEY (`users_oid`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`users` (`oid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  INDEX `fk_statuss_board_id` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_statuss_board_id`
    FOREIGN KEY (`board_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`boards` (`board_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
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
  INDEX `fk_mytasks_status_id` (`status_id` ASC) VISIBLE,
  CONSTRAINT `fk_mytasks_board_id`
    FOREIGN KEY (`board_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`boards` (`board_id`),
  CONSTRAINT `fk_mytasks_status_id`
    FOREIGN KEY (`status_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`statuses` (`status_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kradan_kanban_itb_kk_v2`.`collab_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kradan_kanban_itb_kk_v2`.`collab_board` (
  `collab_id` INT NOT NULL AUTO_INCREMENT,
  `oid` VARCHAR(36) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `access_right` VARCHAR(45) NOT NULL,
  `status_invite` ENUM("PENDING","ACCEPTED") NOT NULL DEFAULT 'pending',
  `added_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `boards_id` VARCHAR(10) NOT NULL,
  `token` VARCHAR(255) NULL UNIQUE,
  PRIMARY KEY (`collab_id`),
  INDEX `fk_collab_board_boards1_idx` (`boards_id` ASC) VISIBLE,
  CONSTRAINT `fk_collab_board_boards1`
    FOREIGN KEY (`boards_id`)
    REFERENCES `kradan_kanban_itb_kk_v2`.`boards` (`board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use kradan_kanban_itb_kk_v2;
SET NAMES utf8mb4;
SET character_set_results = 'utf8mb4';

INSERT INTO users (oid,name,username,email) VALUES
('e392a1a4-77a7-4bb4-8353-3cc05ae61c4b','ITBKK SOMCHAI','itbkk.somchai','itbkk.somchai@ad.sit.kmutt.ac.th'),
('2b2f94fd-68be-4ff2-8c67-cb35e139f6fb','ITBKK OLARN','itbkk.olarn','itbkk.olarn@ad.sit.kmutt.ac.th'),
('995a830b-6c62-45e6-ab89-1077dff55a72','ITBKK SIAM','itbkk.siam','itbkk.siam@ad.sit.kmutt.ac.th');

INSERT INTO boards (board_id, users_oid, board_name,visibility) VALUES
('JzTmVqCnyT', '2b2f94fd-68be-4ff2-8c67-cb35e139f6fb','books list','public'),
('A9k0iqt3nM', '2b2f94fd-68be-4ff2-8c67-cb35e139f6fb','cat list','private'),
('7Kmp2xByTD', 'e392a1a4-77a7-4bb4-8353-3cc05ae61c4b','something','private'),
('9hZkPj2sBw', '2b2f94fd-68be-4ff2-8c67-cb35e139f6fb','home work','private');

INSERT INTO collab_board (oid,name,email,access_right,boards_id) VALUES
('e392a1a4-77a7-4bb4-8353-3cc05ae61c4b','ITBKK SOMCHAI','itbkk.somchai@ad.sit.kmutt.ac.th','read','JzTmVqCnyT'),
('e392a1a4-77a7-4bb4-8353-3cc05ae61c4b','ITBKK SOMCHAI','itbkk.somchai@ad.sit.kmutt.ac.th','read','9hZkPj2sBw'),
('995a830b-6c62-45e6-ab89-1077dff55a72','ITBKK SIAM','itbkk.siam@ad.sit.kmutt.ac.th','write','9hZkPj2sBw');
-- ('2b2f94fd-68be-4ff2-8c67-cb35e139f6fb','ITBKK OLARN','itbkk.olarn@ad.sit.kmutt.ac.th','read','JzTmVqCnyT');


insert into statuses (name, description, board_id) values
("No Status","The default status",'JzTmVqCnyT'),
("To Do","This is To Do",'JzTmVqCnyT'),
("Doing","Being worked on",'JzTmVqCnyT'),
("Done","Finished",'JzTmVqCnyT'),
("No Status","The default status",'9hZkPj2sBw'),
("To Do","This is To Do",'9hZkPj2sBw'),
("Doing","Being worked on",'9hZkPj2sBw'),
("Done","Finished",'9hZkPj2sBw');


INSERT INTO tasks (title, description, assignees, createdOn, updatedOn, status_id, board_id) VALUES
('TaskTitle1TaskTitle2TaskTitle3TaskTitle4TaskTitle5TaskTitle6TaskTitle7TaskTitle8TaskTitle9TaskTitle0',
 'Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti1Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti2Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti3Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti4Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti5',
 'Assignees1Assignees2Assignees3', 
 '2024-04-22 09:00:00', 
 '2024-04-22 09:00:00', 
 1, 
 '9hZkPj2sBw'),
('Repository', null, null, '2024-04-22 09:05:00', '2024-04-22 14:00:00', 2, '9hZkPj2sBw'),
('ดาต้าเบส', 'ສ້າງຖານຂໍ້ມູນ', 'あなた、彼、彼女 (私ではありません)', '2024-04-22 09:10:00', '2024-04-25 00:00:00', 1, '9hZkPj2sBw'),
(' _Infrastructure_ ', ' _Setup containers_ ', 'ไก่งวง กับ เพนกวิน', '2024-04-22 09:15:00', '2024-04-22 10:00:00', 4, '9hZkPj2sBw'),
('Test Application', 'Perform end-to-end testing of the application', 'Chris,White', '2024-08-05 14:00:00', '2024-08-05 20:00:00', 3, '9hZkPj2sBw');

