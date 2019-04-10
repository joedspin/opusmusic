<cfquery name="makePrerelease" datasource="#DSN#">
	update catItems
    set albumStatusID=148
    where ONHAND=0 AND albumStatusID=44 AND (shelfID=11 OR shelfID IN (select ID from shelf where isVendor=1)) AND ID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived)
</cfquery>