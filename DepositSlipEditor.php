<?php
/*******************************************************************************
 *
 *  filename    : DepositSlipEditor.php
 *  last change : 2004-6-12
 *  website     : http://www.infocentral.org
 *  copyright   : Copyright 2001, 2002, 2003 Deane Barker, Chris Gebhardt, Michael Wilt
 *
 *  InfoCentral is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 ******************************************************************************/

//Include the function library
require "Include/Config.php";
require "Include/Functions.php";

//Get whether making new deposit slip from the query string
$bNew = FilterInput($_GET["new"],'int');
$linkBack = FilterInput($_GET["linkBack"]);

$iDepositSlipID = $_SESSION['iCurrentDeposit'];

//Set the page title
if ($bNew)
	$sPageTitle = gettext("Deposit Slip Number: TBD");
else
	$sPageTitle = gettext("Deposit Slip Number: " . $iDepositSlipID);

// Security: User must have finance permission to use this form
if (!$_SESSION['bFinance'])
{
	Redirect("Menu.php");
	exit;
}

if ($iDepositSlipID) {
	//Get the payments for this deposit slip
	$sSQL = "SELECT plg_plgID, plg_date, plg_amount, plg_CheckNo, plg_method, plg_comment, a.fam_Name AS FamilyName
			 FROM pledge_plg 
			 LEFT JOIN family_fam a ON plg_FamID = a.fam_ID
			 WHERE plg_depID = " . $iDepositSlipID . " ORDER BY pledge_plg.plg_date";
	$rsPledges = RunQuery($sSQL);
} else {
	$rsPledges = 0;
}

//Is this the second pass?
if (isset($_POST["DepositSlipSubmit"]))
{
	//Get all the variables from the request object and assign them locally
	$dDate = FilterInput($_POST["Date"]);
	$sComment = FilterInput($_POST["Comment"]);
	$bClosed = FilterInput($_POST["Closed"]);
	if (! $bClosed)
		$bClosed = 0;

	//Initialize the error flag
	$bErrorFlag = false;

	// Validate Date
	if (strlen($dDate) > 0)
	{
		list($iYear, $iMonth, $iDay) = sscanf($dDate,"%04d-%02d-%02d");
		if ( !checkdate($iMonth,$iDay,$iYear) )
		{
			$sDateError = "<span style=\"color: red; \">" . gettext("Not a valid Date") . "</span>";
			$bErrorFlag = true;
		}
	}

	//If no errors, then let's update...
	if (!$bErrorFlag)
	{
		// New deposit slip
		if ($bNew)
		{
			// Only set DepositSlipOrPayment when the record is first created
			$sSQL = "INSERT INTO deposit_dep (dep_Date, dep_Comment, dep_EnteredBy, dep_Closed) 
			VALUES ('" . $dDate . "','" . $sComment . "'," . $_SESSION['iUserID'] . "," . $bClosed . ")";
			$bGetKeyBack = True;

		// Existing record (update)
		} else {
			$sSQL = "UPDATE deposit_dep SET dep_Date = '" . $dDate . "', dep_Comment = '" . $sComment . "', dep_EnteredBy = ". $_SESSION['iUserID'] . ", dep_Closed = " . $bClosed . ";";
			$bGetKeyBack = false;
		}

		//Execute the SQL
		RunQuery($sSQL);

		// If this is a new deposit slip, get the key back
		if ($bGetKeyBack)
		{
			$sSQL = "SELECT MAX(dep_ID) AS iDepositSlipID FROM deposit_dep";
			$rsDepositSlipID = RunQuery($sSQL);
			extract(mysql_fetch_array($rsDepositSlipID));
			$_SESSION['iCurrentDeposit'] = $iDepositSlipID;
		}

		if (isset($_POST["DepositSlipSubmit"]))
		{
			// Check for redirection to another page after saving information: (ie. DepositSlipEditor.php?previousPage=prev.php?a=1;b=2;c=3)
			if ($linkBack != "") {
				Redirect($linkBack);
			} else {
				//Send to the view of this DepositSlip
				Redirect("DepositSlipEditor.php?new=0&linkBack=", $linkBack);
			}
		}
	}
} else {

	//FirstPass
	//Are we editing or adding?
	if (! $bNew)
	{
		//Editing....
		//Get all the data on this record
																		
		$sSQL = "SELECT * FROM deposit_dep WHERE dep_ID = " . $iDepositSlipID;
		$rsDepositSlip = RunQuery($sSQL);
		extract(mysql_fetch_array($rsDepositSlip));

		$dDate = $dep_Date;
		$sComment = $dep_Comment;
		$bClosed = $dep_Closed;
	}
	else
	{
		//Adding....
		//Set defaults
	}
}

require "Include/Header.php";

?>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'] . "?new=" . $bNew . "&linkBack=" . $linkBack?>" name="DepositSlipEditor">

<table cellpadding="3" align="center">

	<tr>
		<td align="center">
			<input type="submit" class="icButton" value="<?php echo gettext("Save"); ?>" name="DepositSlipSubmit">
			<input type="button" class="icButton" value="<?php echo gettext("Cancel"); ?>" name="DepositSlipCancel" onclick="javascript:document.location='<?php if (strlen($linkBack) > 0) { echo $linkBack; } else {echo "Menu.php"; } ?>';">
			<input type="button" class="icButton" value="<?php echo gettext("Generate PDF"); ?>" name="DepositSlipGeneratePDF" onclick="javascript:document.location='Reports/PrintDeposit.php';">
		</td>
	</tr>

	<tr>
		<td>
		<table cellpadding="3">
			<tr>
				<td class="LabelColumn"><?php addToolTip("Format: YYYY-MM-DD<br>or enter the date by clicking on the calendar icon to the right."); ?><?php echo gettext("Date:"); ?></td>
				<td class="TextColumn"><input type="text" name="Date" value="<?php echo $dDate; ?>" maxlength="10" id="sel1" size="11">&nbsp;<input type="image" onclick="return showCalendar('sel1', 'y-mm-dd');" src="Images/calendar.gif"> <span class="SmallText"><?php echo gettext("[format: YYYY-MM-DD]"); ?></span><font color="red"><?php echo $sDateError ?></font></td>
			</tr>

			<tr>
				<td class="LabelColumn"><?php echo gettext("Comment:"); ?></td>
				<td class="TextColumn"><input type="text" name="Comment" id="Comment" value="<?php echo $sComment; ?>"></td>
			</tr>

			<tr>
				<td class="LabelColumn"><?php echo gettext("Closed:"); ?></td>
				<td class="TextColumn"><input type="checkbox" name="Closed" value="1" <?php if ($bClosed) echo " checked";?>><?php echo gettext("Close deposit slip"); ?>
			</tr>

		</table>
		</td>
	</form>
</table>

<br>
<?php if (! $bNew) { ?>
<b><?php echo gettext("Payments on this deposit slip:"); ?></b>
<br>

<table cellpadding="5" cellspacing="0" width="100%">

<tr class="TableHeader">
	<td><?php echo gettext("Family"); ?></td>
	<td><?php echo gettext("Date"); ?></td>
	<td><?php echo gettext("Check #"); ?></td>
	<td><?php echo gettext("Amount"); ?></td>
	<td><?php echo gettext("Method"); ?></td>
	<td><?php echo gettext("Comment"); ?></td>
	<td><?php echo gettext("Edit"); ?></td>
	<td><?php echo gettext("Delete"); ?></td>
</tr>

<?php


$tog = 0;

//Loop through all pledges
while ($aRow =mysql_fetch_array($rsPledges))
{
	$tog = (! $tog);

	$plg_date = "";
	$plg_CheckNo = "";
	$plg_amount = "";
	$plg_method = "";
	$plg_comment = "";
	$plg_plgID = 0;

	extract($aRow);

	if ($tog)
		$sRowClass = "PaymentRowColorA";
	else
		$sRowClass = "PaymentRowColorB";
	?>

	<tr class="<?php echo $sRowClass ?>">
		<td>
			<?php echo $FamilyName ?>&nbsp;
		</td>
		<td>
			<?php echo $plg_date ?>&nbsp;
		</td>
		<td>
			<?php echo $plg_CheckNo ?>&nbsp;
		</td>
		<td>
			<?php echo $plg_amount ?>&nbsp;
		</td>
		<td>
			<?php echo $plg_method; ?>&nbsp;
		</td>
		<td>
			<?php echo $plg_comment; ?>&nbsp;
		</td>
		<td>
			<a href="PledgeEditor.php?PledgeID=<?php echo $plg_plgID ?>&linkBack=DepositSlipEditor.php?new=0">Edit</a>
		</td>
		<td>
			<a href="PledgeDelete.php?PledgeID=<?php echo $plg_plgID ?>&linkBack=DepositSlipEditor.php?new=0">Delete</a>
		</td>
	</tr>
<?php
} // while
?>

</table>

<?php
} // if ($bNew)
?>


<?php
require "Include/Footer.php";
?>
