<cfparam name="url.ID" default="0">
<cfquery name="killOrder" datasource="#DSN#">
	delete
	from orders
	where ID=#url.ID#
</cfquery>
<cfquery name="killItems" datasource="#DSN#">
	delete
	from orderItems
	where orderID=#url.ID#
</cfquery>
<cflocation url="orders.cfm">
