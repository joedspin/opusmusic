<cfsetting requesttimeout="100000" enablecfoutputonly="no">
<cfquery name="deadItems" datasource="#DSN#" maxrows="100">
	select *
    from catItemsQuery
    where mp3Loaded=1 AND mp3Deleted=0 AND (((albumStatusID=44) OR (shelfID<>11 AND ONHAND<1) AND ID NOT IN (select catItemID from purchaseOrderDetailsQuery where completed<>1 AND qtyRequested>qtyReceived)))
    order by dtDateUpdated
</cfquery>
<p><a href="cleanOldMP3s.cfm">Do the next 100 items</a></p>
<cfoutput query="deadItems">
<cfset itemID=ID>
<cfset thisCatnum=Replace(Replace(Replace(catnum,":","_","all"),"/","_","all"),"\","_","all")>
#catnum# #label# #artist# #title# #NRECSINSET#x#media#
<cfquery name="tracks" datasource="#DSN#">
    select *
    from catTracks
    where catID=#itemID#
</cfquery>
<cfloop query="tracks">
<cfset trID=tracks.ID>
<!---<cfset gotthisone=FileExists("c:\Inetpub\wwwroot\downtown304\media\oT#trID#.mp3")> [#gotthisone#]//--->
	    <cfif FileExists("c:\Inetpub\wwwroot\downtown304\media\oT#trID#.mp3")>
    <!---<cffile action="copy" nameconflict="makeunique"
		source="c:\Inetpub\wwwroot\downtown304\media\oT#trID#.mp3"
		destination="c:\Inetpub\wwwroot\downtown304\mpold\#thisCatnum#_#tSort#.mp3">//--->
     <cffile action="delete" file="c:\Inetpub\wwwroot\downtown304\media\oT#trID#.mp3">
    </cfif>
</cfloop><br>
<cfquery name="updateTrack" datasource="#DSN#">
    update catTracks
    set mp3Loaded=0
    where catID=#itemID#
</cfquery>
<cfquery name="updateItem" datasource="#DSN#">
    update catItems
    set mp3Loaded=0, mp3Deleted=1
    where ID=#itemID#
</cfquery>
</cfoutput>