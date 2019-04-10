<cfquery name="findOrder" datasource="#DSN#">
	select *
	from orders
	where orderTotal=139.76
</cfquery>
<cfoutput query="findOrder">#ID#</cfoutput>