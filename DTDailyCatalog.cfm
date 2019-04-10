<cflocation url="http://www.downtown304.com">
<cfparam name="url.rsPage" default="1">
<cfparam name="url.stat" default="21">
<cfparam name="url.lf" default="">
<cfparam name="url.group" default="">
<cfparam name="form.searchField" default="">
<cfparam name="form.searchString" default="">
<cfparam name="url.searchField" default="">
<cfparam name="url.searchString" default="">
<cfset thisSearchField="">
<cfset thisSearchString="">
<cfset numPages=1>
<cfif form.searchField NEQ ""><cfset thisSearchField=form.searchField><cfset url.stat=""></cfif>
<cfif form.searchString NEQ ""><cfset thisSearchString=form.searchString><cfset url.stat=""></cfif>
<cfif url.searchField NEQ ""><cfset thisSearchField=url.searchField><cfset url.stat=""></cfif>
<cfif url.searchString NEQ ""><cfset thisSearchString=url.searchString><cfset url.stat=""></cfif>
<cfif url.stat EQ ""><cfset url.stat=21></cfif>

<cfoutput><!---...#thisSearchString#...#form.searchString#...#form.searchField#...#thisSearchField#...//---></cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><!--update001//-->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 161 :: Underground House Music and Dance Classics since 1991 - 12" singles and more</title>
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
a:link {color:#0066FF;}
a:hover {color:#FFFFFF;}
a:visited {color:#0066FF;}
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
		   <td><cfif url.stat EQ 21><a href="DTDailyCatalog.cfm?stat=21" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f2.jpg','images/DTstatusMenu_r1_c1_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f3.jpg',1);"><img src="images/DTstatusMenu_r1_c1_f3.jpg" border="0"></a><cfelse><a href="DTDailyCatalog.cfm?stat=21" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f2.jpg','images/DTstatusMenu_r1_c1_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f3.jpg',1);"><img name="DTstatusMenu_r1_c1" src="images/DTstatusMenu_r1_c1.jpg" width="101" height="20" border="0" id="DTstatusMenu_r1_c1" alt="New Releases" /></a></cfif></td>
		   <td><cfif url.stat EQ 22><a href="DTDailyCatalog.cfm?stat=22" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f2.jpg','images/DTstatusMenu_r1_c2_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f3.jpg',1);"><img src="images/DTstatusMenu_r1_c2_f3.jpg" border="0"></a><cfelse><a href="DTDailyCatalog.cfm?stat=22" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f2.jpg','images/DTstatusMenu_r1_c2_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f3.jpg',1);"><img name="DTstatusMenu_r1_c2" src="images/DTstatusMenu_r1_c2.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c2" alt="Recent Releases" /></a></cfif></td>
		   <td><cfif url.stat EQ 23><a href="DTDailyCatalog.cfm?stat=23" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f2.jpg','images/DTstatusMenu_r1_c3_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f3.jpg',1);"><img src="images/DTstatusMenu_r1_c3_f3.jpg" border="0"></a><cfelse><a href="DTDailyCatalog.cfm?stat=23" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f2.jpg','images/DTstatusMenu_r1_c3_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f3.jpg',1);"><img name="DTstatusMenu_r1_c3" src="images/DTstatusMenu_r1_c3.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c3" alt="Back in Stock" /></a></cfif></td>
		   <td><cfif url.stat EQ 24><a href="DTDailyCatalog.cfm?stat=24" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f2.jpg','images/DTstatusMenu_r1_c4_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f3.jpg',1);"><img src="images/DTstatusMenu_r1_c4_f3.jpg" border="0"></a><cfelse><a href="DTDailyCatalog.cfm?stat=24" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f2.jpg','images/DTstatusMenu_r1_c4_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f3.jpg',1);"><img name="DTstatusMenu_r1_c4" src="images/DTstatusMenu_r1_c4.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c4" alt="Regular Catalog (loads slowly)" /></a></cfif></td>
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
	    <!---limit to
		  <select name="group">
		    <option value="all" selected>All Inventory</option>
		    <option value="new">New Releases</option>
		    <option value="back">Back Catalogue</option>
		    <option value="reissues">Reissues</option>
	    </select>//--->
	      <input type="submit" name="search" value=" Go " />
&nbsp;</span></span>
	</form></div>
<cfif thisSearchField EQ "all">
	<cfif thisSearchString EQ ""><!--find nothing in all//-->
		<cfquery name="dt161daily" dbtype="query">
			select *
			from Application.dt161Items
		</cfquery>
	<cfelse><!--find search string in all//-->
		<!---<cfquery name="dt161daily"  dbtype="query">
			select *
			from Application.dt161Items
			where (LOWER(artist) LIKE '%#LCase(form.searchString)#%' OR
			LOWER(label) LIKE '%#LCase(form.searchString)#%' OR
			LOWER(title) LIKE '%#LCase(form.searchString)#%')
			AND shelfID IN (7,11,13)
			AND (ONHAND>0 AND (albumStatusID<25))
		</cfquery>//--->
        <!--.find6.//-->
        <cfquery name="trackFind" dbtype="query">
        	select DISTINCT itemID from dt161tracks
            where (LOWER(artist) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(title) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(label) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(tName) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(catnum) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char">)
                AND ONHAND>0 AND albumStatusID<25
        </cfquery>
        <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<cfif tfStart><cfset trackFindList=trackFindList&","&itemID><cfelse><cfset trackFindList=itemID></cfif>
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
        <cfquery name="dt161Daily" dbtype="query">
            select * from Application.dt161Items where ID IN (#trackFindList#) OR ((LOWER(artist) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                    LOWER(title) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                    LOWER(label) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                    LOWER(catnum) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char">)
                    AND ONHAND>0 AND albumStatusID<25)
                order by dtDateUpdated DESC
        </cfquery>
	</cfif>
<cfelseif thisSearchField NEQ "">
	<cfif thisSearchString EQ ""><!--find nothing //-->
		<cfquery name="dt161daily" dbtype="query">
			select *
			from Application.dt161Items
		</cfquery>
	<cfelse><!-- find search string //-->
	<cfquery name="dt161daily" datasource="#DSN#">
		select *
		from catItemsQuery
		where <cfqueryparam value="#thisSearchField#" cfsqltype="cf_sql_char"> LIKE <cfqueryparam value="%#thisSearchString#%" cfsqltype="cf_sql_char">
	</cfquery>
	</cfif>
<cfelseif url.lf NEQ "">
<cfquery name="dt161Daily" dbtype="query">
            select * from Application.dt161Items where labelID=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.lf#">
                order by dtDateUpdated DESC
        </cfquery>
<cfelseif url.group EQ "larry">

	<cfquery name="trackFind" dbtype="query">
        select DISTINCT itemID from dt161tracks
            where LOWER(tName) LIKE '%larry levan%' OR LOWER(tName) LIKE '%paradise garage%'
        </cfquery><br />
		<cfset trackFindList="">
         <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<!---<cfif tfStart>//---><cfset trackFindList=trackFindList&","&itemID><!---<cfelse><cfset trackFindList=itemID></cfif>//--->
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
	<cfquery name="dt161daily" dbtype="query">
			select *
			from Application.dt161Items
			where labelID=5529 OR pgFlag=1 OR (LOWER(artist) LIKE '%larry levan%' OR LOWER(title) LIKE '%larry levan%' OR LOWER(artist) LIKE '%paradise garage%' OR LOWER(title) LIKE '%paradise garage%' OR ID IN (43305#trackFindList#)) 
			order by label ASC, catnum ASC
		</cfquery>
<cfelse>
	<cfif url.stat EQ 24><!--find 24//-->
		<cfquery name="dt161daily" dbtype="query">
			select *
			from Application.dt161Items
			where (albumStatusID=24) 
			 order by label ASC, catnum ASC
		</cfquery>
	<cfelseif url.stat EQ 21><!--find 25//-->
		   <cfquery name="dt161daily" dbtype="query">
			select *
			from Application.dt161Items
			where (albumStatusID<22) 
			 order by dtDateUpdated DESC, ONHAND DESC
		  </cfquery>
     <cfelse><!-- find 26 //-->
           <cfquery name="dt161daily" dbtype="query">
			select *
			from Application.dt161Items
			where (albumStatusID=#url.stat#)
			 order by dtDateUpdated DESC, ONHAND DESC
		  </cfquery>
	</cfif>
</cfif>
<cfif dt161daily.recordCount GT 60>
<cfset numPages=Int((dt161daily.recordCount-1)/60)+1>
<cfoutput>
<p align="center"><font size="2">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="DTDailyCatalog.cfm?rsPage=#url.rsPage-1#&searchString=#thisSearchString#&searchField=#thisSearchField#&stat=#url.stat#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="DTDailyCatalog.cfm?rsPage=#x#&searchString=#thisSearchString#&searchField=#thisSearchField#&stat=#url.stat#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages>&nbsp;&nbsp;<a href="DTDailyCatalog.cfm?rsPage=#url.rsPage+1#&searchString=#thisSearchString#&searchField=#thisSearchField#&stat=#url.stat#">next&gt;&gt;</a></cfif></font></p>
</cfoutput>
</cfif>
<cfset thisStartRow=(url.rsPage*30)-29>
	   <table width="100%" border="0" cellpadding="3"  bgcolor="#C6C7C6">
<cfoutput query="dt161daily" maxrows="30" startrow="#thisStartRow#">
	<cfif dt161daily.jpgLoaded>
		<cfset imagefile="items/oI#dt161daily.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
  <tr>
    <td width="85" rowspan="2" align="center" valign="top"><cfif fullImg NEQ ""><a href="http://www.downtown304.com/images/items/#fullImg#" target="_blank"><img src="images/#imagefile#" width="75" height="75" border="0" /></a><cfelse><img src="images/#imagefile#" width="75" height="75" /></cfif></td>
    <td width="750" align="left" valign="top" class="detailsArtist" ><cfif pgFlag><img src="images/pglogo.jpg" width="38" height="38" vspace="5" style="padding-right: 7px;" align="left" title="Paradise Garage Classic" alt="Paradise Garage Classic" /></cfif><b>#artist#</b>
		<br />#title#</td>
    <td width="150" rowspan="2" align="left" valign="top" class="detailsLabel"><cfif countryID NEQ 1><table width="100%" cellpadding="3" bgcolor="##CC0000"><tr><td style="color:##FFFFFF" align="center"><b>IMPORT</b></td></tr></table><cfelse><table width="100%" cellpadding="3" bgcolor="##669900"><tr><td style="color:##FFFFFF" align="center"><b>U.S. RELEASE</b></td></tr></table></cfif><b>#label#</b><br />
		Cat. No.: #catnum#<br /><!---
		Item No.: #ID##shelfCode#<br />//--->
		Format: <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#<br />
     	<font size="+1"><b>#DollarFormat(buy)#</b></font></td>
  </tr>
  
  <tr>
    <td valign="top" class="detailsTracks"><!---<cfif hideTracks EQ 1><p><a href="javascript:showdiv(#ID#)">Click to see track listing</a></p></cfif>//--->
	<!---<div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden"</cfif>>//---><table border="0" cellpadding="0" align="left"><!---<cfif mediaID NEQ 5>//--->
	<cfquery name="tracks" dbtype="query">
		select *
		from dt161Tracks
		where catID=<cfqueryparam value="#dt161daily.ID#" cfsqltype="cf_sql_integer">
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
		<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfif tracks.mp3Loaded EQ 1 OR mp3Alt NEQ 0 AND mp3Alt NEQ "">
			<td align="center" valign="middle"><a href="http://www.downtown304.com/DT161PlayFrame.cfm?oClip=#trID#" target="dt161player"><img 
		src="images/speaker.gif" width="16" height="13" border="0" align="middle" alt="listen" hspace="2"></a></td>
		<cfelse>
			<td align="center" valign="middle"><img src="images/spacer.gif" width="16" height="13" border="0"></td>
		</cfif>
			<td align="left" valign="middle" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop>
	  <!---<cfelse>
	  <tr><td>&nbsp;</td></tr></cfif>//--->
    </table></div></td>
   </tr>
   
 

  <tr>
  	<td colspan="3"><hr noshade></td>
  </tr>
</cfoutput>
</table> 
<cfif dt161daily.recordCount GT 30>
<cfoutput>
<p align="center"><font size="2">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="DTDailyCatalog.cfm?rsPage=#url.rsPage-1#&searchString=#thisSearchString#&searchField=#thisSearchField#&stat=#url.stat#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="DTDailyCatalog.cfm?rsPage=#x#&searchString=#thisSearchString#&searchField=#thisSearchField#&stat=#url.stat#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages>&nbsp;&nbsp;<a href="DTDailyCatalog.cfm?rsPage=#url.rsPage+1#&searchString=#thisSearchString#&searchField=#thisSearchField#&stat=#url.stat#">next&gt;&gt;</a></cfif><br />&nbsp;</font></p>
</cfoutput>
</cfif>
<!---<cfif url.stat NEQ "">
  <h4 class="style6" style="font-size: medium; font-weight: bold; margin-top: 20px; margin-bottom: 20px;"> &nbsp;&nbsp;CD Section</h4>
  <cfif url.stat EQ 24>
	<cfquery name="dt161daily" datasource="#DSN#">
		select *
		from catItemsQuery
		where active=1 AND ONHAND>0 AND (albumStatusID=24) AND Left(shelfCode,1)='D' AND shelfCode<>'DS' AND (mediaID=2 OR mediaID=3) AND ID=0
		order by label ASC, catnum ASC
	</cfquery>
<cfelse>
	<cfquery name="dt161daily" datasource="#DSN#">
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
<cfoutput query="dt161daily">
	<cfif dt161daily.jpgLoaded>
		<cfset imagefile="items/oI#dt161daily.ID#.jpg">
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
		where catID=#dt161daily.ID#
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