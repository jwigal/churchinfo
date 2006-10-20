--        It is highly recommended you backup your MySQL database before executing this
--        script. To backup from the command prompt use the following.
--
-- system> mysqldump -u root -p db_name > filename.sql
--
-- Upon success filename.sql contains all the SQL to rebuild the database db_name.
-- In case you need to restore your backup use the following command.
--
-- system> mysql -u root -p db_name < filename.sql
--
--      The SQL script below will migrate your database from version 1.2.6 to 1.2.7.
--      There is no script to go back to 1.2.6.  If you need to roll back to 1.2.6 your
--      best bet is to restore your MySQL backup and install 1.2.6 PHP code.
--
--

-- New table to keep track of version information
CREATE TABLE IF NOT EXISTS `version_ver` (
  `ver_ID` mediumint(9) unsigned NOT NULL auto_increment,
  `ver_version` varchar(50) NOT NULL default '',
  `ver_date` datetime default NULL,
  PRIMARY KEY  (`ver_ID`),
  UNIQUE KEY `ver_version` (`ver_version`)
) TYPE=MyISAM;

INSERT IGNORE INTO `version_ver` (`ver_version`, `ver_date`) VALUES ('1.2.7',NOW());

-- New table for user settings and permissions
CREATE TABLE IF NOT EXISTS `userconfig_ucfg` (
  `ucfg_per_id` mediumint(9) unsigned NOT NULL,
  `ucfg_id` int(11) NOT NULL default '0',
  `ucfg_name` varchar(50) NOT NULL default '',
  `ucfg_value` text default NULL,
  `ucfg_type` enum('text','number','date','boolean','textarea') NOT NULL default 'text',
  `ucfg_tooltip` text NOT NULL,
  `ucfg_permission` enum('FALSE','TRUE') NOT NULL default 'FALSE',
  PRIMARY KEY  (`ucfg_per_ID`,`ucfg_id`)
) TYPE=MyISAM;

-- Add default permissions for new users
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (0,0,'bEmailMailto','1',
'boolean','User permission to send email via mailto: links','TRUE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (0,1,'sMailtoDelimiter',',',
'text','Delimiter to separate emails in mailto: links','TRUE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (0,2,'bSendPHPMail','0',
'boolean','User permission to send email using PHPMailer','FALSE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (0,3,'sFromEmailAddress','',
'text','Reply email address for PHPMailer','FALSE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (0,4,'sFromName','ChurchInfo Webmaster',
'text','Name that appears in From field','FALSE');


-- Add permissions for Admin
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_ID, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (1,0,'bEmailMailto','1',
'boolean','User permission to send email via mailto: links','TRUE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_ID, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (1,1,'sMailtoDelimiter',',',
'text','user permission to send email via mailto: links','TRUE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (1,2,'bSendPHPMail','1',
'boolean','User permission to send email using PHPMailer','TRUE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (1,3,'sFromEmailAddress','',
'text','Reply email address for PHPMailer','TRUE');
INSERT IGNORE INTO `userconfig_ucfg` (ucfg_per_id, ucfg_id, ucfg_name, ucfg_value,
ucfg_type, ucfg_tooltip, ucfg_permission)
VALUES (1,4,'sFromName','ChurchInfo Webmaster',
'text','Name that appears in From field','TRUE');


-- Fix a typo
UPDATE IGNORE `config_cfg` 
SET `cfg_name`='sReminderNoPayments' WHERE `cfg_name`='sReminderNoPlayments';

-- Renumber config values to match those of a fresh install.
-- Helpfull in keeping consistency between upgrades and new installations.
-- 1 thru 1000 is for 'General'
-- 1001 thru 2000 is for 'ChurchInfoReport'
-- 2001 thru 3000 is for future use
--
-- Step 1) Copy current config_cfg table into temporary table
DROP TABLE IF EXISTS `tempconfig_tcfg`;
CREATE TABLE `tempconfig_tcfg` (
  `tcfg_id` int(11) NOT NULL default '0',
  `tcfg_name` varchar(50) NOT NULL default '',
  `tcfg_value` text default NULL,
  `tcfg_type` enum('text','number','date','boolean','textarea') NOT NULL default 'text',
  `tcfg_default` text NOT NULL default '',
  `tcfg_tooltip` text NOT NULL,
  `tcfg_section` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`tcfg_id`),
  UNIQUE KEY `tcfg_name` (`tcfg_name`),
  KEY `tcfg_id` (`tcfg_id`)
) TYPE=MyISAM;

INSERT INTO `tempconfig_tcfg` 
SELECT `cfg_id`,`cfg_name`,`cfg_value`,`cfg_type`,`cfg_default`,`cfg_tooltip`,`cfg_section`
FROM `config_cfg` ORDER BY `cfg_id`;

-- Step 2) Make sure `tempconfig_tcfg` matches `config_cfg` or exit with error
--         This is to make darn sure we can restore `config_cfg`  

-- CHECKSUM TABLE tempconfig_tcfg EXTENDED;
-- CHECKSUM TABLE config_cfg EXTENDED;

-- Step 3) Drop the config table and make a new empty table
DROP TABLE IF EXISTS `config_cfg`;
CREATE TABLE `config_cfg` (
  `cfg_id` int(11) NOT NULL default '0',
  `cfg_name` varchar(50) NOT NULL default '',
  `cfg_value` text default NULL,
  `cfg_type` enum('text','number','date','boolean','textarea') NOT NULL default 'text',
  `cfg_default` text NOT NULL default '',
  `cfg_tooltip` text NOT NULL,
  `cfg_section` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`cfg_id`),
  UNIQUE KEY `cfg_name` (`cfg_name`),
  KEY `cfg_id` (`cfg_id`)
) TYPE=MyISAM;

-- Step 4) Copy data into the config table in the desired order
INSERT INTO `config_cfg`
SELECT 1,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sWEBCALENDARDB';
INSERT INTO `config_cfg`
SELECT 2,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='aHTTPports';
INSERT INTO `config_cfg`
SELECT 3,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='aHTTPSports';
INSERT INTO `config_cfg`
SELECT 4,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='debug';
INSERT INTO `config_cfg`
SELECT 5,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sJPGRAPH_PATH';
INSERT INTO `config_cfg`
SELECT 6,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sFPDF_PATH';
INSERT INTO `config_cfg`
SELECT 7,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDirClassifications';
INSERT INTO `config_cfg`
SELECT 8,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDirRoleHead';
INSERT INTO `config_cfg`
SELECT 9,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDirRoleSpouse';
INSERT INTO `config_cfg`
SELECT 10,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDirRoleChild';
INSERT INTO `config_cfg`
SELECT 11,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sSessionTimeout';
INSERT INTO `config_cfg`
SELECT 12,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='aFinanceQueries';
INSERT INTO `config_cfg`
SELECT 13,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bCSVAdminOnly';
INSERT INTO `config_cfg`
SELECT 14,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDefault_Pass';
INSERT INTO `config_cfg`
SELECT 15,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sMinPasswordLength';
INSERT INTO `config_cfg`
SELECT 16,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sMinPasswordChange';
INSERT INTO `config_cfg`
SELECT 17,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDisallowedPasswords';
INSERT INTO `config_cfg`
SELECT 18,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='iMaxFailedLogins';
INSERT INTO `config_cfg`
SELECT 19,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bToolTipsOn';
INSERT INTO `config_cfg`
SELECT 20,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='iNavMethod';
INSERT INTO `config_cfg`
SELECT 21,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bFamListFirstNames';
INSERT INTO `config_cfg`
SELECT 22,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='iPDFOutputType';
INSERT INTO `config_cfg`
SELECT 23,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDefaultCity';
INSERT INTO `config_cfg`
SELECT 24,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDefaultState';
INSERT INTO `config_cfg`
SELECT 25,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDefaultCountry';
INSERT INTO `config_cfg`
SELECT 26,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bEmailSend';
INSERT INTO `config_cfg`
SELECT 27,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sSendType';
INSERT INTO `config_cfg`
SELECT 28,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sToEmailAddress';
INSERT INTO `config_cfg`
SELECT 29,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sSMTPHost';
INSERT INTO `config_cfg`
SELECT 30,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sSMTPAuth';
INSERT INTO `config_cfg`
SELECT 31,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sSMTPUser';
INSERT INTO `config_cfg`
SELECT 32,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sSMTPPass';
INSERT INTO `config_cfg`
SELECT 33,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sWordWrap';
INSERT INTO `config_cfg`
SELECT 34,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bDefectiveBrowser';
INSERT INTO `config_cfg`
SELECT 35,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bShowFamilyData';
INSERT INTO `config_cfg`
SELECT 36,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bOldVCardVersion';
INSERT INTO `config_cfg`
SELECT 37,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bEnableBackupUtility';
INSERT INTO `config_cfg`
SELECT 38,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sGZIPname';
INSERT INTO `config_cfg`
SELECT 39,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sZIPname';
INSERT INTO `config_cfg`
SELECT 40,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sPGPname';
INSERT INTO `config_cfg`
SELECT 41,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sLanguage';
INSERT INTO `config_cfg`
SELECT 42,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='iFYMonth';
INSERT INTO `config_cfg`
SELECT 43,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sXML_RPC_PATH';
INSERT INTO `config_cfg`
SELECT 44,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sGeocoderID';
INSERT INTO `config_cfg`
SELECT 45,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sGeocoderPW';
INSERT INTO `config_cfg`
SELECT 46,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sGoogleMapKey';
INSERT INTO `config_cfg`
SELECT 47,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='nChurchLatitude';
INSERT INTO `config_cfg`
SELECT 48,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='nChurchLongitude';
INSERT INTO `config_cfg`
SELECT 49,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bHidePersonAddress';
INSERT INTO `config_cfg`
SELECT 50,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bHideFriendDate';
INSERT INTO `config_cfg`
SELECT 51,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bHideFamilyNewsletter';
INSERT INTO `config_cfg`
SELECT 52,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bHideWeddingDate';
INSERT INTO `config_cfg`
SELECT 53,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bHideLatLon';
INSERT INTO `config_cfg`
SELECT 54,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bUseDonationEnvelopes';
INSERT INTO `config_cfg`
SELECT 55,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sHeader';
INSERT INTO `config_cfg`
SELECT 56,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sISTusername';
INSERT INTO `config_cfg`
SELECT 57,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sISTpassword';
INSERT INTO `config_cfg`
SELECT 999,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bRegistered';
INSERT INTO `config_cfg`
SELECT 1001,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='leftX';
INSERT INTO `config_cfg`
SELECT 1002,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='incrementY';
INSERT INTO `config_cfg`
SELECT 1003,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchName';
INSERT INTO `config_cfg`
SELECT 1004,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchAddress';
INSERT INTO `config_cfg`
SELECT 1005,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchCity';
INSERT INTO `config_cfg`
SELECT 1006,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchState';
INSERT INTO `config_cfg`
SELECT 1007,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchZip';
INSERT INTO `config_cfg`
SELECT 1008,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchPhone';
INSERT INTO `config_cfg`
SELECT 1009,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sChurchEmail';
INSERT INTO `config_cfg`
SELECT 1010,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sHomeAreaCode';
INSERT INTO `config_cfg`
SELECT 1011,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sTaxReport1';
INSERT INTO `config_cfg`
SELECT 1012,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sTaxReport2';
INSERT INTO `config_cfg`
SELECT 1013,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sTaxReport3';
INSERT INTO `config_cfg`
SELECT 1014,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sTaxSigner';
INSERT INTO `config_cfg`
SELECT 1015,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sReminder1';
INSERT INTO `config_cfg`
SELECT 1016,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sReminderSigner';
INSERT INTO `config_cfg`
SELECT 1017,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sReminderNoPledge';
INSERT INTO `config_cfg`
SELECT 1018,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sReminderNoPayments';
INSERT INTO `config_cfg`
SELECT 1019,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirm1';
INSERT INTO `config_cfg`
SELECT 1020,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirm2';
INSERT INTO `config_cfg`
SELECT 1021,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirm3';
INSERT INTO `config_cfg`
SELECT 1022,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirm4';
INSERT INTO `config_cfg`
SELECT 1023,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirm5';
INSERT INTO `config_cfg`
SELECT 1024,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirm6';
INSERT INTO `config_cfg`
SELECT 1025,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sConfirmSigner';
INSERT INTO `config_cfg`
SELECT 1026,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sPledgeSummary1';
INSERT INTO `config_cfg`
SELECT 1027,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sPledgeSummary2';
INSERT INTO `config_cfg`
SELECT 1028,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDirectoryDisclaimer1';
INSERT INTO `config_cfg`
SELECT 1029,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='sDirectoryDisclaimer2';
INSERT INTO `config_cfg`
SELECT 1030,`tcfg_name`,`tcfg_value`,`tcfg_type`,`tcfg_default`,`tcfg_tooltip`,`tcfg_section`
FROM `tempconfig_tcfg` WHERE `tcfg_name`='bDirLetterHead';

DROP TABLE IF EXISTS `tempconfig_tcfg`;
