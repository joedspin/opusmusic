<cfquery name="fixbaduser" datasource="#DSN#">
	update catItems
    set albumStatusID=23, dtDateUpdated='2013-08-22'
    where ID IN (select catItemID from orderItemsQuery where orderID IN (43070,48133,48145,48160))
    AND albumStatusID=27 AND ONHAND>1
</cfquery>