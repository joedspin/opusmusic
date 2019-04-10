<cfquery name="rejiggerBS" datasource="#DSN#">
	update catItems
    set dateUpdated=releaseDate
    where shelfID=29
</cfquery>