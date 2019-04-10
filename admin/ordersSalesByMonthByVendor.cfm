<cfparam name="form.vendorID" default="0">
<cfparam name="url.vendorID" default="#form.vendorID#">
<cfparam name="url.weeknum" default="0">
<cfparam name="url.monthnum" default="0">
<cfparam name="url.yearnum" default="#DateFormat(vardateODBC,'yyyy')#">
<cfparam name="url.minus30" default="no">
<cfif url.weeknum EQ 0><cfoutput><p><a href="ordersSalesByMonthByVendor.cfm?vendorID=#url.vendorID#&minus30=yes">Deduct Shipping Cost ($0.30)</a></p></cfoutput></cfif>
	<cfif url.minus30 EQ "yes"><cfset costString="cost-0.30 AS thisCost"><cfelse><cfset costString="cost AS thisCost"></cfif>
<cfquery name="vendor" datasource="#DSN#">
	select *
    from shelf
    where ID=#url.vendorID#
</cfquery>
	<cfoutput query="vendor"><h1><cfif partner EQ "William Socolov">GST Distribution<cfelse>#partner#</cfif> Sales (Cost)<cfif url.weeknum NEQ 0><br>Week ###url.weeknum# #url.yearnum#</cfif></h1>
	<cfif url.weeknum EQ 0><h2><a href="ordersSalesByMonthByVendor.cfm?vendorID=#url.vendorID#&weeknum=#week(DateAdd('d','-7',varDateODBC))#&yearnum=#DateFormat(DateAdd('d','-7',varDateODBC),'yyyy')#">Last Week</a> <a href="ordersSalesByMonthByVendor.cfm?vendorID=#url.vendorID#&monthnum=#month(DateAdd('m','-1',varDateODBC))#&yearnum=#DateFormat(DateAdd('m','-1',varDateODBC),'yyyy')#">Last Month</a></h2></cfif></cfoutput>
<cfif url.vendorID EQ 1059 OR url.vendorID EQ 2127 OR url.vendorID EQ 2131>
	<cfset thisVendorString="shelfID IN (1059,2127,2131,2136)">
	<cfset gstFilter=" AND orders.custID=28594">
<cfelse>
	<cfset thisVendorString="shelfID=#url.vendorID#">
	<cfset gstFilter="">
</cfif>
<cfset salesTotal=0>
<cfset costTotal=0>
<!---
<cfloop from="2013" to="#DateFormat(varDateODBC,"yyyy")#" index="y">
<cfloop from="1" to="12" index="x">
<cfquery name="sales" datasource="#DSN#">
	select *
	from ((orderItems LEFT JOIN catItems ON orderItems.catItemID=catItems.ID) LEFT JOIN orders on orderItems.orderID=orders.ID)
	where adminAvailID=6 AND DatePart(m,dateShipped)=#x# AND DatePart(yyyy,dateShipped)=#y# AND  #thisVendorString#
	order by dateShipped
</cfquery>
<cfset salesTotal=0>
<cfset costTotal=0>
<cfoutput query="sales">
<br>
<cfif url.minus30 EQ "yes"><cfset thisCost=cost-(NRECSINSET*.30)><cfelse><cfset thisCost=cost></cfif>
#qtyOrdered# x #catnum# #DollarFormat(thisCost)#
<cfset salesTotal=salesTotal+(qtyOrdered*price)>
<cfset costTotal=costTotal+(qtyOrdered*thisCost)>
</cfoutput>
<cfoutput>
<cfif salesTotal NEQ 0 OR costTotal NEQ 0><p>#x#/#y#<br />
<b>#DollarFormat(costTotal)#</b></p><hr noshade></cfif>
</cfoutput>
</cfloop>
</cfloop>//--->
<table>
<cfif url.weeknum EQ 0 AND url.monthnum EQ 0>
<cfloop from="2013" to="#DateFormat(varDateODBC,"yyyy")#" index="y">
<cfloop from="1" to="12" index="x">
<cfquery name="sales" datasource="#DSN#">
	select *, #costString#
	from ((orderItems LEFT JOIN catItems ON orderItems.catItemID=catItems.ID) LEFT JOIN orders on orderItems.orderID=orders.ID)
	where adminAvailID=6 AND DatePart(m,dateShipped)=#x# AND DatePart(yyyy,dateShipped)=#y# AND #thisVendorString# AND orderItems.price<>0.00
	order by dateShipped
</cfquery>
<cfset salesTotal=0>
<cfset costTotal=0>

<cfset lastM=0>
<cfset lastY=0>
<cfoutput query="sales">
<cfif x&y NEQ lastM&lastY><tr><td colspan="8"><b>#x#/#y#</b></td></tr></cfif>
<tr>
	<td>#DateFormat(dateShipped,"yyyy-mm-dd")#</td>
    <td>#catnum#</td>
    <td>#qtyOrdered#</td>
    <td>#DollarFormat(thisCost)#</td>
    <td>#DollarFormat(qtyOrdered*thisCost)#</td>
    <!---<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(qtyOrdered*price)#</td>//--->
	<td colspan="2">&nbsp;</td>
</tr>
<cfset salesTotal=salesTotal+(qtyOrdered*price)>
<cfset costTotal=costTotal+(qtyOrdered*thisCost)>
<cfset lastM=x>
<cfset lastY=y>
</cfoutput>
<cfoutput>
<cfif costTotal NEQ 0 OR salesTotal NEQ 0><tr><td colspan="6">&nbsp;</td><td><b>#DollarFormat(costTotal)#</b></td><td><b>#DollarFormat(salesTotal)#</b></td></tr></cfif>
</cfoutput>
</cfloop>
</cfloop>
<cfelse>
	<cfif Trim(url.yearnum) EQ ""><cfset searchYear=DateFormat(vardateODBC,'yyyy')><cfelse><cfset searchYear=url.yearnum></cfif><!---<cfset searchYear=DateFormat(varDateODBC,'yyyy')><cfelse><cfset searchYear=DateFormat(varDateODBC,'yyyy')-1></cfif>//--->
<cfif url.weeknum NEQ "0">
<cfquery name="sales" datasource="#DSN#">
	select Sum(qtyOrdered) As qtySold, catnum, cost, #costString#, shelfID
	from ((orderItems LEFT JOIN catItems ON orderItems.catItemID=catItems.ID) LEFT JOIN orders on orderItems.orderID=orders.ID)
	where adminAvailID=6 AND DatePart(wk,dateShipped)=#url.weeknum# AND DatePart(yyyy,dateShipped)=#searchYear# AND  #thisVendorString# AND orderItems.price<>0.00
	group by catnum, cost, shelfID
	order by catnum
</cfquery>
<cfelseif url.monthnum NEQ "0">
<cfquery name="sales" datasource="#DSN#">
	select Sum(qtyOrdered) As qtySold, catnum, cost, #costString#, shelfID
	from ((orderItems LEFT JOIN catItems ON orderItems.catItemID=catItems.ID) LEFT JOIN orders on orderItems.orderID=orders.ID)
	where adminAvailID=6 AND DatePart(m,dateShipped)=#url.monthnum# AND DatePart(yyyy,dateShipped)=#searchYear# AND  #thisVendorString# AND orderItems.price<>0.00 
	group by catnum, cost, shelfID
	order by catnum
</cfquery>
</cfif>
<cfset costTotal=0>
<cfset altTotal=0>
<cfoutput query="sales">
	<cfif shelfID EQ 2127 OR shelfID EQ 2131><cfset thisCost=cost><cfelse><cfset thisCost=cost-.30></cfif>
<cfif qtySold NEQ 0>
	<cfif shelfID EQ 2131><tr style="background-color:yellow;"><cfelse><tr></cfif>
		<!---<td>#DateFormat(dateShipped,"yyyy-mm-dd")#</td>//--->
		<td>#catnum#</td>
		<td align="right">#qtySold# @ </td>
		<td align="right">#DollarFormat(thisCost)# = </td>
		<td align="right">#DollarFormat(qtySold*thisCost)#</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<cfset costTotal=costTotal+(qtySold*thisCost)>
	<cfif shelfID EQ 2131><cfset altTotal=altTotal+(qtySold*thisCost)></cfif>
</cfif>
</cfoutput>
<cfoutput>
<cfif costTotal NEQ 0 OR salesTotal NEQ 0><tr><td colspan="6">&nbsp;</td><td align="right"><b>#DollarFormat(costTotal)#</b><cfif altTotal GT 0><br>
	<span style="background-color:yellow;"><b>#DollarFormat(altTotal)#</b></span></cfif></td></tr></cfif>
</cfoutput>

</cfif>
</table>