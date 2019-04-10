<cfquery name="MINOrders" datasource="#DSN#">
	select Min(DateUpdated) As minDate
	from orders
</cfquery>
<cfquery name="countOrders" datasource="#DSN#" maxrows="20">
	select *
	from orders
	order by ID DESC
</cfquery>
<cfoutput query="countOrders">updated #dateUpdated# started #dateStarted#<br></cfoutput>
<cfquery name="updateOrders" datasource="#DSN#">
	update orders
	set dateUpdated=dateStarted
	where dateUpdated< <cfqueryparam value="#MINOrders.minDate#" cfsqltype="cf_sql_date">
</cfquery>