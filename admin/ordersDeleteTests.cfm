<cfquery name="alltest" datasource="#DSN#">
	select *
	from orders
	where custID=1
</cfquery>
<cfloop query="alltest">
	<cfoutput>Order no. #ID#, </cfoutput>
	<cfquery name="clearItems" datasource="#DSN#">
		delete *
		from orderItems
		where orderID=#alltest.ID#
	</cfquery>
	Deleted Items
	<cfquery name="deleteThisOrder" datasource="#DSN#">
		delete *
		from orders
		where ID=#alltest.ID#
	</cfquery>
	DELETED ORDER<br />
</cfloop>