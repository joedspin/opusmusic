<cfquery name="killTracks" datasource="#DSN#">
	delete *
	from catTracks
</cfquery>
<cfquery name="killItems" datasource="#DSN#">
	delete *
	from catItems
</cfquery>