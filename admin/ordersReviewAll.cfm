<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where statusID>1
	order by ID
</cfquery>

<cfoutput query="thisOrder">
#ID# #DollarFormat(orderSub)#, #DollarFormat(orderShipping)#, #DollarFormat(orderTax)#, #DollarFormat(orderTotal)#<br />
</cfoutput>