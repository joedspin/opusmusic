<cfquery name="fixShip" datasource="#DSN#">
	update shippingRates
	set costplusrecord=<cfqueryparam value="1.75" cfsqltype="cf_sql_money">
	where ID=7
</cfquery>