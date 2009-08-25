-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Aug 14 15:47:02 2009
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `keyword`;

--
-- Table: `keyword`
--
CREATE TABLE `keyword` (
  `id` INTEGER unsigned NOT NULL auto_increment,
  `keyword` VARCHAR(255) NOT NULL,
  `count` INTEGER NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE `keyword_keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8;

DROP TABLE IF EXISTS `comment`;

--
-- Table: `comment`
--
CREATE TABLE `comment` (
  `id` INTEGER unsigned NOT NULL auto_increment,
  `keyword` INTEGER unsigned NOT NULL auto_increment,
  `body` VARCHAR(255) NOT NULL,
  `created_date` datetime NOT NULL,
  INDEX comment_idx_keyword (`keyword`),
  PRIMARY KEY (`id`),
  CONSTRAINT `comment_fk_keyword` FOREIGN KEY (`keyword`) REFERENCES `keyword` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8;

SET foreign_key_checks=1;

