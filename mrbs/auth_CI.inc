<?php
$a = $b;

# # 
# #############################################################################
#																					 		        	#
#   File name     auth_CI.inc						      								#
#									      															#
#   Description	Authenticate users from a user table in the host system 		#
#						MRBS is bridged in.     												#
#									      															#
#   Notes	    To use this authentication scheme, set in config.inc.php: 		#
#			$auth["type"]  = "pkg";  				      									#
#									      															#
#   History								      													#
#    2007-03-29 clone from auth_db.inc created by JFL on 2004/01/11 				#
#									      															#
###############################################################################

// $Id: auth_auth.inc,v 1.0.0.0 2007/03/28 09:46:44 

/* session_php.inc and session_cookie.inc will add a link to the user list
    in the logon box, if the value $user_list_link is set. */
$user_list_link = "edit_users.php";

/* authValidateUser($user, $pass)
 * 
 * Checks if the specified username/password pair are valid
 * 
 * $user  - The user name
 * $pass  - The password
 * 
 * Returns:
 *   0        - The pair are invalid or do not exist
 *   non-zero - The pair are valid
 */

function authValidateUser($user, $pass)
{
   global $tbl_users;

   $user=slashes($user);
   $user=strtolower($user);
   $pass = md5($pass);
   return sql_query1("select count(*) from $tbl_users where name='$user' and password='$pass';");
}

/* authGetUserLevel($user)
 * 
 * Determines the users access level
 * 
 * $user - The user name
 *
 * Returns:
 *   The users access level
 */
function authGetUserLevel($user, $lev1_admin)
{
global $bEditMRBSBooking, $bAddMRBSResource;

// User not logged in, user level '0'
if(!isset($_SESSION['iUserID'])) {
         return 0; }

if ($bAddMRBSResource== 1) {
	return 2;
	}
	
if ($bEditMRBSBooking==1){
	return 1;
	}
return 0;
}

?>
