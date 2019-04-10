<cfquery name="clearFeatured" datasource="#DSN#">
	update catItems
    set albumStatusID=24 where albumStatusID=19
</cfquery>