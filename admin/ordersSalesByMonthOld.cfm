<cfset highMark=0>
<cfset highX=0>
<cfset highY=0>
<style>body {font-family: Arial, Helvetica, sans-serif;}
</style>
<cfquery name="orderItemsReport" cachedwithin="#CreateTimeSpan(0,2,0,0)#" datasource="#DSN#">
	select qtyOrdered, price, price*qtyOrdered As rowPrice, priceOverride*qtyOrdered As rowPriceOverride, cost*qtyOrdered as rowCost, cost, priceOverride, dateShipped, DatePart(m,dateShipped) As shipMonth, DatePart(yyyy,dateShipped) As shipYear, shelfID
    from ordersSalesQuery
    where adminAvailID=6 AND ignoreSales=0
</cfquery>
<cfquery name="shippingReport" cachedwithin="#CreateTimeSpan(0,2,0,0)#" datasource="#DSN#">
	select DatePart(m,dateShipped) As shipMonth, DatePart(yyyy,dateShipped) As shipYear, dateShipped, orderShipping, shippingRates.name As shipName, shippingRates.countryID As shipCountryID
    from ((orders LEFT JOIN custAccounts ON custAccounts.ID=orders.custID) LEFT JOIN shippingRates ON shippingRates.ID=orders.shipID)
    where statusID=6 AND ignoreSales=0
</cfquery>
<cfquery name="receivedReport" datasource="#DSN#">
            select qtyRcvd, qtyRcvd*cost As rowCost, shelfID, DatePart(m,dateReceived) As rcvdMonth, DatePart(yyyy,dateReceived) As rcvdYear
            from (catRcvd Left JOIN catItemsQuery ON catItemsQuery.ID=catRcvd.catItemID)  
            where rcvdShelfID<>7
        </cfquery>
<cfset lastMonthTotal=0>
<cfset lastMonthGrand=0>
<cfset diffPercGrand=0>
<cfset diffPerc=0>
<cfset thisYearSearch=DateFormat(varDateODBC,"yyyy")>
<cfset thisMonthSearch=DateFormat(varDateODBC,"m")>
<cfloop from="#thisYearSearch-3#" to="#thisYearSearch#" index="y">
<cfset annualCost=0>
<cfset annualSales=0>
	<cfif y EQ thisYearSearch><cfset monthLimit=thisMonthSearch><cfelse><cfset monthLimit=12></cfif>
<cfloop from="1" to="#monthLimit#" index="x">
<cfquery name="sales"  dbtype="query">
	select Sum(rowPrice) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride=0
</cfquery>
<cfquery name="overrideSales" dbtype="query">
	select Sum(rowPriceOverride) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride<>0
</cfquery>
<cfquery name="received" dbtype="query">
	select Sum(qtyRcvd) As qtySum, Sum(rowCost) as costSum
    from receivedReport
    where rcvdMonth=#x# AND rcvdYear=#y#
</cfquery>
<cfquery name="GTsales"  dbtype="query">
	select Sum(rowPrice) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride=0 AND shelfID IN (1064,2080)
</cfquery>
<cfquery name="GToverrideSales" dbtype="query">
	select Sum(rowPriceOverride) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride<>0 AND shelfID IN (1064,2080)
</cfquery>
<cfquery name="GRsales"  dbtype="query">
	select Sum(rowPrice) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride=0 AND shelfID IN (15,31,32,33,35,2108)
</cfquery>
<cfquery name="GRoverrideSales" dbtype="query">
	select Sum(rowPriceOverride) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride<>0 AND shelfID IN (15,31,32,33,35,2108)
</cfquery>
<cfquery name="GRreceived" dbtype="query">
	select Sum(qtyRcvd) As qtySum, Sum(rowCost) as costSum
    from receivedReport
    where rcvdMonth=#x# AND rcvdYear=#y# AND shelfID IN (15,31,32,33,35,2108)
</cfquery>
<cfquery name="WSsales"  dbtype="query">
	select Sum(rowPrice) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride=0 AND shelfID IN (2127,2131,2136)
</cfquery>
<cfquery name="WSoverrideSales" dbtype="query">
	select Sum(rowPriceOverride) As priceSum, Sum(rowCost) As costSum, Sum(qtyOrdered) As qtySum
	from orderItemsReport
	where shipMonth=#x# AND shipYear=#y# AND priceOverride<>0 AND shelfID IN (2127,2131,2136)
</cfquery>
<cfquery name="shipping" dbtype="query">
	select Sum(orderShipping) As orderShippingSum
    from shippingReport
    where shipMonth=#x# AND shipYear=#y#
</cfquery>
<cfquery name="PostalShipping" dbtype="query">
	select Sum(orderShipping) As orderShippingSum
    from shippingReport
    where shipMonth=#x# AND shipYear=#y# AND shipName LIKE '%Mail%'
</cfquery>
<cfquery name="PostalExport" dbtype="query">
	select Sum(orderShipping) As orderShippingSum
    from shippingReport
    where shipMonth=#x# AND shipYear=#y# AND shipName LIKE '%Mail%' AND shipCountryID<>1
</cfquery>
<cfquery name="UPSAll" dbtype="query">
	select Sum(orderShipping) As orderShippingSum
    from shippingReport
    where shipMonth=#x# AND shipYear=#y# AND shipName LIKE '%UPS%' AND shipCountryID=1
</cfquery>
<cfquery name="UPSExport" dbtype="query">
	select Sum(orderShipping) As orderShippingSum
    from shippingReport
    where shipMonth=#x# AND shipYear=#y# AND shipName LIKE '%UPS%' AND shipCountryID<>1
</cfquery>
<cfset mShipping=Val(shipping.orderShippingSum)>
<cfset postalShipping=Val(PostalShipping.orderShippingSum)>
<cfset UPSShipping=Val(UPSAll.orderShippingSum)>
<cfset UPSExport=Val(UPSExport.orderShippingSum)>
<cfset postalExport=Val(PostalExport.orderShippingSum)>
<!---<cfset mShipping=0>
<cfset postalShipping=0>
<cfset UPSShipping=0>
<cfset UPSExport=0>
<cfset postalExport=0>
<cfloop query="shipping">
	<cfset mShipping=mShipping+OrderShipping>
    <cfif shipID EQ 62 OR shipID EQ 63 OR shipID EQ 57>
    	<cfif countryID NEQ 1><cfset UPSExport=UPSExport+OrderShipping></cfif>
    	<cfset UPSShipping=UPSShipping+OrderShipping>
    <cfelse>
    	<cfset postalShipping=PostalShipping+OrderShipping>
        <cfif countryID NEQ 1><cfset PostalExport=PostalExport+OrderShipping></cfif>
    </cfif>
</cfloop>//--->
<cfset salesTotal=0>
<!---
<cfloop query="sales">
<!---#DateFormat(dateShipped,"yyyy-mm-dd")# #DollarFormat(orderSub)#<br />//--->
<cfif left(custUsername,3) EQ 'vm_' OR left(custUsername,10) EQ 'vinylmania'><cfset salesTotal=salesTotal+(qtyOrdered*(price-1))><cfelseif priceOverride NEQ 0><cfset salesTotal=salesTotal+(qtyOrdered*priceOverride)><cfelse><cfset salesTotal=salesTotal+(qtyOrdered*price)><cfset annualCost=annualCost+(qtyOrdered*cost)></cfif>
</cfloop>//--->
<!---<cfoutput>#sales.recordCount# [#sales.priceSum#] [#sales.costSumDT#]</cfoutput><cfabort>//--->
<cfset quantityTotal=Val(sales.qtySum)+Val(overrideSales.qtySum)>
<cfset salesTotal=Val(sales.priceSum)+Val(overrideSales.priceSum)>
<cfset GTquantityTotal=Val(GTsales.qtySum)+Val(GToverrideSales.qtySum)>
<cfset GTsalesTotal=Val(GTsales.priceSum)+Val(GToverrideSales.priceSum)>
<cfset GRquantityTotal=Val(GRsales.qtySum)+Val(GRoverrideSales.qtySum)>
<cfset GRsalesTotal=Val(GRsales.priceSum)+Val(GRoverrideSales.priceSum)>
<cfset GRreceivedCount=Val(GRreceived.qtySum)>
<cfset GRreceivedCost=Val(GRreceived.costSum)>
<cfset WSquantityTotal=Val(WSsales.qtySum)+Val(WSoverrideSales.qtySum)>
<cfset WSsalesTotal=Val(WSsales.priceSum)+Val(WSoverrideSales.priceSum)>
<cfset annualCost=annualCost+Val(sales.costSum)+Val(overrideSales.costSum)>
<cfset grandTotal=salesTotal+mShipping>
<cfset annualSales=annualSales+grandTotal>
<cfoutput>
<cfif grandTotal GT 0>
<h1 style="margin-top: 24px; margin-bottom: 0px;">#x#/#y#</h1>
<cfif salesTotal GT highMark><cfset highMark=salesTotal><cfset highX=x><cfset highY=y></cfif>
<p style="margin-top: 0px;">Merchandise Income: <b>#DollarFormat(salesTotal)#</b><br />
Items Sold: #quantityTotal#<br>
Merchandise Received (Cost): #DollarFormat(Val(received.costSum))# (#Val(received.qtySum)# Units)<br>
<font size="xx-small">George T: #DollarFormat(GTsalesTotal)# (#GTquantityTotal# Units)<br>
Groove: #DollarFormat(GRsalesTotal)# (#GRquantityTotal# Units) (Received: #DollarFormat(GRreceivedCost)# - #GRreceivedCount#)<br>
Polite: #DollarFormat(WSsalesTotal)# (#WSquantityTotal# Units)</font><br>
Shipping Income: #DollarFormat(mShipping)#<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Post Office: #DollarFormat(postalShipping)# (Export: #DollarFormat(postalExport)#)<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UPS: #DollarFormat(UPSShipping)# (Export: #DollarFormat(UPSExport)#)<br />
Total: <b>#DollarFormat(grandTotal)#</b></br></cfif>
<cfset diffSales=salesTotal-lastMonthTotal>
<cfset diffGrand=grandTotal-lastMonthGrand>
<cfif lastMonthTotal NEQ 0><cfset diffPerc=diffSales/lastMonthTotal*100></cfif>
<cfif lastMonthTotal EQ 0 AND diffSales EQ 0><cfset diffPerc=0></cfif>
<cfif lastMonthGrand NEQ 0><cfset diffPercGrand=diffSales/lastMonthGrand*100></cfif>
<cfif lastMonthGrand EQ 0 AND diffGrand EQ 0><cfset diffPercGrand=0></cfif>
<cfoutput><cfif grandTotal GT 0>Records Only: (#NumberFormat(diffPerc,'0.0')#% change - <cfif diffPerc GT 0>up #DollarFormat(diffSales)#<cfelseif diffPerc LT 0>down  #DollarFormat(diffSales)#<cfelse> no change</cfif>)<br />
Products and Shipping: (#NumberFormat(diffPercGrand,'0.0')#% change - <cfif diffPercGrand GT 0>up #DollarFormat(diffGrand)#<cfelseif diffPercGrand LT 0>down  #DollarFormat(diffGrand)#<cfelse> no change</cfif>)</cfif></p></cfoutput>

<cfset lastMonthTotal=salesTotal>
<cfset lastMonthGrand=grandTotal>
</cfoutput>

</cfloop>
<p><cfoutput>Annual Sales: #DollarFormat(annualSales)#<br>
Annual Cost: #DollarFormat(annualCost)#</cfoutput></p>
</cfloop>
	<cfoutput><p>Highest Annual = #DollarFormat(highMark)# (#highX#/#highY#)</p></cfoutput>