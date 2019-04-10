<cfquery name="classiqesale" datasource="#DSN#">
	update catItems
    set price=8.99, priceSave=0
    where shelfID IN (1064,2080) AND albumStatusID<25 AND ONHAND>0 AND price=5.99
</cfquery>