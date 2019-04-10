<cfquery name="get99s" datasource="#DSN#">
	select orderItemID
	from orderItemsQuery where dateShipped='2012-09-20' AND price=.99
</cfquery>

<cfoutput query="get99s">#orderItemID#,</cfoutput>