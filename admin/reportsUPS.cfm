<cfparam name="url.mo" default="0">
<cfparam name="url.yr" default="0">
<cfif url.mo EQ 0 OR url.yr EQ 0>Provide mo and yr (4 digit) in URL<cfabort></cfif>
<cfquery name="sales" datasource="#DSN#">
	select dateShipped, orders.ID As orderID, orderShipping, shippingRates.name As shipName
	from orders LEFT JOIN shippingRates ON orders.shipID=shippingRates.ID
	where statusID=6 AND DatePart('m',dateShipped)=#url.mo# AND DatePart('yyyy',dateShipped)=#url.yr# AND (shipID=57 OR shipID=62 OR shipID=63) AND isGEMM=false
	order by dateShipped
</cfquery>
<table border=1 cellpadding=5 style="border-collapse:collapse;">
<cfset shipTotal=0>
<cfoutput query="sales">
	<tr style="font-family:Arial, Helvetica, sans-serif; font-size:x-small;">
    	<td>#orderID#</td>
        <td>#DateFormat(dateShipped,"mm/dd/yyyy")#</td>
        <td>#shipName#</td>
        <td align="right">#DollarFormat(orderShipping)#</td>
    </tr>
    <cfset shipTotal=shipTotal+orderShipping>
</cfoutput>
<tr style="font-family:Arial, Helvetica, sans-serif; font-size:x-small;">
	<td colspan="3">&nbsp;</td>
	<cfoutput><td align="right"><b>#DollarFormat(shipTotal)#</b></td></cfoutput>
</tr>
</table>