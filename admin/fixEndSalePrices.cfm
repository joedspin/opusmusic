<cfquery name="endSalePrices" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0
    where priceSave>0
</cfquery>