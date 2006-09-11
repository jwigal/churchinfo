<?php
require ("Include/Config.php");
require ("Include/Functions.php");
require ("Include/Header.php");
require ("Include/ReportFunctions.php");

$iGroupID = FilterInput($_GET["GroupID"],'int');

// Read values from config table into local variables
// **************************************************
$sSQL = "SELECT cfg_name, IFNULL(cfg_value, cfg_default) AS value FROM config_cfg WHERE cfg_section='ChurchInfoReport'";
$rsConfig = mysql_query($sSQL);			// Can't use RunQuery -- not defined yet
if ($rsConfig) {
	while (list($cfg_name, $cfg_value) = mysql_fetch_row($rsConfig)) {
		$$cfg_name = $cfg_value;
	}
}

if ($nChurchLatitude == 0 || $nChurchLongitude == 0) {

	require ("Include/GeoCoder.php");
	$myAddressLatLon = new AddressLatLon;

	// Try to look up the church address to center the map.
	$myAddressLatLon->SetAddress ($sChurchAddress, $sChurchCity, $sChurchState, $sChurchZip);
	$ret = $myAddressLatLon->Lookup ();
	if ($ret == 0) {
		$nChurchLatitude = $myAddressLatLon->GetLat ();
		$nChurchLongitude = $myAddressLatLon->GetLon ();

		$sSQL = "UPDATE config_cfg SET cfg_value='" . $nChurchLatitude . "' WHERE cfg_name=\"nChurchLatitude\"";
		RunQuery ($sSQL);
		$sSQL = "UPDATE config_cfg SET cfg_value='" . $nChurchLongitude . "' WHERE cfg_name=\"nChurchLongitude\"";
		RunQuery ($sSQL);
	}
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>
    <script src="http://maps.google.com/maps?file=api&v=1&key=<?php echo $sGoogleMapKey; ?>" type="text/javascript"></script>

  </head>
  <body>
    <div id="map" style="width: 600px; height: 450px"></div>


    <script type="text/javascript">
    //<![CDATA[
   
    var map = new GMap(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
    map.addControl(new GMapTypeControl());
    map.centerAndZoom(new GPoint(<?php echo $nChurchLongitude . ", " . $nChurchLatitude; ?>), 4);

	var churchPt = new GPoint (<?php echo $nChurchLongitude . ", " . $nChurchLatitude; ?> );
	var churchMark = new GMarker (churchPt);
	<?php 
		$churchDescription = $sChurchName;
		$churchDescription .= "<p>" . $sChurchAddress . "<p>" . $sChurchCity . ", " . $sChurchState . "  " . $sChurchZip;
	?>
	GEvent.addListener(churchMark, "click", function() {churchMark.openInfoWindowHtml("<?php echo $churchDescription; ?>");});
	map.addOverlay (churchMark);

<?php
	$appendToQuery = "";
	if ($iGroupID > 0) {
		// If mapping only members of  a group build a condition to add to the query used below
	
		//Get all the members of this group
		$sSQL = "SELECT per_fam_ID FROM person_per, person2group2role_p2g2r WHERE per_ID = p2g2r_per_ID AND p2g2r_grp_ID = " . $iGroupID;
		$rsGroupMembers = RunQuery($sSQL);
		$appendToQuery = " WHERE fam_ID IN (";
		while ($aPerFam = mysql_fetch_array($rsGroupMembers)) {
			extract ($aPerFam);
			$appendToQuery .= $per_fam_ID . ",";
		}
		$appendToQuery = substr($appendToQuery, 0, strlen ($appendToQuery)-1);
		$appendToQuery .= ")";
	} elseif ($iGroupID > -1) {
        // group zero means map the cart
		$sSQL = "SELECT per_fam_ID FROM person_per WHERE per_ID IN (" . ConvertCartToString($_SESSION['aPeopleCart']) . ")";
		$rsGroupMembers = RunQuery($sSQL);
		$appendToQuery = " WHERE fam_ID IN (";
		while ($aPerFam = mysql_fetch_array($rsGroupMembers)) {
			extract ($aPerFam);
			$appendToQuery .= $per_fam_ID . ",";
		}
		$appendToQuery = substr($appendToQuery, 0, strlen ($appendToQuery)-1);
		$appendToQuery .= ")";        
    }

	$sSQL = "SELECT fam_ID, fam_Name, fam_latitude, fam_longitude, fam_Address1, fam_City, fam_State, fam_Zip FROM family_fam";
	$sSQL .= $appendToQuery;
	$rsFams = RunQuery ($sSQL);
	while ($aFam = mysql_fetch_array($rsFams)) {
		extract ($aFam);
		if ($fam_longitude != 0 && $fam_latitude != 0) {
?>
			var famPt<?php echo $fam_ID; ?> = new GPoint (<?php echo $fam_longitude . ", " . $fam_latitude; ?> );
			var famMark<?php echo $fam_ID; ?> = new GMarker (famPt<?php echo $fam_ID; ?>);
			<?php 
				$famDescription = MakeSalutationUtility ($fam_ID);
				$famDescription .= "<p>" . $fam_Address1 . "<p>" . $fam_City . ", " . $fam_State . "  " . $fam_Zip;
			?>
			GEvent.addListener(famMark<?php echo $fam_ID; ?>, "click", function() {famMark<?php echo $fam_ID; ?>.openInfoWindowHtml("<?php echo $famDescription; ?>");});

			map.addOverlay (famMark<?php echo $fam_ID; ?>);
<?php
		}

	}
?>

    //]]>
    </script>

  </body>
</html>
