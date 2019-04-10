<cfquery name="sales" datasource="#DSN#">
	select dateShipped, artist, qtyOrdered, title, price, label, catnum, shelfCode, orderID, shelfCode, custUsername, priceOverride
	from orderItemsQuery
	where adminAvailID=6  AND title LIKE '%shirt%'
	order by dateShipped
</cfquery>
<table>
<cfoutput query="sales">
<tr><td>#dateShipped#</td><td>#artist#</td><td>#title#</td><td>#price#</td><td>#qtyOrdered#</td></tr>
</cfoutput>
</table>