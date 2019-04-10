<cfquery name="sellfix" datasource="#DSN#">
	update catItems
    set price=wholesalePrice+3
    where shelfID=11 and albumStatusID<25 AND ONHAND>0 AND price<wholesalePrice+3
</cfquery>