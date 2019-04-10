<style type="text/css">
<!--
.boxList_td {
	font-family:Arial, Helvetica, sans-serif;
	font-size: 10px; 
	padding-left: 3px; 
	padding-right: 4px; 
	padding-top: 2px; 
	padding-bottom: 2px; 
	vertical-align:top;
	text-align:left;}
.boxList_h1 {
	font-size: 14px;
	font-weight: bold;
	color:#FFFFFF;
	margin-top: 7px;
	margin-bottom: 7px;
	margin-left: 5px;
}
.style1 {font-size: 14px; font-weight: bold; color: #333333; margin-top: 7px; margin-bottom: 7px; margin-left: 3px; margin-right: 3px; }
.style2 {color: #FFFFFF}
-->
</style>
<!--- Reusable code for a NEW RELEASES list 
All variables to be passed to this list should be set in the calling page.
This pages uses variables starting with "o1" (that's lowercase oh and the number one) //--->

<!--- VARIABLES //--->
<cfparam name="o1GenreID" default="1">
<cfparam name="o1ListLength" default="25">
<cfparam name="o1GeoFlag" default="0"><!--- 1=Domestic, 2=Imports, 0=Both //--->
<!--- END VARIABLES //--->
<cfswitch expression="#o1GeoFlag#">
	<cfcase value="1">
		<cfset geoSwitch="AND countryID=1">
		<cfset geoTitle="U.S. ">
	</cfcase>
	<cfcase value="2">
		 <cfset geoSwitch="AND countryID<>1">
		 <cfset geoTitle="Import ">
	</cfcase>
	<cfdefaultcase>
		<cfset geoSwitch="">
		<cfset geoTitle="">
	</cfdefaultcase>
</cfswitch>
<!---genreID=#o1GenreID# //--->
<cfquery name="nrList" maxrows="#o1ListLength#" dbtype="query">
	select *
	from Application.dt304items
	where albumStatusID<=21 #geoSwitch# AND title NOT LIKE '%(Promo)%' AND ((ONHAND>0  AND (albumStatusID<25)) OR ONSIDE>0) AND ONSIDE<>999 AND media NOT LIKE '%CD%' AND mp3Loaded=1
	order by releaseDate DESC, ONHAND DESC
</cfquery>
<cfset genreTitle=nrList.genre&" ">
<table width="320" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td bgcolor="#555555" height="40" valign="middle" style="font-size:14px"><cfoutput>&nbsp;&nbsp;#UCase(geoTitle)# LATEST ARRIVALS<!---<img src="images/homepageHeader#o1GeoFlag#.jpg" width="300" height="40" alt="#geoTitle#<!---#genreTitle#//---> - Latest Arrivals" /><!---<p class="style1 style2">#geoTitle##genreTitle# - Latest Arrivals</p>//--->//---></cfoutput></td>
  </tr>
  <tr>
    <td bgcolor="#333333">
        <table border=0 align="left" cellpadding=4 cellspacing=0>
        <cfset itemLogoFile="">
  <cfoutput query="nrList">
  <cfquery name="firstTrack" dbtype="query" maxrows="1">
			select *
			from Application.allTracks
			where catID=#ID#
			order by tSort
		</cfquery>
		<cfif firstTrack.recordCount NEQ 0>
			<cfset thisTrackID=firstTrack.ID>
			<cfset thisMP3=firstTrack.mp3Loaded>
		<cfelse>
			<cfset thisTrackID=0>
			<cfset thisMP3=false>
		</cfif>
	<cfif fullImg NEQ "">
		<cfset imagefile="items/oI#ID#full.jpg">
    <cfelseif jpgLoaded>
    	<cfset imagefile="items/oI#ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	<!---<cfset charCount=0>
	<cfif Len(artist) GT 20><cfset charCount=charCount+20><cfelse><cfset charCount=charCount+Len(artist)></cfif>
	<cfif Len(title) GT 20><cfset charCount=charCount+30><cfelse><cfset charCount=charCount+Len(title)></cfif>
	//--->
<!---    <td width="25" bgcolor="##333333"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="images/#imageFile#" width="25" height="25" border="0" alt="#title#" /></a></td>
    <td bgcolor="##333333" class="boxList_td">#Left(artist,20)#<cfif Len(artist) GT 25>...</cfif> <a href="opussitelayout07main.cfm?sID=#ID#" title="#title#">#left(title,20)#<cfif Len(title) GT 25>...</cfif></a> <font style="color:##999999; font-size: 8px;">(#Left(media,3)#) #Left(label,10)#<cfif Len(label) GT 10>...</cfif></font></td>//--->
    <tr>
		 <td align="left" valign="middle" style="line-height: 100%;" width="10">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images/spacer.gif" width="25" height="1" /></td>
				<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
				<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks" width="30" rowspan="2"><table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;" align="left">
			<tr><td><img src="images/#imagefile#" width="25" height="25" border="0" alt=""></td></tr></table></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##000" width="12" height="12"><div align="center" class="style1"><a href="opussitelayout07player.cfm?oClip=#thisTrackID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##000" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#thisTrackID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
		  </tr>
		</table>
			</td>
	   <td align="left" bgcolor="##333333"><b><a href="opussitelayout07main.cfm?af=#artistID#&group=all" title="See all releases by #artist#">#Left(artist,40)#</a></b><br /><a href="opussitelayout07main.cfm?sID=#ID#" target="opusviewmain" title="See all details about this release">#Left(title,40)#</a></td>
     </tr>
  </cfoutput>
  </table>
  </td></tr></table>









