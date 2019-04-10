<cfparam name="url.recent" default="false">
<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 14px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 13px; line-height: 100%; vertical-align:top;}
//-->
</style>

<cfif url.recent>
	    <cfquery name="topSellers" datasource="#DSN#" maxrows="100">
        SELECT catItemID, Sum(qtyOrdered) AS SumOfQuantity, catnum, label, artistID, artist, title, price, isStore
    FROM orderItemsQuery
    WHERE adminAvailID=6 AND releaseDate>'#DateFormat(DateAdd("d","-90",varDateODBC),"yyyy-mm-dd")#' AND dateShipped>'#DateFormat(DateAdd("d","-90",varDateODBC),"yyyy-mm-dd")#' AND isStore=0
    GROUP BY catItemID, catnum, label, artistID, artist, title, price, catnum, isStore
    ORDER BY Sum(qtyOrdered) DESC
    </cfquery>
<cfelse>
    <cfquery name="topSellers" datasource="#DSN#" maxrows="100">
        SELECT catItemID, Sum(qtyOrdered) AS SumOfQuantity, catnum, label, artistID, artist, title, price, isStore
    FROM orderItemsQuery
    WHERE adminAvailID=6 AND isStore=0
    GROUP BY catItemID, catnum, label, artistID, artist, title, price, catnum, isStore
    ORDER BY Sum(qtyOrdered) DESC
    </cfquery>
</cfif>
<h1>Opus Top Sellers</h1>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse: collapse;">
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