<cfquery name="clearflags" datasource="#DSN#">
	update catItems
    set price=priceSave, cost=costSave, priceSave=0, costSave=0, dtOLDID=0
    where priceSave<>0 AND costSave<>0
</cfquery>
<cfquery name="clearflags" datasource="#DSN#">
	update catItems
    set specialItem=0, priceSave=price, costSave=cost, dtOLDID=0
    where priceSave=0 AND costSave=0
</cfquery>



<!--- THE UNDO FOR THIS IS TO SET PRICE AND COST TO PRICESAVE AND COSTSAVE WHERE PS & CS <>0 THEN ZERO OUT THE SAVES //--->


<style>
td {font-family:Arial, Helvetica, sans-serif; font-size:xx-small;}
</style>
<!---(DateDiff(day,DTDateUpdated,#varDateODBC#)>14 OR dtDateUpdated='') AND
--->
<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2014-03-01' AND dateShipped<>''
    AND statusID=6) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 
        order by label, catnum
</cfquery>
<cfquery name="fixhasnt" datasource="#DSN#">
	update catItems
    set price=priceSave*.8, dtOLDID=20
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2014-03-01' AND dateShipped<>''
    AND statusID=6) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 
</cfquery>
Hasn't sold in 6th months (DT304) 20% off
<table border="1" bordercolor="#000000" style="border-collapse:collapse;" cellpadding="2">
<cfset itemCount=0>
<cfoutput query="hasntsoldsince">
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
    <td align="right">#DollarFormat(priceSave)#</td>
    
    <!---<td>#DateFormat(dateShipped,"mm/dd/yy")#</td>//--->
    <td>#DateFormat(dtDateUpdated,"mm/dd/yy")#</td>
</tr>
</cfoutput>
</table>

<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2013-09-01' AND dateShipped<>'' 
    AND statusID=6) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 
        order by label, catnum
</cfquery>
<cfquery name="fixhasnt" datasource="#DSN#">
	update catItems
    set price=priceSave*.6, dtOLDID=40
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2013-09-01' AND dateShipped<>'' 
    AND statusID=6) AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 
</cfquery>
Hasn't sold in 1 year (DT304) 40% off
<table border="1" bordercolor="#000000" style="border-collapse:collapse;" cellpadding="2">
<cfset itemCount=0>
<cfoutput query="hasntsoldsince">
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
    <td align="right">#DollarFormat(priceSave)#</td>
    <td>#DateFormat(dtDateUpdated,"mm/dd/yy")#</td>
</tr>
</cfoutput>
</table>
<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2013-09-01' AND dateShipped<>'' AND statusID=6) 
    AND shelfID=11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 
        order by label, catnum
</cfquery>
<cfquery name="fixhasnt" datasource="#DSN#">
	update catItems
    set price=priceSave*.4, cost=costSave*.4, dtOLDID=60
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2013-09-01' AND dateShipped<>'' AND statusID=6) 
    AND shelfID=11 AND ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 
</cfquery>
Hasn't sold in 1 year (DT161) 60% off
<table border="1" bordercolor="#000000" style="border-collapse:collapse;" cellpadding="2">
<cfset itemCount=0>
<cfoutput query="hasntsoldsince">
<cfset itemCount=itemCount+1>
<tr>
	<td>#DollarFormat(price*.4)#</td>
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
    <td align="right">#DollarFormat(priceSave)#</td>
    <!---<td>#DateFormat(dateShipped,"mm/dd/yy")#</td>//--->
    <td>#DateFormat(dtDateUpdated,"mm/dd/yy")#</td>
</tr>
</cfoutput>
</table>
<cfquery name="priceSaveAdjust" datasource="#DSN#">
	update catItems
    set priceSave=0
    where priceSave=price
</cfquery>
<cfquery name="priceSaveAdjust" datasource="#DSN#">
	update catItems
    set costSave=0
    where costSave=cost
</cfquery>