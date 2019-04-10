<cfquery name="salesTax" datasource="#DSN#">
	select orderTax, orderTotal, dateShipped
	from orders
	where orderTax>0 AND statusID=6
	order by dateShipped
</cfquery>
<cfset taxTotal=0>
<table>
<cfoutput query="salesTax">
<tr><td>#DateFormat(dateShipped,"mm/dd/yyyy")#</td><td>#DollarFormat(orderTotal)#</td><td>#DollarFormat(orderTax)#</td></tr>
<cfset taxTotal=taxTotal+orderTax>
</cfoutput>
</table>
<cfoutput>#DollarFormat(taxTotal)#</cfoutput>