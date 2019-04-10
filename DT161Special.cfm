<cfparam name="url.rsPage" default="1">
<cfparam name="url.stat" default="">
<cfquery name="dt161special" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
		select DISTINCT artistListsItemsQuery.itemID, catItemsQuery.*
	from artistListsItemsQuery LEFT JOIN catItemsQuery ON artistListsItemsQuery.itemID=catItemsQuery.ID
	where listID=47 AND shelfID=11 AND catItemsQuery.ONHAND>0
	</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 161 :: The Best Underground House Music Worldwide</title>
<script language="JavaScript1.2" type="text/javascript" src="http://www.downtown161.com/scripts/dt161.js"></script>
<style type="text/css">
<!--
p {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
body {
	margin-left: 0px;
	margin-top: 5px;
	margin-right: 0px;
	margin-bottom: 5px;
	background-color: #2C2825;
}
.catDisplay {
	font-family: Arial, Helvetica, sans-serif;
	font-size:x-small;
	color:#333333;}
.catDisplay {
	font-family: Arial, Helvetica, sans-serif;
	font-size:x-small;
	color:#000000;
	margin-top: 0px;
	margin-bottom: 0px;
	color:#333333;}
.catDisplayOOS {
	font-family: Arial, Helvetica, sans-serif;
	font-size:x-small;
	color:#666666;
	margin-top: 0px;
	margin-bottom: 0px;
	color:#333333;}
.detailsArtist {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color:#333333;
	letter-spacing: normal;
}
.detailsTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color:#333333;
	font-weight: bold;
}
.detailsLabel {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color:#333333;
}
.detailsTracks {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color:#333333;
}
.style3 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-small;
}
.style5 {color: #333333}
.style6 {font-family: Arial, Helvetica, sans-serif}
a:link {color:#006633;}
a:hover {color:#FFFFFF;}
a:visited {color:#006633;}
a:active {color:#FFFFFF;}
-->
</style></head>
<body onload= "MM_preloadImages('http://www.downtown161.com/images/topNav_r2_c2_f2.jpg','http://www.downtown161.com/images/topNav_r2_c2_f3.jpg','http://www.downtown161.com/images/topNav_r2_c4_f2.jpg','http://www.downtown161.com/images/topNav_r2_c4_f3.jpg','http://www.downtown161.com/images/topNav_r2_c5_f2.jpg','http://www.downtown161.com/images/topNav_r2_c5_f3.jpg','http://www.downtown161.com/images/topNav_r2_c6_f2.jpg','http://www.downtown161.com/images/topNav_r2_c6_f3.jpg');">
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="http://www.downtown161.com/images/dt161Home_r1.jpg" alt="Downtown 161" width="700" height="173" /></td>
  </tr>
  <tr>
    <td><img src="http://www.downtown161.com/images/dt161Home_r2.jpg" alt="The #1 Source for the Best Underground House Vinyl Records Worldwide" width="700" height="60" /></td>
  </tr>
<tr><td bgcolor="#C0C0C0">
	   <!-- begin content -->
	  
	  <img src="images/spacer.gif" width="500" height="10">
	   <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
         <!-- fwtable fwsrc="DTstatusMenu.png" fwbase="DTstatusMenu.jpg" fwstyle="Dreamweaver" fwdocid = "1179021194" fwnested="0" -->
		  <tr>
		   <td><img src="images/spacer.gif" width="101" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="102" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="102" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="102" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="93" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
		  </tr>
		  <tr>
		   <td><cfif url.stat EQ 21><img src="images/DTstatusMenu_r1_c1_f3.jpg"><cfelse><a href="DTDailyCatalog.cfm?stat=21" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f2.jpg','images/DTstatusMenu_r1_c1_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f3.jpg',1);"><img name="DTstatusMenu_r1_c1" src="images/DTstatusMenu_r1_c1.jpg" width="101" height="20" border="0" id="DTstatusMenu_r1_c1" alt="New Releases" /></a></cfif></td>
		   <td><cfif url.stat EQ 22><img src="images/DTstatusMenu_r1_c2_f3.jpg"><cfelse><a href="DTDailyCatalog.cfm?stat=22" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f2.jpg','images/DTstatusMenu_r1_c2_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f3.jpg',1);"><img name="DTstatusMenu_r1_c2" src="images/DTstatusMenu_r1_c2.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c2" alt="Recent Releases" /></a></cfif></td>
		   <td><cfif url.stat EQ 23><img src="images/DTstatusMenu_r1_c3_f3.jpg"><cfelse><a href="DTDailyCatalog.cfm?stat=23" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f2.jpg','images/DTstatusMenu_r1_c3_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f3.jpg',1);"><img name="DTstatusMenu_r1_c3" src="images/DTstatusMenu_r1_c3.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c3" alt="Back in Stock" /></a></cfif></td>
		   <td><cfif url.stat EQ 24><img src="images/DTstatusMenu_r1_c4_f3.jpg"><cfelse><a href="DTDailyCatalog.cfm?stat=24" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f2.jpg','images/DTstatusMenu_r1_c4_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f3.jpg',1);"><img name="DTstatusMenu_r1_c4" src="images/DTstatusMenu_r1_c4.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c4" alt="Regular Catalog (loads slowly)" /></a></cfif></td>
		   <td><img name="DTstatusMenu_r1_c5" src="images/DTstatusMenu_r1_c5.jpg" width="93" height="20" border="0" id="DTstatusMenu_r1_c5" alt="" /></td>
		   <td><img src="images/spacer.gif" width="1" height="20" border="0" alt="" /></td>
		  </tr>
      </table>
	<div align="center"><form name="searchForm" id="searchForm" title="searchForm" action="dtDailyCatalog.cfm" method="post" style="margin-top: 10px; margin-bottom: 10px; padding-top: 0px; padding-bottom: 0px;">
		<span class="style3"><strong><img align="baseline" src="images/spacer.gif"  width="5" />Find</strong>	    <span class="style5">
		  <input type="text" name="searchString" size="30" maxlength="50"> 
		  in
		  <select name="searchField">
		    <option value="all" selected>All</option>
		    <option value="artist">Artist</option>
		    <option value="title">Title</option>
		    <option value="label">Label</option>
	    </select> 
	    limit to
		  <select name="group">
		    <option value="all" selected>All Inventory</option>
		    <option value="new">New Releases</option>
		    <option value="back">Back Catalogue</option>
		    <option value="reissues">Reissues</option>
	    </select>
	      <input type="submit" name="search" value=" Go " />
&nbsp;</span></span>
	</form></div>
<h1 style="font-family:Arial, Helvetica, sans-serif; margin-left: 50px; margin-right: 50px;"><img src="http://www.nndb.com/people/093/000031000/larry-levan.jpg" width="200" height="294" border="0" align="right" />&nbsp;<br />Happy Birthday<br>Larry Levan<br />&nbsp;<br />&nbsp;</h1>
<cfif dt161special.recordCount GT 50>
<cfset numPages=Int((dt161special.recordCount-1)/50)+1>
<cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="DT161Special.cfm?rsPage=#url.rsPage-1#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="DT161Special.cfm?rsPage=#x#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages>&nbsp;&nbsp;<a href="DT161Special.cfm?rsPage=#url.rsPage+1#">next&gt;&gt;</a></cfif></p>
</cfoutput>
</cfif>
<cfset thisStartRow=(url.rsPage*50)-49>
	   <table width="100%" border="0" cellpadding="3"  bgcolor="#C6C7C6">
<cfoutput query="dt161special" maxrows="50" startrow="#thisStartRow#">
	<cfif dt161special.jpgLoaded>
		<cfset imagefile="items/oI#dt161special.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
  <tr>
    <td width="85" rowspan="2" align="center" valign="top"><img src="images/#imagefile#" width="75" height="75" /></td>
    <td width="390" align="left" valign="top" class="detailsArtist" ><b>#artist#</b>
		<br />#title#</td>
    <td rowspan="2" align="left" valign="top" class="detailsLabel"><b>#label#</b><br />
		Cat. No.: #catnum#<br />
		Item No.: #ID##shelfCode#<br />
		Format: <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#<br />
     	#DollarFormat(cost)#</td>
  </tr>
  
  <tr>
    <td valign="top" class="detailsTracks">
	<table border="0" cellpadding="0" align="left">
	<cfif mediaID NEQ 5><cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#dt161special.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
		<cfif tracks.mp3Loaded>
			<td align="center" valign="middle"><a href="http://www.downtown304.com/DT161PlayFrame.cfm?oClip=#tracks.ID#" target="dt161player"><img 
		src="images/speaker.gif" width="16" height="13" border="0" align="middle" alt="listen" hspace="2"></a></td>
		<cfelse>
			<td align="center" valign="middle"><img src="images/spacer.gif" width="16" height="13" border="0"></td>
		</cfif>
			<td align="left" valign="middle" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop>
	  <cfelse>
	  <tr><td>&nbsp;</td></tr></cfif>
    </table></td>
   </tr>
   
 

  <tr>
  	<td colspan="3"><hr noshade></td>
  </tr>
</cfoutput>
</table> 
<cfif dt161special.recordCount GT 50>
<cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="DT161Special.cfm?rsPage=#url.rsPage-1#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="DT161Special.cfm?rsPage=#x#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages>&nbsp;&nbsp;<a href="DT161Special.cfm?rsPage=#url.rsPage+1#">next&gt;&gt;</a></cfif></p>
</cfoutput>
</cfif>
<!---<cfif url.stat NEQ "">
  <h4 class="style6" style="font-size: medium; font-weight: bold; margin-top: 20px; margin-bottom: 20px;"> &nbsp;&nbsp;CD Section</h4>
  <cfif url.stat EQ 24>
	<cfquery name="dt161special" datasource="#DSN#">
		select *
		from catItemsQuery
		where active=1 AND ONHAND>0 AND (albumStatusID=24) AND Left(shelfCode,1)='D' AND shelfCode<>'DS' AND (mediaID=2 OR mediaID=3) AND ID=0
		order by label ASC, catnum ASC
	</cfquery>
<cfelse>
	<cfquery name="dt161special" datasource="#DSN#">
		select *
		from catItemsQuery
		where active=1 AND ONHAND>0 AND (albumStatusID=#url.stat#) AND Left(shelfCode,1)='D' AND shelfCode<>'DS' AND (mediaID=2 OR mediaID=3)
		order by catItems.dtDateUpdated DESC, label ASC
	</cfquery>
</cfif>
<!---<table width="100%" border="0" cellpadding="8">
  <tr>
    <td bgcolor="#666666">
<p align="left" style="font-family: Arial, Helvetica, sans-serif; font-size: x-small;">
<a href="index.cfm?ob=artist&so=asc">^</a> artist <a href="index.cfm?ob=artist&so=desc">v</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="index.cfm?ob=title&so=asc">^</a>  title <a href="index.cfm?ob=title&so=desc">v</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="index.cfm?ob=label&so=asc">^</a>  label <a href="index.cfm?ob=label&so=desc">v</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="index.cfm?ob=releaseDate&so=asc">^</a> date <a href="index.cfm?ob=releaseDate&so=desc">v</a></p>
	</td>
  </tr>
</table>//--->

<table width="100%" border="0" cellpadding="3"  bgcolor="#C6C7C6">
<cfoutput query="dt161special">
	<cfif dt161special.jpgLoaded>
		<cfset imagefile="items/oI#dt161special.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
  <tr>
    <td width="85" rowspan="2" align="center" valign="top"><img src="images/#imagefile#" width="75" height="75" /></td>
    <td width="390" align="left" valign="top" class="detailsArtist" ><b>#artist#</b>
		<br />#title#</td>
    <td rowspan="2" align="left" valign="top" class="detailsLabel"><b>#label#</b><br />
		Cat. No.: #catnum#<br />
		Item No.: #ID##shelfCode#<br />
		Format: <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#<br />
     	#DollarFormat(cost)#</td>
  </tr>
  <tr>
    <td valign="top" class="detailsTracks">
	<table width="100%" border="0" cellpadding="0" align="left">
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#dt161special.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
		<cfif tracks.mp3Loaded>
			<td align="left" valign="middle"><a href="http://www.downtown304.com/media/oT#tracks.ID#.mp3"><img 
			src="images/speaker.gif" width="16" height="13" border="0" align="middle" alt="listen" hspace="2"></a></td>
		<cfelse>
			<td align="left" valign="middle"><img src="images/spacer.gif" align="baseline" height="13" width="1" border="0"></td>
		</cfif>
			<td align="left" valign="middle" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop>
    </table></td>
   </tr>
  <tr>
  	<td colspan="3"><hr noshade></td>
  </tr>
</cfoutput>
</table> 
</cfif>//--->
<!-- end content -->  
<tr>
    <td><img src="http://www.downtown161.com/images/dt161Home_r5.jpg" width="700" height="37" border="0"  /></td>
  </tr>
</table>


	
</body>
</html>