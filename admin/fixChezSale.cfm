<cfquery name="chez" datasource="#DSN#">
	update catItems
    set price=3.99, cost=2, wholesalePrice=3.99, priceSave=8.99
    where labelID=1849 AND ONHAND>0 AND albumStatusID<25
</cfquery>