<cfparam name="url.ID" default="0">
<cfquery name="closeOrder" datasource="#DSN#">
	update orders
	set statusID=7
	where ID=#url.ID#
</cfquery>
<cfquery name="closeItems" datasource="#DSN#">
	update orderItems
	set adminAvailID=2
	where orderID=#url.ID#
</cfquery>
<cflocation url="orders.cfm">