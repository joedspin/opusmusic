<cfquery name="fixBS" datasource="#DSN#">
	update catItems
	set price=2.99
	where price<2.99 AND shelfID=29 AND albumStatusID<25 AND ONHAND>0
</cfquery>