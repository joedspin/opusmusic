<cfquery name="makePricesPrettier" datasource="#DSN#">
	update catItems
    set price=price-.2 where right(price,2)<20
</cfquery>