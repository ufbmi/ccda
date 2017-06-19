
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `Show Audio Links`;
/*!50001 DROP VIEW IF EXISTS `Show Audio Links`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Show Audio Links` AS SELECT 
 1 AS `id`,
 1 AS `lu_options_id`,
 1 AS `languages_id`,
 1 AS `value`,
 1 AS `sites_id`,
 1 AS `projects_id`,
 1 AS `forms_id`,
 1 AS `sections_id`,
 1 AS `questions_id`,
 1 AS `answers_id`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questions_id` bigint(20) NOT NULL,
  `next_answers_id` bigint(20) DEFAULT NULL,
  `previous_answers_id` bigint(20) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `questions_id` (`questions_id`),
  KEY `next_answers_id` (`next_answers_id`),
  KEY `previous_answers_id` (`previous_answers_id`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answers_ibfk_4` FOREIGN KEY (`next_answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answers_ibfk_5` FOREIGN KEY (`previous_answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1985 DEFAULT CHARSET=latin1 COMMENT='Stores all available answers underneath the questions.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `authorization_id` bigint(20) DEFAULT NULL,
  `sessions_id` bigint(20) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `passid` int(11) NOT NULL,
  `passkey` varchar(32) NOT NULL,
  `token` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  `expired_at` datetime DEFAULT '0000-00-00 00:00:00',
  `checked_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `passid` (`passid`),
  KEY `authorization_id` (`authorization_id`),
  KEY `sessions_id` (`sessions_id`),
  KEY `projects_id` (`projects_id`),
  KEY `sites_id` (`sites_id`),
  CONSTRAINT `authorization_ibfk_1` FOREIGN KEY (`authorization_id`) REFERENCES `authorization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `authorization_ibfk_2` FOREIGN KEY (`sessions_id`) REFERENCES `sessions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `authorization_ibfk_3` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `authorization_ibfk_4` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6004 DEFAULT CHARSET=latin1 COMMENT='Stores all of the permissions for all parts of the API.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `projects_id` bigint(20) NOT NULL,
  `next_forms_id` bigint(20) DEFAULT NULL,
  `previous_forms_id` bigint(20) DEFAULT NULL,
  `version` varchar(9) NOT NULL DEFAULT '0.0.0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `projects_id` (`projects_id`),
  KEY `next_forms_id` (`next_forms_id`),
  KEY `previous_forms_id` (`previous_forms_id`),
  CONSTRAINT `forms_ibfk_1` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `forms_ibfk_6` FOREIGN KEY (`next_forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `forms_ibfk_7` FOREIGN KEY (`previous_forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COMMENT='Stores all available forms underneath the projects.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `lu_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lu_icons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `category` enum('','sites','projects','forms','sections','questions','answers') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores all available bootstrap icons.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `lu_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lu_languages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `abbreviation` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Stores all available languages.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `lu_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lu_options` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parameter` enum('display','width','height','rows','cols','max','min','headers','isOpen','isDisabled','video_src','autoplay','loop','aspectRatio','resetAvailable','show_logic','scored_section','audio_src','controls','preload','volume','isRequired') NOT NULL,
  `category` enum('','sites','projects','forms','sections','questions','answers') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1 COMMENT='Stores all available options (min, max, cols, rows, etc)';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `lu_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lu_styles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `category` enum('','sites','projects','forms','sections','questions','answers') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Store all available bootstrap styles.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `lu_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lu_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` varchar(32) NOT NULL,
  `parameter` enum('type') NOT NULL,
  `category` enum('','sites','projects','forms','sections','questions','answers') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COMMENT='Store all available types (text, survey, longitudinal, etc)';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `preferences_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences_icons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lu_icons_id` bigint(20) NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `forms_id` bigint(20) DEFAULT NULL,
  `sections_id` bigint(20) DEFAULT NULL,
  `questions_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `questions_id` (`questions_id`),
  KEY `lu_icons_id` (`lu_icons_id`),
  KEY `sites_id` (`sites_id`),
  KEY `projects_id` (`projects_id`),
  CONSTRAINT `preferences_icons_ibfk_1` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_icons_ibfk_2` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_icons_ibfk_3` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_icons_ibfk_4` FOREIGN KEY (`lu_icons_id`) REFERENCES `lu_icons` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_icons_ibfk_5` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_icons_ibfk_6` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores links to all icons.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `preferences_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences_languages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lu_languages_id` bigint(20) NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `forms_id` bigint(20) DEFAULT NULL,
  `sections_id` bigint(20) DEFAULT NULL,
  `questions_id` bigint(20) DEFAULT NULL,
  `answers_id` bigint(20) DEFAULT NULL,
  `default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_id` (`projects_id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `lu_languages_id` (`lu_languages_id`),
  KEY `sites_id` (`sites_id`),
  KEY `questions_id` (`questions_id`),
  KEY `answers_id` (`answers_id`),
  CONSTRAINT `preferences_languages_ibfk_11` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_languages_ibfk_12` FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_languages_ibfk_4` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_languages_ibfk_5` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_languages_ibfk_6` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_languages_ibfk_7` FOREIGN KEY (`lu_languages_id`) REFERENCES `lu_languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_languages_ibfk_9` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Stores links to all languages.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `preferences_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences_options` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lu_options_id` bigint(20) NOT NULL,
  `languages_id` bigint(20) DEFAULT NULL,
  `value` text NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `forms_id` bigint(20) DEFAULT NULL,
  `sections_id` bigint(20) DEFAULT NULL,
  `questions_id` bigint(20) DEFAULT NULL,
  `answers_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `questions_id` (`questions_id`),
  KEY `lu_options_id` (`lu_options_id`),
  KEY `sites_id` (`sites_id`),
  KEY `projects_id` (`projects_id`),
  KEY `answers_id` (`answers_id`),
  CONSTRAINT `preferences_options_ibfk_1` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_options_ibfk_2` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_options_ibfk_3` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_options_ibfk_4` FOREIGN KEY (`lu_options_id`) REFERENCES `lu_options` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_options_ibfk_5` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_options_ibfk_6` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_options_ibfk_7` FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1248 DEFAULT CHARSET=latin1 COMMENT='Stores links to all options.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `preferences_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences_styles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lu_styles_id` bigint(20) NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `forms_id` bigint(20) DEFAULT NULL,
  `sections_id` bigint(20) DEFAULT NULL,
  `questions_id` bigint(20) DEFAULT NULL,
  `answers_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `questions_id` (`questions_id`),
  KEY `lu_styles_id` (`lu_styles_id`),
  KEY `sites_id` (`sites_id`),
  KEY `projects_id` (`projects_id`),
  KEY `answers_id` (`answers_id`),
  CONSTRAINT `preferences_styles_ibfk_1` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_styles_ibfk_2` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_styles_ibfk_3` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_styles_ibfk_4` FOREIGN KEY (`lu_styles_id`) REFERENCES `lu_styles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_styles_ibfk_5` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_styles_ibfk_6` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_styles_ibfk_7` FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores links to all styles.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `preferences_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences_text` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `languages_id` bigint(20) DEFAULT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `instructions` text NOT NULL,
  `placeholder` varchar(32) NOT NULL,
  `default` text NOT NULL,
  `object_label` text NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `forms_id` bigint(20) DEFAULT NULL,
  `sections_id` bigint(20) DEFAULT NULL,
  `questions_id` bigint(20) DEFAULT NULL,
  `answers_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_id` (`projects_id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `questions_id` (`questions_id`),
  KEY `answers_id` (`answers_id`),
  KEY `languages_id` (`languages_id`),
  KEY `sites_id` (`sites_id`),
  CONSTRAINT `preferences_text_ibfk_2` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_text_ibfk_3` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_text_ibfk_4` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_text_ibfk_5` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_text_ibfk_6` FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_text_ibfk_7` FOREIGN KEY (`languages_id`) REFERENCES `lu_languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_text_ibfk_8` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4511 DEFAULT CHARSET=latin1 COMMENT='Stores links to all texts.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `preferences_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lu_types_id` bigint(20) NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `forms_id` bigint(20) DEFAULT NULL,
  `sections_id` bigint(20) DEFAULT NULL,
  `questions_id` bigint(20) DEFAULT NULL,
  `answers_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `questions_id` (`questions_id`),
  KEY `lu_types_id` (`lu_types_id`),
  KEY `sites_id` (`sites_id`),
  KEY `projects_id` (`projects_id`),
  KEY `answers_id` (`answers_id`),
  CONSTRAINT `preferences_types_ibfk_1` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_types_ibfk_2` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_types_ibfk_3` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_types_ibfk_4` FOREIGN KEY (`lu_types_id`) REFERENCES `lu_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_types_ibfk_5` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_types_ibfk_6` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `preferences_types_ibfk_7` FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=769 DEFAULT CHARSET=latin1 COMMENT='Stores links to all types.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sites_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `sites_id` (`sites_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Stores all available projects underneath the sites.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sections_id` bigint(20) NOT NULL,
  `next_questions_id` bigint(20) DEFAULT NULL,
  `previous_questions_id` bigint(20) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `sections_id` (`sections_id`),
  KEY `previous_questions_id` (`previous_questions_id`),
  KEY `next_questions_id` (`next_questions_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `questions_ibfk_5` FOREIGN KEY (`next_questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `questions_ibfk_6` FOREIGN KEY (`previous_questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=latin1 COMMENT='Stores all available questions underneath the sections.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sessions_id` bigint(20) NOT NULL,
  `languages_id` bigint(20) NOT NULL,
  `sites_id` bigint(20) NOT NULL,
  `projects_id` bigint(20) NOT NULL,
  `forms_id` bigint(20) NOT NULL,
  `sections_id` bigint(20) NOT NULL,
  `questions_id` bigint(20) NOT NULL,
  `answers_id` bigint(20) DEFAULT NULL,
  `free_text` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  `completed_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `sites_id` (`sites_id`),
  KEY `projects_id` (`projects_id`),
  KEY `forms_id` (`forms_id`),
  KEY `sections_id` (`sections_id`),
  KEY `questions_id` (`questions_id`),
  KEY `answers_id` (`answers_id`),
  KEY `sessions_id` (`sessions_id`),
  KEY `languages_id` (`languages_id`),
  CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`sessions_id`) REFERENCES `sessions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_2` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_3` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_4` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_5` FOREIGN KEY (`sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_6` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_7` FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `responses_ibfk_8` FOREIGN KEY (`languages_id`) REFERENCES `lu_languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1 COMMENT='Stores all data collected from participants.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `forms_id` bigint(20) NOT NULL,
  `next_sections_id` bigint(20) DEFAULT NULL,
  `previous_sections_id` bigint(20) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `forms_id` (`forms_id`),
  KEY `previous_sections_id` (`previous_sections_id`),
  KEY `next_sections_id` (`next_sections_id`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`forms_id`) REFERENCES `forms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sections_ibfk_5` FOREIGN KEY (`next_sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sections_ibfk_6` FOREIGN KEY (`previous_sections_id`) REFERENCES `sections` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1 COMMENT='Stores all available sections underneath the forms.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `sites_id` bigint(20) DEFAULT NULL,
  `projects_id` bigint(20) DEFAULT NULL,
  `authorization_id` bigint(20) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `languages_id` bigint(20) DEFAULT NULL,
  `responses_id` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  `expired_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `authorization_id` (`authorization_id`),
  KEY `languages_id` (`languages_id`),
  KEY `responses_id` (`responses_id`),
  KEY `projects_id` (`projects_id`),
  KEY `sites_id` (`sites_id`),
  CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`authorization_id`) REFERENCES `authorization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sessions_ibfk_3` FOREIGN KEY (`languages_id`) REFERENCES `lu_languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sessions_ibfk_4` FOREIGN KEY (`responses_id`) REFERENCES `responses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sessions_ibfk_5` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sessions_ibfk_6` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COMMENT='Stores all sessions that were granted access to the API.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `show_navbar` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT '0000-00-00 00:00:00',
  `deleted_at` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Stores all available sites.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 DROP PROCEDURE IF EXISTS `addAudioToObject` */;
ALTER DATABASE `ccdaa` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `addAudioToObject`(IN `object_type` text, IN `object_id` bigint, IN `audio_src_spanish` text, IN `audio_src_english` text, IN `audio_autoplay` text, IN `audio_preload` text, IN `audio_controls` text, IN `audio_volume` text)
BEGIN

DECLARE object_insert TEXT;
DECLARE autoplay INT;
DECLARE controls INT;
DECLARE preload INT;
DECLARE volume INT;
DECLARE source INT;

IF (object_type = 'sites') THEN
    SET object_insert = CONCAT(object_id,",NULL,NULL,NULL,NULL");
    SET autoplay = 37;
    SET controls = 35;
    SET preload = 36;
    SET volume = 39;
    SET source = 34;
    SET audio_src_spanish = CONCAT("{\"languages_id\": \"2\",\"src\":\"",audio_src_spanish,"\"}");
    SET audio_src_english = CONCAT("{\"languages_id\": \"1\",\"src\":\"",audio_src_english,"\"}");
END IF;

IF (object_type = 'projects') THEN
    SET object_insert = CONCAT("NULL,",object_id,",NULL,NULL,NULL");
    SET autoplay = 18;
    SET controls = 19;
    SET preload = 20;
    SET volume = 23;
    SET source = 14;
END IF;

IF (object_type = 'forms') THEN
    SET object_insert = CONCAT("NULL,NULL,",object_id,",NULL,NULL");
    SET autoplay = 33;
    SET controls = 32;
    SET preload = 31;
    SET volume = 30;
    SET source = 15;
END IF;

IF (object_type = 'sections') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,",object_id,",NULL");
    SET autoplay = 28;
    SET controls = 24;
    SET preload = 25;
    SET volume = 26;
    SET source = 16;
END IF;

IF (object_type = 'questions') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,",object_id);
    SET autoplay = 7;
    SET controls = 21;
    SET preload = 22;
    SET volume = 27;
    SET source = 17;
END IF;

SET @query = CONCAT("INSERT INTO `preferences_options` (`id`, `lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES ");

SET @query = CONCAT(@query,"(NULL,",source,",1,'", audio_src_english,"',", object_insert, ")",",");
SET @query = CONCAT(@query,"(NULL,",source,",2,'", audio_src_spanish,"',", object_insert, ")",",");

SET @query = CONCAT(@query,"(NULL,",autoplay,",NULL,'",audio_autoplay,"',", object_insert, ")");
SET @query = CONCAT(@query,",");
SET @query = CONCAT(@query,"(NULL,",preload,",NULL,'",audio_preload,"',", object_insert, ")");
SET @query = CONCAT(@query,",");
SET @query = CONCAT(@query,"(NULL,",controls,",NULL,'",audio_controls,"',", object_insert, ")");
SET @query = CONCAT(@query,",");
SET @query = CONCAT(@query,"(NULL,",volume,",NULL,'",audio_volume,"',", object_insert, ")");

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `ccdaa` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `clearAuthAndSession` */;
ALTER DATABASE `ccdaa` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clearAuthAndSession`()
BEGIN
SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM  `ccdaa`.`authorization` WHERE  `authorization`.`name`='ccdaa_session_token';

TRUNCATE sessions;

SET FOREIGN_KEY_CHECKS = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `ccdaa` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `clearResponses` */;
ALTER DATABASE `ccdaa` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `clearResponses`()
BEGIN
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE responses;
SET FOREIGN_KEY_CHECKS = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `ccdaa` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `createKeyGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `createKeyGroup`(IN `key_count` int, IN `min_val` int)
BEGIN
    DECLARE i INT;
    SET i = 0;
    START TRANSACTION;
        WHILE i <= key_count DO
            CALL insertSessionKey(min_val + i);
            SET i = i + 1;
        END WHILE;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createNewObject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `createNewObject`(IN `object_type` text, IN `parent_id` bigint, IN `object_title_english` text, IN `object_description_english` text, IN `object_instructions_english` text, IN `object_title_spanish` text, IN `object_description_spanish` text, IN `object_instructions_spanish` text, IN `object_types_id` bigint, IN `object_sort_order` int, IN `object_options_display` int, IN `object_options_value` text)
BEGIN

DECLARE new_object_id BIGINT;
DECLARE object_insert TEXT;
DECLARE placeholder_english TEXT DEFAULT '';
DECLARE placeholder_spanish TEXT DEFAULT '';
DECLARE default_english TEXT DEFAULT '';
DECLARE default_spanish TEXT DEFAULT '';

IF (object_type = 'forms') THEN
    SET @insert_query = CONCAT("INSERT INTO forms (projects_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

IF (object_type = 'sections') THEN
    SET @insert_query = CONCAT("INSERT INTO sections (forms_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");

    SET placeholder_english = 'Next';
    SET placeholder_spanish = 'Siguiente';
    SET default_english = 'Previous';
    SET default_spanish = 'Anterior';
END IF;

IF (object_type = 'questions') THEN
    SET @insert_query = CONCAT("INSERT INTO questions (sections_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

IF (object_type = 'answers') THEN
    SET @insert_query = CONCAT("INSERT INTO answers (questions_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

PREPARE stmt FROM @insert_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET new_object_id = LAST_INSERT_ID();

IF (object_type = 'forms') THEN
    SET object_insert = CONCAT("NULL,NULL,",new_object_id,",NULL,NULL,NULL");
END IF;

IF (object_type = 'sections') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,",new_object_id,",NULL,NULL");
END IF;

IF (object_type = 'questions') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,",new_object_id,",NULL");
END IF;

IF (object_type = 'answers') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,NULL,",new_object_id);
END IF;

SET @ptext_query = CONCAT("INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES (1,'",object_title_english,"', '",object_description_english,"', '",object_instructions_english,"', '",placeholder_english,"', '",default_english,"', '',",object_insert,")");
PREPARE stmt FROM @ptext_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @ptext_query = CONCAT("INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES (2,'",object_title_spanish,"', '",object_description_spanish,"', '",object_instructions_spanish,"', '",placeholder_spanish,"', '",default_spanish,"', '',",object_insert,")");
PREPARE stmt FROM @ptext_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

IF (object_types_id) THEN
    SET @ptypes_query = CONCAT("INSERT INTO `preferences_types` (`lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES ('",object_types_id,"',",object_insert,")");
    PREPARE stmt FROM @ptypes_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

IF (object_options_display) THEN
    SET @poptions_query = CONCAT("INSERT INTO `preferences_options` (`lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES ('",object_options_display,"', NULL, '",object_options_value,"',",object_insert,")");
    PREPARE stmt FROM @poptions_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getObjectByObjectId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `getObjectByObjectId`(IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `object_id` bigint)
BEGIN
DECLARE object_id_column TEXT;
DECLARE next_object_column TEXT;
DECLARE previous_object_column TEXT;

DECLARE title_field TEXT DEFAULT 'pt.title';
DECLARE description_field TEXT DEFAULT 'pt.description';
DECLARE placeholder_field TEXT DEFAULT 'pt.placeholder';
DECLARE default_field TEXT DEFAULT 'pt.default';

IF (object_type = 'projects')
THEN
    SET placeholder_field = 'pt.placeholder AS begin';
END IF;

IF (object_type = 'forms') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'sections') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'answers') THEN
    SET title_field = 'pt.title AS display';
    SET description_field = 'pt.description AS value';
END IF;

SET object_id_column = CONCAT(object_type,'_id');
SET next_object_column = CONCAT('next_',object_type,'_id');
SET previous_object_column = CONCAT('previous_',object_type,'_id');

SET @sql_command = "SELECT object.id";

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command,",object.",previous_object_column,",object.",next_object_column,",object.sort_order");
END IF;

IF (object_type = 'forms') THEN
    SET @sql_command = CONCAT(@sql_command, ",version");
END IF;

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label,
    pt.languages_id
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.id='",object_id,"' AND object.deleted_at='",deleted_at,"'");

IF (languages_id != '0') THEN
    SET @sql_command = CONCAT(@sql_command," AND pt.languages_id='",languages_id,"'");
END IF;

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getObjectByParentId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `getObjectByParentId`(IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `parent_type` text, IN `parent_id` bigint)
BEGIN
DECLARE parent_id_column TEXT;
DECLARE object_id_column TEXT;
DECLARE next_object_column TEXT;
DECLARE previous_object_column TEXT;

DECLARE title_field TEXT DEFAULT 'pt.title';
DECLARE description_field TEXT DEFAULT 'pt.description';
DECLARE placeholder_field TEXT DEFAULT 'pt.placeholder';
DECLARE default_field TEXT DEFAULT 'pt.default';

SET parent_id_column = CONCAT(parent_type,'_id');
SET object_id_column = CONCAT(object_type,'_id');
SET next_object_column = CONCAT('next_',object_type,'_id');
SET previous_object_column = CONCAT('previous_',object_type,'_id');

IF (object_type = 'projects')
THEN
    SET placeholder_field = 'pt.placeholder AS begin';
END IF;

IF (object_type = 'forms') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'sections') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'answers') THEN
    SET title_field = 'pt.title AS display';
    SET description_field = 'pt.description AS value';
END IF;

SET @sql_command = "SELECT object.id";

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command,",object.",previous_object_column,",object.",next_object_column,",object.sort_order");
END IF;

IF (object_type = 'forms') THEN
    SET @sql_command = CONCAT(@sql_command, ",version");
END IF;

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label,
    pt.languages_id
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.",parent_id_column,"='",parent_id,"' AND object.deleted_at='",deleted_at,"'");

IF (languages_id != '0') THEN
    SET @sql_command = CONCAT(@sql_command," AND pt.languages_id='",languages_id,"'");
END IF;

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getObjectDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `getObjectDetails`(IN `object_id` bigint, IN `object_type` text, IN `languages_id` text)
BEGIN

DECLARE pt_object_type_id TEXT;
DECLARE po_object_type_id TEXT;

SET pt_object_type_id=CONCAT('pt.',object_type,'_id');
SET po_object_type_id=CONCAT('po.',object_type,'_id');

SET @query = CONCAT("SELECT CONCAT('types') AS from_table,lut.parameter, lut.value FROM preferences_types AS pt JOIN lu_types AS lut ON pt.lu_types_id=lut.id WHERE ",pt_object_type_id,"=",object_id," AND lut.category='",object_type,"' UNION SELECT CONCAT('options'),luo.parameter, po.value FROM preferences_options AS po JOIN lu_options AS luo ON po.lu_options_id=luo.id WHERE ",po_object_type_id,"=",object_id," AND luo.category='",object_type,"'");

IF (languages_id != "all") THEN
 SET @query = CONCAT(@query," AND (po.languages_id='",languages_id,"' OR po.languages_id IS NULL)");
END IF;

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getResponsesForAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `getResponsesForAll`()
SELECT
     az.passid AS subject_id,
     spt.title AS section,
     qpt.title AS question,
     apt.title AS answer_title,
     apt.description AS answer_value,
     r.free_text AS free_text,
     r.created_at
FROM
     responses AS r
        JOIN 
     (select max(r2.id) id from responses r2
      group by r2.sessions_id, r2.forms_id, r2.sections_id, r2.questions_id
     ) as last_response on last_response.id = r.id
        JOIN
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=1
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=1
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=1
        JOIN
     sessions AS s ON r.sessions_id=s.id
        JOIN
     authorization as az ON s.id=az.sessions_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getScores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `getScores`(IN `sessions_id` bigint, IN `lu_options_id` bigint)
SELECT spt.title AS section, r.sections_id,qpt.title AS question, r.questions_id,apt.description AS score, r.answers_id, s.token, r.id, r.created_at FROM responses AS r, preferences_text AS spt, preferences_text AS qpt, preferences_text AS apt, sessions AS s, preferences_options AS spo WHERE r.sessions_id=sessions_id AND spt.sections_id=r.sections_id AND qpt.questions_id=r.questions_id AND apt.answers_id=r.answers_id AND r.sessions_id=s.id AND spo.value=r.sections_id AND spo.lu_options_id=lu_options_id GROUP BY r.questions_id ORDER BY r.created_at DESC ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertSessionKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `insertSessionKey`(IN `new_passid` int(11))
BEGIN
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO `authorization` (`authorization_id`, `sites_id`, `projects_id`, `sessions_id`, `name`, `description`,`passid`, `passkey`, `token`, `created_at`, `updated_at`, `deleted_at`, `expired_at`,`checked_at`) VALUES
(1, 1,  1,NULL, 'ccdaa_session_token', 'Available tokens to allow creation of a new session. This is for limiting the number of participants.', new_passid,'1234', '', '2015-05-13 16:30:46', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00','0000-00-00 00:00:00');


SET FOREIGN_KEY_CHECKS = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removeAudioFromObject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `removeAudioFromObject`(IN `object_type` text, IN `object_id` bigint)
BEGIN

DECLARE object_remove TEXT;
DECLARE id_list TEXT;
DECLARE autoplay INT;
DECLARE controls INT;
DECLARE preload INT;
DECLARE volume INT;
DECLARE source INT;

IF (object_type = 'sites') THEN
    SET object_remove = 'sites_id';
    SET autoplay = 37;
    SET controls = 35;
    SET preload = 36;
    SET volume = 39;
    SET source = 34;
END IF;

IF (object_type = 'projects') THEN
    SET object_remove = 'projects_id';
    SET autoplay = 18;
    SET controls = 19;
    SET preload = 20;
    SET volume = 23;
    SET source = 14;
END IF;

IF (object_type = 'forms') THEN
    SET object_remove = 'forms_id';
    SET autoplay = 33;
    SET controls = 32;
    SET preload = 31;
    SET volume = 30;
    SET source = 15;
END IF;

IF (object_type = 'sections') THEN
    SET object_remove = 'sections_id';
    SET autoplay = 28;
    SET controls = 24;
    SET preload = 25;
    SET volume = 26;
    SET source = 16;
END IF;

IF (object_type = 'questions') THEN
    SET object_remove = 'questions_id';
    SET autoplay = 7;
    SET controls = 21;
    SET preload = 22;
    SET volume = 27;
    SET source = 17;
END IF;

IF (object_type != '' AND object_id > 0) THEN
    SET id_list = CONCAT(autoplay,",",controls,",",preload,",",volume,",",source);
    SET @query = CONCAT("DELETE FROM `preferences_options` WHERE ",object_remove,"='",object_id,"' AND lu_options_id IN(",id_list,")");
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reportFormsAndSectionsByProjectsId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `reportFormsAndSectionsByProjectsId`(IN `deleted_at` text, IN `languages_id` bigint, IN `object_id` bigint)
BEGIN

SELECT
    object.id AS form_id,
    child.id AS section_id,
    pt.title as form_title,
    pt_child.title as section_title
FROM
    forms AS object
        JOIN
    preferences_text AS pt ON object.id = pt.forms_id
            join
    sections as child ON object.id = child.forms_id
            Join
    preferences_text AS pt_child ON child.id = pt_child.sections_id

WHERE
    object.projects_id = object_id
        AND pt.languages_id = languages_id
        AND pt_child.languages_id = languages_id
        AND object.deleted_at = deleted_at
ORDER BY object.sort_order, child.sort_order ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setupNewInstance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `setupNewInstance`(IN `key_count` int, IN `min_val` int)
BEGIN
CALL `clearAuthAndSession`();
CALL `clearResponses`();
CALL `createKeyGroup`(key_count, min_val);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50001 DROP VIEW IF EXISTS `Show Audio Links`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ccdaa`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Show Audio Links` AS select `preferences_options`.`id` AS `id`,`preferences_options`.`lu_options_id` AS `lu_options_id`,`preferences_options`.`languages_id` AS `languages_id`,`preferences_options`.`value` AS `value`,`preferences_options`.`sites_id` AS `sites_id`,`preferences_options`.`projects_id` AS `projects_id`,`preferences_options`.`forms_id` AS `forms_id`,`preferences_options`.`sections_id` AS `sections_id`,`preferences_options`.`questions_id` AS `questions_id`,`preferences_options`.`answers_id` AS `answers_id` from `preferences_options` where (`preferences_options`.`value` like '%.mp3') order by `preferences_options`.`value` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

