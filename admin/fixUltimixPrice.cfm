<cfquery name="fixUltimixPrice" datasource="#DSN#">
	update catItems
    set price=27.99,cost=13.49,wholesalePrice=15.99
    where labelID=1234 AND NRECSINSET=2 AND mediaID=5
</cfquery>