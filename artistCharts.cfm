<!---<cfcache timespan="#createTimeSpan(1,0,0,0)#">//--->
<cfparam name="url.artistID" default="0">
<cfparam name="url.chartID" default="0">
<cfparam name="url.SID" default="0">
<cfquery name="allArtistCharts" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select *
	from artistListsQuery
</cfquery>
<cfquery name="artistCharts" dbtype="query" maxrows="20">
	select *
	from allArtistCharts
	where artistID=<cfqueryparam value="#url.artistID#" cfsqltype="cf_sql_integer"> AND active=1
	order by listDate DESC
</cfquery>
<cfif chartID EQ 0>
	<cfquery name="thisChart" dbtype="query" maxrows="1">
		select *
		from artistCharts
	</cfquery>
<cfelse>
	<cfquery name="thisChart" dbtype="query" maxrows="1">
		select *
		from artistCharts
		where ID=<cfqueryparam value="#url.chartID#" cfsqltype="cf_sql_integer">
	</cfquery>
</cfif>
<cfset thisChartID=thisChart.ID>
<cfquery name="allChartItems" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select *
	from artistListsItemsQuery
</cfquery>
<cfquery name="thisChartItems" dbtype="query">
	select *
	from allChartItems
	where listID=#thisChartID# AND ((ONHAND>0 ) OR ONSIDE>0 OR (trackONHAND>0 ) OR trackONSIDE>0)
	order by sort
</cfquery>
<cfquery name="getTrackListA" dbtype="query">
	select DISTINCT itemID from Application.allTracks
    where (artistID=<cfqueryparam value="#url.artistID#" cfsqltype="cf_sql_integer">
        OR LOWER(artist) LIKE <cfqueryparam value="%#LCase(thisChart.artist)#%" cfsqltype="cf_sql_char">
        OR LOWER(title) LIKE <cfqueryparam value="%#LCase(thisChart.artist)#%" cfsqltype="cf_sql_char">
        OR LOWER(tName) LIKE <cfqueryparam value="%#LCase(thisChart.artist)#%" cfsqltype="cf_sql_char">)
        AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0)
</cfquery>
<cfset trackListCSV="0">
<cfloop query="getTrackListA">
	<cfset trackListCSV=trackListCSV&","&itemID>
</cfloop>
<cfquery name="chartAlso" dbtype="query">
	select * from Application.dt304Items where ID IN (#trackListCSV#) order by releaseDate DESC
</cfquery>
<!---<cfquery name="chartAlso" datasource="#DSN#">
	select *
	from catTracksQuery
	where (artistID=#url.artistID# 
		OR artist LIKE <cfqueryparam value="%#thisChart.artist#%" cfsqltype="cf_sql_char">
		OR title LIKE <cfqueryparam value="%#thisChart.artist#%" cfsqltype="cf_sql_char">
		OR tName LIKE <cfqueryparam value="%#thisChart.artist#%" cfsqltype="cf_sql_char">)
		AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0)
		order by itemID, tSort
</cfquery>//--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304: Artist Charts</title>
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<style type="text/css">
td img {display: block;}body {
	background-color: #000000;
}
.style1 {color: #333333}
.style3 {
	color: #FFFFFF;
	font-size: 12px;
}
</style>
</head>

<body onLoad="MM_preloadImages('images/boxButtonListen_f3.jpg','images/boxButtonListen_f2.jpg','images/boxButtonBuy_f3.jpg','images/boxButtonBuy_f2.jpg','images/boxButtonBin_f3.jpg','images/boxButtonBin_f2.jpg','images/boxButtonView_f3.jpg','images/boxButtonView_f2.jpg')">
<cfinclude template="topNav.cfm">
	<a href="javascript: history.go(-1);" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','buttonBack','images/buttonBack_f2.jpg','images/buttonBack_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','buttonBack','images/buttonBack_f3.jpg',1);"><img src="images/buttonBack.jpg" alt="" name="buttonBack" width="37" height="10" hspace="5" vspace="5" border="0" id="buttonBack" /></a>
<table border="0" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" align="center">
<cfoutput query="thisChart">
<tr>
	<td align="left" valign="bottom"><h4>#artist#<cfif website NEQ ""><font size="1"><br />
		<a href="#website#" target="_blank">View artist website</a></font></cfif></h4>
	  </td>
	<td align="right" valign="bottom"><h4><font size="1"><a href="artistChartsList.cfm">See lists from other artists</a></font></h4>
    </td>
</tr>
</cfoutput>
<tr>
	<td valign="top">
<table border="0" cellpadding="0" cellspacing="0" >
<!-- fwtable fwsrc="opussitelayout07lists.png" fwbase="opussitelayout07lists.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="13" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td><img name="opussitelayout07lists_r1_c1" src="images/opussitelayout07lists_r1_c1.jpg" width="13" height="10" border="0" id="opussitelayout07lists_r1_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r1_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r1_c3" src="images/opussitelayout07lists_r1_c3.jpg" width="12" height="10" border="0" id="opussitelayout07lists_r1_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r2_c1" src="images/opussitelayout07lists_r2_c1.jpg" width="13" height="24" border="0" id="opussitelayout07lists_r2_c1" alt="" /></td>
   <td align="left" valign="top" bgcolor="#006599"><span class="style3">All Artist Play Lists</span></td>
   <td><img name="opussitelayout07lists_r2_c3" src="images/opussitelayout07lists_r2_c3.jpg" width="12" height="24" border="0" id="opussitelayout07lists_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="24" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r3_c1" src="images/opussitelayout07lists_r3_c1.jpg" width="13" height="6" border="0" id="opussitelayout07lists_r3_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r3_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r3_c3" src="images/opussitelayout07lists_r3_c3.jpg" width="12" height="6" border="0" id="opussitelayout07lists_r3_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt="" /></td>
  </tr>
  <tr>
   <td background="images/opussitelayout07lists_r4_c1.jpg"><img src="images/spacer.gif" width="1" heigth="1" /></td>
   <td valign="top" bgcolor="#333333"><table border=0 cellpadding=4 cellspacing=0>
     <cfoutput query="artistCharts">
	 <tr>
       <td align="left"><cfif ID NEQ thisChartID><a href="artistCharts.cfm?artistID=#artistID#&chartID=#ID#">#listName#</a> &nbsp;&nbsp;(#DateFormat(listDate,"mmmm yyyy")#)<cfelse>#listName# &nbsp;&nbsp;(#DateFormat(listDate,"mmmm yyyy")#)</cfif></td>
     </tr>
	 </cfoutput> 
</table></td>
   <td background="images/opussitelayout07lists_r4_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="78" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r5_c1" src="images/opussitelayout07lists_r5_c1.jpg" width="13" height="12" border="0" id="opussitelayout07lists_r5_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r5_c2.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img name="opussitelayout07lists_r5_c3" src="images/opussitelayout07lists_r5_c3.jpg" width="12" height="12" border="0" id="opussitelayout07lists_r5_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt="" /></td>
  </tr>
</table>
</td>
<td valign="top">
<table border="0" cellpadding="0" cellspacing="0" >
<!-- fwtable fwsrc="opussitelayout07lists.png" fwbase="opussitelayout07lists.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="13" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td><img name="opussitelayout07lists_r1_c1" src="images/opussitelayout07lists_r1_c1.jpg" width="13" height="10" border="0" id="opussitelayout07lists_r1_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r1_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r1_c3" src="images/opussitelayout07lists_r1_c3.jpg" width="12" height="10" border="0" id="opussitelayout07lists_r1_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r2_c1" src="images/opussitelayout07lists_r2_c1.jpg" width="13" height="24" border="0" id="opussitelayout07lists_r2_c1" alt="" /></td>
   <td align="left" valign="top" bgcolor="#006599"><span class="style3"><cfoutput query="thisChart">#listName# #DateFormat(listDate,"mmmm yyyy")#<br />
   </cfoutput></span></td>
   <td><img name="opussitelayout07lists_r2_c3" src="images/opussitelayout07lists_r2_c3.jpg" width="12" height="24" border="0" id="opussitelayout07lists_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="24" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r3_c1" src="images/opussitelayout07lists_r3_c1.jpg" width="13" height="6" border="0" id="opussitelayout07lists_r3_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r3_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r3_c3" src="images/opussitelayout07lists_r3_c3.jpg" width="12" height="6" border="0" id="opussitelayout07lists_r3_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt="" /></td>
  </tr>
  <tr>
   <td background="images/opussitelayout07lists_r4_c1.jpg"><img src="images/spacer.gif" width="1" heigth="1" /></td>
   <td valign="top" bgcolor="#333333"><table border=0 cellpadding=4 cellspacing=0>
<cfset listCt=0>
<cfoutput query="thisChartItems">
	<cfset listCt=listCt+1>
	<tr>
       <!---<td rowspan="2" align="center" style="font-size:13px; background-color:##666666;color:##CCCCCC;"><b>&nbsp;#listCt#&nbsp;</b></td>//--->
	  <cfif trackID NEQ 0>
	   	<cfset thisID=trackItemID>
		<cfset thisArtist=trackArtist>
		<cfset thisTitle=tName>
		<cfset thisLabel=trackLabel>
		<cfset thisTrackID=trackID>
		<cfset thisArtistID=trackArtistID>
	 <cfelse>
	 	<cfset thisID=itemID>
		<cfset thisArtist=itemArtist>
		<cfset thisTitle=itemTitle>
		<cfset thisLabel=itemLabel>
		<cfset thisArtistID=artistID>
		<cfquery name="firstTrack" dbtype="query" maxrows="1">
			select *
			from Application.allTracks
			where catID=#itemID#
			order by tSort
		</cfquery>
		<cfset thisTrackID=firstTrack.ID>
	</cfif>
	<!---<cfdirectory directory="d:\media" filter="oT#thisTrackID#.mp3" name="trackCheck" action="list">//--->
	<td align="left" valign="middle" style="line-height: 100%;" width="10">
		<cfif mp3Alt NEQ 0 AND mp3Alt NEQ ""><cfset trID=mp3Alt><cfelse><cfset trID=thisTrackID></cfif>
			<cfif mp3Loaded EQ 1 OR mp3Alt NEQ 0>
			
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
				<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="opussitelayout07player.cfm?oClip=#trID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#trID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
		  </tr>
		</table>
			
			<!---
			<table border="0" cellpadding="0" cellspacing="2"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="10" style="border-collapse:collapse;">
			<tr class="oTrack"><td><a href="opussitelayout07player.cfm?oClip=#thisTrackID#" target="opusviewplayer" class="detailsTracks"><img src="spacer.gif" width="9" height="10" border="0" alt="Play"  /></a></td></tr></table>
			</td>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks" width="10" rowspan="2"><table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;">
			<tr class="oTrackBin"><td><a href="binaction.cfm?oClip=#thisTrackID#" target="opusviewbins" class="detailsTracks"><img src="spacer.gif" width="9" height="10" border="0" alt="Add to listening bin" /></a></td></tr></table></td>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks" width="10" rowspan="2"><table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;">
			<tr class="oTrackCart"><td><a href="cartAction.cfm?cAdd=#thisID#" target="opusviewbins" class="detailsTracks"><img src="spacer.gif" width="9" height="10" border="0" alt="Buy" /></a></td></tr></table></td>
			</tr></table>//--->
			<cfelse>&nbsp;</cfif></td>
	   <td align="left" bgcolor="##333333"><b><a href="opussitelayout07main.cfm?af=#thisArtistID#&group=all" title="See all releases by #thisArtist#">#thisArtist#</a></b><br /><a href="opussitelayout07main.cfm?sID=#thisID#" target="opusviewmain" title="See all details about this release">#thisTitle#</a></td>
     </tr>
</cfoutput>
</table></td>
   <td background="images/opussitelayout07lists_r4_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="78" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r5_c1" src="images/opussitelayout07lists_r5_c1.jpg" width="13" height="12" border="0" id="opussitelayout07lists_r5_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r5_c2.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img name="opussitelayout07lists_r5_c3" src="images/opussitelayout07lists_r5_c3.jpg" width="12" height="12" border="0" id="opussitelayout07lists_r5_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt="" /></td>
  </tr>
</table></td>
</tr>
<cfif chartAlso.recordCount GT 0>
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
  
   <cfoutput query="chartAlso">
   	<cfset displayedID=ID>
	<cfif chartAlso.jpgLoaded AND NOT (fullImg NEQ "" AND url.sID NEQ 0)>
		<cfset imagefile="items/oI#chartAlso.ID#.jpg">
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
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="images/spacer.gif" width="75" height="75" border="0" /></a></td>
  </tr>
</table></td>
   <td rowspan="3" background="images/opussitelayout07main_r11_c5.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="##333333" colspan="5"><font size="2"><a href="opussitelayout07main.cfm?af=#artistID#&group=all"><b>#artist#</b></a><br /><a href="opussitelayout07main.cfm?sID=#ID#" title="View Details and Recommendations">#title#</a> (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</font><br /><a href="opussitelayout07main.cfm?lf=#labelID#&group=all">#label#</a></td>
   <td colspan="2" rowspan="2" valign="top" bgcolor="##333333" class="detailsArtist"><font style="font-family: Arial, Helvetica, sans-serif; font-size:x-small; line-height:100%;"><cfif releaseDate NEQ "" AND albumStatusID NEQ 148>#DateFormat(releaseDate,"yyyy-mm-dd")#<cfelse>#DateFormat(DTdateUpdated,"yyyy-mm-dd")#</cfif><br />
		Cat. No.:<br />
		#Right(catnum,13)#<br />
		Genre: #genre#<br />
		#country#</font><br />
     	<cfif albumStatusID EQ 148>
			<b><font color="red">PRE-RELEASE</font></b>
		<cfelse>
		<cfset salePerc=79><cfif url.group EQ "sale"><b><font color="red" style="text-decoration:line-through;">#DollarFormat(price)#</font> #DollarFormat(price*salePerc/100)#</b><cfelse><b>#DollarFormat(price)#</cfif></b><br />
		<span class="style1">IN-STOCK</span><br />
		<cfif url.group EQ "sale"><a href="cartAction.cfm?cAdd=#ID#&dos=oui&dosp=#salePerc#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse>
		<a href="cartAction.cfm?cAdd=#ID#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a></cfif></cfif></td>
   <td rowspan="3" colspan="2" background="images/opussitelayout07main_r11_c13.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top" bgcolor="##333333">
    <cfif hideTracks EQ 1><p><a href="javascript:showdiv(#ID#)">Click to see track listing</a></p></cfif>
	<div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden;"</cfif>><table width="100%" border="0" cellpadding="0" >
	 <cfquery name="tracks" dbtype="query">
		select *
		from Application.allTracks
		where catID=#chartAlso.ID#
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
				<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="opussitelayout07player.cfm?oClip=#trID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#tracks.ID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
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
</cfif></body></html>