<cfquery name="saleUpdateDates" datasource="#DSN#">
	update catItems
    set dtDateUpdated='2009-12-18'
    where price<>0 AND price<cost OR price=cost and shelfID NOT IN (7,11,13) AND albumStatusID<25 AND ONHAND>0
</cfquery>