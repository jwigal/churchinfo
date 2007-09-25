<?php 
/*******************************************************************************
 *
 *  filename    : config_CI.inc.php
 *  last change : 2007-06-25
 *  description : Override MRBS control parameters by ChurchInfo config table
 *
 *  ChurchInfo and is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 ******************************************************************************/
###########################################################################
# MBRS ChurchInfo Bridging Note:
#  In Churchinfo Environment, the following variables are extract from config_cfg table 
#	instead of being hard-coded in this config.inc.php.
#  For easy upgrade (of MRBS), the original config.inc.php file is preserved as much as possible. All necessary variables assigned 
# there and now moved to database in Churchinfo is overided in this file.
#
#  When doing upgrade, add the following line to config.inc.php before setting language parameters (currently before line 388):
#  include 'config_CI.inc.php';
#
###########################################################################
require "../Include/Config.php";
require "../Include/Functions.php";

$auth["session"] = "CI";
$auth["type"] = "CI";
$db_host = $sSERVERNAME;
$db_database = $sDATABASE;
$db_login = $sUSER;
$db_password = $sPASSWORD;

$db_tbl_prefix = $sMBRSDBPrefix;
$mrbs_admin = $sMRBSAdminName;
$mrbs_admin_email = $sMRBSAdminEmail;
$mrbs_company = $sChurchName;
$url_base = $sRootPath.'/'.$sMRBSPathName;
$enable_periods = $sMRBS_eable_periods;
$resolution = $sMRBS_resolution;
$morningstarts = $sMRBS_morningstarts;
$eveningends   = $sMRBS_eveningends;
$morningstarts_minutes = $sMRBS_morningstart_min;
$eveningends_minutes = $sMRBS_eveningends_min;
$periods = explode(",", $sMRBSPeriods);
$weekstarts = $sMRBS_weekstarts;
$dateformat = $sMRBS_dateformat;
$twentyfourhour_format = $sMRBS_24hrs_format;
$default_report_days = $sMRBS_default_rpt_days;
$search["count"] = $sMRBS_search_count;
$refresh_rate = $sMRBS_refresh_rate;
$area_list_format = $sMRBS_area_list_fmt;
$monthly_view_entries_details = $sMRBS_mon_v_entries_dtl;
$view_week_number = $bMRBSViewWeekNumber;
$times_right_side = $bMRBSTimesRightSide;
$javascript_cursor = $bMRBSJavascriptCursor;
$show_plus_link = $bMRBSShowPlusLink;
$highlight_method = $sMRBSHighlight_Method;
$default_view = "day";
define ("MAIL_ADMIN_ON_BOOKINGS", $bMRBSMailAdminOnBooking);
define ("MAIL_AREA_ADMIN_ON_BOOKINGS", $bMRBSMailAreaAdminOnBooking);
define ("MAIL_ROOM_ADMIN_ON_BOOKINGS", $bMRBSMailRoomAdminOnBooking);
define ("MAIL_ADMIN_ON_DELETE", $bMRBSMailAdminOnDelete);
define ("MAIL_ADMIN_ALL", $bMRBSMailAdminAll);
define ("MAIL_DETAILS", $bMRBSMailDetails);
define ("MAIL_BOOKER", $bMRBSMailBooker);
define ("MAIL_DOMAIN", $bMRBSMailDomain);
define ("MAIL_USERNAME_SUFFIX", $sMRBSMailUserSfx);
define ("MAIL_ADMIN_BACKEND", $sMRBSAdminBackend);
define ("SENDMAIL_PATH", $sMRBSSendMailPath);
define ("SENDMAIL_ARGS", $sMRBSSendMailArgs);
define ("SMTP_HOST", $sSMTPHost);
$delimeter = strpos($sSMTPHost, ':');
if ($delimeter === FALSE) {
	$sRMBSSMTPPort = 25;                // Default port number
} else {
	$sRMBSSMTPPort = substr($sSMTPHost, $delimeter+1);
}
if (!is_int($sMRBSSMTPPort))
	$sMRBSSMTPPort = 25;
define ("SMTP_PORT",$sMRBSSMTPPort);
define ("SMTP_AUTH", $sSMTPAuth);
define ("SMTP_USERNAME", $sSMTPUser);
define ("SMTP_PASSWORD", $sSMTPPass);
define ("MAIL_ADMIN_LANG", $sRMBSLanguage);
define ("MAIL_FROM", $mrbs_admin_email);
if ($sRMBSEmailRecipient == "")
	define ("MAIL_RECIPIENTS", $mrbs_admin_email);
else
	define ("MAIL_RECIPIENTS", $sRMBSEmailRecipient);
define ("MAIL_CC", $sRMBSEmailCCList);
$mail["subject"] = $sRMBSEmailSubject;
$mail["subject_delete"] = $sRMBSEmailDeleteSubject;
$mail["new_entry"] = $sRMBSEntryAddEmailContent;
$mail["changed_entry"] = $sRMBSEntryChangedEmailContent;
$mail["deleted_entry"] = $sRMBSEntryDeleteEmailContent;

?>