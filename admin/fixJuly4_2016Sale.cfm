<cfquery name="hasntsoldsince" datasource="#DSN#">
	update catItems
    set price=priceSave, specialItem=0
    where price=5.99 AND priceSave<>0 AND specialItem=1
</cfquery>
<cfabort>


<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2015-06-01' AND dateShipped<>''
    AND statusID=6) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21  AND price>0.99 AND NRECSINSET=1
        order by label, catnum
</cfquery>
<cfquery name="dohasntsoldsince" datasource="#DSN#">
	update catItems
    set price=5.99, priceSave=price, specialItem=1
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2015-06-01' AND dateShipped<>''
    AND statusID=6) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21  AND price>6.99 AND NRECSINSET=1 and priceSave=0 AND specialItem=0
</cfquery>
<cfset itemcounter=0>
<table>
<cfoutput query="hasntsoldsince">
<cfset itemCounter=itemCounter+1>
<tr>
<td>#itemCounter#</td>
<td>#catnum#</td>
<td>#label#</td>
<td>#artist#</td>
<td>#title#</td>
<td>#NRECSINSET#</td>
<td>#DollarFormat(price)#</td>
<td>#ONHAND#</td>
</tr>
</cfoutput>
</table>


<cfabort>


<cfquery name="switch" datasource="#DSN#">
	update catItems
    set price=5.99
    where price=7.99 AND specialItem=1
</cfquery>
<cfabort>



<!--- UNDO IS READY TO RUN ABOVE --->
<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2015-01-01' AND dateShipped<>''
    AND statusID=6) AND shelfID=11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21  AND price>0.99 AND NRECSINSET=1
        order by label, catnum
</cfquery>
<cfquery name="dohasntsoldsince" datasource="#DSN#">
	update catItems
    set price=.99, priceSave=price, specialItem=1
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2015-01-01' AND dateShipped<>''
    AND statusID=6) AND shelfID=11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21  AND price>0.99 AND NRECSINSET=1 and specialItem=0 AND priceSave=0
</cfquery>
<cfset itemcounter=0>
<table>
<cfoutput query="hasntsoldsince">
<cfset itemCounter=itemCounter+1>
<tr>
<td>#itemCounter#</td>
<td>#catnum#</td>
<td>#label#</td>
<td>#artist#</td>
<td>#title#</td>
<td>#NRECSINSET#</td>
<td>#DollarFormat(price)#</td>
<td>#ONHAND#</td>
</tr>
</cfoutput>
</table>