<cfquery name="completedOrders" datasource="#DSN#">
	select * from orders where statusID=6
</cfquery>
<cfloop query="completedOrders">
	<cfquery name="fixOrderedItems" datasource="#DSN#">
		update orderItems
		set qtyAvailable=qtyOrdered, shipped=yes
		where orderID=#completedOrders.ID#
	</cfquery>
</cfloop>