<cfquery name="fix12dollarrecords" datasource="#DSN#">
	update catItems
    set price=11.99 where price>11.99 AND price<12.49 AND albumStatusID<25 AND ONHAND>1 AND cost <11.00
</cfquery>