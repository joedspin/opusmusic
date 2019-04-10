<cfparam name="url.yr" default="0">
<cfif url.mo EQ 0 OR url.yr EQ 0>Provide yr (4 digit) in URL<cfabort></cfif>
<cfquery name="sales" datasource="#DSN#">
	select dateShipped, artist, qtyOrdered, title, price, label, catnum, shelfCode, orderID, shelfCode, custUsername, priceOverride
	from orderItemsQuery
	where adminAvailID=6 AND DatePart(yyyy,dateShipped)=#url.yr# AND custID<>2126 AND custID<>4318 AND ignoreSales=0
	order by dateShipped
</cfquery>
<cfquery name="shippingQuery" datasource="#DSN#">
	select Sum(orderShipping) As shipTotal
	from orders 
	where statusID=6 AND DatePart(yyyy,dateShipped)=#url.yr# AND custID<>2126 AND custID<>4318
    group by orderShipping
</cfquery>
<cfset salesTotal=0>
<cfset itemCount=0>
<cfset dtSales=0>
<cfset dtQty=0>
<cfset importSales=0>
<cfset importQty=0>
<cfoutput query="sales">
<cfset itemCount=itemCount+qtyOrdered>
<!---#DateFormat(datePurchased,"yyyy-mm-dd")# #DollarFormat(orderSub)#<br />//--->
<cfif left(custUsername,3) EQ 'vm_' OR left(custUsername,10) EQ 'vinylmania'><cfset salesTotal=salesTotal+(qtyOrdered*(price-1))><cfelseif priceOverride NEQ 0><cfset salesTotal=salesTotal+(qtyOrdered*priceOverride)><cfelse><cfset salesTotal=salesTotal+(qtyOrdered*price)></cfif>
<cfif left(shelfCode,1) EQ 'D'>
	<cfif priceOverride NEQ 0><cfset dtSales=dtSales+(qtyOrdered*priceOverride)><cfelse><cfset dtSales=dtSales+(qtyOrdered*price)></cfif>
    <cfset dtQty=dtQty+qtyOrdered>
<cfelse>
	<cfif priceOverride NEQ 0><cfset importSales=importSales+(qtyOrdered*priceOverride)><cfelse><cfset importSales=importSales+(qtyOrdered*price)></cfif>
    <cfset importQty=importQty+qtyOrdered>
</cfif>
#qtyOrdered#&nbsp;
#Left(artist,20)# / #Left(title,15)# [#label#] [#catnum##shelfCode#][#dateFormat(dateShipped,"mm/dd/yy")#][#orderID#]<br>
</cfoutput>
<cfoutput>
<p>#url.yr#<br />
<b>#DollarFormat(salesTotal)#</b> [#itemCount# Units]<br />
Downtown 161: #DollarFormat(dtSales)# [#dtQty# Units]<br />
Other Vendors: #DollarFormat(importSales)# [#importQty# Units]<br />
Shipping: #DollarFormat(shippingQuery.shipTotal)#</p>

</cfoutput>