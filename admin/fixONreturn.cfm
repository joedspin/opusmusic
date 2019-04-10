<cfquery name="fixONreturn" datasource="#DSN#">
	update orderItems
    set qtyOrdered=qtyOrdered*-1 where orderID=30040
</cfquery>