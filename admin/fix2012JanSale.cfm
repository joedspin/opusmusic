<cfabort>
<cfquery name="clearpricesave" datasource="#DSN#">
	update catItems
    set pricesave=0
</cfquery>
<cfquery name="importSaleJan2012" datasource="#DSN#">
	update catItems
    set pricesave=price, price=price*.75
    where ONHAND>0 AND shelfID<>11 AND releaseDate<'#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#'
</cfquery>
<cfquery name="domesticSaleJan2012" datasource="#DSN#">
	update catItems
    set pricesave=price, price=price*.75
    where (ONHAND>0 AND albumStatusID>22) AND shelfID=11 AND mediaID<>20 AND
    vendorID IN (6791,6375,7930,5497,6155,6319,7691,6897,7166,7280,7301,7367,7878,7583,7665,7676,7677,7678,7680,7681,7682,7683,7684,7686,7687,7688)
</cfquery>
<!---<cfset rowCount=0>
<table>
<cfoutput query="importSaleJan2012">
<cfset rowCount=rowCount+1>
	<tr>
    	<td>#rowCount#</td>
		<td>#label#</td>
		<td>#catnum#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#DollarFormat(price)#</td>
		<td>#DollarFormat(cost)#</td>
   		<td>#DollarFormat(buy)#</td>
   		<td>#DollarFormat(dtBuy)#</td>
		<td>#DollarFormat(price*.75)#</td>
		<td>#ONHAND#</td>
	</tr>
</cfoutput>
<cfoutput query="domesticSaleJan2012">
<cfset rowCount=rowCount+1>
	<tr>
    	<td>#rowCount#</td>
		<td>#label#</td>
		<td>#catnum#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#DollarFormat(price)#</td>
		<td>#DollarFormat(cost)#</td>
   		<td>#DollarFormat(buy)#</td>
   		<td>#DollarFormat(dtBuy)#</td>
		<td>#DollarFormat(price*.75)#</td>
		<td>#ONHAND#</td>
	</tr>
</cfoutput>
</table>//--->