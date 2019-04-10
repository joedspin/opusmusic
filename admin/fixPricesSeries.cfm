<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
	set price=8.24, cost=5.49, buy=5.49
	where labelID IN (706,2035,2038,2239,2054) AND NRECSINSET=1 AND mediaID=1
</cfquery>