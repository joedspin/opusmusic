<cfquery name="fix80s" datasource="#DSN#">
	update catItems
    set genreID=31
    where labelID=2239
</cfquery>