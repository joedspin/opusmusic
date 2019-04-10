<cfquery name="deleteBadOrderItems" datasource="#DSN#">
	delete *
	from orderItems
	where ID IN (2406,2879,2810,2537,2651,3073,2182,2534)
</cfquery>