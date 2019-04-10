<cfsetting requesttimeout="60000">
<cfquery name="catTracks" datasource="#DSN#">
	select DISTINCT catID
	from catTracks
	where mp3Loaded=1 AND ID>30000
</cfquery>
<cfloop query="catTracks">
	<cfquery name="catItems" datasource="#DSN#">
		update catItems
		set mp3Loaded=1
		where ID=#catTracks.catID#
	</cfquery>
</cfloop>