<cfquery name="fixspatflap" datasource="#DSN#">
	update catItems
    set shelfID=2078, wholesalePrice=6.99, cost=5, price=9.99 where labelID=6131
</cfquery>
<cfquery name="fixspatflap" datasource="#DSN#">
	update catItems
    set shelfID=2079, wholesalePrice=6.99, cost=5, price=9.99 where labelID=2538
</cfquery>