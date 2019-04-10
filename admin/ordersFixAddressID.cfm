<cfquery name="fixAddress" datasource="#DSN#">
	update orders
	set billingAddressID=1414
	where ID=1476
</cfquery>