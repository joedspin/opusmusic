<cfquery name="shippingIntlHistory" datasource="#DSN#" maxrows="200">
	select *
    from orders LEFT JOIN custAddressesQuery ON orders.shipAddressID=custAddressesQuery.ID
    where countryID<>1 and statusID=6
    order by dateShipped DESC
</cfquery>
<style>
td {font-family:Arial, Helvetica, sans-serif; font-size:xx-small;}
</style>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="shippingIntlHistory">
<tr>
<td>#ID#</td>
<td>#country#</td>
<td>#DateFormat(dateShipped,"yyyy-mm-dd")#</td>
<td align="right">#DollarFormat(orderSub)#</td>
<td align="right">#DollarFormat(orderShipping)#</td>
<td align="right">#DollarFormat(orderTotal)#</td>
</tr>
</cfoutput>
</table>