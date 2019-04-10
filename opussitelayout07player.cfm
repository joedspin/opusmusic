<cfparam name="url.oClip" default="0">
<cfif url.oClip EQ "" OR NOT IsValid("integer",url.oClip)><cfset thisClip=0><cfelse><cfset thisClip=url.oClip></cfif>
<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>Downtown 304</title>
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color:#333333;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: white;
}
td {font-family: Arial, Helvetica, sans-serif; font-size:11px; color:white;}
object { margin: 10px; display: block; }

.playerdescrip {position:absolute; margin-left:-90px; padding:0px; width:20px; height:60px; overflow:hidden; }
.playerdeets {position:absolute; margin:0px; padding:0px; width:100px; height:auto; overflow:hidden; font-family:"Times New Roman", Times, serif;}

-->
</style></head>
<body bgcolor="#000000">
<table border="0" cellpadding="0" cellspacing="0" width="275">
<!-- fwtable fwsrc="opussitelayout07player.png" fwbase="opussitelayout07player.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="18" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="251" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td colspan="3"><img name="opussitelayout07player_r1_c1" src="images/opussitelayout07player_r1_c1.jpg" width="275" height="41" border="0" id="opussitelayout07player_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="41" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="2"><img name="opussitelayout07player_r2_c1" src="images/opussitelayout07player_r2_c1.jpg" width="18" height="96" border="0" id="opussitelayout07player_r2_c1" alt="" /></td>
   <td valign="top" align="left" bgcolor="#333333">
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
	SELECT ID, catID, artist, title, tName, ONHAND, albumStatusID, ONSIDE
	from Application.allTracks
	where ID=#thisClip#
</cfquery>
<cfif thisTrack.recordCount GT 0>
	<cfoutput query="thisTrack">
		<table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;"><b>#Left(artist,43)#</b></span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;">#Left(title,43)#</span></td>
          </tr>
          <tr>
            <td colspan="2"><img src="images/spacer.gif" align="left" width="5" height="5"><span style="font-color:white;">#Left(tName,43)#</span></td>
          </tr>
          <tr>
            <td><audio src="media/oT#thisTrack.ID#.mp3" autoplay controls>Your browser does not support this player. Use the mp3 link instead.</audio><!---<script language="javascript" type="text/javascript">loadPlayer('#thisTrack.ID#');</script>//---></td>
            <td align="center" valign="middle"><cfif ((ONHAND GT 0 AND albumStatusID LT 25) OR ONSIDE GT 0) AND ONSIDE NEQ 999><a href="cartAction.cfm?cAdd=#catID#" target="opusviewbins" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','shopButton#catID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','shopButton#catID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#catID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#catID#" alt="ADD TO CART" vspace="4" /></a><cfelse>&nbsp;</cfif></td>
          </tr>
        </table>
	</cfoutput>
<cfelse>
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
        </table>
</cfif>
   </td>
   <td rowspan="2"><img name="opussitelayout07player_r2_c3" src="images/opussitelayout07player_r2_c3.jpg" width="6" height="96" border="0" id="opussitelayout07player_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="89" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07player_r3_c2" src="images/opussitelayout07player_r3_c2.jpg" width="251" height="7" border="0" id="opussitelayout07player_r3_c2" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="7" border="0" alt="" /></td>
  </tr>
</table>
</body>
</html>
