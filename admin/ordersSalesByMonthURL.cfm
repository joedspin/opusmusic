<cfparam name="url.mo" default="0">
<cfparam name="url.yr" default="0">
<cfif url.mo EQ 0 OR url.yr EQ 0>Provide mo (2 digits) and yr (4 digits) in URL<cfabort></cfif>
<cfquery name="sales" datasource="#DSN#">
	select dateShipped, artist, qtyOrdered, title, price, label, catnum, shelfCode, orderID, shelfCode, custUsername, priceOverride, isStore, cost
	from orderItemsQuery
	where adminAvailID=6 AND DatePart(m,dateShipped)=#url.mo# AND DatePart(yyyy,dateShipped)=#url.yr# AND custID<>2126 AND custID<>4318 AND ignoreSales=0
	order by dateShipped
</cfquery>
<cfset salesTotal=0>
<cfset itemCount=0>
<cfset dtSales=0>
<cfset dtQty=0>
<cfset importSales=0>
<cfset importQty=0>
<cfset distroSales=0>
<cfset distroQty=0>
<table>
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
<cfif isStore>
	<cfif priceOverride NEQ 0><cfset distroSales=distroSales+(qtyOrdered*priceOverride)><cfelse><cfset distroSales=distroSales+(qtyOrdered*price)></cfif>
    <cfset distroQty=distroQty+qtyOrdered>
</cfif>
<tr>
	<td>#qtyOrdered#</td>
	<td>#Left(artist,20)#</td>
    <td>#Left(title,15)#</td>
    <td>#label#</td>
    <td>#catnum#</td>
    <td>#shelfCode#</td>
    <td>#dateFormat(dateShipped,"mm/dd/yy")#</td>
    <td>#DollarFormat(cost)#</td>
    <td>#DollarFormat(price)#</td>
    <td>#orderID#</td>
</tr>
</cfoutput>
</table>
<cfoutput>
<p>#url.mo#/#url.yr#<br />
<b>#DollarFormat(salesTotal)#</b> [#itemCount# Units]<br />
Downtown 161: #DollarFormat(dtSales)# [#dtQty# Units]<br />
Other Vendors: #DollarFormat(importSales)# [#importQty# Units]<br>
Distribution Sales: #DollarFormat(distroSales)# [#distroQty# Units]<br>
Web Site Sales: #DollarFormat(salesTotal-distroSales)# [#itemCount-distroQty# Units]</p>
<cfif url.mo EQ "12"><cfset nextmo=1><cfset nextyr=url.yr+1><cfelse><cfset nextmo=url.mo+1><cfset nextyr=url.yr></cfif>
<p><a href="ordersSalesByMonthURL.cfm?mo=#nextmo#&yr=#nextyr#">Next Month</a></p>
</cfoutput>