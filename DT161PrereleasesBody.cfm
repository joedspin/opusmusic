<cfparam name="url.rsPage" default="1">
<cfparam name="url.ob" default="ID">
<cfparam name="url.so" default="DESC">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<style type="text/css">
<!--
body {
	background-color: #000000;
}
.style2 {font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #FFFFFF; }
.style3 {
	color: #FF0000;
	font-weight: bold;
}
.style4 {color: #FF0000}
.style6 {font-family: Arial, Helvetica, sans-serif; font-size: small; color: #FFFFFF; }
.style7 {
	color: #FFFF00;
	font-weight: bold;
}
-->
</style>

<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script></head>

<body>
<p align="left" class="style2">The items listed below are <span class="style3">PRE-RELEASES</span>. They are <span class="style3">NOT AVAILABLE</span> yet.</p>
<p align="left" class="style2"> We are accepting <b><span class="style4">PRE-ORDERS</span></b> for these items at this time. </p>
<p align="left" class="style6"><span class="style7">RELEASE DATES ARE NOT KNOWN</span> and due to the nature of the manufacturing process cannot be predicted.</p>
<cfquery name="catFind" datasource="#DSN#">
	select *
	from catItemsQuery 
	where albumStatusID=148 AND mp3Loaded=1
	order by ID DESC
</cfquery>
<cfif catFind.recordCount EQ 0>
<p align="center" class="detailsArtist">&nbsp;</p>
<p align="center" class="detailsArtist"><br /><b>THERE ARE CURRENTLY NO PRE-RELEASES</b></p>
<p align="center" class="detailsArtist">&nbsp;</p>
<cfelse>
<cfif catFind.recordCount GT 20>
<cfset numPages=Int((catFind.recordCount-1)/20)+1>
<cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="DT161PrereleasesBody.cfm?so=#url.so#&amp;ob=#url.ob#&rsPage=#url.rsPage-1#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="DT161PrereleasesBody.cfm?so=#url.so#&amp;ob=#url.ob#&rsPage=#x#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="DT161PrereleasesBody.cfm?so=#url.so#&amp;ob=#url.ob#&rsPage=#url.rsPage+1#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
</cfoutput>
</cfif>
<table border="0" cellpadding="0" cellspacing="0" width="693">
<!-- fwtable fwsrc="opussitelayout07main.png" fwbase="opussitelayout07main.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="15" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="7" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="28" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="40" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="200" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="44" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="26" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="130" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="90" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="98" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="2" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td colspan="14"><img name="opussitelayout07main_r1_c1" src="images/opussitelayout07main_r1_c1.jpg" width="693" height="6" border="0" id="opussitelayout07main_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  
  <tr>
   <td rowspan="2" colspan="14"><img name="opussitelayout07main_r5_c1" src="images/opussitelayout07main_r5_c1.jpg" width="693" height="21" border="0" id="opussitelayout07main_r5_c1" usemap="#m_opussitelayout07main_r5_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <cfset thisStartRow=(url.rsPage*20)-19>
   <cfoutput query="catFind" maxrows="20" startrow="#thisStartRow#">
	<cfif catFind.jpgLoaded>
		<cfset imagefile="items/oI#catFind.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r10_c1" src="images/opussitelayout07main_r10_c1.jpg" width="693" height="5" border="0" id="opussitelayout07main_r10_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="3" background="images/opussitelayout07main_r11_c1.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td colspan="3" rowspan="2" valign="top" bgcolor="##333333"><table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><img src="images/oCorners.gif" width="75" height="75" border="0" /></td>
  </tr>
</table></td>
   <td rowspan="3" background="images/opussitelayout07main_r11_c5.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="##333333" class="detailsArtist"><b>#artist#</b></td>
   <td colspan="3" valign="top" bgcolor="##333333" class="detailsArtist">#title# (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</td>
   <td valign="top" bgcolor="##333333" class="detailsLabel">#label#</td>
   <td colspan="2" rowspan="2" valign="top" bgcolor="##333333" class="detailsArtist">
		<font style="font-family: Arial, Helvetica, sans-serif; font-size:9px; line-height:100%;">Cat. No.: #catnum#<br />
		Item No.: #ID##shelfCode#</font><br />
		Genre: #genre#<br />
		Country: #country#<br />
		<!---#DollarFormat(cost)#<br />//--->
		<b><font color="red">PRE-RELEASE</font></b></span></td>
   <td rowspan="3" colspan="2" background="images/opussitelayout07main_r11_c13.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top" bgcolor="##333333">
	<table width="100%" border="0" cellpadding="0" align="left">
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#catFind.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
			<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfif tracks.mp3Loaded OR mp3Alt NEQ 0>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="DT161PlayFrame.cfm?oClip=#trID#" target="DT161preplay" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
		  </tr>
		</table>
	</td>
	<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	<cfelse>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table cellpadding="0" cellspacing="0" border="0" width="10" style="border-collapse:collapse;">
			<tr><td><img src="spacer.gif" width="9" height="10" border="0"></td></tr></table>
			</td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
		</cfif>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop> 
    </table>
	</td>
    <td><img src="images/spacer.gif" width="1" height="9" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="3"><img name="opussitelayout07main_r13_c2" src="images/opussitelayout07main_r13_c2.jpg" width="75" height="2" border="0" id="opussitelayout07main_r13_c2" alt="" /></td>
   <td colspan="7"><img name="opussitelayout07main_r13_c6" src="images/opussitelayout07main_r13_c6.jpg" width="590" height="2" border="0" id="opussitelayout07main_r13_c6" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="2" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r14_c1" src="images/opussitelayout07main_r14_c1.jpg" width="693" height="3" border="0" id="opussitelayout07main_r14_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="3" border="0" alt="" /></td>
  </tr>
</cfoutput>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r17_c1" src="images/opussitelayout07main_r17_c1.jpg" width="693" height="22" border="0" id="opussitelayout07main_r17_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="22" border="0" alt="" /></td>
  </tr>
</table>
<cfif catFind.recordCount GT 20>
<cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="DT161PrereleasesBody.cfm?so=#url.so#&amp;ob=#url.ob#&rsPage=#url.rsPage-1#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="DT161PrereleasesBody.cfm?so=#url.so#&amp;ob=#url.ob#&rsPage=#x#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="DT161PrereleasesBody.cfm?so=#url.so#&amp;ob=#url.ob#&rsPage=#url.rsPage+1#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
</cfoutput>
</cfif>
</cfif>
<cfoutput><map name="m_opussitelayout07main_r5_c1" id="m_opussitelayout07main_r5_c1">
<area shape="poly" coords="137,2,148,2,148,22,137,22,137,2" href="DT161PrereleasesBody.cfm?ob=artist&amp;so=asc" alt="Sort by Artist A-Z" />
<area shape="poly" coords="148,2,159,2,159,21,148,21,148,2" href="DT161PrereleasesBody.cfm?ob=artist&amp;so=desc" alt="Sort by Artist Z-A" />
<area shape="poly" coords="330,0,341,0,341,22,330,22,330,0" href="DT161PrereleasesBody.cfm?ob=title&amp;so=asc" alt="Sort by Title A-Z" />
<area shape="poly" coords="341,0,352,0,352,22,341,22,341,0" href="DT161PrereleasesBody.cfm?ob=title&amp;so=desc" alt="Sort by Title Z-A" />
<area shape="poly" coords="529,0,540,0,540,22,529,22,529,0" href="DT161PrereleasesBody.cfm?ob=label&amp;so=asc" alt="Sort by Label A-Z" />
<area shape="poly" coords="540,0,551,0,551,22,540,22,540,0" href="DT161PrereleasesBody.cfm?ob=label&amp;so=desc" alt="Sort by Label Z-A" />
<area shape="poly" coords="618,0,629,0,629,22,618,22,618,0" href="DT161PrereleasesBody.cfm?ob=ID&amp;so=asc" alt="Sort by Date, oldest first" />
<area shape="poly" coords="629,0,640,0,640,22,629,22,629,0" href="DT161PrereleasesBody.cfm?ob=ID&amp;so=desc" alt="Sort by Date, most recent first" />
</map></cfoutput>
</body>
</html>
