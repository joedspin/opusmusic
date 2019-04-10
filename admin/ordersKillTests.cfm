<cfquery name="testOrderItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where custID=1 OR custID=21 OR custID=22 OR custID=113 OR custID=114
</cfquery>
<cfquery name="killBogusAccounts" datasource="#DSN#">
	delete *
	from custAccounts
	where ID=106
</cfquery>
<cfloop query="testOrderItems">
	<cfquery name="killTestOrderItems" datasource="#DSN#">
		delete *
		from orderItems
		where ID=#testOrderItems.ID#
	</cfquery>
</cfloop>
<cfquery name="killTestOrders" datasource="#DSN#">
	delete *
	from orders
	where custID=1 OR custID=21 OR custID=22 OR custID=113 OR custID=114
</cfquery>