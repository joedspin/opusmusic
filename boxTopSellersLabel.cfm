<!---<cfquery name="topSellers" datasource="#DSN#" maxrows="12">
	SELECT DISTINCT orderItems.catItemID, Sum(orderItems.qtyOrdered) AS SumOfQuantity, catItemsQuery.catnum, catItemsQuery.label, catItemsQuery.artistID, catItemsQuery.artist, catItemsQuery.title, catItemsQuery.price, catItemsQuery.logofile, catItems.jpgLoaded
	FROM (((orderItems LEFT JOIN orders ON orderItems.orderID=orders.ID) LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID) LEFT JOIN catItems ON catItems.ID=catItemsQuery.ID)
	where ((catItemsQuery.ONHAND>0 and catItemsQuery.albumStatusID<25)or catItemsQuery.ONSIDE>0) AND orderItems.adminAvailID=6  AND orders.custID<>445 AND catItemsQuery.mp3Loaded=1 AND catItemsQuery.labelID=<cfqueryparam value="#url.lf#" cfsqltype="cf_sql_integer">
	GROUP BY orderItems.catItemID, catItemsQuery.catnum, catItemsQuery.catnum, catItemsQuery.label, catItemsQuery.artistID, catItemsQuery.artist, catItemsQuery.title, catItemsQuery.price, catItemsQuery.logofile, catItems.jpgLoaded
	ORDER BY Sum(orderItems.qtyOrdered) DESC
</cfquery>
<cfif topSellers.recordCount GT 5>
<table border="0" cellspacing="0" cellpadding="0"><tr><td><img src="images/spacer.gif" height="10" width="10" /></td></tr></table><!---AND DateDiff(day,orders.dateUpdated,#varDateODBC#)<90//--->
<table width="640" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td bgcolor="#CD9933" align="left"><img src="images/boxHead_TopSellers.jpg" width="320" height="48" /></td>
  </tr>
  <tr>
    <td bgcolor="#333333" width="640">
        <table border="0" align="left" cellpadding="4" cellspacing="0" width="640">
<cfset listCt=0>
<cfset colflipflop="left">
<cfoutput query="topSellers">
	<cfif jpgLoaded>
		<cfset imagefile="items/oI#topSellers.catItemID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	<cfset listCt=listCt+1>
	<cfif colflipflop EQ "left"><tr></cfif>
	  <cfquery name="firstTrack" datasource="#DSN#" maxrows="1">
			select *
			from catTracks
			where catID=#catItemID#
			order by tSort
		</cfquery>
		<cfif firstTrack.recordCount NEQ 0>
			<cfset thisTrackID=firstTrack.ID>
			<cfset thisMP3=firstTrack.mp3Loaded>
		<cfelse>
			<cfset thisTrackID=0>
			<cfset thisMP3=false>
		</cfif>
	<td align="left" valign="middle" style="line-height: 100%;" width="10">
		<cfif thisMP3>	
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
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="opussitelayout07player.cfm?oClip=#thisTrackID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#thisTrackID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
		  </tr>
		</table>
			<cfelse>&nbsp;</cfif></td>
	   <td align="left" bgcolor="##333333"><b><a href="opussitelayout07main.cfm?af=#artistID#&group=all" title="See all releases by #artist#">#Left(artist,40)#</a></b><br /><a href="opussitelayout07main.cfm?sID=#catItemID#" target="opusviewmain" title="See all details about this release">#Left(title,40)#</a></td>
     <cfif colflipflop EQ "right"></tr><cfset colflipflop="left"><cfelse><cfset colflipflop="right"></cfif>
</cfoutput>
<cfif colflipflop EQ "right"><td><img src="images/spacer.gif" width="1" height="1" /></td></tr></cfif>
</table>
       </td>
  </tr>
</table>
</cfif>
//--->