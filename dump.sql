-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июн 26 2013 г., 20:25
-- Версия сервера: 5.5.29
-- Версия PHP: 5.3.20

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `mipt`
--
CREATE DATABASE `mipt` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mipt`;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_answer`
--

DROP TABLE IF EXISTS `mipt_answer`;
CREATE TABLE IF NOT EXISTS `mipt_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `answer` varchar(400) DEFAULT NULL,
  `is_right` tinyint(1) DEFAULT NULL,
  `result_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_result_test_result1_idx` (`result_id`),
  KEY `fk_mipt_result_mipt_question1_idx` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Триггеры `mipt_answer`
--
DROP TRIGGER IF EXISTS `TriggerOnAnswer`;
DELIMITER //
CREATE TRIGGER `TriggerOnAnswer` AFTER INSERT ON `mipt_answer`
 FOR EACH ROW BEGIN
	
	UPDATE mipt_result as res SET res.answered =res.answered+1, res.end_time = NOW()
		WHERE res.id = NEW.result_id;
	
	IF NEW.is_right = 1 THEN
		UPDATE mipt_result as res SET res.answered_right=res.answered_right+1 
			WHERE res.id = NEW.result_id;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_branch`
--

DROP TABLE IF EXISTS `mipt_branch`;
CREATE TABLE IF NOT EXISTS `mipt_branch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_group`
--

DROP TABLE IF EXISTS `mipt_group`;
CREATE TABLE IF NOT EXISTS `mipt_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `institute_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_group_institute1_idx` (`institute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_group_test`
--

DROP TABLE IF EXISTS `mipt_group_test`;
CREATE TABLE IF NOT EXISTS `mipt_group_test` (
  `test_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_key` (`test_id`,`group_id`),
  KEY `fk_testgroup_relation_test1_idx` (`test_id`),
  KEY `fk_testgroup_relation_group1_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_institute`
--

DROP TABLE IF EXISTS `mipt_institute`;
CREATE TABLE IF NOT EXISTS `mipt_institute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_question`
--

DROP TABLE IF EXISTS `mipt_question`;
CREATE TABLE IF NOT EXISTS `mipt_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(400) DEFAULT NULL,
  `answer` varchar(400) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_question_branch1_idx` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_result`
--

DROP TABLE IF EXISTS `mipt_result`;
CREATE TABLE IF NOT EXISTS `mipt_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` timestamp NULL DEFAULT NULL,
  `answered` int(4) DEFAULT '0',
  `answered_right` int(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_test_result_user1_idx` (`user_id`),
  KEY `fk_mipt_test_result_mipt_test1_idx` (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_test`
--

DROP TABLE IF EXISTS `mipt_test`;
CREATE TABLE IF NOT EXISTS `mipt_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_count` int(4) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_test_branch1_idx` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mipt_user`
--

DROP TABLE IF EXISTS `mipt_user`;
CREATE TABLE IF NOT EXISTS `mipt_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_group_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `mipt_answer`
--
ALTER TABLE `mipt_answer`
  ADD CONSTRAINT `fk_mipt_result_mipt_question1` FOREIGN KEY (`question_id`) REFERENCES `mipt_question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_result_test_result1` FOREIGN KEY (`result_id`) REFERENCES `mipt_result` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `mipt_group`
--
ALTER TABLE `mipt_group`
  ADD CONSTRAINT `fk_group_institute1` FOREIGN KEY (`institute_id`) REFERENCES `mipt_institute` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `mipt_group_test`
--
ALTER TABLE `mipt_group_test`
  ADD CONSTRAINT `fk_group_test_group1` FOREIGN KEY (`group_id`) REFERENCES `mipt_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_group_test_test1` FOREIGN KEY (`test_id`) REFERENCES `mipt_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `mipt_question`
--
ALTER TABLE `mipt_question`
  ADD CONSTRAINT `fk_question_branch1` FOREIGN KEY (`branch_id`) REFERENCES `mipt_branch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `mipt_result`
--
ALTER TABLE `mipt_result`
  ADD CONSTRAINT `fk_test_result_test1` FOREIGN KEY (`test_id`) REFERENCES `mipt_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_test_result_user1` FOREIGN KEY (`user_id`) REFERENCES `mipt_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `mipt_test`
--
ALTER TABLE `mipt_test`
  ADD CONSTRAINT `fk_test_branch1` FOREIGN KEY (`branch_id`) REFERENCES `mipt_branch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `mipt_user`
--
ALTER TABLE `mipt_user`
  ADD CONSTRAINT `fk_user_group` FOREIGN KEY (`group_id`) REFERENCES `mipt_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- База данных: `mipt_stable`
--
CREATE DATABASE `mipt_stable` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mipt_stable`;

-- --------------------------------------------------------

--
-- Структура таблицы `application_schedule`
--

DROP TABLE IF EXISTS `application_schedule`;
CREATE TABLE IF NOT EXISTS `application_schedule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DAY_OF_WEEK` int(1) NOT NULL,
  `EMPLOYEE_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

-- --------------------------------------------------------

--
-- Структура таблицы `cash_machines`
--

DROP TABLE IF EXISTS `cash_machines`;
CREATE TABLE IF NOT EXISTS `cash_machines` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS` varchar(256) DEFAULT NULL,
  `NEAREST_METRO_ST` varchar(128) DEFAULT NULL,
  `LOCATION` varchar(256) DEFAULT NULL,
  `WORK_HOURS` longtext,
  `CURRENCY` varchar(45) DEFAULT NULL,
  `MAP_IMG_PATH` varchar(512) DEFAULT NULL,
  `IMG_PATH` varchar(512) DEFAULT NULL,
  `MACHINE_TYPE` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LATITUDE` varchar(45) DEFAULT NULL,
  `CITY` varchar(256) NOT NULL DEFAULT 'Москва',
  `ORDER_NUMBER` int(10) unsigned NOT NULL DEFAULT '0',
  `LONGTITUDE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=136 ;

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(64) DEFAULT NULL,
  `DETECT_TYPE` tinyint(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Структура таблицы `client_employment`
--

DROP TABLE IF EXISTS `client_employment`;
CREATE TABLE IF NOT EXISTS `client_employment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EMPLOYMENT_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Структура таблицы `client_income_type`
--

DROP TABLE IF EXISTS `client_income_type`;
CREATE TABLE IF NOT EXISTS `client_income_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `INCOME_TYPE_NAME` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `consultation_settings`
--

DROP TABLE IF EXISTS `consultation_settings`;
CREATE TABLE IF NOT EXISTS `consultation_settings` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(10) unsigned NOT NULL DEFAULT '0',
  `filter_block` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_application`
--

DROP TABLE IF EXISTS `credit_application`;
CREATE TABLE IF NOT EXISTS `credit_application` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CLIENT_LAST_NAME` varchar(64) NOT NULL,
  `CLIENT_FIRST_NAME` varchar(32) NOT NULL,
  `CLIENT_MIDDLE_NAME` varchar(64) NOT NULL,
  `CLIENT_FULL_NAME` varchar(256) NOT NULL,
  `CLIENT_AGE` int(3) DEFAULT NULL,
  `CLIENT_EMPLOYMENT_TYPE_ID` int(11) DEFAULT NULL,
  `REGISTRATION_TYPE_ID` int(11) DEFAULT NULL,
  `TYPE_OF_INCOME` int(11) DEFAULT NULL,
  `MONTHLY_INCOME` double(15,2) DEFAULT NULL,
  `CLIENT_PHONE` varchar(128) NOT NULL,
  `CLIENT_EMAIL` varchar(128) DEFAULT NULL,
  `CREDIT_NAME_ID` int(11) DEFAULT NULL,
  `INITIAL_DEPOSIT` double(15,2) DEFAULT NULL,
  `TYPE_OF_OBJECT` int(11) DEFAULT NULL,
  `COST_OF_OBJECT` double(15,2) DEFAULT NULL,
  `SUM_OF_CREDIT` double(15,2) DEFAULT NULL,
  `CREDIT_PERIOD` int(11) DEFAULT NULL,
  `REGION_ID` int(11) DEFAULT NULL,
  `APPLICATION_EMPLOYER_ANSWER_ID` int(11) NOT NULL,
  `APPLICATION_STATUS_ID` int(11) NOT NULL,
  `APPLICATION_CREATE_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `APPLICATION_ANSWER_DATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `COMMENT` varchar(1024) DEFAULT NULL,
  `FLAT_ID` int(11) NOT NULL DEFAULT '0',
  `OFFICE_ID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=270 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_application_status`
--

DROP TABLE IF EXISTS `credit_application_status`;
CREATE TABLE IF NOT EXISTS `credit_application_status` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STATUS_NAME` varchar(64) NOT NULL,
  `WRITE_DETAILS` int(1) NOT NULL DEFAULT '0',
  KEY `ID` (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_object`
--

DROP TABLE IF EXISTS `credit_object`;
CREATE TABLE IF NOT EXISTS `credit_object` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREDIT_OBJECT_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_period`
--

DROP TABLE IF EXISTS `credit_period`;
CREATE TABLE IF NOT EXISTS `credit_period` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VALUE` int(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credits`
--

DROP TABLE IF EXISTS `credits`;
CREATE TABLE IF NOT EXISTS `credits` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREDIT_NAME` varchar(64) DEFAULT NULL,
  `FORMULA` varchar(512) DEFAULT NULL,
  `CURRENCY` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit`
--

DROP TABLE IF EXISTS `deposit`;
CREATE TABLE IF NOT EXISTS `deposit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DEPOSIT_ID` int(11) DEFAULT NULL,
  `CURRENCY` varchar(3) DEFAULT NULL,
  `PERIOD_MIN` int(5) DEFAULT NULL,
  `PERIOD_MAX` int(5) DEFAULT NULL,
  `SUM_MIN` double(14,2) DEFAULT NULL,
  `SUM_MAX` double(14,2) DEFAULT NULL,
  `PERCENT` double(6,2) DEFAULT NULL,
  `EFF_PERCENT` double(6,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=266 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit_courses`
--

DROP TABLE IF EXISTS `deposit_courses`;
CREATE TABLE IF NOT EXISTS `deposit_courses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RUBUSD` double(14,2) DEFAULT NULL,
  `RUBEUR` double(14,2) DEFAULT NULL,
  `DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=33 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit_description`
--

DROP TABLE IF EXISTS `deposit_description`;
CREATE TABLE IF NOT EXISTS `deposit_description` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) DEFAULT NULL,
  `DESCRIPTION` varchar(4096) DEFAULT NULL,
  `CHARGE_TYPE` varchar(10) DEFAULT 'at_the_end',
  `PARTIAL_WITHDRAWAL` varchar(10) DEFAULT 'notallowed',
  `IS_ARCHIVE` varchar(10) DEFAULT 'notarchive',
  `IS_SINGLE` varchar(10) DEFAULT 'single',
  `IS_MULTI` varchar(10) DEFAULT 'notmulti',
  `GEO_ID` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit_recipes`
--

DROP TABLE IF EXISTS `deposit_recipes`;
CREATE TABLE IF NOT EXISTS `deposit_recipes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USD` double(14,2) DEFAULT NULL,
  `EUR` double(14,2) DEFAULT NULL,
  `DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=98 ;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_data_permissions`
--

DROP TABLE IF EXISTS `dyn_data_permissions`;
CREATE TABLE IF NOT EXISTS `dyn_data_permissions` (
  `USER_ID` int(11) NOT NULL,
  `TYPE_ID` varchar(20) DEFAULT NULL,
  KEY `fk_DYN_DATA_PERMISSIONS_USER1` (`USER_ID`),
  KEY `fk_DYN_DATA_PERMISSIONS_DYN_DATA_TYPES1` (`TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_data_types`
--

DROP TABLE IF EXISTS `dyn_data_types`;
CREATE TABLE IF NOT EXISTS `dyn_data_types` (
  `ID` varchar(64) NOT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `files`
--

DROP TABLE IF EXISTS `files`;
CREATE TABLE IF NOT EXISTS `files` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GROUP_ID` int(11) NOT NULL,
  `SORT` int(11) NOT NULL,
  `FILENAME` varchar(512) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=837 ;

-- --------------------------------------------------------

--
-- Структура таблицы `files_all`
--

DROP TABLE IF EXISTS `files_all`;
CREATE TABLE IF NOT EXISTS `files_all` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) DEFAULT NULL,
  `COMMENT` varchar(512) DEFAULT NULL,
  `FILENAME` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=822 ;

-- --------------------------------------------------------

--
-- Структура таблицы `files_groups`
--

DROP TABLE IF EXISTS `files_groups`;
CREATE TABLE IF NOT EXISTS `files_groups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=481 ;

-- --------------------------------------------------------

--
-- Структура таблицы `flat`
--

DROP TABLE IF EXISTS `flat`;
CREATE TABLE IF NOT EXISTS `flat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS` varchar(1024) DEFAULT NULL,
  `ROOMS` int(3) DEFAULT NULL,
  `YARDAGE` int(3) DEFAULT NULL,
  `PRICE` double(15,2) DEFAULT NULL,
  `CITY_ID` int(11) NOT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '1',
  `X` double(8,6) NOT NULL DEFAULT '0.000000',
  `Y` double(8,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- Структура таблицы `geoip_blocks`
--

DROP TABLE IF EXISTS `geoip_blocks`;
CREATE TABLE IF NOT EXISTS `geoip_blocks` (
  `START` int(11) unsigned DEFAULT NULL,
  `END` int(11) unsigned DEFAULT NULL,
  `LOC_ID` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `geoip_locations`
--

DROP TABLE IF EXISTS `geoip_locations`;
CREATE TABLE IF NOT EXISTS `geoip_locations` (
  `LOC_ID` int(11) unsigned DEFAULT NULL,
  `COUNTRY` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `REGION` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `CITY` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `POSTAL_CODE` varchar(6) COLLATE utf8_bin DEFAULT NULL,
  `LATITUDE` decimal(10,0) unsigned DEFAULT NULL,
  `LONGITUDE` decimal(10,0) unsigned DEFAULT NULL,
  `METRO_CODE` int(10) unsigned DEFAULT NULL,
  `AREA_CODE` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `geoip_relations`
--

DROP TABLE IF EXISTS `geoip_relations`;
CREATE TABLE IF NOT EXISTS `geoip_relations` (
  `CITY_ID` int(11) DEFAULT NULL,
  `LOC_ID` int(11) DEFAULT NULL,
  `REGION_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `initial_deposit`
--

DROP TABLE IF EXISTS `initial_deposit`;
CREATE TABLE IF NOT EXISTS `initial_deposit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PERCENT` int(3) NOT NULL,
  KEY `ID` (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `key_fields`
--

DROP TABLE IF EXISTS `key_fields`;
CREATE TABLE IF NOT EXISTS `key_fields` (
  `SECTION_ID` int(10) unsigned NOT NULL,
  `FIELD_ID` int(10) unsigned NOT NULL,
  `IS_OBLIGATORY` tinyint(1) unsigned NOT NULL,
  `FIELD_ORDER` tinyint(3) unsigned NOT NULL,
  `IS_REG` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`SECTION_ID`,`FIELD_ID`),
  KEY `FK_key_fields_2` (`FIELD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `key_sections`
--

DROP TABLE IF EXISTS `key_sections`;
CREATE TABLE IF NOT EXISTS `key_sections` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `KEY_ID` int(10) unsigned NOT NULL,
  `SECTION_NAME` varchar(128) DEFAULT NULL,
  `SECTION_ORDER` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_key_sections_1` (`KEY_ID`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=168 ;

-- --------------------------------------------------------

--
-- Структура таблицы `lists`
--

DROP TABLE IF EXISTS `lists`;
CREATE TABLE IF NOT EXISTS `lists` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GID` int(11) NOT NULL,
  `ORDER` int(11) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `CONTENT` longtext NOT NULL,
  PRIMARY KEY (`ID`,`ORDER`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=123 ;

-- --------------------------------------------------------

--
-- Структура таблицы `metro`
--

DROP TABLE IF EXISTS `metro`;
CREATE TABLE IF NOT EXISTS `metro` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_ID` int(11) NOT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

-- --------------------------------------------------------

--
-- Структура таблицы `metro_has_flat`
--

DROP TABLE IF EXISTS `metro_has_flat`;
CREATE TABLE IF NOT EXISTS `metro_has_flat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `METRO_ID` int(11) NOT NULL,
  `FLAT_ID` int(11) NOT NULL,
  PRIMARY KEY (`METRO_ID`,`FLAT_ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `fk_metro_has_flat_flat1` (`FLAT_ID`),
  KEY `fk_metro_has_flat_metro1` (`METRO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `modal_window`
--

DROP TABLE IF EXISTS `modal_window`;
CREATE TABLE IF NOT EXISTS `modal_window` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL,
  `order` tinyint(4) NOT NULL,
  `content` longtext NOT NULL,
  `label` char(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

--
-- Структура таблицы `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MODULE_NAME` varchar(45) NOT NULL,
  `MODULE_KEY` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE_ID` int(11) DEFAULT NULL,
  `TITLE` varchar(512) NOT NULL,
  `DATE` datetime NOT NULL,
  `FULL_TEXT` longtext NOT NULL,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  `LASTCHANGED` datetime NOT NULL,
  `changeuserid` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_NEWS_DYN_DATA_TYPES1` (`TYPE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=285 ;

-- --------------------------------------------------------

--
-- Структура таблицы `office`
--

DROP TABLE IF EXISTS `office`;
CREATE TABLE IF NOT EXISTS `office` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `CITY` varchar(512) NOT NULL,
  `ADDRESS` varchar(256) DEFAULT NULL,
  `PHONE_NUMBER` varchar(128) DEFAULT NULL,
  `WORK_HOURS` varchar(512) DEFAULT NULL,
  `LATITUDE` varchar(45) DEFAULT NULL,
  `LONGTITUDE` varchar(45) DEFAULT NULL,
  `FAX` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `MAP_IMG_PATH` varchar(512) DEFAULT NULL,
  `ADDITIONAL_INFO` text,
  `IS_MAIN` tinyint(4) DEFAULT '0',
  `ORDER_NUMBER` int(10) unsigned NOT NULL DEFAULT '0',
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=70 ;

-- --------------------------------------------------------

--
-- Структура таблицы `office_service_permissions`
--

DROP TABLE IF EXISTS `office_service_permissions`;
CREATE TABLE IF NOT EXISTS `office_service_permissions` (
  `USER_ID` int(11) NOT NULL,
  `OFFICE_ID` int(11) NOT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  KEY `fk_OFFICE_SERVICE_PERMISSION_USER1` (`USER_ID`),
  KEY `fk_OFFICE_SERVICE_PERMISSION_OFFICE1` (`OFFICE_ID`),
  KEY `fk_OFFICE_SERVICE_PERMISSION_SERVICE1` (`SERVICE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `options`
--

DROP TABLE IF EXISTS `options`;
CREATE TABLE IF NOT EXISTS `options` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEY` varchar(45) NOT NULL,
  `VALUE` text,
  `SNIPPET` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `key` (`KEY`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Структура таблицы `page_permissions`
--

DROP TABLE IF EXISTS `page_permissions`;
CREATE TABLE IF NOT EXISTS `page_permissions` (
  `USER_ID` int(11) NOT NULL,
  `PAGE_ID` int(11) NOT NULL,
  KEY `fk_USER_PERMISSION_USER1` (`USER_ID`),
  KEY `fk_USER_PERMISSION_SITE_PAGE1` (`PAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `page_widget`
--

DROP TABLE IF EXISTS `page_widget`;
CREATE TABLE IF NOT EXISTS `page_widget` (
  `PAGE_ID` int(11) NOT NULL,
  `WIDGET_ID` char(20) NOT NULL,
  KEY `fk_PAGE_WIDGET_SITE_PAGE1` (`PAGE_ID`),
  KEY `fk_PAGE_WIDGET_SITE_WIDGET1` (`WIDGET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `partner`
--

DROP TABLE IF EXISTS `partner`;
CREATE TABLE IF NOT EXISTS `partner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE` int(11) DEFAULT NULL,
  `COMPANY_NAME` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `LOGO_SRC` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `PHONE` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `ADDRESS` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `CONTACT_PERSON` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `WORK_TIME` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `HREF` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

-- --------------------------------------------------------

--
-- Структура таблицы `partner_type`
--

DROP TABLE IF EXISTS `partner_type`;
CREATE TABLE IF NOT EXISTS `partner_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SINGULAR_NAME` varchar(32) NOT NULL,
  `PLURAL_NAME` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура таблицы `permission_request`
--

DROP TABLE IF EXISTS `permission_request`;
CREATE TABLE IF NOT EXISTS `permission_request` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `DATE` datetime DEFAULT NULL,
  `DETAILS` longtext,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `EMAIL` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PERMISSION_REQUEST_USER1` (`USER_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Структура таблицы `permission_type`
--

DROP TABLE IF EXISTS `permission_type`;
CREATE TABLE IF NOT EXISTS `permission_type` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `photos`
--

DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OFFICE_ID` int(11) NOT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `ALT_TEXT` varchar(256) DEFAULT NULL,
  `IMG_PATH` varchar(512) DEFAULT NULL,
  `DEFAULT` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `fk_PHOTOS_OFFICE1` (`OFFICE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=138 ;

-- --------------------------------------------------------

--
-- Структура таблицы `purchase_request`
--

DROP TABLE IF EXISTS `purchase_request`;
CREATE TABLE IF NOT EXISTS `purchase_request` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEY_ID` int(10) unsigned NOT NULL,
  `USER_ID` int(10) unsigned NOT NULL,
  `AGENT_CODE_REFERER` int(10) unsigned DEFAULT NULL,
  `REQUEST_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `GEO_ID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_purchase_request_1` (`KEY_ID`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1981 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `QUESTION` mediumtext,
  `QUESTION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PID` int(10) unsigned DEFAULT '0',
  `SUB_ORDER` int(10) unsigned DEFAULT '0',
  `PATH` varchar(128) DEFAULT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  `THEME_ID` int(11) DEFAULT NULL,
  `STATUS_ID` int(11) DEFAULT NULL,
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2389 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions_old`
--

DROP TABLE IF EXISTS `questions_old`;
CREATE TABLE IF NOT EXISTS `questions_old` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `QUESTION` mediumtext,
  `QUESTION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PID` int(10) unsigned DEFAULT '0',
  `SUB_ORDER` int(10) unsigned DEFAULT '0',
  `PATH` varchar(128) DEFAULT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  `THEME_ID` int(11) DEFAULT NULL,
  `STATUS_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1829 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions_status`
--

DROP TABLE IF EXISTS `questions_status`;
CREATE TABLE IF NOT EXISTS `questions_status` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `SORTING` int(11) NOT NULL DEFAULT '0',
  `AUTO_SELECT` int(1) NOT NULL DEFAULT '0',
  `NAME` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions_title`
--

DROP TABLE IF EXISTS `questions_title`;
CREATE TABLE IF NOT EXISTS `questions_title` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SORTING` int(10) NOT NULL DEFAULT '0',
  `NAME` varchar(64) NOT NULL DEFAULT '0',
  `HIDE` int(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `REGION_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

-- --------------------------------------------------------

--
-- Структура таблицы `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE IF NOT EXISTS `registration` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `REGISTRATION_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `request_fields`
--

DROP TABLE IF EXISTS `request_fields`;
CREATE TABLE IF NOT EXISTS `request_fields` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(45) NOT NULL,
  `CAPTION` varchar(256) DEFAULT NULL,
  `SMALL_CAPTION` varchar(256) DEFAULT NULL,
  `VALID_PATTERN` varchar(256) DEFAULT NULL,
  `INVALID_PATTERN` varchar(256) DEFAULT NULL,
  `ATTRIBUTES` varchar(256) DEFAULT NULL,
  `DATA` text,
  `ALIAS` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=218 ;

-- --------------------------------------------------------

--
-- Структура таблицы `request_keys`
--

DROP TABLE IF EXISTS `request_keys`;
CREATE TABLE IF NOT EXISTS `request_keys` (
  `ID` int(10) unsigned NOT NULL,
  `KEY_TYPE` char(1) NOT NULL,
  `KEY_NAME` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `request_values`
--

DROP TABLE IF EXISTS `request_values`;
CREATE TABLE IF NOT EXISTS `request_values` (
  `REQUEST_ID` int(10) unsigned NOT NULL,
  `FIELD_ID` int(10) unsigned NOT NULL,
  `FIELD_VALUE` varchar(512) DEFAULT NULL,
  `SECTION_ID` int(10) unsigned NOT NULL,
  `FIELD_ALIAS` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`REQUEST_ID`,`FIELD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PAGE_ID` (`PAGE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1017 ;

-- --------------------------------------------------------

--
-- Структура таблицы `service_rate`
--

DROP TABLE IF EXISTS `service_rate`;
CREATE TABLE IF NOT EXISTS `service_rate` (
  `RATE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `OFFICE_ID` int(11) NOT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  `NAME` varchar(512) DEFAULT NULL,
  `DATA` longblob,
  `SOURCE` varchar(10) DEFAULT 'DB',
  `URL_ADDRESS` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`RATE_ID`),
  KEY `fk_SERVICE_RATE_OFFICE1` (`OFFICE_ID`),
  KEY `fk_SERVICE_RATE_SERVICE1` (`SERVICE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=452 ;

-- --------------------------------------------------------

--
-- Структура таблицы `shareholder_widget`
--

DROP TABLE IF EXISTS `shareholder_widget`;
CREATE TABLE IF NOT EXISTS `shareholder_widget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(256) DEFAULT NULL,
  `PERCENT` float(5,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=98 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_banner`
--

DROP TABLE IF EXISTS `site_banner`;
CREATE TABLE IF NOT EXISTS `site_banner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FILE` varchar(512) NOT NULL,
  `TITLE` varchar(225) NOT NULL,
  `URL` varchar(512) NOT NULL,
  `TYPE` char(1) NOT NULL,
  `EXTERNAL` tinyint(1) NOT NULL,
  `HTML` longtext,
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=184 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_banner_assignments`
--

DROP TABLE IF EXISTS `site_banner_assignments`;
CREATE TABLE IF NOT EXISTS `site_banner_assignments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAGE_ID` int(11) NOT NULL,
  `BANNER_ID` int(11) DEFAULT NULL,
  `ZONE_KEY` varchar(10) DEFAULT NULL,
  `ORDER` mediumint(9) DEFAULT NULL,
  `DURATION` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BANNER_ID` (`BANNER_ID`),
  KEY `PAGE_ID` (`PAGE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=641 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_menu`
--

DROP TABLE IF EXISTS `site_menu`;
CREATE TABLE IF NOT EXISTS `site_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARENT_ID` int(11) NOT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  `MENU_ID` tinyint(1) DEFAULT NULL,
  `GEO_ID` int(11) unsigned NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `ORDER` int(11) NOT NULL DEFAULT '0',
  `MENU_IMG_PATH` varchar(512) DEFAULT NULL,
  `MENU_SMALL_IMG_PATH` varchar(512) DEFAULT NULL,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  `CUSTOM_URL` varchar(256) DEFAULT NULL,
  `EDITABLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `fk_SITE_MENU_SITE_PAGE1` (`PAGE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=94 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_page`
--

DROP TABLE IF EXISTS `site_page`;
CREATE TABLE IF NOT EXISTS `site_page` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEMPLATE_ID` int(11) NOT NULL,
  `MODULE_ID` int(11) DEFAULT NULL,
  `PARENT` int(11) NOT NULL,
  `GEO_ID` int(11) unsigned NOT NULL,
  `KEY` varchar(45) DEFAULT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `ALIAS` varchar(256) DEFAULT NULL,
  `PAGE_CODE` longtext,
  `META_KEYWORDS` varchar(255) DEFAULT NULL,
  `META_DESCRIPTION` varchar(512) DEFAULT NULL,
  `META_TITLE` varchar(256) DEFAULT NULL,
  `HEADER_CLASSNAME` varchar(255) DEFAULT NULL,
  `HEADER_SHOW_NEWS` tinyint(4) DEFAULT NULL,
  `HEADER_TEXT` text,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  `CREATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_SITE_PAGE_SITE_TEMPLATE1` (`TEMPLATE_ID`),
  KEY `fk_SITE_PAGE_MODULES1` (`MODULE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=185 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_region`
--

DROP TABLE IF EXISTS `site_region`;
CREATE TABLE IF NOT EXISTS `site_region` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DOMAIN_NAME` varchar(128) DEFAULT NULL,
  `NAME` varchar(256) DEFAULT NULL,
  `ENABLE` varchar(10) DEFAULT 'disable',
  `CITY` int(11) unsigned NOT NULL,
  `OFFICE_NAME` varchar(100) DEFAULT NULL,
  `OFFICE_ADDRESS` varchar(300) DEFAULT NULL,
  `OFFICE_PHONE` varchar(20) DEFAULT NULL,
  `OFFICE_EMAIL` varchar(50) DEFAULT NULL,
  `OFFICE_FAX` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `DOMAIN_NAME` (`DOMAIN_NAME`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_region_rus_translit`
--

DROP TABLE IF EXISTS `site_region_rus_translit`;
CREATE TABLE IF NOT EXISTS `site_region_rus_translit` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `REG_ID` int(11) unsigned DEFAULT NULL,
  `SYS_NAME` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `REG_ID` (`REG_ID`),
  KEY `SYS_NAME` (`SYS_NAME`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_template`
--

DROP TABLE IF EXISTS `site_template`;
CREATE TABLE IF NOT EXISTS `site_template` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEMPLATE_FILE` varchar(90) NOT NULL,
  `TEMPLATE_NAME` varchar(90) NOT NULL,
  `ARCHIVED` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_users`
--

DROP TABLE IF EXISTS `site_users`;
CREATE TABLE IF NOT EXISTS `site_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_TYPE` char(1) NOT NULL,
  `AGENT` tinyint(1) NOT NULL DEFAULT '0',
  `AGENT_CODE` smallint(4) NOT NULL DEFAULT '0',
  `P_SEX` char(1) DEFAULT NULL,
  `LIKE_OFFICE_ID` int(10) unsigned DEFAULT NULL,
  `P_BIRTH_DATE` date DEFAULT NULL,
  `P_PASSPORT_DATE` date DEFAULT NULL,
  `B_REGISTRATION_DATE` date DEFAULT NULL,
  `B_ACTIVITIES_DATE` date DEFAULT NULL,
  `EMAIL` varchar(128) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `P_FIRST_NAME` varchar(32) DEFAULT NULL,
  `P_MIDDLE_NAME` varchar(64) DEFAULT NULL,
  `P_LAST_NAME` varchar(64) DEFAULT NULL,
  `P_PHONE_NUMBER_1_WT` varchar(64) DEFAULT NULL,
  `P_PHONE_NUMBER_2_WT` varchar(64) DEFAULT NULL,
  `P_MOBILE_NUMBER_WT` varchar(64) DEFAULT NULL,
  `P_SMS_NUMBER` varchar(24) DEFAULT NULL,
  `P_BIRTH_PLACE` varchar(128) DEFAULT NULL,
  `P_CITIZENSHIP` varchar(32) DEFAULT NULL,
  `P_PASSPORT_SERIES` varchar(10) DEFAULT NULL,
  `P_PASSPORT_NUMBER` varchar(10) DEFAULT NULL,
  `P_PASSPORT_WHOM` varchar(128) DEFAULT NULL,
  `P_PASSPORT_CODE` varchar(10) DEFAULT NULL,
  `P_LEGAL_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_LEGAL_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_LEGAL_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_LEGAL_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_LEGAL_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_LEGAL_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_LEGAL_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_LEGAL_ADDRESS_FLAT` varchar(4) DEFAULT NULL,
  `P_POST_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_POST_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_POST_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_POST_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_POST_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_POST_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_POST_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_POST_ADDRESS_FLAT` varchar(4) DEFAULT NULL,
  `P_JOB_ORGANIZATION` varchar(128) DEFAULT NULL,
  `P_JOB_POST_NAME` varchar(128) DEFAULT NULL,
  `P_JOB_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_JOB_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_JOB_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_JOB_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_JOB_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_JOB_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_JOB_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_JOB_ADDRESS_OFFICE` varchar(16) DEFAULT NULL,
  `P_JOB_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `P_STUDY_NAME` varchar(128) DEFAULT NULL,
  `P_STUDY_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_STUDY_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_STUDY_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_STUDY_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_STUDY_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_STUDY_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_STUDY_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_STUDY_FACULTY` varchar(64) DEFAULT NULL,
  `P_STUDY_SPECIALITY` varchar(64) DEFAULT NULL,
  `P_STUDY_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `B_COMPANY_NAME` varchar(256) DEFAULT NULL,
  `B_REGISTRATION_AREA` varchar(256) DEFAULT NULL,
  `B_REGISTRATION_NUMBER` varchar(13) DEFAULT NULL,
  `B_INN` varchar(12) DEFAULT NULL,
  `B_KPP` varchar(9) DEFAULT NULL,
  `B_STAT_CODE` varchar(128) DEFAULT NULL,
  `B_ACTIVITIES` varchar(512) DEFAULT NULL,
  `B_BANK` varchar(256) DEFAULT NULL,
  `B_BIK` varchar(9) DEFAULT NULL,
  `B_SETT_ACCOUNT` varchar(20) DEFAULT NULL,
  `B_CORR_ACCOUNT` varchar(20) DEFAULT NULL,
  `B_BOSS_POST_NAME` varchar(128) DEFAULT NULL,
  `B_BOSS_FIRST_NAME` varchar(32) DEFAULT NULL,
  `B_BOSS_MIDDLE_NAME` varchar(64) DEFAULT NULL,
  `B_BOSS_LAST_NAME` varchar(64) DEFAULT NULL,
  `B_BOSS_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `B_BOSS_FAX` varchar(12) DEFAULT NULL,
  `B_BOSS_EMAIL` varchar(128) DEFAULT NULL,
  `B_CONTACT_POST_NAME` varchar(128) DEFAULT NULL,
  `B_CONTACT_FIRST_NAME` varchar(32) DEFAULT NULL,
  `B_CONTACT_MIDDLE_NAME` varchar(64) DEFAULT NULL,
  `B_CONTACT_LAST_NAME` varchar(64) DEFAULT NULL,
  `B_CONTACT_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `B_CONTACT_FAX` varchar(12) DEFAULT NULL,
  `B_CONTACT_EMAIL` varchar(128) DEFAULT NULL,
  `B_LEGAL_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `B_LEGAL_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `B_LEGAL_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `B_LEGAL_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `B_LEGAL_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `B_LEGAL_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `B_LEGAL_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `B_LEGAL_ADDRESS_OFFICE` varchar(16) DEFAULT NULL,
  `B_POST_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `B_POST_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `B_POST_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `B_POST_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `B_POST_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `B_POST_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `B_POST_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `B_POST_ADDRESS_OFFICE` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`EMAIL`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1701 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) DEFAULT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `ROLE` char(1) NOT NULL,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `BLOCKED` tinyint(1) NOT NULL DEFAULT '0',
  `GEO_ADMIN` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=65 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user_offers`
--

DROP TABLE IF EXISTS `user_offers`;
CREATE TABLE IF NOT EXISTS `user_offers` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(256) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `NAME` varchar(128) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `PHONE_NUMBER` varchar(64) DEFAULT NULL,
  `ADDRESS` varchar(512) DEFAULT NULL,
  `RECEIVED_ON` datetime NOT NULL,
  `HIDDEN` tinyint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12864 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user_relation`
--

DROP TABLE IF EXISTS `user_relation`;
CREATE TABLE IF NOT EXISTS `user_relation` (
  `USER_ID` int(11) unsigned NOT NULL,
  `GEO_ID` int(11) unsigned NOT NULL,
  UNIQUE KEY `USER_ID` (`USER_ID`,`GEO_ID`),
  KEY `GEO_ID` (`GEO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `vacancy`
--

DROP TABLE IF EXISTS `vacancy`;
CREATE TABLE IF NOT EXISTS `vacancy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(10) DEFAULT '-',
  `CITY` varchar(256) DEFAULT NULL,
  `TITLE` varchar(128) DEFAULT NULL,
  `REQUIREMENTS` longtext,
  `FUNCTIONS` longtext,
  `CREDENTIALS` varchar(256) DEFAULT NULL,
  `SALARY` varchar(256) DEFAULT NULL,
  `WORK_PLACE` varchar(256) DEFAULT NULL,
  `SOCPACK` varchar(256) DEFAULT NULL,
  `ADDRESS` varchar(256) DEFAULT NULL,
  `PHONE_NUMBER` varchar(128) DEFAULT NULL,
  `FAX` varchar(128) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `CLOSED_ON` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=117 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vacancy_applicant`
--

DROP TABLE IF EXISTS `vacancy_applicant`;
CREATE TABLE IF NOT EXISTS `vacancy_applicant` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `POSITION` varchar(256) DEFAULT NULL,
  `FIRST_NAME` varchar(128) DEFAULT NULL,
  `MIDDLE_NAME` varchar(128) DEFAULT NULL,
  `LAST_NAME` varchar(128) DEFAULT NULL,
  `SEX` char(1) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `BIRTH_DATE` datetime DEFAULT NULL,
  `PHONE_NUMBER` varchar(128) DEFAULT NULL,
  `CITIZENSHIP` varchar(128) DEFAULT NULL,
  `RESIDENCE` varchar(256) DEFAULT NULL,
  `PREVJOB` longtext,
  `EDUCATION` longtext,
  `SKILLS` longtext,
  `RESUME_FILE` varchar(512) DEFAULT NULL,
  `NOTES` longtext,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4105 ;

-- --------------------------------------------------------

--
-- Структура таблицы `work_experience`
--

DROP TABLE IF EXISTS `work_experience`;
CREATE TABLE IF NOT EXISTS `work_experience` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `APPLICANT_ID` int(11) NOT NULL,
  `COMPANY_NAME` varchar(128) DEFAULT NULL,
  `POSITION` varchar(128) DEFAULT NULL,
  `DETAILS` longtext,
  PRIMARY KEY (`ID`),
  KEY `fk_WORK_EXPERIENCE_VACANCY_APPLICANT1` (`APPLICANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_field_types`
--

DROP TABLE IF EXISTS `yandex_xml_field_types`;
CREATE TABLE IF NOT EXISTS `yandex_xml_field_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `type` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_field_values`
--

DROP TABLE IF EXISTS `yandex_xml_field_values`;
CREATE TABLE IF NOT EXISTS `yandex_xml_field_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `label` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_fields`
--

DROP TABLE IF EXISTS `yandex_xml_fields`;
CREATE TABLE IF NOT EXISTS `yandex_xml_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `name` tinytext NOT NULL,
  `label` tinytext NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `values` tinytext NOT NULL,
  `description` longtext NOT NULL,
  `required` tinyint(4) NOT NULL,
  `required_if` tinytext NOT NULL,
  `multiple` tinyint(4) NOT NULL,
  `branch` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=170 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_save`
--

DROP TABLE IF EXISTS `yandex_xml_save`;
CREATE TABLE IF NOT EXISTS `yandex_xml_save` (
  `name` text NOT NULL,
  `value` text NOT NULL,
  `array` tinyint(4) NOT NULL DEFAULT '0',
  `key` tinytext NOT NULL,
  `class` tinytext NOT NULL,
  `multiple` tinyint(4) NOT NULL DEFAULT '0',
  `multiple_key` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `dyn_data_permissions`
--
ALTER TABLE `dyn_data_permissions`
  ADD CONSTRAINT `fk_DYN_DATA_PERMISSIONS_USER1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `key_fields`
--
ALTER TABLE `key_fields`
  ADD CONSTRAINT `FK_key_fields_1` FOREIGN KEY (`SECTION_ID`) REFERENCES `key_sections` (`ID`),
  ADD CONSTRAINT `FK_key_fields_2` FOREIGN KEY (`FIELD_ID`) REFERENCES `request_fields` (`ID`);

--
-- Ограничения внешнего ключа таблицы `key_sections`
--
ALTER TABLE `key_sections`
  ADD CONSTRAINT `FK_key_sections_1` FOREIGN KEY (`KEY_ID`) REFERENCES `request_keys` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `metro_has_flat`
--
ALTER TABLE `metro_has_flat`
  ADD CONSTRAINT `fk_metro_has_flat_flat1` FOREIGN KEY (`FLAT_ID`) REFERENCES `flat` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_metro_has_flat_metro1` FOREIGN KEY (`METRO_ID`) REFERENCES `metro` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `office_service_permissions`
--
ALTER TABLE `office_service_permissions`
  ADD CONSTRAINT `fk_OFFICE_SERVICE_PERMISSION_OFFICE1` FOREIGN KEY (`OFFICE_ID`) REFERENCES `office` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_OFFICE_SERVICE_PERMISSION_SERVICE1` FOREIGN KEY (`SERVICE_ID`) REFERENCES `service` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_OFFICE_SERVICE_PERMISSION_USER1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `page_permissions`
--
ALTER TABLE `page_permissions`
  ADD CONSTRAINT `fk_USER_PERMISSION_SITE_PAGE1` FOREIGN KEY (`PAGE_ID`) REFERENCES `site_page` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_USER_PERMISSION_USER1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `page_widget`
--
ALTER TABLE `page_widget`
  ADD CONSTRAINT `fk_PAGE_WIDGET_SITE_PAGE1` FOREIGN KEY (`PAGE_ID`) REFERENCES `site_page` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `permission_request`
--
ALTER TABLE `permission_request`
  ADD CONSTRAINT `fk_PERMISSION_REQUEST_USER1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `photos`
--
ALTER TABLE `photos`
  ADD CONSTRAINT `fk_PHOTOS_OFFICE1` FOREIGN KEY (`OFFICE_ID`) REFERENCES `office` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `purchase_request`
--
ALTER TABLE `purchase_request`
  ADD CONSTRAINT `FK_purchase_request_1` FOREIGN KEY (`KEY_ID`) REFERENCES `request_keys` (`ID`);

--
-- Ограничения внешнего ключа таблицы `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_fk1` FOREIGN KEY (`PAGE_ID`) REFERENCES `site_page` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `service_rate`
--
ALTER TABLE `service_rate`
  ADD CONSTRAINT `fk_SERVICE_RATE_OFFICE1` FOREIGN KEY (`OFFICE_ID`) REFERENCES `office` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SERVICE_RATE_SERVICE1` FOREIGN KEY (`SERVICE_ID`) REFERENCES `service` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `site_banner_assignments`
--
ALTER TABLE `site_banner_assignments`
  ADD CONSTRAINT `site_banner_assignments_fk` FOREIGN KEY (`BANNER_ID`) REFERENCES `site_banner` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `site_banner_assignments_fk1` FOREIGN KEY (`PAGE_ID`) REFERENCES `site_page` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `site_menu`
--
ALTER TABLE `site_menu`
  ADD CONSTRAINT `fk_SITE_MENU_SITE_PAGE1` FOREIGN KEY (`PAGE_ID`) REFERENCES `site_page` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `site_page`
--
ALTER TABLE `site_page`
  ADD CONSTRAINT `fk_SITE_PAGE_MODULES1` FOREIGN KEY (`MODULE_ID`) REFERENCES `modules` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SITE_PAGE_SITE_TEMPLATE1` FOREIGN KEY (`TEMPLATE_ID`) REFERENCES `site_template` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `work_experience`
--
ALTER TABLE `work_experience`
  ADD CONSTRAINT `fk_WORK_EXPERIENCE_VACANCY_APPLICANT1` FOREIGN KEY (`APPLICANT_ID`) REFERENCES `vacancy_applicant` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- База данных: `mipt_test`
--
CREATE DATABASE `mipt_test` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mipt_test`;

-- --------------------------------------------------------

--
-- Структура таблицы `application_schedule`
--

DROP TABLE IF EXISTS `application_schedule`;
CREATE TABLE IF NOT EXISTS `application_schedule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DAY_OF_WEEK` int(1) NOT NULL,
  `EMPLOYEE_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

-- --------------------------------------------------------

--
-- Структура таблицы `cash_machines`
--

DROP TABLE IF EXISTS `cash_machines`;
CREATE TABLE IF NOT EXISTS `cash_machines` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS` varchar(256) DEFAULT NULL,
  `NEAREST_METRO_ST` varchar(128) DEFAULT NULL,
  `LOCATION` varchar(256) DEFAULT NULL,
  `WORK_HOURS` longtext,
  `CURRENCY` varchar(45) DEFAULT NULL,
  `MAP_IMG_PATH` varchar(512) DEFAULT NULL,
  `IMG_PATH` varchar(512) DEFAULT NULL,
  `MACHINE_TYPE` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LATITUDE` varchar(45) DEFAULT NULL,
  `CITY` varchar(256) NOT NULL DEFAULT 'Москва',
  `ORDER_NUMBER` int(10) unsigned NOT NULL DEFAULT '0',
  `LONGTITUDE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=136 ;

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(64) DEFAULT NULL,
  `DETECT_TYPE` tinyint(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Структура таблицы `client_employment`
--

DROP TABLE IF EXISTS `client_employment`;
CREATE TABLE IF NOT EXISTS `client_employment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EMPLOYMENT_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Структура таблицы `client_income_type`
--

DROP TABLE IF EXISTS `client_income_type`;
CREATE TABLE IF NOT EXISTS `client_income_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `INCOME_TYPE_NAME` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `consultation_settings`
--

DROP TABLE IF EXISTS `consultation_settings`;
CREATE TABLE IF NOT EXISTS `consultation_settings` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(10) unsigned NOT NULL DEFAULT '0',
  `filter_block` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_application`
--

DROP TABLE IF EXISTS `credit_application`;
CREATE TABLE IF NOT EXISTS `credit_application` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CLIENT_LAST_NAME` varchar(64) NOT NULL,
  `CLIENT_FIRST_NAME` varchar(32) NOT NULL,
  `CLIENT_MIDDLE_NAME` varchar(64) NOT NULL,
  `CLIENT_FULL_NAME` varchar(256) NOT NULL,
  `CLIENT_AGE` int(3) DEFAULT NULL,
  `CLIENT_EMPLOYMENT_TYPE_ID` int(11) DEFAULT NULL,
  `REGISTRATION_TYPE_ID` int(11) DEFAULT NULL,
  `TYPE_OF_INCOME` int(11) DEFAULT NULL,
  `MONTHLY_INCOME` double(15,2) DEFAULT NULL,
  `CLIENT_PHONE` varchar(128) NOT NULL,
  `CLIENT_EMAIL` varchar(128) DEFAULT NULL,
  `CREDIT_NAME_ID` int(11) DEFAULT NULL,
  `INITIAL_DEPOSIT` double(15,2) DEFAULT NULL,
  `TYPE_OF_OBJECT` int(11) DEFAULT NULL,
  `COST_OF_OBJECT` double(15,2) DEFAULT NULL,
  `SUM_OF_CREDIT` double(15,2) DEFAULT NULL,
  `CREDIT_PERIOD` int(11) DEFAULT NULL,
  `REGION_ID` int(11) DEFAULT NULL,
  `APPLICATION_EMPLOYER_ANSWER_ID` int(11) NOT NULL,
  `APPLICATION_STATUS_ID` int(11) NOT NULL,
  `APPLICATION_CREATE_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `APPLICATION_ANSWER_DATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `COMMENT` varchar(1024) DEFAULT NULL,
  `FLAT_ID` int(11) NOT NULL DEFAULT '0',
  `OFFICE_ID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=270 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_application_status`
--

DROP TABLE IF EXISTS `credit_application_status`;
CREATE TABLE IF NOT EXISTS `credit_application_status` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STATUS_NAME` varchar(64) NOT NULL,
  `WRITE_DETAILS` int(1) NOT NULL DEFAULT '0',
  KEY `ID` (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_object`
--

DROP TABLE IF EXISTS `credit_object`;
CREATE TABLE IF NOT EXISTS `credit_object` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREDIT_OBJECT_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credit_period`
--

DROP TABLE IF EXISTS `credit_period`;
CREATE TABLE IF NOT EXISTS `credit_period` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VALUE` int(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Структура таблицы `credits`
--

DROP TABLE IF EXISTS `credits`;
CREATE TABLE IF NOT EXISTS `credits` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREDIT_NAME` varchar(64) DEFAULT NULL,
  `FORMULA` varchar(512) DEFAULT NULL,
  `CURRENCY` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit`
--

DROP TABLE IF EXISTS `deposit`;
CREATE TABLE IF NOT EXISTS `deposit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DEPOSIT_ID` int(11) DEFAULT NULL,
  `CURRENCY` varchar(3) DEFAULT NULL,
  `PERIOD_MIN` int(5) DEFAULT NULL,
  `PERIOD_MAX` int(5) DEFAULT NULL,
  `SUM_MIN` double(14,2) DEFAULT NULL,
  `SUM_MAX` double(14,2) DEFAULT NULL,
  `PERCENT` double(6,2) DEFAULT NULL,
  `EFF_PERCENT` double(6,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=266 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit_courses`
--

DROP TABLE IF EXISTS `deposit_courses`;
CREATE TABLE IF NOT EXISTS `deposit_courses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RUBUSD` double(14,2) DEFAULT NULL,
  `RUBEUR` double(14,2) DEFAULT NULL,
  `DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=33 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit_description`
--

DROP TABLE IF EXISTS `deposit_description`;
CREATE TABLE IF NOT EXISTS `deposit_description` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) DEFAULT NULL,
  `DESCRIPTION` varchar(4096) DEFAULT NULL,
  `CHARGE_TYPE` varchar(10) DEFAULT 'at_the_end',
  `PARTIAL_WITHDRAWAL` varchar(10) DEFAULT 'notallowed',
  `IS_ARCHIVE` varchar(10) DEFAULT 'notarchive',
  `IS_SINGLE` varchar(10) DEFAULT 'single',
  `IS_MULTI` varchar(10) DEFAULT 'notmulti',
  `GEO_ID` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- --------------------------------------------------------

--
-- Структура таблицы `deposit_recipes`
--

DROP TABLE IF EXISTS `deposit_recipes`;
CREATE TABLE IF NOT EXISTS `deposit_recipes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USD` double(14,2) DEFAULT NULL,
  `EUR` double(14,2) DEFAULT NULL,
  `DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=98 ;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_data_permissions`
--

DROP TABLE IF EXISTS `dyn_data_permissions`;
CREATE TABLE IF NOT EXISTS `dyn_data_permissions` (
  `USER_ID` int(11) NOT NULL,
  `TYPE_ID` varchar(20) DEFAULT NULL,
  KEY `fk_DYN_DATA_PERMISSIONS_USER1` (`USER_ID`),
  KEY `fk_DYN_DATA_PERMISSIONS_DYN_DATA_TYPES1` (`TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_data_types`
--

DROP TABLE IF EXISTS `dyn_data_types`;
CREATE TABLE IF NOT EXISTS `dyn_data_types` (
  `ID` varchar(64) NOT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `files`
--

DROP TABLE IF EXISTS `files`;
CREATE TABLE IF NOT EXISTS `files` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GROUP_ID` int(11) NOT NULL,
  `SORT` int(11) NOT NULL,
  `FILENAME` varchar(512) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=837 ;

-- --------------------------------------------------------

--
-- Структура таблицы `files_all`
--

DROP TABLE IF EXISTS `files_all`;
CREATE TABLE IF NOT EXISTS `files_all` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) DEFAULT NULL,
  `COMMENT` varchar(512) DEFAULT NULL,
  `FILENAME` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=822 ;

-- --------------------------------------------------------

--
-- Структура таблицы `files_groups`
--

DROP TABLE IF EXISTS `files_groups`;
CREATE TABLE IF NOT EXISTS `files_groups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=481 ;

-- --------------------------------------------------------

--
-- Структура таблицы `flat`
--

DROP TABLE IF EXISTS `flat`;
CREATE TABLE IF NOT EXISTS `flat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS` varchar(1024) DEFAULT NULL,
  `ROOMS` int(3) DEFAULT NULL,
  `YARDAGE` int(3) DEFAULT NULL,
  `PRICE` double(15,2) DEFAULT NULL,
  `CITY_ID` int(11) NOT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '1',
  `X` double(8,6) NOT NULL DEFAULT '0.000000',
  `Y` double(8,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- Структура таблицы `geoip_blocks`
--

DROP TABLE IF EXISTS `geoip_blocks`;
CREATE TABLE IF NOT EXISTS `geoip_blocks` (
  `START` int(11) unsigned DEFAULT NULL,
  `END` int(11) unsigned DEFAULT NULL,
  `LOC_ID` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `geoip_locations`
--

DROP TABLE IF EXISTS `geoip_locations`;
CREATE TABLE IF NOT EXISTS `geoip_locations` (
  `LOC_ID` int(11) unsigned DEFAULT NULL,
  `COUNTRY` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `REGION` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `CITY` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `POSTAL_CODE` varchar(6) COLLATE utf8_bin DEFAULT NULL,
  `LATITUDE` decimal(10,0) unsigned DEFAULT NULL,
  `LONGITUDE` decimal(10,0) unsigned DEFAULT NULL,
  `METRO_CODE` int(10) unsigned DEFAULT NULL,
  `AREA_CODE` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `geoip_relations`
--

DROP TABLE IF EXISTS `geoip_relations`;
CREATE TABLE IF NOT EXISTS `geoip_relations` (
  `CITY_ID` int(11) DEFAULT NULL,
  `LOC_ID` int(11) DEFAULT NULL,
  `REGION_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `initial_deposit`
--

DROP TABLE IF EXISTS `initial_deposit`;
CREATE TABLE IF NOT EXISTS `initial_deposit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PERCENT` int(3) NOT NULL,
  KEY `ID` (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `key_fields`
--

DROP TABLE IF EXISTS `key_fields`;
CREATE TABLE IF NOT EXISTS `key_fields` (
  `SECTION_ID` int(10) unsigned NOT NULL,
  `FIELD_ID` int(10) unsigned NOT NULL,
  `IS_OBLIGATORY` tinyint(1) unsigned NOT NULL,
  `FIELD_ORDER` tinyint(3) unsigned NOT NULL,
  `IS_REG` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`SECTION_ID`,`FIELD_ID`),
  KEY `FK_key_fields_2` (`FIELD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `key_sections`
--

DROP TABLE IF EXISTS `key_sections`;
CREATE TABLE IF NOT EXISTS `key_sections` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `KEY_ID` int(10) unsigned NOT NULL,
  `SECTION_NAME` varchar(128) DEFAULT NULL,
  `SECTION_ORDER` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_key_sections_1` (`KEY_ID`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=168 ;

-- --------------------------------------------------------

--
-- Структура таблицы `lists`
--

DROP TABLE IF EXISTS `lists`;
CREATE TABLE IF NOT EXISTS `lists` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GID` int(11) NOT NULL,
  `ORDER` int(11) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `CONTENT` longtext NOT NULL,
  PRIMARY KEY (`ID`,`ORDER`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=123 ;

-- --------------------------------------------------------

--
-- Структура таблицы `metro`
--

DROP TABLE IF EXISTS `metro`;
CREATE TABLE IF NOT EXISTS `metro` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_ID` int(11) NOT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

-- --------------------------------------------------------

--
-- Структура таблицы `metro_has_flat`
--

DROP TABLE IF EXISTS `metro_has_flat`;
CREATE TABLE IF NOT EXISTS `metro_has_flat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `METRO_ID` int(11) NOT NULL,
  `FLAT_ID` int(11) NOT NULL,
  PRIMARY KEY (`METRO_ID`,`FLAT_ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `fk_metro_has_flat_flat1` (`FLAT_ID`),
  KEY `fk_metro_has_flat_metro1` (`METRO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `modal_window`
--

DROP TABLE IF EXISTS `modal_window`;
CREATE TABLE IF NOT EXISTS `modal_window` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL,
  `order` tinyint(4) NOT NULL,
  `content` longtext NOT NULL,
  `label` char(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

--
-- Структура таблицы `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MODULE_NAME` varchar(45) NOT NULL,
  `MODULE_KEY` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE_ID` int(11) DEFAULT NULL,
  `TITLE` varchar(512) NOT NULL,
  `DATE` datetime NOT NULL,
  `FULL_TEXT` longtext NOT NULL,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  `LASTCHANGED` datetime NOT NULL,
  `changeuserid` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_NEWS_DYN_DATA_TYPES1` (`TYPE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=285 ;

-- --------------------------------------------------------

--
-- Структура таблицы `office`
--

DROP TABLE IF EXISTS `office`;
CREATE TABLE IF NOT EXISTS `office` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `CITY` varchar(512) NOT NULL,
  `ADDRESS` varchar(256) DEFAULT NULL,
  `PHONE_NUMBER` varchar(128) DEFAULT NULL,
  `WORK_HOURS` varchar(512) DEFAULT NULL,
  `LATITUDE` varchar(45) DEFAULT NULL,
  `LONGTITUDE` varchar(45) DEFAULT NULL,
  `FAX` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `MAP_IMG_PATH` varchar(512) DEFAULT NULL,
  `ADDITIONAL_INFO` text,
  `IS_MAIN` tinyint(4) DEFAULT '0',
  `ORDER_NUMBER` int(10) unsigned NOT NULL DEFAULT '0',
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=70 ;

-- --------------------------------------------------------

--
-- Структура таблицы `office_service_permissions`
--

DROP TABLE IF EXISTS `office_service_permissions`;
CREATE TABLE IF NOT EXISTS `office_service_permissions` (
  `USER_ID` int(11) NOT NULL,
  `OFFICE_ID` int(11) NOT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  KEY `fk_OFFICE_SERVICE_PERMISSION_USER1` (`USER_ID`),
  KEY `fk_OFFICE_SERVICE_PERMISSION_OFFICE1` (`OFFICE_ID`),
  KEY `fk_OFFICE_SERVICE_PERMISSION_SERVICE1` (`SERVICE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `options`
--

DROP TABLE IF EXISTS `options`;
CREATE TABLE IF NOT EXISTS `options` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEY` varchar(45) NOT NULL,
  `VALUE` text,
  `SNIPPET` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `key` (`KEY`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Структура таблицы `page_permissions`
--

DROP TABLE IF EXISTS `page_permissions`;
CREATE TABLE IF NOT EXISTS `page_permissions` (
  `USER_ID` int(11) NOT NULL,
  `PAGE_ID` int(11) NOT NULL,
  KEY `fk_USER_PERMISSION_USER1` (`USER_ID`),
  KEY `fk_USER_PERMISSION_SITE_PAGE1` (`PAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `page_widget`
--

DROP TABLE IF EXISTS `page_widget`;
CREATE TABLE IF NOT EXISTS `page_widget` (
  `PAGE_ID` int(11) NOT NULL,
  `WIDGET_ID` char(20) NOT NULL,
  KEY `fk_PAGE_WIDGET_SITE_PAGE1` (`PAGE_ID`),
  KEY `fk_PAGE_WIDGET_SITE_WIDGET1` (`WIDGET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `partner`
--

DROP TABLE IF EXISTS `partner`;
CREATE TABLE IF NOT EXISTS `partner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE` int(11) DEFAULT NULL,
  `COMPANY_NAME` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `LOGO_SRC` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `PHONE` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `ADDRESS` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `CONTACT_PERSON` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `WORK_TIME` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `HREF` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

-- --------------------------------------------------------

--
-- Структура таблицы `partner_type`
--

DROP TABLE IF EXISTS `partner_type`;
CREATE TABLE IF NOT EXISTS `partner_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SINGULAR_NAME` varchar(32) NOT NULL,
  `PLURAL_NAME` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура таблицы `permission_request`
--

DROP TABLE IF EXISTS `permission_request`;
CREATE TABLE IF NOT EXISTS `permission_request` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `DATE` datetime DEFAULT NULL,
  `DETAILS` longtext,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `EMAIL` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PERMISSION_REQUEST_USER1` (`USER_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Структура таблицы `permission_type`
--

DROP TABLE IF EXISTS `permission_type`;
CREATE TABLE IF NOT EXISTS `permission_type` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `photos`
--

DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OFFICE_ID` int(11) NOT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `ALT_TEXT` varchar(256) DEFAULT NULL,
  `IMG_PATH` varchar(512) DEFAULT NULL,
  `DEFAULT` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `fk_PHOTOS_OFFICE1` (`OFFICE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=138 ;

-- --------------------------------------------------------

--
-- Структура таблицы `purchase_request`
--

DROP TABLE IF EXISTS `purchase_request`;
CREATE TABLE IF NOT EXISTS `purchase_request` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEY_ID` int(10) unsigned NOT NULL,
  `USER_ID` int(10) unsigned NOT NULL,
  `AGENT_CODE_REFERER` int(10) unsigned DEFAULT NULL,
  `REQUEST_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `GEO_ID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_purchase_request_1` (`KEY_ID`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1981 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `QUESTION` mediumtext,
  `QUESTION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PID` int(10) unsigned DEFAULT '0',
  `SUB_ORDER` int(10) unsigned DEFAULT '0',
  `PATH` varchar(128) DEFAULT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  `THEME_ID` int(11) DEFAULT NULL,
  `STATUS_ID` int(11) DEFAULT NULL,
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2389 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions_old`
--

DROP TABLE IF EXISTS `questions_old`;
CREATE TABLE IF NOT EXISTS `questions_old` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `QUESTION` mediumtext,
  `QUESTION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PID` int(10) unsigned DEFAULT '0',
  `SUB_ORDER` int(10) unsigned DEFAULT '0',
  `PATH` varchar(128) DEFAULT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  `THEME_ID` int(11) DEFAULT NULL,
  `STATUS_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1829 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions_status`
--

DROP TABLE IF EXISTS `questions_status`;
CREATE TABLE IF NOT EXISTS `questions_status` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `SORTING` int(11) NOT NULL DEFAULT '0',
  `AUTO_SELECT` int(1) NOT NULL DEFAULT '0',
  `NAME` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура таблицы `questions_title`
--

DROP TABLE IF EXISTS `questions_title`;
CREATE TABLE IF NOT EXISTS `questions_title` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SORTING` int(10) NOT NULL DEFAULT '0',
  `NAME` varchar(64) NOT NULL DEFAULT '0',
  `HIDE` int(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `REGION_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

-- --------------------------------------------------------

--
-- Структура таблицы `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE IF NOT EXISTS `registration` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `REGISTRATION_NAME` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `request_fields`
--

DROP TABLE IF EXISTS `request_fields`;
CREATE TABLE IF NOT EXISTS `request_fields` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(45) NOT NULL,
  `CAPTION` varchar(256) DEFAULT NULL,
  `SMALL_CAPTION` varchar(256) DEFAULT NULL,
  `VALID_PATTERN` varchar(256) DEFAULT NULL,
  `INVALID_PATTERN` varchar(256) DEFAULT NULL,
  `ATTRIBUTES` varchar(256) DEFAULT NULL,
  `DATA` text,
  `ALIAS` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=218 ;

-- --------------------------------------------------------

--
-- Структура таблицы `request_keys`
--

DROP TABLE IF EXISTS `request_keys`;
CREATE TABLE IF NOT EXISTS `request_keys` (
  `ID` int(10) unsigned NOT NULL,
  `KEY_TYPE` char(1) NOT NULL,
  `KEY_NAME` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `request_values`
--

DROP TABLE IF EXISTS `request_values`;
CREATE TABLE IF NOT EXISTS `request_values` (
  `REQUEST_ID` int(10) unsigned NOT NULL,
  `FIELD_ID` int(10) unsigned NOT NULL,
  `FIELD_VALUE` varchar(512) DEFAULT NULL,
  `SECTION_ID` int(10) unsigned NOT NULL,
  `FIELD_ALIAS` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`REQUEST_ID`,`FIELD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PAGE_ID` (`PAGE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1017 ;

-- --------------------------------------------------------

--
-- Структура таблицы `service_rate`
--

DROP TABLE IF EXISTS `service_rate`;
CREATE TABLE IF NOT EXISTS `service_rate` (
  `RATE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `OFFICE_ID` int(11) NOT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  `NAME` varchar(512) DEFAULT NULL,
  `DATA` longblob,
  `SOURCE` varchar(10) DEFAULT 'DB',
  `URL_ADDRESS` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`RATE_ID`),
  KEY `fk_SERVICE_RATE_OFFICE1` (`OFFICE_ID`),
  KEY `fk_SERVICE_RATE_SERVICE1` (`SERVICE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=452 ;

-- --------------------------------------------------------

--
-- Структура таблицы `shareholder_widget`
--

DROP TABLE IF EXISTS `shareholder_widget`;
CREATE TABLE IF NOT EXISTS `shareholder_widget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(256) DEFAULT NULL,
  `PERCENT` float(5,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=98 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_banner`
--

DROP TABLE IF EXISTS `site_banner`;
CREATE TABLE IF NOT EXISTS `site_banner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FILE` varchar(512) NOT NULL,
  `TITLE` varchar(225) NOT NULL,
  `URL` varchar(512) NOT NULL,
  `TYPE` char(1) NOT NULL,
  `EXTERNAL` tinyint(1) NOT NULL,
  `HTML` longtext,
  `GEO_ID` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=184 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_banner_assignments`
--

DROP TABLE IF EXISTS `site_banner_assignments`;
CREATE TABLE IF NOT EXISTS `site_banner_assignments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAGE_ID` int(11) NOT NULL,
  `BANNER_ID` int(11) DEFAULT NULL,
  `ZONE_KEY` varchar(10) DEFAULT NULL,
  `ORDER` mediumint(9) DEFAULT NULL,
  `DURATION` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BANNER_ID` (`BANNER_ID`),
  KEY `PAGE_ID` (`PAGE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=641 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_menu`
--

DROP TABLE IF EXISTS `site_menu`;
CREATE TABLE IF NOT EXISTS `site_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARENT_ID` int(11) NOT NULL,
  `PAGE_ID` int(11) DEFAULT NULL,
  `MENU_ID` tinyint(1) DEFAULT NULL,
  `GEO_ID` int(11) unsigned NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `ORDER` int(11) NOT NULL DEFAULT '0',
  `MENU_IMG_PATH` varchar(512) DEFAULT NULL,
  `MENU_SMALL_IMG_PATH` varchar(512) DEFAULT NULL,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  `CUSTOM_URL` varchar(256) DEFAULT NULL,
  `EDITABLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `fk_SITE_MENU_SITE_PAGE1` (`PAGE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=94 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_page`
--

DROP TABLE IF EXISTS `site_page`;
CREATE TABLE IF NOT EXISTS `site_page` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEMPLATE_ID` int(11) NOT NULL,
  `MODULE_ID` int(11) DEFAULT NULL,
  `PARENT` int(11) NOT NULL,
  `GEO_ID` int(11) unsigned NOT NULL,
  `KEY` varchar(45) DEFAULT NULL,
  `TITLE` varchar(256) DEFAULT NULL,
  `ALIAS` varchar(256) DEFAULT NULL,
  `PAGE_CODE` longtext,
  `META_KEYWORDS` varchar(255) DEFAULT NULL,
  `META_DESCRIPTION` varchar(512) DEFAULT NULL,
  `META_TITLE` varchar(256) DEFAULT NULL,
  `HEADER_CLASSNAME` varchar(255) DEFAULT NULL,
  `HEADER_SHOW_NEWS` tinyint(4) DEFAULT NULL,
  `HEADER_TEXT` text,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  `CREATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_SITE_PAGE_SITE_TEMPLATE1` (`TEMPLATE_ID`),
  KEY `fk_SITE_PAGE_MODULES1` (`MODULE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=185 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_region`
--

DROP TABLE IF EXISTS `site_region`;
CREATE TABLE IF NOT EXISTS `site_region` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DOMAIN_NAME` varchar(128) DEFAULT NULL,
  `NAME` varchar(256) DEFAULT NULL,
  `ENABLE` varchar(10) DEFAULT 'disable',
  `CITY` int(11) unsigned NOT NULL,
  `OFFICE_NAME` varchar(100) DEFAULT NULL,
  `OFFICE_ADDRESS` varchar(300) DEFAULT NULL,
  `OFFICE_PHONE` varchar(20) DEFAULT NULL,
  `OFFICE_EMAIL` varchar(50) DEFAULT NULL,
  `OFFICE_FAX` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `DOMAIN_NAME` (`DOMAIN_NAME`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_region_rus_translit`
--

DROP TABLE IF EXISTS `site_region_rus_translit`;
CREATE TABLE IF NOT EXISTS `site_region_rus_translit` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `REG_ID` int(11) unsigned DEFAULT NULL,
  `SYS_NAME` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `REG_ID` (`REG_ID`),
  KEY `SYS_NAME` (`SYS_NAME`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_template`
--

DROP TABLE IF EXISTS `site_template`;
CREATE TABLE IF NOT EXISTS `site_template` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEMPLATE_FILE` varchar(90) NOT NULL,
  `TEMPLATE_NAME` varchar(90) NOT NULL,
  `ARCHIVED` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 ;

-- --------------------------------------------------------

--
-- Структура таблицы `site_users`
--

DROP TABLE IF EXISTS `site_users`;
CREATE TABLE IF NOT EXISTS `site_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_TYPE` char(1) NOT NULL,
  `AGENT` tinyint(1) NOT NULL DEFAULT '0',
  `AGENT_CODE` smallint(4) NOT NULL DEFAULT '0',
  `P_SEX` char(1) DEFAULT NULL,
  `LIKE_OFFICE_ID` int(10) unsigned DEFAULT NULL,
  `P_BIRTH_DATE` date DEFAULT NULL,
  `P_PASSPORT_DATE` date DEFAULT NULL,
  `B_REGISTRATION_DATE` date DEFAULT NULL,
  `B_ACTIVITIES_DATE` date DEFAULT NULL,
  `EMAIL` varchar(128) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `P_FIRST_NAME` varchar(32) DEFAULT NULL,
  `P_MIDDLE_NAME` varchar(64) DEFAULT NULL,
  `P_LAST_NAME` varchar(64) DEFAULT NULL,
  `P_PHONE_NUMBER_1_WT` varchar(64) DEFAULT NULL,
  `P_PHONE_NUMBER_2_WT` varchar(64) DEFAULT NULL,
  `P_MOBILE_NUMBER_WT` varchar(64) DEFAULT NULL,
  `P_SMS_NUMBER` varchar(24) DEFAULT NULL,
  `P_BIRTH_PLACE` varchar(128) DEFAULT NULL,
  `P_CITIZENSHIP` varchar(32) DEFAULT NULL,
  `P_PASSPORT_SERIES` varchar(10) DEFAULT NULL,
  `P_PASSPORT_NUMBER` varchar(10) DEFAULT NULL,
  `P_PASSPORT_WHOM` varchar(128) DEFAULT NULL,
  `P_PASSPORT_CODE` varchar(10) DEFAULT NULL,
  `P_LEGAL_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_LEGAL_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_LEGAL_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_LEGAL_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_LEGAL_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_LEGAL_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_LEGAL_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_LEGAL_ADDRESS_FLAT` varchar(4) DEFAULT NULL,
  `P_POST_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_POST_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_POST_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_POST_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_POST_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_POST_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_POST_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_POST_ADDRESS_FLAT` varchar(4) DEFAULT NULL,
  `P_JOB_ORGANIZATION` varchar(128) DEFAULT NULL,
  `P_JOB_POST_NAME` varchar(128) DEFAULT NULL,
  `P_JOB_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_JOB_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_JOB_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_JOB_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_JOB_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_JOB_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_JOB_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_JOB_ADDRESS_OFFICE` varchar(16) DEFAULT NULL,
  `P_JOB_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `P_STUDY_NAME` varchar(128) DEFAULT NULL,
  `P_STUDY_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `P_STUDY_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `P_STUDY_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `P_STUDY_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `P_STUDY_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `P_STUDY_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `P_STUDY_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `P_STUDY_FACULTY` varchar(64) DEFAULT NULL,
  `P_STUDY_SPECIALITY` varchar(64) DEFAULT NULL,
  `P_STUDY_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `B_COMPANY_NAME` varchar(256) DEFAULT NULL,
  `B_REGISTRATION_AREA` varchar(256) DEFAULT NULL,
  `B_REGISTRATION_NUMBER` varchar(13) DEFAULT NULL,
  `B_INN` varchar(12) DEFAULT NULL,
  `B_KPP` varchar(9) DEFAULT NULL,
  `B_STAT_CODE` varchar(128) DEFAULT NULL,
  `B_ACTIVITIES` varchar(512) DEFAULT NULL,
  `B_BANK` varchar(256) DEFAULT NULL,
  `B_BIK` varchar(9) DEFAULT NULL,
  `B_SETT_ACCOUNT` varchar(20) DEFAULT NULL,
  `B_CORR_ACCOUNT` varchar(20) DEFAULT NULL,
  `B_BOSS_POST_NAME` varchar(128) DEFAULT NULL,
  `B_BOSS_FIRST_NAME` varchar(32) DEFAULT NULL,
  `B_BOSS_MIDDLE_NAME` varchar(64) DEFAULT NULL,
  `B_BOSS_LAST_NAME` varchar(64) DEFAULT NULL,
  `B_BOSS_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `B_BOSS_FAX` varchar(12) DEFAULT NULL,
  `B_BOSS_EMAIL` varchar(128) DEFAULT NULL,
  `B_CONTACT_POST_NAME` varchar(128) DEFAULT NULL,
  `B_CONTACT_FIRST_NAME` varchar(32) DEFAULT NULL,
  `B_CONTACT_MIDDLE_NAME` varchar(64) DEFAULT NULL,
  `B_CONTACT_LAST_NAME` varchar(64) DEFAULT NULL,
  `B_CONTACT_PHONE_NUMBER` varchar(24) DEFAULT NULL,
  `B_CONTACT_FAX` varchar(12) DEFAULT NULL,
  `B_CONTACT_EMAIL` varchar(128) DEFAULT NULL,
  `B_LEGAL_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `B_LEGAL_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `B_LEGAL_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `B_LEGAL_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `B_LEGAL_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `B_LEGAL_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `B_LEGAL_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `B_LEGAL_ADDRESS_OFFICE` varchar(16) DEFAULT NULL,
  `B_POST_ADDRESS_INDEX` varchar(10) DEFAULT NULL,
  `B_POST_ADDRESS_COUNTRY` varchar(32) DEFAULT NULL,
  `B_POST_ADDRESS_REGION` varchar(64) DEFAULT NULL,
  `B_POST_ADDRESS_CITY` varchar(32) DEFAULT NULL,
  `B_POST_ADDRESS_STREET` varchar(32) DEFAULT NULL,
  `B_POST_ADDRESS_HOUSE` varchar(8) DEFAULT NULL,
  `B_POST_ADDRESS_BUILD` varchar(8) DEFAULT NULL,
  `B_POST_ADDRESS_OFFICE` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Index_2` (`EMAIL`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1701 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) DEFAULT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `ROLE` char(1) NOT NULL,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `BLOCKED` tinyint(1) NOT NULL DEFAULT '0',
  `GEO_ADMIN` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=65 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user_offers`
--

DROP TABLE IF EXISTS `user_offers`;
CREATE TABLE IF NOT EXISTS `user_offers` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(256) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `NAME` varchar(128) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `PHONE_NUMBER` varchar(64) DEFAULT NULL,
  `ADDRESS` varchar(512) DEFAULT NULL,
  `RECEIVED_ON` datetime NOT NULL,
  `HIDDEN` tinyint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12864 ;

-- --------------------------------------------------------

--
-- Структура таблицы `user_relation`
--

DROP TABLE IF EXISTS `user_relation`;
CREATE TABLE IF NOT EXISTS `user_relation` (
  `USER_ID` int(11) unsigned NOT NULL,
  `GEO_ID` int(11) unsigned NOT NULL,
  UNIQUE KEY `USER_ID` (`USER_ID`,`GEO_ID`),
  KEY `GEO_ID` (`GEO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `vacancy`
--

DROP TABLE IF EXISTS `vacancy`;
CREATE TABLE IF NOT EXISTS `vacancy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(10) DEFAULT '-',
  `CITY` varchar(256) DEFAULT NULL,
  `TITLE` varchar(128) DEFAULT NULL,
  `REQUIREMENTS` longtext,
  `FUNCTIONS` longtext,
  `CREDENTIALS` varchar(256) DEFAULT NULL,
  `SALARY` varchar(256) DEFAULT NULL,
  `WORK_PLACE` varchar(256) DEFAULT NULL,
  `SOCPACK` varchar(256) DEFAULT NULL,
  `ADDRESS` varchar(256) DEFAULT NULL,
  `PHONE_NUMBER` varchar(128) DEFAULT NULL,
  `FAX` varchar(128) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `CLOSED_ON` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=117 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vacancy_applicant`
--

DROP TABLE IF EXISTS `vacancy_applicant`;
CREATE TABLE IF NOT EXISTS `vacancy_applicant` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `POSITION` varchar(256) DEFAULT NULL,
  `FIRST_NAME` varchar(128) DEFAULT NULL,
  `MIDDLE_NAME` varchar(128) DEFAULT NULL,
  `LAST_NAME` varchar(128) DEFAULT NULL,
  `SEX` char(1) DEFAULT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `BIRTH_DATE` datetime DEFAULT NULL,
  `PHONE_NUMBER` varchar(128) DEFAULT NULL,
  `CITIZENSHIP` varchar(128) DEFAULT NULL,
  `RESIDENCE` varchar(256) DEFAULT NULL,
  `PREVJOB` longtext,
  `EDUCATION` longtext,
  `SKILLS` longtext,
  `RESUME_FILE` varchar(512) DEFAULT NULL,
  `NOTES` longtext,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4105 ;

-- --------------------------------------------------------

--
-- Структура таблицы `work_experience`
--

DROP TABLE IF EXISTS `work_experience`;
CREATE TABLE IF NOT EXISTS `work_experience` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `APPLICANT_ID` int(11) NOT NULL,
  `COMPANY_NAME` varchar(128) DEFAULT NULL,
  `POSITION` varchar(128) DEFAULT NULL,
  `DETAILS` longtext,
  PRIMARY KEY (`ID`),
  KEY `fk_WORK_EXPERIENCE_VACANCY_APPLICANT1` (`APPLICANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_field_types`
--

DROP TABLE IF EXISTS `yandex_xml_field_types`;
CREATE TABLE IF NOT EXISTS `yandex_xml_field_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `type` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_field_values`
--

DROP TABLE IF EXISTS `yandex_xml_field_values`;
CREATE TABLE IF NOT EXISTS `yandex_xml_field_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `label` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_fields`
--

DROP TABLE IF EXISTS `yandex_xml_fields`;
CREATE TABLE IF NOT EXISTS `yandex_xml_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `name` tinytext NOT NULL,
  `label` tinytext NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `values` tinytext NOT NULL,
  `description` longtext NOT NULL,
  `required` tinyint(4) NOT NULL,
  `required_if` tinytext NOT NULL,
  `multiple` tinyint(4) NOT NULL,
  `branch` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=170 ;

-- --------------------------------------------------------

--
-- Структура таблицы `yandex_xml_save`
--

DROP TABLE IF EXISTS `yandex_xml_save`;
CREATE TABLE IF NOT EXISTS `yandex_xml_save` (
  `name` text NOT NULL,
  `value` text NOT NULL,
  `array` tinyint(4) NOT NULL DEFAULT '0',
  `key` tinytext NOT NULL,
  `class` tinytext NOT NULL,
  `multiple` tinyint(4) NOT NULL DEFAULT '0',
  `multiple_key` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
