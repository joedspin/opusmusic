<cfquery name="rsdBackIn" datasource="#DSN#">
	update catItems
    set dtDateUpdated='2015-04-17'
    where title LIKE '%Record Store Day%' OR title LIKE '%RSD%' AND albumStatusID<25 AND ONHAND>0
</cfquery>