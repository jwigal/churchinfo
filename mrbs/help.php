<?php

# $Id: help.php,v 1.1 2007/06/22 23:45:27 amagrace Exp $

require_once "grab_globals.inc.php";
include "config.inc.php";
include "$dbsys.inc";
include "functions.inc";
include "version.inc";

#If we dont know the right date then make it up
if(!isset($day) or !isset($month) or !isset($year))
{
	$day   = date("d");
	$month = date("m");
	$year  = date("Y");
}
if(empty($area))
	$area = get_default_area();

print_header($day, $month, $year, $area);

echo "<H3>" . get_vocab("about_mrbs") . "</H3>\n";
echo "<P><a href=\"http://mrbs.sourceforge.net\">".get_vocab("mrbs")."</a> - ".get_mrbs_version()."\n";
echo "<BR>" . get_vocab("database") . sql_version() . "\n";
echo "<BR>" . get_vocab("system") . php_uname() . "\n";
echo "<BR>PHP: " . phpversion() . "\n";

echo "<H3>" . get_vocab("help") . "</H3>\n";
echo get_vocab("please_contact") . '<a href="mailto:' . $mrbs_admin_email
	. '">' . $mrbs_admin
	. "</a> " . get_vocab("for_any_questions") . "\n";
 
include "site_faq" . $faqfilelang . ".html";

include "trailer.inc";
?>
