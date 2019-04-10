<cfquery name="killOrders" datasource="#DSN#">
	delete *
	from orderItems
	where orderID=23 OR (orderID>26 AND orderID<30) OR orderID=33
</cfquery>
<cfquery name="killOrders" datasource="#DSN#">
	delete *
	from orders
	where ID=23 OR (ID>26 AND ID<30) OR ID=33
</cfquery>