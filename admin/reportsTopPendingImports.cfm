<cfparam name="url.shelf" default="">
<cfif url.shelf EQ ''><cfset shelfString="(shelfCode='SY' OR shelfCode='GR' OR shelfCode='TO' OR shelfCode='VI')"><cfelse><cfset shelfString="shelfCode='"&url.shelf&"'"></cfif>
<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 14px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 10px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="topSellers" datasource="#DSN#" maxrows="100">
	SELECT orderItems.catItemID, Sum(orderItems.qtyOrdered) AS SumOfQuantity,catItemsQuery.shelfCode,  catItemsQuery.catnum, catItemsQuery.label, catItemsQuery.ONHAND, catItemsQuery.artistID, catItemsQuery.artist, catItemsQuery.title, catItemsQuery.price
FROM ((orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID) LEFT JOIN orders ON orderItems.orderID = orders.ID)
WHERE orderItems.adminAvailID<3 and orderItems.orderID<>1479 AND #shelfString#
GROUP BY orderItems.catItemID, catItemsQuery.catnum, catItemsQuery.shelfCode, catItemsQuery.ONHAND, catItemsQuery.label, catItemsQuery.artistID, catItemsQuery.artist, catItemsQuery.title, catItemsQuery.price, catItemsQuery.catnum
ORDER BY Sum(orderItems.qtyOrdered) DESC
</cfquery>
<h1>Downtown 304 Pending Sales (Imports)</h1>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfset ctRow=0>
<cfoutput query="topSellers">
	<cfset ctRow=ctRow+1>
	<tr>
		<td align="right">#ctRow#.</td>	
        <td>#shelfCode#</td>
		<td align="right">#SumOfQuantity# ON ORDER</td>
        <td align="right">#ONHAND# ONHAND</td>
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>
<!---
<cfquery name="topSellers" datasource="#DSN#" maxrows="100">
	SELECT Sum(Quantity) AS SumOfQuantity, opCATNUM, opLABEL, opARTIST, opTITLE, opMEDIA, Price
	FROM GEMMBatchProcessing
	GROUP BY opCATNUM, opLABEL, opARTIST, opTITLE, opMEDIA, Price
	ORDER BY Sum(Quantity) DESC
</cfquery>
<h1>GEMM Top Sellers</h1>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfset ctRow=0>
<cfoutput query="topSellers">
	<cfset ctRow=ctRow+1>
	<tr>
		<td align="right">#ctRow#.</td>
		<td align="right">#SumOfQuantity#</td>
		<td>#opCATNUM#</td>
		<td>#opLABEL#</td>
		<td>#opARTIST#</td>
		<td>#opTITLE#</td>
		<td>#opMEDIA#</td>
		<td align="right">#DollarFormat(Price)#</td>
	</tr>
</cfoutput>
</table>//--->