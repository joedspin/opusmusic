<cfparam name="url.paymentTypeID" default="7"><!--- default payment type= PayPal (7)//--->
<style>body {font-family: Arial, Helvetica, sans-serif;}
</style>
<cfset lastMonthTotal=0>
<cfset lastMonthGrand=0>
<cfset diffPerc=0>
<cfloop from="2006" to="2009" index="y">
<cfloop from="1" to="12" index="x">
<cfquery name="sales" datasource="#DSN#">
	select *
	from ordersSalesQuery
	where adminAvailID=6 AND DatePart(m,dateShipped)=#x# AND DatePart(yyyy,dateShipped)=#y# AND custID<>2126 AND custID<>4318  AND ignoreSales=0 AND paymentTypeID=#url.paymentTypeID#
	order by dateShipped
</cfquery>
<cfquery name="shipping" datasource="#DSN#">
	select *
    from (orders LEFT JOIN custAccounts ON orders.custID=custAccounts.ID)
    where statusID=6 AND DatePart(m,dateShipped)=#x# AND DatePart(yyyy,dateShipped)=#y# AND custID<>2126 AND custID<>4318 AND ignoreSales=0 AND paymentTypeID=#url.paymentTypeID#
</cfquery>
<cfset mShipping=0>
<cfset postalShipping=0>
<cfset UPSShipping=0>
<cfloop query="shipping">
	<cfset mShipping=mShipping+OrderShipping>
    <cfif shipID EQ 62 OR shipID EQ 63 OR shipID EQ 57>
    	<cfset UPSShipping=UPSShipping+OrderShipping>
    <cfelse>
    	<cfset postalShipping=PostalShipping+OrderShipping>
    </cfif>
</cfloop>
<cfset salesTotal=0>
<cfloop query="sales">
<!---#DateFormat(dateShipped,"yyyy-mm-dd")# #DollarFormat(orderSub)#<br />//--->
<cfif left(custUsername,3) EQ 'vm_' OR left(custUsername,10) EQ 'vinylmania'><cfset salesTotal=salesTotal+(qtyOrdered*(price-1))><cfelseif priceOverride NEQ 0><cfset salesTotal=salesTotal+(qtyOrdered*priceOverride)><cfelse><cfset salesTotal=salesTotal+(qtyOrdered*price)></cfif>
</cfloop>
<cfset grandTotal=salesTotal+mShipping>
<cfoutput>
<cfif grandTotal GT 0>
<h1 style="margin-top: 24px; margin-bottom: 0px;">#x#/#y#</h1>
<p style="margin-top: 0px;">Merchandise Income: <b>#DollarFormat(salesTotal)#</b><br />
Shipping Income: #DollarFormat(mShipping)#<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Post Office: #DollarFormat(postalShipping)#<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UPS: #DollarFormat(UPSShipping)#<br />
Total: <b>#DollarFormat(grandTotal)#</b></br></cfif>
<cfset diffSales=salesTotal-lastMonthTotal>
<cfset diffGrand=grandTotal-lastMonthGrand>
<cfif lastMonthTotal NEQ 0><cfset diffPerc=diffSales/lastMonthTotal*100></cfif>
<cfif lastMonthTotal EQ 0 AND diffSales EQ 0><cfset diffPerc=0></cfif>
<cfif lastMonthGrand NEQ 0><cfset diffPercGrand=diffSales/lastMonthGrand*100></cfif>
<cfif lastMonthGrand EQ 0 AND diffGrand EQ 0><cfset diffPercGrand=0></cfif>
<cfoutput><cfif grandTotal GT 0>Records Only: (#NumberFormat(diffPerc,'0.0')#% change - <cfif diffPerc GT 0>up #DollarFormat(diffSales)#<cfelseif diffPerc LT 0>down  #DollarFormat(diffSales)#<cfelse> no change</cfif>)<br />
Records and Shipping: (#NumberFormat(diffPercGrand,'0.0')#% change - <cfif diffPercGrand GT 0>up #DollarFormat(diffGrand)#<cfelseif diffPercGrand LT 0>down  #DollarFormat(diffGrand)#<cfelse> no change</cfif>)</cfif></p></cfoutput>

<cfset lastMonthTotal=salesTotal>
<cfset lastMonthGrand=grandTotal>
</cfoutput>

</cfloop>
</cfloop>