<cfquery name="killItems" datasource="#DSN#">
	delete *
	from orderItems
	where orderID >250 AND orderID < 263
</cfquery>
<cfquery name="killOrders" datasource="#DSN#">
	delete *
	from orders
	where ID >250 AND ID < 263
</cfquery>