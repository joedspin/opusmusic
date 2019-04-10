<cfquery name="fixAmenti" datasource="#DSN#">
	update catItems
    set price=4.99, cost=2, wholesalePrice=3.99, dtDateUpdated='2015-03-02', albumStatusID=23
    where labelID=531 AND albumStatusID<25 AND ONHAND>0
</cfquery>