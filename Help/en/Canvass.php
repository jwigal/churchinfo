<?php
	$sPageTitle = "Canvass Support";
	require "Include/Header.php";
?>

<div class="Help_Section">
	<div class="Help_Header">How does ChurchInfo support an every-member canvass?</div>
	<table width="100%" class="LightShadedBox">
	<tr>
	<td>
	<p>
<P>ChurchInfo includes comprehensive support to facilitate an
every-member canvass effort.  The main control panel for canvass
activity is called the  Canvass Automation page.  This page may be
found by selecting Data/Reports-&gt;Reports Menu, and then clicking
the <U>Canvass Automation</U> link.</P>
<P>Here is an overview of the steps:</P>
<OL>
	<LI><P>Create a group called &ldquo;Canvassers&rdquo;.  Identify
	canvassers and collect them in this &ldquo;Canvassers&rdquo; group.</P>
	<LI><P>Optionally create a group called &ldquo;BraveCanvassers&rdquo;.
	 These canvassers are people who are willing to call families that
	did not pledge last year.</P>
	<LI><P>Use the Canvass Automation page to either enable or disable
	canvassing for all families.  If most families will be canvassed,
	enable canvassing for all families and then turn off the &ldquo;Ok
	To Canvass&rdquo; field for families that should not be canvassed. 
	Alternatively, disable canvassing for all families and then turn on
	the &ldquo;Ok To Canvass&rdquo; field for families to canvass.  The
	&ldquo;Ok To Canvass&rdquo; field is found about half-way down the
	family editor page.</P>
	<LI><P>Use the Canvass Automation page to assign &ldquo;BraveCanvassers&rdquo;
	to non-pledging families first, if using this feature.</P>
	<LI><P>Use the Canvass Automation page to assign canvassers.</P>
	<LI><P>Canvasser assignments may be adjusted in the family editor. 
	The canvasser assignments are near the &ldquo;Ok To Canvass&rdquo;
	field.</P>
	<LI><P>Edit the file Reports/CanvassQuestions.txt to include the
	questions that will be used to initiate canvass conversations this
	year.</P>
	<LI><P>Use the Canvass Automation page to generate the briefing
	sheets.  These sheets contain briefing information for each family
	and the canvass questions, with room for the canvasser to take notes
	during the conversation.  The briefing sheets are organized by
	canvasser to make it easy to deliver these canvass assignments.</P>
	<LI><P>Instruct the canvassers to use the &ldquo;... Canvass Entry&rdquo;
	link at the bottom of the page for the family that was canvassed. 
	Canvassers must have the &ldquo;Canvasser&rdquo; permission enabled
	to have this feature.  
	</P>
	<LI><P>The reports at the bottom of the Canvass Automation page may
	be used to track the progress of the canvass, summarize the results,
	and find the families which are no longer interested in being part
	of the church.</P>
</OL>
</p>
</td>
</tr>
</table>

</div>

<?php
	require "Include/Footer.php";
?>
