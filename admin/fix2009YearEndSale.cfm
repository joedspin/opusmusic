<cfquery name="undoSale" datasource="#DSN#">
	update catItems
    set price=cost+(3*NRECSINSET), specialItem=0
    where price<cost and price>0 and cost>0 and shelfID NOT IN (7,11,13)
</cfquery>
