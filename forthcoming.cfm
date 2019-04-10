<cfparam name="url.sID" default="0">
<cfif url.sID NEQ 0>
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where ID IN (<cfqueryparam value="#url.sID#" cfsqltype="cf_sql_char">)
	</cfquery>
<cfelse>
<cfquery name="forthcoming" datasource="#DSN#">
		select *
		from catItemsQuery
		where ONHAND=0 AND ONSIDE=0 AND ((albumStatusID>27  AND left(shelfCode,1)<>'D' AND ID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived)) OR (albumStatusID=148 AND (mp3Loaded=1 OR fullImg<>''))) AND
			dtDateUpdated>'#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#' 
		order by dtDateUpdated DESC 
	</cfquery>
</cfif>
    <style>
	tr {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif;}
	.artist {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; font-weight:bold; margin-top: 0px; margin-bottom: 0px;}
	.title {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; margin-top: 0px; margin-bottom: 6px;}
	.label {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px; margin-top: 6px; margin-bottom: 12px;}
	.tracks {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 10px; line-height:120%; margin-top: 0px; margin-bottom: 0px;}
	</style>
<cfoutput query="forthcoming">
<table border="0" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
	<tr>
    	<td valign="top"><cfif fullImg NEQ ""><cfset imagefile="items/oI#ID#full.jpg"><cfset imagesize="300">
        <cfelseif jpgLoaded>
		<cfset imagefile="items/oI#ID#.jpg"><cfset imagesize="75">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile><cfset imagesize="75">
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif"><cfset imagesize="75">
	</cfif><img src="http://www.downtown304.com/images/#imagefile#" alt="#artist# - #title#" width="#imagesize#" height="#imagesize#"></td>
    <td valign="top">
    	<p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 24px; font-weight:bold; margin-top: 0px; margin-bottom: 0px;">#artist#</p>
    	<p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 24px; margin-top: 0px; margin-bottom: 6px;">#title#</p>
        <p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; margin-top: 6px; margin-bottom: 18px;"><b>Label:</b> #label#<br>
        	<b>Catalog ##:</b> #catnum#<br>
            <b>Media:</b> <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br>
            <b>Style:</b> #genre#<br>
            <b>Price:</b> #DollarFormat(buy)#</p>
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#forthcoming.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
    	<p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; line-height:120%; margin-top: 0px; margin-bottom: 0px;"><cfif tracks.mp3Loaded OR mp3Alt NEQ 0><a href="http://www.downtown304.com/media/oT#tracks.ID#.mp3" title="Play">LISTEN</a></cfif> #tName#</p>
	  </cfloop></td></tr>
</table>
<hr noshade>
</cfoutput>