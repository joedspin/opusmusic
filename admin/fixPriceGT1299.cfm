<cfquery name="fix13dollarrecords" datasource="#DSN#">
	update catItems
    set price=12.99 where price>12.99 AND price<13.99 AND albumStatusID<25 AND ONHAND>1 AND cost <12.00
</cfquery>