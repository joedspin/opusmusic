<cfquery name="invoiced" datasource="#DSN#">
	update orders
	set issueResolved=yes
	where statusID=2 AND ID<>1577 AND ID<>1078
</cfquery>