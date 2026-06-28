-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.18-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema bsitdb
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ bsitdb;
USE bsitdb;

--
-- Table structure for table `bsitdb`.`tbl_activity_log`
--

DROP TABLE IF EXISTS `tbl_activity_log`;
CREATE TABLE `tbl_activity_log` (
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `action_details` varchar(45) NOT NULL default '',
  `activity_time` varchar(45) NOT NULL default '',
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_activity_log`
--

/*!40000 ALTER TABLE `tbl_activity_log` DISABLE KEYS */;
INSERT INTO `tbl_activity_log` (`user_id`,`action_details`,`activity_time`) VALUES 
 (4,'Profile Picture updated.\n','2026-06-28 17:41:22.881102');
/*!40000 ALTER TABLE `tbl_activity_log` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_certificate`
--

DROP TABLE IF EXISTS `tbl_certificate`;
CREATE TABLE `tbl_certificate` (
  `certificate_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `course_code` varchar(50) NOT NULL default '0',
  `date_issued` datetime NOT NULL default '0000-00-00 00:00:00',
  `file_path` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`certificate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_certificate`
--

/*!40000 ALTER TABLE `tbl_certificate` DISABLE KEYS */;
INSERT INTO `tbl_certificate` (`certificate_id`,`user_id`,`course_code`,`date_issued`,`file_path`) VALUES 
 (1,4,'MB123','2026-03-05 11:15:38','~/certificates/certificate_4_MB123_20260305111538.png');
/*!40000 ALTER TABLE `tbl_certificate` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_course`
--

DROP TABLE IF EXISTS `tbl_course`;
CREATE TABLE `tbl_course` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `course_code` varchar(45) NOT NULL default '',
  `course_name` varchar(100) NOT NULL default '',
  `course_description` text,
  `video_file_path` varchar(255) default NULL,
  `module_number` int(10) unsigned NOT NULL default '0',
  `course_image` varchar(255) NOT NULL default '',
  `faculty_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_course`
--

/*!40000 ALTER TABLE `tbl_course` DISABLE KEYS */;
INSERT INTO `tbl_course` (`id`,`course_code`,`course_name`,`course_description`,`video_file_path`,`module_number`,`course_image`,`faculty_id`) VALUES 
 (2,'MB123','Marine Biology','This module introduces students to marine biology, the study of life in oceans, estuaries, and coastal ecosystems. It covers marine ecosystems, organisms, and human impacts on marine life.',NULL,0,'images/course/IFMS1.jpg',0),
 (3,'sdjlkajda','sdjasdkla','deklsdklsa',NULL,0,'images/course/IFMS1.jpg',0);
/*!40000 ALTER TABLE `tbl_course` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_enrollment`
--

DROP TABLE IF EXISTS `tbl_enrollment`;
CREATE TABLE `tbl_enrollment` (
  `enrollment_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `course_code` varchar(45) NOT NULL default '',
  `date_enrolled` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_enrollment`
--

/*!40000 ALTER TABLE `tbl_enrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_enrollment` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_faculty`
--

DROP TABLE IF EXISTS `tbl_faculty`;
CREATE TABLE `tbl_faculty` (
  `faculty_id` int(11) NOT NULL auto_increment,
  `Email` varchar(100) NOT NULL default '',
  `Password` varchar(255) NOT NULL,
  `first_name` varchar(45) NOT NULL default '',
  `last_name` varchar(45) NOT NULL default '',
  `user_id` int(10) unsigned NOT NULL default '0',
  `created_at` datetime default NULL,
  PRIMARY KEY  (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_faculty`
--

/*!40000 ALTER TABLE `tbl_faculty` DISABLE KEYS */;
INSERT INTO `tbl_faculty` (`faculty_id`,`Email`,`Password`,`first_name`,`last_name`,`user_id`,`created_at`) VALUES 
 (4,'wayne@gmail.com','saOWgtJFemOebfjlCFObriSXMV1jtJkQSSFHCqwf0tzGjVu1','wayne','Castro',40,NULL),
 (5,'april@gmail.com','flk8cg/6hXSJWOVXdyhSksbyIsvtiC46fRkavZMgvFpJeA0u','April','agno',41,NULL),
 (6,'madam@gmail.com','NXLhEmKHi8f6B5XTkAmj306OJrsY34aFVYh83nLxsHLGaeT/','Faculty','madam',43,'2026-02-15 12:36:37'),
 (7,'GAYGAY@gmail.com','v5d2ttrYrVEjfs/Ucuud2g8QcToOvOUcGBvqwgb6/82MxzNN','gaygay','caturan',48,'2026-06-23 04:24:03'),
 (8,'agno@gmail.com','bVOplHWkfmQSzFWHTGwTEqbhKFNWvZCSkjiJnKgzyLGCnYEI','april','agno',49,'2026-06-23 04:25:45'),
 (9,'Ril@gmai.com','KAV/6hxdQXc4Bt4lF3E+3hngXk4aVh951jtuuUs21ibFHOmv','april','agno',50,'2026-06-23 04:27:45'),
 (10,'Amor@gmail.com','xxqdJ3RZuDdFFpTzPPvnL7vApaGPMjv6lcBNNvIQ8geAAvLV','maria','amor',51,'2026-06-23 04:28:49');
/*!40000 ALTER TABLE `tbl_faculty` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_module`
--

DROP TABLE IF EXISTS `tbl_module`;
CREATE TABLE `tbl_module` (
  `module_id` int(10) unsigned NOT NULL auto_increment,
  `course_code` varchar(45) NOT NULL default '',
  `module_content` longtext,
  `module_number` varchar(45) NOT NULL default '',
  `module_title` varchar(45) NOT NULL default '',
  `file_path` varchar(255) NOT NULL default '',
  `is_locked` tinyint(1) default '1',
  `IsLocked` tinyint(1) default '1',
  `faculty_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_module`
--

/*!40000 ALTER TABLE `tbl_module` DISABLE KEYS */;
INSERT INTO `tbl_module` (`module_id`,`course_code`,`module_content`,`module_number`,`module_title`,`file_path`,`is_locked`,`IsLocked`,`faculty_id`) VALUES 
 (2,'MB123','Module Description:\r\n\r\nThis module introduces students to marine biology, the study of life in oceans, estuaries, and coastal ecosystems. It covers marine ecosystems, organisms, and human impacts on marine life.\r\n\r\nLearning Objectives:\r\n\r\nBy the end of this module, students should be able to:\r\n\r\nDefine marine biology and its significance.\r\n\r\nIdentify different marine ecosystems and habitats.\r\n\r\nDescribe the major groups of marine organisms.\r\n\r\nExplain the impact of human activities on marine environments.\r\n\r\nUnderstand methods used in marine biological research.','1','Module 1','ViewerOutput/Module_1_8cf02492-2623-4786-beef-5e86384d57f9.html',1,1,0),
 (3,'sdjlkajda','lkdjkljdlkas','1','Module 1','ViewerOutput/Module_1_7a8ac66c-400b-4ad4-8c91-6757d433d18c.html',1,1,0);
/*!40000 ALTER TABLE `tbl_module` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_progress`
--

DROP TABLE IF EXISTS `tbl_progress`;
CREATE TABLE `tbl_progress` (
  `progress_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `module_number` int(10) unsigned NOT NULL default '0',
  `course_code` varchar(45) NOT NULL default '',
  `module_id` int(11) default NULL,
  `status` text NOT NULL,
  `quiz_score` int(11) default '0',
  PRIMARY KEY  (`progress_id`),
  UNIQUE KEY `uniq_user_course_module` (`user_id`,`course_code`,`module_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_progress`
--

/*!40000 ALTER TABLE `tbl_progress` DISABLE KEYS */;
INSERT INTO `tbl_progress` (`progress_id`,`user_id`,`module_number`,`course_code`,`module_id`,`status`,`quiz_score`) VALUES 
 (1,4,1,'IT001',NULL,'Not Started',0),
 (2,4,1,'IT002',NULL,'Not Started',0),
 (3,4,1,'IT0088999',NULL,'Not Started',0),
 (4,4,1,'MB123',NULL,'completed',4),
 (5,4,1,'dhfj33',NULL,'Not Started',0),
 (6,4,1,'sdjlkajda',NULL,'Not Started',0),
 (7,25,1,'sdjlkajda',NULL,'Not Started',0),
 (8,25,1,'MB123',NULL,'Not Started',0),
 (9,44,1,'MB123',NULL,'Not Started',0),
 (10,46,1,'MB123',NULL,'Not Started',0),
 (11,47,1,'MB123',NULL,'Not Started',0);
/*!40000 ALTER TABLE `tbl_progress` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_quizzes`
--

DROP TABLE IF EXISTS `tbl_quizzes`;
CREATE TABLE `tbl_quizzes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `course_code` varchar(50) NOT NULL default '',
  `module_number` int(10) unsigned NOT NULL default '0',
  `quiz_type` varchar(10) NOT NULL default '',
  `quiz_question` text NOT NULL,
  `option_a` text,
  `option_b` text,
  `option_c` text,
  `option_d` text,
  `correct_answer` text NOT NULL,
  `module_id` varchar(45) NOT NULL default '',
  `faculty_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_quizzes`
--

/*!40000 ALTER TABLE `tbl_quizzes` DISABLE KEYS */;
INSERT INTO `tbl_quizzes` (`id`,`course_code`,`module_number`,`quiz_type`,`quiz_question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_answer`,`module_id`,`faculty_id`) VALUES 
 (1,'IT001',1,'MCQ','What does IT stand for?','Internet Technology','Information Technology','Integrated Technology','Intelligent Technology','B\r','',0),
 (2,'IT001',1,'MCQ','Which of the following is considered hardware?','Microsoft Word','Google Chrome','Keyboard','Windows 11','C\r','',0),
 (3,'IT001',1,'MCQ','Which software controls the overall operation of a computer?','Operating System','Mouse','Printer','Monitor','A\r','',0),
 (4,'IT001',1,'MCQ','What type of network covers a large geographical area like the Internet?','LAN','PAN','MAN','WAN','D\r','',0),
 (5,'IT001',1,'MCQ','Which of the following is an example of application software?','Keyboard','System Unit','Microsoft Excel','Router','C','',0),
 (6,'MB123',1,'MCQ','What is marine biology?','Study of land animals','Study of freshwater life','Study of ocean life','Study of atmospheric conditions','C\r','',0),
 (7,'MB123',1,'MCQ','Oceans cover approximately what percentage of the Earth’s surface?','50%','71%','35%','80%','B\r','',0);
INSERT INTO `tbl_quizzes` (`id`,`course_code`,`module_number`,`quiz_type`,`quiz_question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_answer`,`module_id`,`faculty_id`) VALUES 
 (8,'MB123',1,'MCQ','Which of the following is a major threat to coral reefs?','Deforestation','Ocean acidification','Air pollution','Desertification','B\r','',0),
 (9,'MB123',1,'MCQ','Overfishing primarily affects?','Marine mammals','Fish populations','Coral reefs','Mangroves','B\r','',0),
 (10,'MB123',1,'MCQ','Coral reefs are considered the “rainforests of the sea.”','True','False','','','A','',0);
/*!40000 ALTER TABLE `tbl_quizzes` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_signup`
--

DROP TABLE IF EXISTS `tbl_signup`;
CREATE TABLE `tbl_signup` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `fullname` varchar(45) NOT NULL default '',
  `eml` varchar(45) NOT NULL default '',
  `pwd` varchar(225) NOT NULL default '',
  `role` varchar(45) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_signup`
--

/*!40000 ALTER TABLE `tbl_signup` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_signup` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_users`
--

DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL auto_increment,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `bio` text NOT NULL,
  `profile_pic` varchar(500) default NULL,
  `faculty_id_code` varchar(50) default NULL,
  `adminID` int(10) unsigned default NULL,
  `faculty_id` varchar(45) NOT NULL default '',
  `status` enum('Pending','Approved','Rejected') default 'Pending',
  `approved_at` datetime default NULL,
  `is_approved` varchar(45) NOT NULL default '',
  `is_archived` tinyint(1) NOT NULL default '0',
  `archived_date` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_users`
--

/*!40000 ALTER TABLE `tbl_users` DISABLE KEYS */;
INSERT INTO `tbl_users` (`user_id`,`first_name`,`last_name`,`email`,`password`,`role`,`phone`,`bio`,`profile_pic`,`faculty_id_code`,`adminID`,`faculty_id`,`status`,`approved_at`,`is_approved`,`is_archived`,`archived_date`,`created_at`) VALUES 
 (4,'mila','','mila@gmail.com','xzit63Fxeb7/RYnZmIFeumrZ1vPqgZJS5U6WUhm2kZWuoRNo','student','','','~/uploads/93c71ce3-fc0d-410e-9d04-bf92571e49a4.jpg',NULL,NULL,'','Pending',NULL,'',1,'2026-01-12 00:08:03',NULL),
 (6,'Admin','User','Admin@gmail.com','+xLPDszuiBUwzEAUNq4ZiX3QfRumJFwfNBe027GpWWvTxe2Y','admin','09123456789','System Administrator','~/uploads/profile/admin_6.png',NULL,NULL,'','Pending',NULL,'',0,NULL,NULL),
 (25,'margie','caturan','margie@gmail.com','84n8XMuHYWE5rrIv15TbsLfA3dPbr+zho96oUXbH/cC4lsXW','student','','','default.png',NULL,NULL,'','Pending',NULL,'',0,NULL,NULL),
 (38,'mariaa','belbario','maria@gmail.com','MlZyOnHWTwFos17QY85/V57gCLaG13DZgIAvffE+1ncXcDjb','student','','','~/uploads/01ea9a30-d451-4175-8f67-4960dea3aa90.png',NULL,NULL,'','Approved',NULL,'',0,NULL,NULL),
 (40,'wayne','Castro','wayne@gmail.com','gSMzCSkKYWiHNEFQs5vhwBpfXz8RvCrUMBpGCQwK+e6EFL22','faculty','','','default.png','FACGZUBA',NULL,'','Pending',NULL,'1',0,NULL,NULL);
INSERT INTO `tbl_users` (`user_id`,`first_name`,`last_name`,`email`,`password`,`role`,`phone`,`bio`,`profile_pic`,`faculty_id_code`,`adminID`,`faculty_id`,`status`,`approved_at`,`is_approved`,`is_archived`,`archived_date`,`created_at`) VALUES 
 (41,'April','agno','april@gmail.com','gR7YEqq/lwVRA4spCz5Dn5zka3jB+zgn7y6x6CihUMNEj51K','faculty','','','ee0de9bc-c597-4761-87f3-952a26849801.png','FACH598A',NULL,'','Pending',NULL,'1',0,NULL,NULL),
 (42,'gigay','caturan','Gay@gmail.com','gXSI7DI7FrpOs2F3doRvXKXK1AwNKh7/XMEP06s9C01KxYjX','student','','','default.png',NULL,NULL,'','Approved',NULL,'',0,NULL,'2026-02-15 12:25:12'),
 (43,'Faculty','madam','madam@gmail.com','Sua5L7m79r6zva31nHBMSOT9jWX19qJzfVGZu/9fADccD934','faculty','','','default.png','FACWV9VW',NULL,'','Pending',NULL,'1',0,NULL,'2026-02-15 12:36:36'),
 (44,'rosamae','caturan','caturanrosamae@spamast.edu.ph','IDK/4JSkbn0OeWPbNuxQ/Xu7gA3yvpR9grYgsW0KYXYMbXEz','student','','','default.png',NULL,NULL,'','Approved',NULL,'',0,NULL,'2026-03-16 06:56:56'),
 (45,'Maria','Caturan','Vivian@gmail.com','c4QeUg5zpUSIZmUmZI4a54aQo9Zds1gkiI1m5K5HsRVv31HZ','student','','','default.png',NULL,NULL,'','Approved',NULL,'',0,NULL,'2026-06-21 11:36:01');
INSERT INTO `tbl_users` (`user_id`,`first_name`,`last_name`,`email`,`password`,`role`,`phone`,`bio`,`profile_pic`,`faculty_id_code`,`adminID`,`faculty_id`,`status`,`approved_at`,`is_approved`,`is_archived`,`archived_date`,`created_at`) VALUES 
 (46,'Cara','Lim','Cara@gmail.com','OWmSdlEzBu5KrAymndB5Th3gqnEcjQxCToWhQuVd78yhPiTp','student','','','default.png',NULL,NULL,'','Approved',NULL,'',0,NULL,'2026-06-21 11:38:47'),
 (47,'kristine','Caturan','Kristine@gmail.com','8LOytZ9sPLib7oLX8Uq9yjNSuzMAwaoyaxQDgtaHW8AXr8PV','student','','','default.png',NULL,NULL,'','Approved',NULL,'',0,NULL,'2026-06-21 11:43:10'),
 (48,'gaygay','caturan','GAYGAY@gmail.com','QDXhp/jzXVA/KGV0P4EOLtOBRsQ+sqiblCe8nYtWfTQNDED5','faculty','','','default.png','FACRFQHG',NULL,'','Pending',NULL,'',0,NULL,'2026-06-23 04:24:02'),
 (49,'april','agno','agno@gmail.com','PU0FWnD/jwjM+lCrB4cJe4Anym9bYiqhiWomfBfQIqEsCbpB','faculty','','','default.png','FACFGWXX',NULL,'','Pending',NULL,'',0,NULL,'2026-06-23 04:25:42'),
 (50,'april','agno','Ril@gmai.com','f8VSbv8s1hS4EOZGYR0iEB4OlN98Y+nN6hlV8PXMtFvDSr7y','faculty','','','default.png','FAC3NDBF',NULL,'','Pending',NULL,'',0,NULL,'2026-06-23 04:27:42'),
 (51,'maria','amor','Amor@gmail.com','nEnzjPNR0ANUo8lJNAjBDOeZAGT8X7JnhJ/bs5crsRX89M6f','faculty','','','default.png','FACNZJ45',NULL,'','Pending',NULL,'1',0,NULL,'2026-06-23 04:28:47');
/*!40000 ALTER TABLE `tbl_users` ENABLE KEYS */;


--
-- Table structure for table `bsitdb`.`tbl_videos`
--

DROP TABLE IF EXISTS `tbl_videos`;
CREATE TABLE `tbl_videos` (
  `video_id` int(10) unsigned NOT NULL auto_increment,
  `course_code` varchar(45) NOT NULL default '',
  `module_number` int(10) unsigned NOT NULL default '0',
  `video_title` varchar(255) NOT NULL default '',
  `video_file_path` text,
  `faculty_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bsitdb`.`tbl_videos`
--

/*!40000 ALTER TABLE `tbl_videos` DISABLE KEYS */;
INSERT INTO `tbl_videos` (`video_id`,`course_code`,`module_number`,`video_title`,`video_file_path`,`faculty_id`) VALUES 
 (1,'MB123',1,'Introduction to Marine Biology','uploads/videos/7baab1ff-0e01-4233-9c6a-fd4d514cc08f.mp4',0);
/*!40000 ALTER TABLE `tbl_videos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
