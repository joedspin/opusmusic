<cfparam name="url.vendorID" default="0">
<cfparam name="url.orderID" default="0">
<cfif url.vendorID NEQ "0" AND url.orderID NEQ "0">
<cfquery name="getVendorInventory" datasource="#DSN#">
	select ID, ONHAND
    from catItemsQuery
    where (shelfID=#url.vendorID# OR ID IN (select DISTINCT catItemID from catRcvd where rcvdShelfID=#vendorID#)) AND ONHAND>0
</cfquery>
<cfloop query="getVendorInventory">
    <cfquery name="inven" datasource="#DSN#">
        insert into orderItems (catItemID,qtyOrdered,orderID)
            values (#getVendorInventory.ID#,#getVendorInventory.ONHAND#,#url.orderID#)
    </cfquery>
</cfloop>
</cfif>
<cflocation url="orders.cfm">