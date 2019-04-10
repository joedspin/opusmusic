<!---<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
    set specialItem=0, blueDate=<cfqueryparam value="2016-01-01" cfsqltype="cf_sql_date">, dtOLDID=0
</cfquery>--->
<cfquery name="checkFix" datasource="#DSN#">
	select *
    from catItemsQuery
    where priceSave>0 AND blue99=1
</cfquery>
<cfset itemCounter=0>
<table>
<cfoutput query="checkFix">
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
<!-- UNDO -->
<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
    set dtOLDID=0, price=priceSave, priceSave=0
    where priceSave>0 AND (dtOLDID=30 OR dtOLDID=50)
</cfquery>


<!-- END UNDO -->
<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where (ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped<>'' AND statusID=6) OR ONHAND>3) 
    	AND shelfID NOT IN (11,50,14,1059,1072,47,1057,1056,1067,2080,2111,1064,2115,1070,2099,2102,2092) 
        AND ONHAND>0 AND albumStatusID<25 AND realReleaseDate<'2015-12-15' AND priceSave=0
        order by realReleaseDate DESC, label, catnum
</cfquery>
<cfquery name="fixhasnt" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price*.7, dtOLDID=30
    where (ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped<>'' AND statusID=6) OR ONHAND>3) 
    	AND shelfID NOT IN (11,50,14,1059,1072,47,1057,1056,1067,2080,2111,1064,2115,1070,2099,2102,2092) 
        AND ONHAND>0 AND albumStatusID<25 AND realReleaseDate<'2015-12-15' AND priceSave=0
</cfquery>
<p>Downtown 304</p>
<cfset itemCounter=0>
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
<cfquery name="hasntsoldsince" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2015-06-01' AND dateShipped<>'' AND statusID=6) AND 
    	shelfID=11 AND ONHAND>0 AND albumStatusID<25 AND price>1.99 AND priceSave=0
        order by label, catnum
</cfquery>
<cfquery name="fixhasnt" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price*.5, dtOLDID=50
    where ID NOT IN (select DISTINCT catItemID from orderItemsQuery where dateShipped>'2015-06-01' AND dateShipped<>'' AND statusID=6) AND 
    	shelfID=11 AND ONHAND>0 AND albumStatusID<25 AND price>1.99 AND priceSave=0
</cfquery>
<p>Downtown 161</p>
<cfset itemCounter=0>
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