<cfquery name="killit" datasource="#DSN#">
	delete *
	from orderItems
	where orderID=2801 AND price=<cfqueryparam value="0.00" cfsqltype="cf_sql_money">
</cfquery>