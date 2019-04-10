<cfquery name="killCatItems" datasource="#DSN#">
	delete *
	from catItems
</cfquery>