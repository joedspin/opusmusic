<cfquery name="specialFix" datasource="#DSN#">
	update orders
	set dateShipped='2018-04-20'
	where ID=81845
</cfquery>