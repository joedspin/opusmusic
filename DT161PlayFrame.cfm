<cfparam name="url.oClip" default="0">
<cfif url.oClip EQ "" OR NOT IsValid("integer",url.oClip)><cfset thisClip=0><cfelse><cfset thisClip=url.oClip></cfif>
<html>
<head>
<title>Downtown 161</title>
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color:#4D4948;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: white;
}
.style2 {font-family: "Courier New", Courier, monospace; font-size: small; color: #99FF00; }

td {font-family: Arial, Helvetica, sans-serif; font-size:11px; color:white;}
object { margin: 10px; display: block; }
-->
</style><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
<body>
<p><img src="images/spacer.gif" width="200" height="10"></p>
<!---<cfquery name="thisTrack" datasource="#DSN#">
	SELECT catTracks.ID, catTracks.catID, artist, title, tName
	FROM catTracks LEFT JOIN catItemsQuery ON catTracks.catID = catItemsQuery.ID
	where catTracks.ID=<cfqueryparam value="#url.oClip#" cfsqltype="cf_sql_integer">
</cfquery>//--->
<cfquery name="thisTrack" dbtype="query">
	SELECT ID, catID, artist, title, tName
	from Application.allTracks
	where ID=#thisClip#
</cfquery>
<cfif thisTrack.recordCount GT 0>
	<cfoutput query="thisTrack">
		<table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;"><b>#artist#</b></span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;">#title#</span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;">#tName#</span></td>
          </tr>
          <tr>
            <td><script language="javascript" type="text/javascript">loadPlayer('#thisTrack.ID#');</script></td>
            <td align="center" valign="middle">&nbsp;</td>
          </tr>
        </table>
	</cfoutput>
<!---<cfelse>
	<table border="0" cellspacing="0" cellpadding="0" align="left">
	<tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;"><b>&nbsp;</b></span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;">&nbsp;</span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;">&nbsp;</span></td>
          </tr>
           <tr>
            <td><script language="javascript" type="text/javascript">loadPlayer('00000');</script></td>
            <td align="center" valign="middle"><img name="shopButton" src="images/spacer.gif" width="75" height="20" border="0" id="shopButton" vspace="4" /></a></td>
          </tr>
        </table>//--->
<cfelse>

</cfif>
   
</table>
</body>
</html>
