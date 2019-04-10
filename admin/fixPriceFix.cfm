<cfquery name="pricefixer" datasource="#DSN#">
	update catItems
    set price=11.99, cost=7.99, wholesalePrice=9.99
    where price=11.79 and (releaseDate='2016-02-01' OR releaseDate='02/01/2016')
</cfquery>