<cfquery name="fixOrder" datasource="#DSN#">
	update orders
	set shipAddressID=184, billingAddressID=183
	where ID=311
</cfquery>