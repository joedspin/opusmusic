<cfquery name="onsideSales" datasource="#DSN#">
	select DISTINCT catItemID, catnum, ONSIDE, artist, title, label
    from orderItemsQuery
    where orderItems_adminShipID=5 AND DateDiff(day,dateShipped,#varDateODBC#)<10 AND ONSIDE<5
    order by ONSIDE, label, catnum
</cfquery>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size: xx-small; border-color:black;}
</style>
<table border="2" cellpadding="4" cellspacing="0" style="border-collapse:collapse; border-color: black;">
<tr>
	<td>SIDE</td>
    <td>CATNUM</td>
    <td>LABEL</td>
    <td>ARTIST</td>
    <td>TITLE</td>
    <td>SOLD</td>
    <td>PEND</td>
</tr>
<cfoutput query="onsideSales">
<cfset soldCount=0>
<cfset pendCount=0>
<cfquery name="pendingCarts" datasource="#DSN#">
	select Sum(qtyOrdered) As pendingCount
    from orderItemsQuery
    where adminAvailID<3 AND catItemID=#catItemID# AND DateDiff(day,dateUpdated,#varDateODBC#)<90
</cfquery>
<cfquery name="soldCarts" datasource="#DSN#">
	select Sum(qtyOrdered) As soldCount
    from orderItemsQuery
    where adminAvailID>2 AND catItemID=#catItemID# AND DateDiff(day,dateUpdated,#varDateODBC#)<90
</cfquery>
<cfif soldCarts.recordCount GT 0><cfset soldCount=soldCarts.soldCount></cfif>
<cfif pendingCarts.recordCount GT 0><cfset pendCount=pendingCarts.pendingCount></cfif>
<tr>
	<td align="right">#ONSIDE#</td>
    <td>#UCase(catnum)#</td>
    <td>#Ucase(Left(label,15))#</td>
    <td>#Ucase(Left(artist,30))#</td>
    <td>#Ucase(Left(title,25))#</td>
    <td align="right">#soldCount#</td>
    <td align="right">#pendCount#</td>
</tr>
</cfoutput>
</table>