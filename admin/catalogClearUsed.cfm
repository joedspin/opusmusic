<cfquery name="killUsed" datasource="#DSN#">
	update catItems
	set albumStatusID=44
	where albumStatusID=20 OR CONDITION_MEDIA_ID>2 OR (shelfID<7 AND shelfID<>3)
</cfquery>