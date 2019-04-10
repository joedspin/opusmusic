<cfparam name="url.group" default="sale">
<cfquery name="allTracks" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
	select *
	from catTracks
	order by catID, tSort
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>downtown161.com</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color: #000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: white;
}
.style1 {
	color: #FFCC00;
	font-weight: bold;
}
.style2 {
	font-size: 48px;
	font-weight: bold;
	font-family: "Courier New", Courier, monospace;
}
.style7 {
	font-size: 24px;
	font-family: "Courier New", Courier, monospace;
}
.style8 {
	font-size: 14px;
	color: #FFCC00;
	font-weight: bold;
}
-->
</style></head>
<body onload="MM_preloadImages('images/topnav_v2_r2_c2_f2.jpg','images/topnav_v2_r2_c2_f3.jpg','images/topnav_v2_r2_c4_f2.jpg','images/topnav_v2_r2_c4_f3.jpg','images/topnav_v2_r2_c6_f2.jpg','images/topnav_v2_r2_c6_f3.jpg','images/topnav_v2_r2_c8_f2.jpg','images/topnav_v2_r2_c8_f3.jpg','images/topnav_v2_r2_c10_f2.jpg','images/topnav_v2_r2_c10_f3.jpg','images/topnav_v2_r2_c12_f2.jpg','images/topnav_v2_r2_c12_f3.jpg','images/topnav_v2_r2_c14_f2.jpg','images/topnav_v2_r2_c14_f3.jpg','images/topnav_v2_r2_c16_f2.jpg','images/topnav_v2_r2_c16_f3.jpg');">
	<p align="center">
	  <cfquery name="catFind" datasource="#DSN#" cachedWithin="#CreateTimeSpan(0, 2, 0, 0)#">
		select *
        from catItemsQuery
        where shelfCode='BS'
        ORDER BY dtDateUpdated DESC
    </cfquery>
 &nbsp;<br />
 <span class="style2">Downtown 161<br />
 </span><span class="style7">Private Import Sale</span></p>
	<table border="0" align="center" cellpadding="5" cellspacing="0">
      <tr>
        <td><div align="right"><span class="style8">BUY 1-9 pieces</span><br />
              <span class="style8">BUY 10-19 pieces</span><br />
              <span class="style8">BUY 20-29 pieces</span><br />
              <span class="style8">BUY 30-39 pieces</span><br />
            <span class="style8">BUY 40+ piece</span></div></td>
        <td><span class="style8">@ $4.99 each<br />
@ $4.79 each<br />
@ $4.49 each<br />
@ $4.29 each<br />
@ $3.99 each</span></td>
      </tr>
    </table>
	<table border="0" cellpadding="0" cellspacing="0" width="693" align="center">
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
   	<cfset displayedID=ID>
	<cfif catFind.jpgLoaded AND NOT (fullImg NEQ "" AND url.sID NEQ 0)>
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
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><img src="images/spacer.gif" width="75" height="75" border="0" /></td>
  </tr>
</table></td>
   <td rowspan="3" background="images/opussitelayout07main_r11_c5.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="##333333" colspan="5"><font size="2"><b>#artist#</b><br />#title# (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</font><br />#label#</td>

   <td colspan="2" rowspan="2" valign="top" bgcolor="##333333" class="detailsArtist"><font style="font-family: Arial, Helvetica, sans-serif; font-size:x-small; line-height:100%;"><cfif releaseDate NEQ "" AND albumStatusID NEQ 148>#DateFormat(releaseDate,"yyyy-mm-dd")#<cfelse>#DateFormat(DTdateUpdated,"yyyy-mm-dd")#</cfif><br />
		Cat. No.:<br />
		#Right(catnum,13)#<br />
		Genre: #genre#<br />
		#country#</font><br /><b><font color="red" style="text-decoration:line-through;">$7.49</font><br /><font size="2" face="Courier New, Courier, monospace">$4.99</font></b><br />
	  </td>
   <td rowspan="3" colspan="2" background="images/opussitelayout07main_r11_c13.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top" bgcolor="##333333">
    <cfif hideTracks EQ 1><p><a href="javascript:showdiv(#ID#)">Click to see track listing</a></p></cfif>
	<div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden;"</cfif>><table width="100%" border="0" cellpadding="0" >
	 <cfquery name="tracks" dbtype="query">
		select *
		from allTracks
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
			<td align="center" bgcolor="##009933" width="12" height="12" colspan="3"><div align="center" class="style1"><a href="http://www.downtown304.com/DT161PlayFrame.cfm?oClip=#trID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			
		  </tr>
		</table></td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	<cfelse>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table cellpadding="0" cellspacing="0" border="0" width="10"style="border-collapse:collapse;">
			<tr><td><img src="spacer.gif" width="9" height="10" border="0"></td></tr></table>
			</td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	</cfif>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop> 
    </table></div>
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
  <cfset thisFullImg=fullImg>
</cfoutput>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r17_c1" src="images/opussitelayout07main_r17_c1.jpg" width="693" height="22" border="0" id="opussitelayout07main_r17_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="22" border="0" alt="" /></td>
  </tr>
  
</table>
</body>
</html>
