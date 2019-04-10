<table border="0" cellspacing="0" cellpadding="0"><tr><td><img src="images/spacer.gif" height="10" width="10" /></td></tr></table>
<cfquery name="staffList" datasource="#DSN#" maxrows="1">
	select *
	from artistListsQuery
	where artistID=15387 AND active=1
	order by listDate DESC 
</cfquery>
<cfquery name="staffListItems" datasource="#DSN#">
	select *
	from (artistListsItemsQuery LEFT JOIN catTracks ON catTracks.ID=artistListsItemsQuery.trackID)
	where artistListsItemsQuery.listID=#staffList.ID# AND (artistListsItemsQuery.ONHAND>0 OR artistListsItemsQuery.ONSIDE>0 OR artistListsItemsQuery.trackONHAND>0 OR artistListsItemsQuery.trackONSIDE>0)
	order by artistListsItemsQuery.sort
</cfquery>
<table width="320" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="40" bgcolor="#555555" style="padding:10px; font-size:18px;">STAFF PICKS</td>
  </tr>
  <tr>
    <td bgcolor="#333333">
<table border=0 align="left" cellpadding=4 cellspacing=0>
<cfset listCt=0>
<cfoutput query="staffListItems">
	<cfset listCt=listCt+1>
	<tr>
	  <cfif trackID NEQ 0>
	   	<cfset thisID=trackItemID>
		<cfset thisArtist=trackArtist>
		<cfset thisTitle=tName>
		<cfset thisLabel=trackLabel>
		<cfset thisTrackID=trackID>
		<cfset thisArtistID=trackArtistID>
		<cfset thisMP3=mp3Loaded>
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
		<cfset thisMP3=firstTrack.mp3Loaded>
	</cfif>
	<cfif fullImg NEQ "">
		<cfset imagefile="items/oI#itemID#full.jpg">
    <cfelseif jpgLoaded EQ 1>
    	<cfset imagefile="items/oI#itemID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	<td align="left" valign="middle" style="line-height: 100%;" width="10">
		<cfif thisMP3 EQ 1>	
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
			<cfelse>&nbsp;</cfif></td>
	   <td align="left" bgcolor="##333333"><b><a href="opussitelayout07main.cfm?af=#thisArtistID#&group=all" title="See all releases by #thisArtist#">#Left(thisArtist,40)#</a></b><br /><a href="opussitelayout07main.cfm?sID=#thisID#" target="opusviewmain" title="See all details about this release">#Left(thisTitle,40)#</a></td>
     </tr>
</cfoutput>
</table>
       </td>
  </tr>
</table>