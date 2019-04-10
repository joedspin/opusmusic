<cfquery name="origOrderItems" datasource="#DSN#">
	select *
	from orderItems
	where orderID=#url.ID#
</cfquery>
<cfoutput query="origOrderItems">
#ID# #qtyOrdered#<br />
</cfoutput>