<?php
/*******************************************************************************
*
*  filename    : CartView.php
*  website     : http://www.churchdb.org
*
*  Copyright 2001-2003 Phillip Hullquist, Deane Barker, Chris Gebhardt
*
*  Additional Contributors:
*  2006 Ed Davis
*
*
*  Copyright 2006 Contributors
*
*  ChurchInfo is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This file best viewed in a text editor with tabs stops set to 4 characters
*
******************************************************************************/


// Include the function library

require "Include/Config.php";
require "Include/Functions.php";
require "Include/LabelFunctions.php";

// Set the page title and include HTML header
$sPageTitle = gettext("View Your Cart");
require "Include/Header.php";

// Confirmation message that people where added to Event from Cart
if (count($_SESSION['aPeopleCart']) == 0) {
        if (!$_GET["Message"])
        {
            echo "<p align=\"center\" class=\"LargeText\">" . gettext("You have no items in your cart.") . "</p>";
        } else {
            switch ($_GET["Message"])
            {
                case "aMessage":
                    echo '<p align="center" class="LargeText">'.$_GET["iCount"].' '.($_GET["iCount"] == 1 ? "Record":"Records").' Emptied into Event ID:'.$_GET["iEID"].'</p>'."\n";
                break;
            }
        }
        echo '<p align="center"><input type="button" name="Exit" class="icButton" value="'.gettext("Back to Menu").'" '."onclick=\"javascript:document.location='Menu.php';\"></p>\n";

} else {

        // Create array with Classification Information (lst_ID = 1)
        $sClassSQL  = "SELECT * FROM list_lst WHERE lst_ID=1 ORDER BY lst_OptionSequence";
        $rsClassification = RunQuery($sClassSQL);
        unset($aClassificationName);
        $aClassificationName[0] = "Unassigned";
        while ($aRow = mysql_fetch_array($rsClassification))
        {
            extract($aRow);
            $aClassificationName[intval($lst_OptionID)]=$lst_OptionName;
        }

        // Create array with Family Role Information (lst_ID = 2)
        $sFamRoleSQL  = "SELECT * FROM list_lst WHERE lst_ID=2 ORDER BY lst_OptionSequence";
        $rsFamilyRole = RunQuery($sFamRoleSQL);
        unset($aFamilyRoleName);
        $aFamilyRoleName[0] = "Unassigned";
        while ($aRow = mysql_fetch_array($rsFamilyRole))
        {
            extract($aRow);
            $aFamilyRoleName[intval($lst_OptionID)]=$lst_OptionName;
        }


        $sSQL = "SELECT * FROM person_per LEFT JOIN family_fam ON person_per.per_fam_ID = family_fam.fam_ID WHERE per_ID IN (" . ConvertCartToString($_SESSION['aPeopleCart']) . ") ORDER BY per_LastName";
        $rsCartItems = RunQuery($sSQL);
        $iNumPersons = mysql_num_rows($rsCartItems);

        $sSQL = "SELECT distinct per_fam_ID FROM person_per LEFT JOIN family_fam ON person_per.per_fam_ID = family_fam.fam_ID WHERE per_ID IN (" . ConvertCartToString($_SESSION['aPeopleCart']) . ") ORDER BY per_fam_ID";
        $iNumFamilies = mysql_num_rows(RunQuery($sSQL));

        if ($iNumPersons > 16)
        {
        ?>
        <center>
        <form method="get" action="CartView.php#GenerateLabels">
        <input type="submit" class="icButton" name="gotolabels" 
        value="<?php echo gettext("Go To Labels");?>">
        </form></center>
        <?php
        }

        echo '<p align="center">' . gettext("Your cart contains") . ' ' . $iNumPersons . ' ' . gettext("persons from") . ' ' . $iNumFamilies . ' ' . gettext("families.") . '</p>';

        echo '<table align="center" width="70%" cellpadding="4" cellspacing="0">';
        echo '<tr class="TableHeader">';
        echo '<td><b>' . gettext("Name") . '</b></td>';
        echo '<td align="center"><b>' . gettext("Address?") . '</b></td>';
        echo '<td align="center"><b>' . gettext("Email?") . '</b></td>';
        echo '<td><b>' . gettext("Remove") . '</b></td>';
        echo '<td align="center"><b>' . gettext("Classification") . '</b></td>';
        echo '<td align="center"><b>' . gettext("Family Role") . '</b></td>';

        $sEmailLink = "";
        $iEmailNum = 0;

        while ($aRow = mysql_fetch_array($rsCartItems))
        {
                $sRowClass = AlternateRowStyle($sRowClass);

                extract($aRow);

                $sEmail = SelectWhichInfo($per_Email, $fam_Email, False);
                if (strlen($sEmail))
                {
                        $sValidEmail = gettext("Yes");
                        if (!stristr($sEmailLink, $sEmail))
                        {
                                $email_array[] = $sEmail;

                                if ($iEmailNum == 0)
                                {
                                        $sEmailLink .= $sEmail;
                                        $iEmailNum++;
                                }
                                else
                                        $sEmailLink .= ";" . $sEmail;
                        }
                }
                else
                {
                        $sValidEmail = gettext("No");
                }

                $sAddress1 = SelectWhichInfo($per_Address1, $fam_Address1, False);
                $sAddress2 = SelectWhichInfo($per_Address2, $fam_Address2, False);

                if (strlen($sAddress1) > 0 || strlen($sAddress2) > 0)
                        $sValidAddy = gettext("Yes");
                else
                        $sValidAddy = gettext("No");

                echo '<tr class="' . $sRowClass . '">';
                echo '<td><a href="PersonView.php?PersonID=' . $per_ID . '">' . FormatFullName($per_Title, $per_FirstName, $per_MiddleName, $per_LastName, $per_Suffix, 1) . '</a></td>';

                echo '<td align="center">' . $sValidAddy . '</td>';
                echo '<td align="center">' . $sValidEmail . '</td>';
                echo '<td><a onclick=saveScrollCoordinates() 
                        href="CartView.php?RemoveFromPeopleCart=' . 
                        $per_ID . '">' . gettext("Remove") . '</a></td>';
                echo '<td align="center">' . $aClassificationName[$per_cls_ID] . '</td>';
                echo '<td align="center">' . $aFamilyRoleName[$per_fmr_ID] . '</td>';

                echo "</tr>";
        }

"<a onclick=saveScrollCoordinates() 
					href=\"" .$sRedirect. "RemoveFromPeopleCart=" .$per_ID. "\">";

        echo "</table>";
}

if (count($_SESSION['aPeopleCart']) != 0)
{
        echo "<br><table align=\"center\" cellpadding=\"15\"><tr><td valign=\"top\">";
        echo "<p align=\"center\" class=\"MediumText\">";
        echo "<b>" . gettext("Cart Functions") . "</b><br>";
        echo "<br>";
        echo "<a href=\"CartView.php?Action=EmptyCart\">" . gettext("Empty Cart") . "</a>";

        if ($_SESSION['bManageGroups']) {
                echo "<br>";
                echo "<a href=\"CartToGroup.php\">" . gettext("Empty Cart to Group") . "</a>";
        }
        if ($_SESSION['bAddRecords']) {
                echo "<br>";
                echo "<a href=\"CartToFamily.php\">" . gettext("Empty Cart to Family") . "</a>";
        }
        echo "<br>";
        echo "<a href=\"CartToEvent.php\">" . gettext("Empty Cart to Event") . "</a>";
        /* Link to CSV export */
        echo "<br>";
        echo "<a href=\"CSVExport.php?Source=cart\">" . gettext("CSV Export") . "</a>";

        if ($iEmailNum > 0) {
                // Add default email if default email has been set and is not already in string
                if ($sToEmailAddress != "" && $sToEmailAddress != "myReceiveEmailAddress" && !stristr($sEmailLink, $sToEmailAddress))
                        $sEmailLink .= ";" . $sToEmailAddress;
                echo "<br><a href=\"mailto:" . $sEmailLink ."\">". gettext("Email Cart") . "</a>";
                echo "<br><a href=\"mailto:?bcc=".$sEmailLink."\">".gettext("Email (BCC)")."</a>";
        }

        echo "</p></td>";
?>
        <td>
        <a name="GenerateLabels"></a>

        <SCRIPT LANGUAGE="JavaScript"><!--
        function codename() 
        {
            if(document.labelform.bulkmailpresort.checked)
            {
                document.labelform.bulkmailquiet.disabled=false;
            }
            else
            {
                document.labelform.bulkmailquiet.disabled=true;
            }
        }
    
        //-->
        </SCRIPT>



    <form method="get" action="Reports/PDFLabel.php" name="labelform">
        <table cellpadding="4" align="center">
                <?php
				LabelGroupSelect("groupbymode");

                echo '  <tr><td class="LabelColumn">' . gettext("Bulk Mail Presort") . '</td>';
                echo '  <td class="TextColumn">';
                echo '  <input name="bulkmailpresort" type="checkbox" onclick="codename()"';
                echo '  id="BulkMailPresort" value="1" ';
                if ($_COOKIE["bulkmailpresort"])
                    echo "checked";
                echo '  ><br></td></tr>';

                echo '  <tr><td class="LabelColumn">' . gettext("Quiet Presort") . '</td>';
                echo '  <td class="TextColumn">';
                echo '  <input disabled name="bulkmailquiet" type="checkbox" ';
                echo '  id="QuietBulkMail" value="1" ';
                if ($_COOKIE["bulkmailquiet"])
                    echo "checked";
                echo '  ><br></td></tr>';

				ToParentsOfCheckBox("toparents");
				LabelSelect("labeltype");
				FontSelect("labelfont");
				FontSizeSelect("labelfontsize");
				StartRowStartColumn();
				IgnoreIncompleteAddresses();
				LabelFileType();
                ?> 	                           

    			<tr>
						<td></td>
						<td><input type="submit" class="icButton" value="<?php echo gettext("Generate Labels");?>" name="Submit"></td>
				</tr>
    </table></form></td></tr></table>

<div align="center">
<form method="get" action="DirectoryReports.php">
<?php echo "<br><h2>" . gettext("Create Member Directory") . "</h2>"; ?>
<input type="submit" class="icButton" name="cartdir" value="<?php echo gettext("Member Directory");?>">
</form>
</div>

<div align="center"><table><tr><td align="center">

<?php
        if ((isset($email_array)) && ($bEmailSend))
        {
                echo "<br><h2>" . gettext("Send Email To People in Cart") . "</h2>";
                echo "<form action=\"EmailPreview.php\" method=\"POST\">";
                foreach ($email_array as $email_address)
                {
                        echo "<input type=\"hidden\" name=\"emaillist[]\" value=\"" . $email_address . "\">";
                }
                echo "<input type=\"hidden\" name=\"emaillist[]\" value=\"" . $sToEmailAddress . "\">";

                // If editing, get Title and Message
            $sEditSubject = $_POST['emailtitle'];
            if (isset($sEditSubject))
                        $subject = $sEditSubject;
                else
                        $subject = "";

            $sEditMessage = $_POST['emailmessage'];
            if (isset($sEditMessage))
                        $message = $sEditMessage;
                else
                        $message = "";

                echo gettext("Subject:");
                echo "<br><input type=\"text\" name=\"emailtitle\" size=\"80\" value=\"" . htmlspecialchars(stripslashes($subject)) . "\"></input>";
                echo "<br>" . gettext("Message:");
                echo "<br><textarea name=\"emailmessage\" rows=\"20\" cols=\"72\">" . htmlspecialchars(stripslashes($message)) . "</textarea>";
                echo "<br><input class=\"icButton\" type=\"submit\" name=\"submit\" value=\"" . gettext("Preview your Email") . "\"></form>";
        }
        echo "</td></tr></table></div>";
        echo "<a name=\"email\"></a>";
}

require "Include/Footer.php";
?>
