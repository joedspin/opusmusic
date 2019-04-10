<cfquery name="warehouseSaleReport" datasource="#DSN#">
	select *
    from catItemsQuery
    where (priceSave>0 OR specialItem=1) AND albumStatusID<25 AND ONHAND>0
    order by price, label, catnum
</cfquery>
<table border="1" bordercolor="#000000" style="border-collapse:collapse;" cellpadding="2">
<cfset itemCount=0>
<cfoutput query="warehouseSaleReport">
<cfset itemCount=itemCount+1>
<tr>
	<td>#itemCount#</td>
	<td>#shelfCode#</td>
	<td align="right">#ONHAND#</td>
    <td>#labelID#</td>
	<td>#UCase(Left(label,20))#</td>
    <td>#catnum#</td>
    <td>#UCase(Left(artist,20))#</td>
    <td>#UCase(Left(title,20))#</td>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#Left(media,3)#</td>
    <td align="right">#DollarFormat(price)#</td>
    
    <!---<td>#DateFormat(dateShipped,"mm/dd/yy")#</td>//--->
    <td>#DateFormat(dtDateUpdated,"mm/dd/yy")#</td>
</tr>
</cfoutput>
</table>