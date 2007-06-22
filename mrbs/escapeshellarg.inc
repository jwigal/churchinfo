<?php

/* $Id: escapeshellarg.inc,v 1.1 2007/06/22 23:45:27 amagrace Exp $
 *
 * Included if your PHP version is less than 4.0.3 and therefore this
 * function doesn't exist.
 *
 */

function escapeshellarg($x)
{
  return "'".ereg_replace("'", "'\\''", $x)."'";
} 

?>
