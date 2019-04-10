<cfparam name="url.oClip" default="0">
<cfif url.oClip EQ "" OR NOT IsValid("integer",url.oClip)><cfset thisClip=0><cfelse><cfset thisClip=url.oClip></cfif>
<html>
<head>
<title>Downtown 304</title>
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color:#FFFFFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: black;
}
td {font-family: Arial, Helvetica, sans-serif; font-size:11px; color:black;}
object { margin: 10px; display: block; }
-->
</style></head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="275">
<!-- fwtable fwsrc="opussitelayout07player.png" fwbase="opussitelayout07player.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->


  <tr>
   <td colspan="3">&nbsp;</td>
   <td><img src="images/spacer.gif" width="1" height="41" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="2">&nbsp;</td>
   <td valign="top" align="left">
   <!---<cfquery name="thisTrack" datasource="#DSN#">
	SELECT catTracks.ID, catTracks.catID, artist, title, tName
	FROM catTracks LEFT JOIN catItemsQuery ON catTracks.catID = catItemsQuery.ID
	where catTracks.ID=#thisClip#
</cfquery>//--->
<!---<cfquery name="allPlayerTracks" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	SELECT ID, catID, artist, title, tName
	FROM catTracksQuery
</cfquery>
<cfquery name="thisTrack" dbtype="query">
	SELECT ID, catID, artist, title, tName
	FROM allPlayerTracks
	where ID=#thisClip#
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
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:black;"><b>#artist#</b></span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:black;">#title#</span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:black;">#tName#</span></td>
          </tr>
          <tr>
            <td><script language="javascript" type="text/javascript">loadPlayer('#thisTrack.ID#');</script></td>
            <td align="center" valign="middle">&nbsp;</td>
          </tr>
        </table>
	</cfoutput>
<cfelse>
	<table border="0" cellspacing="0" cellpadding="0" align="left">
	<tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:black;"><b>&nbsp;</b></span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:black;">&nbsp;</span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:black;">&nbsp;</span></td>
          </tr>
           <tr>
            <td><script language="javascript" type="text/javascript">loadPlayer('00000');</script></td>
            <td align="center" valign="middle"><img name="shopButton" src="images/spacer.gif" width="75" height="20" border="0" id="shopButton" vspace="4" /></a></td>
          </tr>
        </table>
</cfif>
   </td>
   <td rowspan="2">&nbsp;</td>
   <td><img src="images/spacer.gif" width="1" height="89" border="0" alt="" /></td>
  </tr>
  <tr>
   <td>&nbsp;</td>
   <td><img src="images/spacer.gif" width="1" height="7" border="0" alt="" /></td>
  </tr>
</table>
</body>
</html>
