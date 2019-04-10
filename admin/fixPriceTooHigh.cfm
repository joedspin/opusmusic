<cfquery name="fixPriceTooHigh" datasource="#DSN#">
	select * from catItemsQuery
    where price>cost+3.50 AND cost>4.99 AND shelfID NOT IN (11,50,14,1059,1072,47,1057,1056,1067,2080,2111,1064,2115,1070,2099,2102,2092) AND NRECSINSET=1
</cfquery>
<!---<cfquery name="fixPriceTooHigh" datasource="#DSN#">
	update catItems
    set price=cost+3
    where price>cost+3.50 AND cost>4.99 AND shelfID NOT IN (11,50,14,1059,1072,47,1057,1056,1067,2080,2111,1064,2115,1070,2099,2102,2092) AND NRECSINSET=1
</cfquery>//--->
<cfset itemCounter=0>
<table>
<cfoutput query="fixPriceTooHigh">
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