<cfquery name="killTheZeroes" datasource="#DSN#">
	delete
	from orderItems
	where qtyOrdered=0
</cfquery>