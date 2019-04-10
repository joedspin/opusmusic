<cfparam name="url.ID" default="0">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<style type="text/css">
<!--
body {
	background-color: #000000; margin-top:0 px; margin-left: 0px; margin-right: 0px; margin-bottom: 0px;
}
.style2 {font-family: "Courier New", Courier, monospace; font-size: small; color: #99FF00; }
.style3 {
	color: #FF0000;
	font-weight: bold;
}
.style5 {color: #FFFF00}
.style6 {font-size: x-small}
-->
</style>

<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script></head>

<body>

<cfquery name="catFind" datasource="#DSN#">
	select catItemsQuery.*, catItems.jpgLoaded
	from catItemsQuery LEFT JOIN catItems ON catItems.ID=catItemsQuery.ID
	where catItemsQuery.ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>


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
   <cfoutput query="catFind">
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
		#DollarFormat(cost)#<!---<br />
		<b><font color="red">PRE-RELEASE</font></b></span>//---></td>
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
</body>
</html>
