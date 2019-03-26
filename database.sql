CREATE SCHEMA `financial_blogs` ;
CREATE TABLE `financial_blogs`.`blogger` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `blogger_name` VARCHAR(45) NOT NULL,
  `visits` INT NULL,
  `ranking` INT NULL,
  `first_page_url` VARCHAR(200) NULL,
  `start_page` INT NULL,
  `end_page` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `blogger_name_UNIQUE` (`blogger_name` ASC)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `financial_blogs`.`blogs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `blogger_name` VARCHAR(45) NULL,
  `headline` VARCHAR(200) NULL,
  `content` TEXT NULL,
  `num_views` INT NULL DEFAULT 1,
  `num_comments` INT NULL DEFAULT 1,
  `created_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `blogger_name_index` (`blogger_name` ASC),
  INDEX `created_date_index` (`created_date` ASC),
  INDEX `blogger_name_and_date_index` (`blogger_name` ASC, `created_date` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `financial_blogs`.`blogs`
ADD UNIQUE INDEX `created_date_UNIQUE` (`created_date` ASC);
;

ALTER TABLE `financial_blogs`.`blogs`
ADD UNIQUE INDEX `blogger_date_UNIQUE` (`blogger_name` ASC, `created_date` ASC),
DROP INDEX `created_date_UNIQUE` ;
;

CREATE TABLE `financial_blogs`.`processed_blogs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `blogger_name` VARCHAR(45) NULL,
  `words` TEXT NULL,
  `created_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `blogger_name_and_date_UNIQUE` (`blogger_name` ASC, `created_date` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `financial_blogs`.`processed_blogs`
ADD COLUMN `num_words` INT NULL AFTER `created_date`;

ALTER TABLE `financial_blogs`.`blogger`
ADD COLUMN `remarks` TEXT NULL DEFAULT NULL AFTER `end_page`;


INSERT INTO `financial_blogs`.`blogger` (`blogger_name`, `visits`, `ranking`, `first_page_url`, `start_page`, `end_page`) VALUES ('余岳桐', '24122167', '118', 'http://blog.eastmoney.com/yuyuetong/bloglist_0_1.html', '1', '31');

