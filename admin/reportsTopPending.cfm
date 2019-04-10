<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 14px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 10px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="topSellers" datasource="#DSN#" maxrows="100">
	SELECT DISTINCT catItemID, Sum(qtyOrdered) AS SumOfQuantity, catnum, label, artistID, artist, title, price
FROM orderItemsQuery
WHERE adminAvailID<3
GROUP BY catItemID, catnum, label, artistID, artist, title, price, catnum
ORDER BY Sum(qtyOrdered) DESC
</cfquery>
<h1>Opus Pending Sales</h1>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfset ctRow=0>
<cfoutput query="topSellers">
	<cfset ctRow=ctRow+1>
	<tr>
		<td align="right">#ctRow#.</td>	
		<td align="right">#SumOfQuantity#</td>
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