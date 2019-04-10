<cfquery name="fixfuckup" datasource="#DSN#">
	update catItems
    set ONHAND=ONHAND+1
    where ID IN (select catItemID from orderItemsQuery where orderID=57931)
</cfquery>