<cfquery name="falloutsale" datasource="#DSN#">
	update catItems
    set price=.99, cost=.49, wholesalePrice=0.99
    where labelID=72 AND ONHAND>0 AND albumStatusID<25
</cfquery>