<cfquery name="fixNR" datasource="#DSN#">
	update catItems
    set albumStatusID=24 
    where albumStatusID<22 AND releaseDate<'2010-07-19'
</cfquery>