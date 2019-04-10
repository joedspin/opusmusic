<cfsetting requesttimeout="6000">
<cfset lineFeed=chr(13)&chr(10)>
<cfparam name="form.ID" default="0">
<cfparam name="form.pageBack" default="catalogReview.cfm">
<cfparam name="form.custMessage" default="">
<cfparam name="Session.userEmail" default="">
<cfif Session.userEmail EQ "">
	<cflogout>
	<cfset userMessage="Your email address is not loaded, please login again.<br>Sorry for the inconvenience.">
	<cfinclude template="loginform.cfm">
	<cfabort>
</cfif>
<cfquery name="catalogFind" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=#form.ID#
</cfquery>
<cfmail query="catalogFind" to="#Session.userEmail#" from="joe@downtown161.com" subject="DOWNTOWN 161 :: #label# #catnum#" type="html">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 161</title>
<style type="text/css">
<!--
body {
	background-color: ##000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.rsb {	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 12px;
	color: ##CCCCCC;
}
a {text-decoration : underline;}
a:link { color:##99CC66;}
a:visited { color: ##99CC66;} 
a:hover { color: ##99CC66;} 
a:active { color: ##99CC66;} 


.default {
	font-family: verdana;
	color: ##666666;
	font-size: 10px; 
	line-height: 14px;
}
.rsb {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 12px;
	color: ##CCCCCC;
}
.footer {
	font-family: verdana;
	color: ##999999;
	font-size: 9px; 
	line-height: 10px;
}
.footer a {text-decoration : none;}
.footer a:link { color: ##999999;}
.footer a:visited { color: ##999999;} 
.footer a:hover { color: ##a51c4a;} 
.footer a:active { color: ##a51c4a;} 
.catDisplay {
	font-family: Arial, Helvetica, sans-serif;
	font-size:10px;
	color:##333333;}
.catDisplay {
	font-family: Arial, Helvetica, sans-serif;
	font-size:10px;
	color:##000000;
	margin-top: 0px;
	margin-bottom: 0px;
	line-height:80%;}
.catDisplayOOS {
	font-family: Arial, Helvetica, sans-serif;
	font-size:10px;
	color:##666666;
	margin-top: 0px;
	margin-bottom: 0px;
	line-height:80%;}
.detailsArtist {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 120%;
	color:##CCCCCC;
	letter-spacing: normal;
}
.detailsTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 120%;
	color: ##CCCCCC;
	font-weight: bold;
}
.detailsLabel {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 120%;
	color: ##CCCCCC;
}
.detailsTracks {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 80%;
	color:##CCCCCC;
}
.msg {
	font-size: 14px;
	font-family: Arial, Helvetica, sans-serif;
	color: ##FFFF66;
	font-weight: bold;
}
a.clickit:link {
	color:##66FF00;
	text-decoration: none;
}
a.clickit:visited {
	text-decoration: none;
	color:##666666;
}
a.clickit:hover {
	text-decoration: none;
	color:##FFCC00;
}
a.clickit:active {
	text-decoration: none;
	color:##FFCC00;
}
.style1 {color: ##000000}
.style2 {font-size: 14px; font-family: Arial, Helvetica, sans-serif; color: ##99CC66; font-weight: bold; }
-->
</style></head>
<body>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr>
        <td bgcolor="##4D4948"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><img src="http://www.downtown304.com/images/Downtown161_Logo1.jpg" width="218" height="93" /></td>
            <td><cfif form.custMessage NEQ ""><p><span class='style2'>#Replace(custMessage,lineFeed,"</span></p><p><span class='style2'>")#</span></p>
          </cfif></td>
          </tr>
        </table>
          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>
<cfquery name="catalogFind" datasource="#DSN#">
select catItemsQuery.*, catItems.jpgLoaded
from catItemsQuery LEFT JOIN catItems ON catItems.ID=catItemsQuery.ID
where catItemsQuery.ID=#form.ID#
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="693">
  <tr>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="15" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="7" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="28" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="40" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="200" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="44" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="26" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="130" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="90" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="98" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="2" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
 
  <tr>
   <td rowspan="2" colspan="14">&nbsp;</td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
   <cfloop query="catalogFind">
	<cfif catalogFind.jpgLoaded>
		<cfset imagefile="items/oI#catalogFind.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
  <tr>
   <td colspan="14">&nbsp;</td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="3"><img src="http://www.downtown304.com/images/spacer.gif" height="1" width="1" /></td>
   <td colspan="3" rowspan="2" valign="top"><table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td style="background-position:top; background-repeat:no-repeat">&nbsp;</td>
  </tr>
</table>
     <span style="background-position:top; background-repeat:no-repeat"><img src="http://www.downtown304.com/images/#imageFile#" width="75" height="75" border="0" /></span></td>
   <td rowspan="3"><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" class="detailsArtist"><b>#artist#</b></td>
   <td colspan="3" valign="top" class="detailsArtist">#title# (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</td>
   <td valign="top" class="detailsLabel">#label#</td>
   <td colspan="2" rowspan="2" valign="top" class="detailsArtist">
		<font style="font-family: Arial, Helvetica, sans-serif; font-size:9px; line-height:100%;">Cat. No.: #catnum#<br />
		Item No.: #ID##shelfCode#</font><br />
		Genre: #genre#<br />
		Country: #country#<br />
		#DollarFormat(cost)#<!---<br />
		<b><font color="red">PRE-RELEASE</font></b></span>//---></td>
   <td rowspan="3" colspan="2"><img src="http://www.downtown304.com/images/spacer.gif" height="1" width="1" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top">
	<table width="100%" border="0" cellpadding="0" align="left">
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#catalogFind.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
			<cfif mp3Alt NEQ 0>
			  <cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfif tracks.mp3Loaded OR mp3Alt NEQ 0>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="http://www.downtown304.com/images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="http://www.downtown304.com/DT161Item.cfm?ID=#form.ID#" target="DT161preplay" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
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
    <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="9" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="3"><img name="opussitelayout07main_r13_c2" src="http://www.downtown304.com/images/opussitelayout07main_r13_c2.jpg" width="75" height="2" border="0" id="opussitelayout07main_r13_c2" alt="" /></td>
   <td colspan="7"><img name="opussitelayout07main_r13_c6" src="http://www.downtown304.com/images/opussitelayout07main_r13_c6.jpg" width="590" height="2" border="0" id="opussitelayout07main_r13_c6" alt="" /></td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="2" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="14">&nbsp;</td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="3" border="0" alt="" /></td>
  </tr>
</cfloop>
  <tr>
   <td colspan="14">&nbsp;</td>
   <td><img src="http://www.downtown304.com/images/spacer.gif" width="1" height="22" border="0" alt="" /></td>
  </tr>
</table>
	</td>
  </tr>
  <tr>
    <td><table width="693" border="0" cellspacing="0" cellpadding="10">
      <cfif fullImg NEQ ""><tr>
        <td colspan="2" valign="top"><cfoutput><blockquote><img src="http://www.downtown304.com/images/items/oI#form.ID#full.jpg"></blockquote></cfoutput></td>
        </tr></cfif>
      <tr>
        <td valign="top"><span class="rsb"><strong>Linda Perrone</strong><br />
President<br />
<a href="mailto:linda@downtown161.com">linda@downtown161.com</a><br />
&nbsp;<br />
<strong>Judy Russell</strong><br />
Buyer / Sales/A&amp;R<br />
<a href="mailto:judy@downtown161.com">judy@downtown161.com</a><br />
&nbsp;<br />
<strong>Address:</strong> <br />
Downtown 161<br />
304 Hudson Street<br />
5th Floor<br />
New York, NY 10013
<br />
        </span></td>
        <td valign="top"><span class="rsb">
  <strong>Lisa Nell</strong><br />
Financial Department<br />
  <a href="mailto:lisa@downtown161.com">lisa@downtown161.com</a></span></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td bgcolor="##4D4948">&nbsp;</td>
  </tr>
</table>
</body>
</body>
</html>
</cfmail>
<cflocation url="#form.pageBack#?emailsent=#form.ID#">