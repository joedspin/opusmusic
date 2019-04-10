<cfparam name="url.mo" default="0">
<cfparam name="url.yr" default="0">
<cfif url.mo EQ 0 OR url.yr EQ 0>Provide mo and yr (4 digit) in URL<cfabort></cfif>
<cfquery name="sales" datasource="#DSN#">
	select dateShipped, artist, qtyOrdered, title, catItemsQuery.price, catItemsQuery.cost, catItemsQuery.buy, label, catnum, shelfCode, orderID
	from ((orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID=catItemsQuery.ID) LEFT JOIN orders ON orderItems.orderID=orders.ID)
	where adminAvailID=6 AND DatePart(m,dateShipped)=#url.mo# AND DatePart(yyyy,dateShipped)=#url.yr# AND custID<>2126 AND custID<>4318 AND left(shelfCode,1)='D' AND catItemsQuery.cost<catItemsQuery.buy
	order by dateShipped
</cfquery>
<cfset salesTotal=0>
<cfset costTotal=0>
<cfset buyTotal=0>
<cfset itemCount=0>
<cfoutput query="sales">
<cfset itemCount=itemCount+1>
<!---#DateFormat(datePurchased,"yyyy-mm-dd")# #DollarFormat(orderSub)#<br />//--->
<cfset salesTotal=salesTotal+(qtyOrdered*price)>
<cfset costTotal=costTotal+(qtyOrdered*cost)>
<cfset buyTotal=buyTotal+(qtyOrdered*buy)>
#qtyOrdered#&nbsp;
#Left(artist,20)# / #Left(title,15)# [#label#] [#catnum##shelfCode#][#dateFormat(dateShipped,"mm/dd/yy")#][#orderID#]<br>
</cfoutput>
<cfoutput>
<p>#url.mo#/#url.yr#<br />
<b>#DollarFormat(salesTotal)#</b> [#itemCount# Units]<br />
<b>#DollarFormat(costTotal)#</b><br />
<b>#DollarFormat(buyTotal)#</b><br />
<b>Increase: #DollarFormat(buyTotal-costTotal)#</p>
</cfoutput>