<style>
td {font-family:Arial, Helvetica, sans-serif; font-size:xx-small;}
</style>
<cfquery name="listDeadbeatImports" datasource="#DSN#">
	select *
    from catItemsQuery
    where (DateDiff(day,DTDateUpdated,#varDateODBC#)>120 OR dtDateUpdated='') AND ID NOT IN (select catItemID from orderItemsQuery where statusID>5 AND DateDiff(day,dateShipped,#varDateODBC#)<60) AND isVendor=1 AND left(shelfCode,1)<>'D' AND ONHAND>0 AND albumStatusID<25 AND price>cost+1
    order by label, catnum
</cfquery>
<table border="1" bordercolor="#000000" style="border-collapse:collapse;" cellpadding="2">
<cfoutput query="listDeadbeatImports">
<tr><td>#shelfCode#</td>
	<td>#UCase(Left(label,20))#</td>
    <td>#catnum#</td>
    <td>#UCase(Left(artist,20))#</td>
    <td>#UCase(Left(title,20))#</td>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#Left(media,3)#</td>
    <td align="right">#DollarFormat(price)#</td>
    <td>#DateFormat(dtDateUpdated,"mm/dd/yy")#</td>
</tr>
</cfoutput>
</table>

<cfquery name="listDeadbeatImports" datasource="#DSN#">
	update catItems
    set price=cost+1, dtDateUpdated=<cfqueryparam cfsqltype="cf_sql_date" value="8/25/10">, albumStatusID=23
    where (DateDiff(day,DTDateUpdated,#varDateODBC#)>120 OR dtDateUpdated='') AND ID NOT IN (select catItemID from orderItemsQuery where statusID>5 AND DateDiff(day,dateShipped,#varDateODBC#)<60) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND price>cost+1
</cfquery>