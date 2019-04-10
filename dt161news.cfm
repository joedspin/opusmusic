<cfparam name="url.sID" default="0">
<cfparam name="url.classics" default="no">
<cfparam name="url.artistID" default="0">
<cfparam name="url.labelID" default="0">
<cfparam name="url.blue99" default="false">
<cfparam name="url.retail" default="false">
<cfparam name="url.distro" default="false">
<cfparam name="url.details" default="yes">
<cfif url.retail EQ "true">


<cfelseif url.distro EQ "true">
<cfquery name="forthcoming" datasource="#DSN#" maxrows="60">
		select *
		from catItemsQuery
		where distribution=1 AND albumStatusID=21
        order by releaseDate DESC
	</cfquery>
<cfelseif url.classics EQ "george">
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where shelfID IN (2080,1064) AND albumStatusID<25 AND ONHAND>0
        order by label, artist, catnum
	</cfquery>
<cfelseif url.classics EQ "yes">
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where (vendorID IN (6978,5439,2811,5650) OR shelfID IN (40,1066,1059,2080,1064) OR reissue=1) AND albumStatusID<25 AND ONHAND>0
        order by label, artist
	</cfquery>
<cfelseif url.classics EQ "metro">
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where (shelfID IN (2136,2127,2131,1059) OR vendorID=5650) AND ONHAND>0 AND albumStatusID<25
        order by label, artist, catnum
	</cfquery>
<cfelseif url.classics EQ "will">
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where shelfCode='WS' AND albumStatusID<25 AND ONHAND>0
        order by label, artist
	</cfquery>
<cfelseif url.artistID NEQ 0>
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where artistID IN (#url.artistID#) AND albumStatusID<25 AND ONHAND>0
        order by releaseDate DESC
	</cfquery>
<cfelseif url.labelID NEQ 0>
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where labelID IN (#url.labelID#) AND albumStatusID<25 AND ONHAND>0
        order by releaseDate DESC, label, ONHAND DESC, catnum DESC
	</cfquery>
<cfelseif url.sID NEQ 0>
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where ID IN (#url.sID#)
        order by dtDateUpdated DESC, ONHAND DESC
	</cfquery>
<cfelseif url.blue99>
<cfquery name="forthcoming" datasource="#DSN#" maxrows="200">
		select *
		from catItemsQuery AND albumStatusID<25 AND ONHAND>0
		where blue99=1
        order by dtDateUpdated DESC, ONHAND DESC
	</cfquery>
<cfelse>
<cfquery name="forthcoming" dbtype="query">
			select *
			from Application.dt161Items
			where (albumStatusID<22)  AND albumStatusID<25 AND ONHAND>0
			 order by dtDateUpdated DESC, ONHAND DESC
	</cfquery>
</cfif>
<link href='http://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'>
    <style>
	tr {font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; text-transform:uppercase;}
	.artist {font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; font-weight:bold; margin-top: 0px; margin-bottom: 0px; text-transform:uppercase;}
	.title {font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; margin-top: 0px; margin-bottom: 6px;text-transform:uppercase;}
	.label {font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px; margin-top: 6px; margin-bottom: 12px;text-transform:uppercase;}
	.tracks {font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 10px; line-height:120%; margin-top: 0px; margin-bottom: 0px;text-transform:uppercase;}
	</style>
	<cfif url.classics EQ "metro"><p><cfif url.details EQ "yes"><a href="dt161news.cfm?classics=metro&details=no">Hide Details</a><cfelse><a href="dt161news.cfm?classics=metro">Show Details</a></cfif></p></cfif>
<cfif url.details EQ "yes">
<cfoutput query="forthcoming">
<table border="0" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
	<tr>
    	<td valign="top">
		<cfif altImg NEQ ""><cfset altImagefile="items/#altImg#"><cfelse><cfset altImageFile=""></cfif>
			<cfif fullImg NEQ ""><cfset imagefile="items/oI#ID#full.jpg"><cfif url.classics EQ "no"><cfset imagesize="200"><cfelse><cfset imagesize="75"></cfif>
        <cfelseif jpgLoaded>
		<cfset imagefile="items/oI#ID#.jpg"><cfset imagesize="75">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile><cfset imagesize="75">
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif"><cfset imagesize="75">
	</cfif>
			<cfif url.classics EQ "metro"><img src="http://www.downtown304.com/images/#imagefile#" alt="#artist# - #title#" height="#imagesize#" width="#imagesize#"><cfelse><img src="http://www.downtown304.com/images/#imagefile#" alt="#artist# - #title#" height="#imagesize#" width="#imagesize#"></cfif><cfif altImageFile NEQ "" AND NOT url.classics EQ "metro"> <img src="http://www.downtown304.com/images/#altImagefile#" alt="#artist# - #title#" height="#imagesize#" width="#imagesize#"></cfif></td>
    <td valign="top">
		<cfif url.classics EQ "metro"><p style="font-size: 14px;"><b>#artist#</b> #title#</p>
			<p style="font-family:Arial; font-size: 9px;">#label# (#catnum#) <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</p>
			<cfelse>
			<p style="font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 24px; font-weight:bold; margin-top: 0px; margin-bottom: 0px;">#artist#</p>
		<p style="font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 24px; margin-top: 0px; margin-bottom: 6px; line-height:100%;">#title# <cfif Remastered>[Remastered]</cfif> <!---<cfif reissue>[Reissue]</cfif> <cfif warehouseFind>[Warehouse Find]</cfif> //---><cfif vinyl180g>[180g Vinyl]</cfif> <!---<cfif Repress>[Re-press]</cfif> <cfif notched>[Notched]</cfif> //---><cfif limitedEdition>[Limited Edition]</cfif></p>
        <p style="font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 13px; margin-top: 6px; margin-bottom: 16px; line-height: 100%;"><b>Label:</b> #label#<br>
        	<b>Catalog ##:</b> #catnum#<br>
            <b>Media:</b> <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br>
            <b>Style:</b> #genre#<br>
            <b>Price:</b> <cfif url.blue99><font style="text-decoration:line-through;">#DollarFormat(priceSave)#</font> <font color="red">#DollarFormat(price)#</font><cfelse>#DollarFormat(wholesalePrice)#</cfif></p>
				</cfif>
            <cfset releaseID=ID>
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#forthcoming.ID#
		order by tSort
	</cfquery>
				<cfif url.classics EQ "metro"><p style="font-size:12px;"></cfif>
	<cfloop query="tracks">
		<cfif url.classics EQ "metro">#tName#<br><cfelse><p style="font-family:Abel, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px; line-height:120%; margin-top: 0px; margin-bottom: 0px;"><cfif tracks.mp3Loaded OR mp3Alt NEQ 0><!---<a href="http://www.downtown304.com/media/oT#tracks.ID#.mp3" title="Play">//---><a href="http://www.downtown304.com/index.cfm?sID=#releaseID#">LISTEN</a> <a href="http://www.downtown304.com/media/oT#tracks.ID#.mp3" title="MP3" target="dt304play">mp3</a></cfif> #tName#</p></cfif>
			</cfloop><cfif url.classics EQ "metro"></p></cfif></td></tr>
</table>
<hr noshade style="margin-top:0px; margin-bottom:0px; padding-top:0px; padding-bottom:0px;">
</cfoutput>
<cfelse>
	<table>
	<cfoutput query="forthcoming">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		</tr>
	</cfoutput>
	</table>
</cfif>