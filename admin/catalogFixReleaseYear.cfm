<cfquery name="fixReleaseYear" datasource="#DSN#">
	update catItems
	set releaseYear='2006' where releaseYear='6/28/1905'
</cfquery>