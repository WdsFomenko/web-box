
-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ang_linkavie
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.12.04.1

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

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(45) NOT NULL,
  `user_id` int(11) NOT NULL,
  `shelf_id` int(11) NOT NULL,
  `cover_link` varchar(255) DEFAULT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `skin` enum('modern','oldschool','woodenlines','freshgarden') DEFAULT 'modern',
  `event_id` int(11) DEFAULT NULL,
  `sync_id` int(11) DEFAULT NULL,
  `sync_allow_share` tinyint(1) NOT NULL DEFAULT '0',
  `owner_id` int(11) DEFAULT NULL,
  `last_notification_sent` int(10) DEFAULT NULL,
  `speriod` date DEFAULT NULL,
  `fperiod` date DEFAULT NULL,
  `relative_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shelves_shelf_albums` (`shelf_id`),
  CONSTRAINT `fk_shelves_shelf_albums` FOREIGN KEY (`shelf_id`) REFERENCES `shelves` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_info`
--

DROP TABLE IF EXISTS `company_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(127) NOT NULL,
  `billing_number` varchar(127) NOT NULL,
  `billing_street` varchar(127) NOT NULL,
  `billing_zip` varchar(15) NOT NULL,
  `billing_city` varchar(127) NOT NULL,
  `billing_country` varchar(127) NOT NULL,
  `shipping_number` varchar(127) DEFAULT NULL,
  `shipping_street` varchar(127) DEFAULT NULL,
  `shipping_zip` varchar(15) DEFAULT NULL,
  `shipping_city` varchar(127) DEFAULT NULL,
  `shipping_country` varchar(127) DEFAULT NULL,
  `vat` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` varchar(2) NOT NULL,
  `name` varchar(64) NOT NULL,
  `locale` varchar(2) NOT NULL,
  UNIQUE KEY `idx_country` (`id`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_contributors`
--

DROP TABLE IF EXISTS `event_contributors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_contributors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  `role` enum('owner','contributor') NOT NULL DEFAULT 'contributor',
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `hash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`user_id`,`event_id`,`hash`),
  KEY `fk_event_conrib_evetns_idx` (`event_id`),
  CONSTRAINT `fk_event_conrib_evetns` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_event_conrib_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('personal','common') NOT NULL DEFAULT 'common',
  `contribute_vault` tinyint(1) NOT NULL DEFAULT '0',
  `contribute_album` tinyint(1) NOT NULL DEFAULT '0',
  `wifi_only` tinyint(1) NOT NULL DEFAULT '0',
  `allow_share` tinyint(1) NOT NULL DEFAULT '0',
  `share_linkavie` tinyint(1) NOT NULL DEFAULT '0',
  `share_facebook` tinyint(1) NOT NULL DEFAULT '0',
  `share_other` tinyint(1) NOT NULL DEFAULT '0',
  `allow_picture_description` tinyint(1) NOT NULL DEFAULT '0',
  `allow_3g` tinyint(1) NOT NULL DEFAULT '0',
  `mobile_copy_pictures` tinyint(1) NOT NULL DEFAULT '0',
  `mobile_share_gallery` tinyint(1) NOT NULL DEFAULT '0',
  `memory_limit` bigint(12) NOT NULL,
  `memory_extend` bigint(12) NOT NULL DEFAULT '0',
  `memory_expiration` date NOT NULL,
  `memory_used` bigint(12) NOT NULL DEFAULT '0',
  `notification_code` tinyint(1) NOT NULL DEFAULT '0',
  `sdate` date DEFAULT NULL,
  `edate` date DEFAULT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `close_date` date DEFAULT NULL,
  `available_after_close` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `event_wall_session` int(11) NOT NULL DEFAULT '0',
  `event_wall_session_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_type` enum('image','video','document') NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `description` longtext,
  `weight` varchar(45) NOT NULL,
  `resolution` varchar(45) DEFAULT NULL,
  `file_extension` varchar(10) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `sub_type` varchar(45) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `folder_id` int(11) NOT NULL,
  `sync_id` int(11) DEFAULT NULL,
  `sync_allow_change` tinyint(1) DEFAULT '0',
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `state` enum('uploading','saving','processing','available','deleted') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5815 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) NOT NULL,
  `obj_name` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `speriod` date DEFAULT NULL,
  `fperiod` date DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `is_encrypt` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_mobile` tinyint(1) NOT NULL DEFAULT '0',
  `sync_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=523 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `footer_links`
--

DROP TABLE IF EXISTS `footer_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `footer_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'en',
  `title` varchar(45) NOT NULL,
  `link` varchar(45) NOT NULL,
  `is_hide` tinyint(1) NOT NULL DEFAULT '0',
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `landings`
--

DROP TABLE IF EXISTS `landings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `landings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'en',
  `title` varchar(255) NOT NULL,
  `type` varchar(45) NOT NULL,
  `content` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `row` int(2) DEFAULT '0',
  `col` int(2) DEFAULT '0',
  `sizex` int(2) DEFAULT '0',
  `sizey` int(2) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_events`
--

DROP TABLE IF EXISTS `mobile_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdate` int(10) DEFAULT NULL,
  `event_code` varchar(255) NOT NULL,
  `event_id` int(11) NOT NULL,
  `expire_date` int(10) NOT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `po_number` varchar(255) DEFAULT NULL,
  `invoice_number` varchar(100) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`id`),
  KEY `fk_mobile_events_events_idx` (`event_id`),
  CONSTRAINT `fk_mobile_events_events` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_sessions`
--

DROP TABLE IF EXISTS `mobile_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `obj_id` int(11) NOT NULL,
  `obj_name` varchar(45) NOT NULL,
  `expire_date` int(10) NOT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  `data` longtext,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=443 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_attachments`
--

DROP TABLE IF EXISTS `page_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sheet_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `cdate` datetime NOT NULL,
  `mdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pageSheetAttachments` (`sheet_id`),
  KEY `fk_pageAttachmentFile` (`file_id`),
  CONSTRAINT `fk_pageAttachmentFile` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`),
  CONSTRAINT `fk_pageSheetAttachments` FOREIGN KEY (`sheet_id`) REFERENCES `sheets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_images`
--

DROP TABLE IF EXISTS `section_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `cdate` int(11) NOT NULL,
  `mdate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sectionImages` (`section_id`),
  KEY `fk_imageSectionFile` (`file_id`),
  CONSTRAINT `fk_sectionImages` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1038 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_text`
--

DROP TABLE IF EXISTS `section_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `cdate` int(11) NOT NULL,
  `mdate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sectionText` (`section_id`),
  CONSTRAINT `fk_sectionText` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_videos`
--

DROP TABLE IF EXISTS `section_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `cdate` int(11) NOT NULL,
  `mdate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sectionVideos` (`section_id`),
  KEY `fk_videoSectionFile` (`file_id`),
  CONSTRAINT `fk_sectionVideos` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videoSectionFile` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sheet_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `type` enum('images','videos','text') NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `relative_id` int(11) DEFAULT NULL,
  `cdate` int(11) NOT NULL,
  `mdate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sheetSections` (`sheet_id`),
  CONSTRAINT `fk_sheetSections` FOREIGN KEY (`sheet_id`) REFERENCES `sheets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` char(32) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share_resources`
--

DROP TABLE IF EXISTS `share_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_hash` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `owner_id` int(11) NOT NULL,
  `obj_name` varchar(15) NOT NULL,
  `obj_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `allow_download` tinyint(1) NOT NULL DEFAULT '0',
  `allow_copy` tinyint(1) NOT NULL DEFAULT '0',
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=576 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sheets`
--

DROP TABLE IF EXISTS `sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sheets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `type` enum('chapter','page') NOT NULL,
  `title` varchar(255) NOT NULL,
  `speriod` int(11) DEFAULT NULL,
  `fperiod` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `relative_id` int(11) DEFAULT NULL,
  `is_syncable` tinyint(4) NOT NULL DEFAULT '0',
  `cdate` int(11) NOT NULL,
  `mdate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albumSheets` (`album_id`),
  CONSTRAINT `fk_albumSheets` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=573 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shelves`
--

DROP TABLE IF EXISTS `shelves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shelves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` enum('digital','printable','life') NOT NULL DEFAULT 'digital',
  `user_id` int(11) NOT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `order` int(11) NOT NULL,
  `event_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_user_shelves_idx` (`user_id`),
  CONSTRAINT `fk_users_user_shelves` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=483 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_dashboards`
--

DROP TABLE IF EXISTS `user_dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_dashboards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `first_file_id` int(11) DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_owner` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_user_dashboard_idx` (`user_id`),
  CONSTRAINT `fk_users_user_dashboard` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invitations`
--

DROP TABLE IF EXISTS `user_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `who_invited` int(11) NOT NULL,
  `email_invited` varchar(255) NOT NULL,
  `link_hash` varchar(255) NOT NULL,
  `cdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_hash_UNIQUE` (`link_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_relationships`
--

DROP TABLE IF EXISTS `user_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_relationships` (
  `user_id1` int(11) NOT NULL,
  `user_id2` int(11) NOT NULL,
  `status` enum('accept','ignore','pending') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`user_id2`,`user_id1`),
  KEY `fk_users_userref_user1_idx` (`user_id1`),
  CONSTRAINT `fk_users_userref_user1_idx` FOREIGN KEY (`user_id1`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_userref_user2_idx` FOREIGN KEY (`user_id2`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `lang` varchar(45) NOT NULL DEFAULT 'en',
  `avatar` varchar(255) DEFAULT NULL,
  `role` varchar(11) DEFAULT 'unconfirmed',
  `gender` varchar(10) DEFAULT NULL,
  `birth` int(11) DEFAULT NULL,
  `place_birth` varchar(255) DEFAULT NULL,
  `contact_number` varchar(100) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `street_1` varchar(255) DEFAULT NULL,
  `number_house` varchar(45) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `sum_weight` int(20) NOT NULL DEFAULT '0',
  `album_id` int(11) DEFAULT NULL,
  `msg_howtostart` tinyint(4) NOT NULL DEFAULT '1',
  `auto_login_hash` varchar(255) DEFAULT NULL,
  `bonus_storage` varchar(45) DEFAULT NULL,
  `is_newsletter` tinyint(1) NOT NULL DEFAULT '1',
  `msg_first_step_help` tinyint(1) NOT NULL DEFAULT '1',
  `help_with_contributing` int(1) NOT NULL DEFAULT '1',
  `msg_event_how_start` tinyint(1) NOT NULL DEFAULT '0',
  `agree_cookies` tinyint(1) NOT NULL DEFAULT '0',
  `timezone` varchar(50) NOT NULL DEFAULT 'UTC',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wall`
--

DROP TABLE IF EXISTS `wall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wall` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `moderate` varchar(45) NOT NULL,
  `obj_id` varchar(100) NOT NULL,
  `obj_type` varchar(45) NOT NULL,
  `cdate` int(10) NOT NULL,
  `mdate` int(10) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `showed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-08 14:00:03
