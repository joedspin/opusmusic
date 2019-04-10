<cfquery name="savePrices" datasource="#DSN#">
	update catItems
    set priceSave=price
</cfquery>
<cfquery name="importSale" datasource="#DSN#">
	update catItems
    set price=8.99
    where albumStatusID<25 AND ONHAND>0 AND shelfID<>11 AND releaseDate<='#DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")#' AND cost<9 AND price>8.99 AND NRECSINSET=1
</cfquery>
<cfquery name="ONsale" datasource="#DSN#">
	update catItems
    set price=cost
    where shelfID=27 and price=priceSave
</cfquery>