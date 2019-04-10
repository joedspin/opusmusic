<cfquery name="updateItems" datasource="#DSN#">
	update catItems
	set mp3Loaded=No where mp3Loaded Is Null
</cfquery>
<cfquery name="updateTracks" datasource="#DSN#">
	update catTracks
	set mp3Loaded=No where mp3Loaded Is Null
</cfquery>
<cfquery name="updateItems" datasource="#DSN#">
	update catItems
	set jpgLoaded=No where jpgLoaded Is Null
</cfquery>
<cfquery name="updateLabels" datasource="#DSN#">
	update labels
	set jpgLoaded=No where jpgLoaded Is Null
</cfquery>