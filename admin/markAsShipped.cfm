<cfquery name="updateOrderStat" datasource="#DSN#">
	update orders
	set statusID=6, dateShipped='2006-11-06'
	where ID=31
</cfquery>