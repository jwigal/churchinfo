<?php
/*******************************************************************************
 *
 *  filename    : SundaySchool.php
 *  last change : 2003-09-03
 *  description : form to invoke Sunday School reports
 *
 *  ChurchInfo is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 ******************************************************************************/

// Include the function library
require "Include/Config.php";
require "Include/Functions.php";

// Get all the groups
$sSQL = "SELECT * FROM group_grp ORDER BY grp_Name";
$rsGroups = RunQuery($sSQL);

// If CSVAdminOnly option is enabled and user is not admin, redirect to the menu.
if (!$_SESSION['bAdmin'] && $bCSVAdminOnly) {
	Redirect("Menu.php");
	exit;
}

// Set the page title and include HTML header
$sPageTitle = gettext("Sunday School Reports");
require "Include/Header.php";

// Is this the second pass?
if (isset($_POST["SubmitClassList"]) || isset($_POST["SubmitClassAttendance"])) {
   $iGroupID = FilterInput($_POST['GroupID'],'int');
	$iFYID = FilterInput($_POST["FYID"], 'int');
	$dFirstSunday = FilterInput($_POST["FirstSunday"]);
	$dLastSunday = FilterInput($_POST["LastSunday"]);
	$dNoSchool1 = FilterInput($_POST["NoSchool1"]);
	$dNoSchool2 = FilterInput($_POST["NoSchool2"]);
	$dNoSchool3 = FilterInput($_POST["NoSchool3"]);
	$dNoSchool4 = FilterInput($_POST["NoSchool4"]);
   $iExtraStudents = FilterInput($_POST["ExtraStudents"], 'int');
   $iExtraTeachers = FilterInput($_POST["ExtraTeachers"], 'int');
   $_SESSION['idefaultFY'] = $iFYID;

   if (isset($_POST["SubmitClassList"])) {
      Redirect ("Reports/ClassList.php?GroupID=" . $iGroupID . "&FYID=" . $iFYID . "&FirstSunday=" . $dFirstSunday . "&LastSunday=" . $dLastSunday);
   } else if (isset($_POST["SubmitClassAttendance"])) {
      $toStr = "Reports/ClassAttendance.php?";
      $toStr .= "GroupID=" . $iGroupID;
      $toStr .= "&FYID=" . $iFYID;
      $toStr .= "&FirstSunday=" . $dFirstSunday;
      $toStr .= "&LastSunday=" . $dLastSunday;
      if ($dNoSchool1)
         $toStr .= "&NoSchool1=" . $dNoSchool1;
      if ($dNoSchool2)
         $toStr .= "&NoSchool2=" . $dNoSchool2;
      if ($dNoSchool3)
         $toStr .= "&NoSchool3=" . $dNoSchool3;
      if ($dNoSchool4)
         $toStr .= "&NoSchool4=" . $dNoSchool4;
      if ($iExtraStudents)
         $toStr .= "&ExtraStudents=" . $iExtraStudents;
      if ($iExtraTeachers)
         $toStr .= "&ExtraTeachers=" . $iExtraTeachers;
      Redirect ($toStr);
   }
} else {
   $iFYID = $_SESSION['idefaultFY'];
   $iGroupID = 0;
	$dFirstSunday = "";
	$dLastSunday = "";
}

?>

<form method="post" action="<?php echo $_SERVER['PHP_SELF']?>">

<table cellpadding="3" align="left">
	<tr>
		<td class="LabelColumn"><?php echo gettext("Select Group:"); ?></td>
		<td class="TextColumn">
			<?php
			// Create the group select drop-down
			echo "<select id=\"GroupID\" name=\"GroupID\" onChange=\"UpdateRoles();\"><option value=\"0\">". gettext('None') . "</option>";
			while ($aRow = mysql_fetch_array($rsGroups)) {
				extract($aRow);
				echo "<option value=\"" . $grp_ID . "\">" . $grp_Name . "</option>";
			}
			echo "</select>";
			?>
		</td>
	</tr>

   <tr>
      <td class="LabelColumn"><?php echo gettext("Fiscal Year:"); ?></td>
      <td class="TextColumnWithBottomBorder">
	      <select name="FYID">
		      <option value="0"><?php echo gettext("Select Fiscal Year"); ?></option>
		      <option value="1" <?php if ($iFYID == 1) { echo "selected"; } ?>><?php echo gettext("1996/97"); ?></option>
		      <option value="2" <?php if ($iFYID == 2) { echo "selected"; } ?>><?php echo gettext("1997/98"); ?></option>
		      <option value="3" <?php if ($iFYID == 3) { echo "selected"; } ?>><?php echo gettext("1998/99"); ?></option>
		      <option value="4" <?php if ($iFYID == 4) { echo "selected"; } ?>><?php echo gettext("1999/00"); ?></option>
		      <option value="5" <?php if ($iFYID == 5) { echo "selected"; } ?>><?php echo gettext("2000/01"); ?></option>
		      <option value="6" <?php if ($iFYID == 6) { echo "selected"; } ?>><?php echo gettext("2001/02"); ?></option>
		      <option value="7" <?php if ($iFYID == 7) { echo "selected"; } ?>><?php echo gettext("2002/03"); ?></option>
		      <option value="8" <?php if ($iFYID == 8) { echo "selected"; } ?>><?php echo gettext("2003/04"); ?></option>
		      <option value="9" <?php if ($iFYID == 9) { echo "selected"; } ?>><?php echo gettext("2004/05"); ?></option>
		      <option value="10" <?php if ($iFYID == 10) { echo "selected"; } ?>><?php echo gettext("2005/06"); ?></option>
		      <option value="11" <?php if ($iFYID == 11) { echo "selected"; } ?>><?php echo gettext("2006/07"); ?></option>
		      <option value="12" <?php if ($iFYID == 12) { echo "selected"; } ?>><?php echo gettext("2007/08"); ?></option>
		      <option value="13" <?php if ($iFYID == 13) { echo "selected"; } ?>><?php echo gettext("2008/09"); ?></option>
		      <option value="14" <?php if ($iFYID == 14) { echo "selected"; } ?>><?php echo gettext("2009/10"); ?></option>
		      <option value="15" <?php if ($iFYID == 15) { echo "selected"; } ?>><?php echo gettext("2010/11"); ?></option>
		      <option value="16" <?php if ($iFYID == 16) { echo "selected"; } ?>><?php echo gettext("2011/12"); ?></option>
		      <option value="17" <?php if ($iFYID == 17) { echo "selected"; } ?>><?php echo gettext("2012/13"); ?></option>
		      <option value="18" <?php if ($iFYID == 18) { echo "selected"; } ?>><?php echo gettext("2013/14"); ?></option>
	      </select>
      </td>
   </tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("First Sunday:"); ?></td>
		<td class="TextColumn"><input type="text" name="FirstSunday" value="<?php echo $dFirstSunday; ?>" maxlength="10" id="sel1" size="11">&nbsp;<input type="image" onclick="return showCalendar('sel1', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span></td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("Last Sunday:"); ?></td>
		<td class="TextColumn"><input type="text" name="LastSunday" value="<?php echo $dLastSunday; ?>" maxlength="10" id="sel2" size="11">&nbsp;<input type="image" onclick="return showCalendar('sel2', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span></td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("No Sunday School:"); ?></td>
		<td class="TextColumn"><input type="text" name="NoSchool1" value="<?php echo $dNoSchool1; ?>" maxlength="10" id="NoSchool1" size="11">&nbsp;<input type="image" onclick="return showCalendar('NoSchool1', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span></td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("No Sunday School:"); ?></td>
		<td class="TextColumn"><input type="text" name="NoSchool2" value="<?php echo $dNoSchool2; ?>" maxlength="10" id="NoSchool2" size="11">&nbsp;<input type="image" onclick="return showCalendar('NoSchool2', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span></td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("No Sunday School:"); ?></td>
		<td class="TextColumn"><input type="text" name="NoSchool3" value="<?php echo $dNoSchool3; ?>" maxlength="10" id="NoSchool3" size="11">&nbsp;<input type="image" onclick="return showCalendar('NoSchool3', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span></td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("No Sunday School:"); ?></td>
		<td class="TextColumn"><input type="text" name="NoSchool4" value="<?php echo $dNoSchool4; ?>" maxlength="10" id="NoSchool4" size="11">&nbsp;<input type="image" onclick="return showCalendar('NoSchool4', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span></td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Number of extra rows for write-in students"); ?><?php echo gettext("Extra Students:"); ?></td>
		<td class="TextColumn"><input type="text" name="ExtraStudents" value="<?php echo $iExtraStudents; ?>" id="ExtraStudents" size="11">&nbsp;</td>
	</tr>

	<tr>
		<td class="LabelColumn"><?php addToolTip("Number of extra rows for write-in teachers"); ?><?php echo gettext("Extra Teachers:"); ?></td>
		<td class="TextColumn"><input type="text" name="ExtraTeachers" value="<?php echo $iExtraTeachers; ?>" id="ExtraTeachers" size="11">&nbsp;</td>
	</tr>

   <tr>
      <td><input type="submit" class="icButton" name="SubmitClassList" <?php echo 'value="' . gettext("Create Class List") . '"'; ?>></td>
      <td><input type="submit" class="icButton" name="SubmitClassAttendance" <?php echo 'value="' . gettext("Create Attendance Sheet") . '"'; ?>></td>
      <td><input type="button" class="icButton" name="Cancel" <?php echo 'value="' . gettext("Cancel") . '"'; ?> onclick="javascript:document.location='Menu.php';"></td>
   </tr>

</table>

</form>

<?php
require "Include/Footer.php";
?>
