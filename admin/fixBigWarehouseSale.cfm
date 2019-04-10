
<cfquery name="bigwarehousesale" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, price=price/2, cost=cost/2
    where albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND vendorID NOT IN (6978, 2811, 5650, 5439) AND labelID <>1586
</cfquery>
<!---<cfquery name="bigwarehousesale" datasource="#DSN#">
	select 	* from catItemsQuery 
    where albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND vendorID NOT IN (6978, 2811, 5650, 5439) AND labelID <>1586
    order by label, catnum
</cfquery>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="bigwarehousesale">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(price/2)#</td>
	</tr>
</cfoutput>
</table>
<cfoutput>#bigwarehousesale.recordCount#</cfoutput>//--->
